import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/FieldExecutive/landmodel.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class EditLandScreen extends StatefulWidget {
  final Datum landData;
  final String? landId;

  const EditLandScreen({super.key, required this.landData, this.landId});

  @override
  State<EditLandScreen> createState() => _EditLandScreenState();
}

class _EditLandScreenState extends State<EditLandScreen> {
  // ---------- Controllers ----------
  final TextEditingController villageController = TextEditingController();
  final TextEditingController mandalController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController farmerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otherWhatsappController = TextEditingController();
  final TextEditingController landAreaController = TextEditingController();
  final TextEditingController guntasController = TextEditingController();
  final TextEditingController pricePerAcreController = TextEditingController();
  final TextEditingController totalLandPriceController =
      TextEditingController();
  final TextEditingController shedDetailsController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  // ---------- Dropdown values ----------
  bool isWhatsApp = false;
  String? selectedLiteracy;
  String? selectedAgeGroup;
  String? selectedNature;
  String? selectedOwnership;
  String? selectedMortgage;
  String? selectedDisputeType;
  String? selectedSibling;
  String? selectedPath;
  String? selectedLandType;
  String? selectedResidential;
  String? selectedFencing;

  // 🆕 MULTIPLE SELECTION FIELDS
  List<String> selectedWaterSources = [];
  List<String> selectedGardens = [];
  List<String> selectedSheds = [];
  List<String> selectedFarmPonds = [];

  // ---------- API & Files ----------
  String? _apiToken;
  File? passbookImage;
  final List<File> landPhotos = [];
  final List<File> landVideos = [];
  List<String> existingPhotosUrls = [];
  List<String> existingVideosUrls = [];
  final ImagePicker _picker = ImagePicker();

  // ---------- State ----------
  bool loadingGPS = false;
  bool submitting = false;
  bool isDraft = false; // ✅ ADDED FOR DRAFT OPTION
  String? _landId;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadToken();
    _extractLandId();
    _populateExistingData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isDataLoaded = true;
        });
      }
    });
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
  }

  void _extractLandId() {
    _landId =
        widget.landId ??
        widget.landData.landId?.toString() ??
        widget.landData.id?.toString();
  }

  void _populateExistingData() {
    final data = widget.landData;

    print('=== POPULATING DATA FROM API ===');

    // Address Section
    stateController.text = data.landLocation.state ?? '';
    districtController.text = data.landLocation.district?.toString() ?? '';
    mandalController.text = data.landLocation.mandal ?? '';
    villageController.text = data.landLocation.village ?? '';

    // Farmer Details
    farmerNameController.text = data.farmerDetails.name ?? '';
    phoneController.text = data.farmerDetails.phone ?? '';

    // WhatsApp check
    final whatsappNumber = data.farmerDetails.whatsappNumber ?? '';
    if (whatsappNumber.isNotEmpty) {
      if (whatsappNumber == phoneController.text) {
        isWhatsApp = true;
      } else {
        otherWhatsappController.text = whatsappNumber;
      }
    }

    // Set dropdown values
    selectedLiteracy = _getValidValue(data.farmerDetails.literacy, [
      "High School",
      "Illiterate",
      "Literate",
      "Graduate",
    ]);
    selectedAgeGroup = _getValidValue(data.farmerDetails.ageGroup, [
      "Upto 30",
      "30-50",
      "50+",
    ]);
    selectedNature = _getValidValue(data.farmerDetails.nature, [
      "Calm",
      "Polite",
      "Medium",
      "Rude",
    ]);
    selectedOwnership = _getValidValue(data.farmerDetails.landOwnership, [
      "Own",
      "Joint",
      "Single",
    ]);
    selectedMortgage = _getValidValue(data.farmerDetails.mortgage, [
      "Yes",
      "No",
    ]);

    // Dispute Details
    selectedDisputeType = _getValidValue(data.disputeDetails.disputeType, [
      "Boundary",
      "Ownership",
      "Family",
      "Other",
      "Budhan",
      "Land Sealing",
      "Electric Poles",
      "Canal Planning",
      "None",
    ]);
    selectedSibling = _getValidValue(
      data.disputeDetails.siblingsInvolveInDispute,
      ["Yes", "No"],
    );
    selectedPath = _getValidValue(data.disputeDetails.pathToLand, [
      "Easy Access",
      "No Path to Land",
      "Concrete Road",
    ]);

    // Land Details
    landAreaController.text = data.landDetails.landArea ?? '';
    guntasController.text = data.landDetails.guntas ?? '';
    pricePerAcreController.text =
        data.landDetails.pricePerAcre?.toString() ?? '';
    totalLandPriceController.text =
        data.landDetails.totalLandPrice?.toString() ?? '';

    // Land characteristics - SINGLE SELECTION
    selectedLandType = _getValidValue(data.landDetails.landType, [
      "agri",
      "Red",
      "Black",
      "Sandy",
    ]);
    selectedResidential = _getValidValue(data.landDetails.residental, [
      "Yes",
      "Farm House",
      "RCC Home",
      "Asbestos Shelter",
      "Hut",
    ]);
    selectedFencing = _getValidValue(data.landDetails.fencing, [
      "Complete",
      "With Gate",
      "All Sides",
      "Partially",
      "No",
    ]);

    // 🆕 MULTIPLE SELECTIONS - Parse comma separated strings from API
    final waterSourceStr = data.landDetails.waterSource ?? '';
    if (waterSourceStr.isNotEmpty) {
      selectedWaterSources = waterSourceStr
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    final gardenStr = data.landDetails.garden ?? '';
    if (gardenStr.isNotEmpty) {
      selectedGardens = gardenStr
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    final shedStr = data.landDetails.shedDetails ?? '';
    if (shedStr.isNotEmpty) {
      selectedSheds = shedStr
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    final farmPondStr = data.landDetails.farmPond ?? '';
    if (farmPondStr.isNotEmpty) {
      selectedFarmPonds = farmPondStr
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    // GPS Section
    latitudeController.text = data.gpsTracking.latitude ?? '';
    longitudeController.text = data.gpsTracking.longitude ?? '';
    selectedPath = _getValidValue(data.gpsTracking.roadPath, [
      "Concrete Road",
      "Mud Road",
      "No Connectivity",
      "Easy Access",
    ]);

    // Shed details
    shedDetailsController.text = data.landDetails.shedDetails ?? '';

    // Existing Media Files
    if (data.documentMedia.landPhotos != null) {
      existingPhotosUrls = List<String>.from(data.documentMedia.landPhotos!);
    }
    if (data.documentMedia.landVideos != null) {
      existingVideosUrls = List<String>.from(data.documentMedia.landVideos!);
    }

    print('Selected Water Sources: $selectedWaterSources');
    print('Selected Gardens: $selectedGardens');
    print('Selected Sheds: $selectedSheds');
    print('Selected Farm Ponds: $selectedFarmPonds');
    print('=== DATA LOADED SUCCESSFULLY ===');
  }

  // Helper to get valid value or default
  String? _getValidValue(String? value, List<String> validOptions) {
    if (value == null || value.isEmpty) {
      return validOptions.isNotEmpty ? validOptions[0] : null;
    }

    if (validOptions.contains(value)) {
      return value;
    } else {
      return validOptions.isNotEmpty ? validOptions[0] : null;
    }
  }

  // 🆕 MULTIPLE SELECTION HELPERS
  void _toggleWaterSource(String source) {
    setState(() {
      if (selectedWaterSources.contains(source)) {
        selectedWaterSources.remove(source);
      } else {
        selectedWaterSources.add(source);
      }
    });
  }

  void _toggleGarden(String garden) {
    setState(() {
      if (selectedGardens.contains(garden)) {
        selectedGardens.remove(garden);
      } else {
        selectedGardens.add(garden);
      }
    });
  }

  void _toggleShed(String shed) {
    setState(() {
      if (selectedSheds.contains(shed)) {
        selectedSheds.remove(shed);
      } else {
        selectedSheds.add(shed);
      }
    });
  }

  void _toggleFarmPond(String pond) {
    setState(() {
      selectedFarmPonds.clear(); // Purane sab select hatao
      selectedFarmPonds.add(pond); // Sirf current wala add karo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Land Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Update land information",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.edit, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Edit Land Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildAddressSection(),
                const SizedBox(height: 40),
                _buildFarmerDetails(),
                const SizedBox(height: 40),
                _buildDisputeSection(),
                const SizedBox(height: 40),
                _buildLandDetailsSection(),
                const SizedBox(height: 40),
                _buildGpsSection(),
                const SizedBox(height: 40),
                _buildDocumentsSection(),
                const SizedBox(height: 30),
                _buildSubmitButtons(),
                const SizedBox(height: 30),
              ],
            ),
          ),
          if (submitting)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  // ====================== Address Section ======================
  Widget _buildAddressSection() => _sectionContainer(
    title: "Village Address",
    children: [
      _labeledInputController(
        "State",
        "Enter state",
        Icons.location_on_outlined,
        stateController,
      ),
      const SizedBox(height: 20),
      _labeledInputController(
        "District",
        "Enter district",
        Icons.location_city_outlined,
        districtController,
      ),
      const SizedBox(height: 20),
      _labeledInputController(
        "Mandal",
        "Enter mandal",
        Icons.map_outlined,
        mandalController,
      ),
      const SizedBox(height: 20),
      _labeledInputController(
        "Village",
        "Enter village name",
        Icons.home_outlined,
        villageController,
      ),
    ],
  );

  // ====================== Farmer Details ======================
  Widget _buildFarmerDetails() => _sectionContainer(
    title: "Farmer Details",
    children: [
      _labeledInputController(
        "Farmer Name",
        "Enter Farmer's name",
        Icons.person_outline,
        farmerNameController,
      ),
      const SizedBox(height: 20),

      // Phone Number - Only numbers
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Phone Number",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: "Enter phone number",
              prefixIcon: const Icon(Icons.phone_outlined),
              counterText: "",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),

      // WhatsApp Section
      _buildWhatsAppSection(),

      const SizedBox(height: 25),

      // Literacy
      _labelWithIcon("Literacy", Icons.menu_book_outlined),
      _buildOptionGroupWithSelection(
        options: ["High School", "Illiterate", "Literate", "Graduate"],
        selectedValue: selectedLiteracy,
        onSelect: (val) => setState(() => selectedLiteracy = val),
      ),

      // Age Group
      _labelWithIcon("Age Group", Icons.person_outline),
      _buildOptionGroupWithSelection(
        options: ["Upto 30", "30-50", "50+"],
        selectedValue: selectedAgeGroup,
        onSelect: (val) => setState(() => selectedAgeGroup = val),
      ),

      // Nature
      _labelWithIcon("Nature", Icons.accessibility_new_outlined),
      _buildOptionGroupWithSelection(
        options: ["Calm", "Polite", "Medium", "Rude"],
        selectedValue: selectedNature,
        onSelect: (val) => setState(() => selectedNature = val),
      ),

      // Land Ownership
      _labelWithIcon("Land Ownership", Icons.percent_outlined),
      _buildOptionGroupWithSelection(
        options: ["Own", "Joint", "Single"],
        selectedValue: selectedOwnership,
        onSelect: (val) => setState(() => selectedOwnership = val),
      ),

      // Mortgage
      _labelWithIcon("Ready for Mortgage", Icons.thumb_up_alt_outlined),
      _buildOptionGroupWithSelection(
        options: ["Yes", "No"],
        selectedValue: selectedMortgage,
        onSelect: (val) => setState(() => selectedMortgage = val),
      ),
    ],
  );

  // WhatsApp Section
  Widget _buildWhatsAppSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom checkbox
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              isWhatsApp = !isWhatsApp;
              if (isWhatsApp) {
                otherWhatsappController.clear();
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isWhatsApp ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    color: isWhatsApp ? Colors.blue : Colors.transparent,
                  ),
                  child: isWhatsApp
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                const Text(
                  "This number has WhatsApp",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),

        if (!isWhatsApp) ...[
          const SizedBox(height: 10),

          // Other WhatsApp Number - Only numbers
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Other WhatsApp Number",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: otherWhatsappController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: "Enter other WhatsApp number",
                  prefixIcon: const Icon(Icons.wechat),
                  counterText: "",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  // ====================== Dispute Section ======================
  Widget _buildDisputeSection() => _sectionContainer(
    title: "Dispute Details",
    children: [
      // Dispute Type
      _labelWithIcon("Type of Dispute", Icons.report_problem_outlined),
      _buildOptionGroupWithSelection(
        options: [
          "Boundary",
          "Ownership",
          "Family",
          "Other",
          "Budhan",
          "Land Sealing",
          "Electric Poles",
          "Canal Planning",
          "None",
        ],
        selectedValue: selectedDisputeType,
        onSelect: (val) => setState(() => selectedDisputeType = val),
      ),

      // Siblings
      _labelWithIcon("Siblings Involved in Dispute", Icons.group_outlined),
      _buildOptionGroupWithSelection(
        options: ["Yes", "No"],
        selectedValue: selectedSibling,
        onSelect: (val) => setState(() => selectedSibling = val),
      ),

      // Path to Land
      _labelWithIcon("Path to Land", Icons.route_outlined),
      _buildOptionGroupWithSelection(
        options: ["Easy Access", "No Path to Land", "Concrete Road"],
        selectedValue: selectedPath,
        onSelect: (val) => setState(() => selectedPath = val),
      ),
    ],
  );

  // ====================== Land Details ======================
  Widget _buildLandDetailsSection() => _sectionContainer(
    title: "Land Details",
    children: [
      Row(
        children: [
          // Land Area (Acres) - Allows decimals
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Land Area (Acres)",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: landAreaController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  decoration: InputDecoration(
                    hintText: "e.g. 3.5",
                    prefixIcon: const Icon(Icons.square_foot_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),

          // Guntas - Only numbers
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Guntas",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: guntasController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "e.g. 12",
                    prefixIcon: const Icon(Icons.straighten_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),

      // Price per Acre - Only numbers
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price per Acre (in Rupees)",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: pricePerAcreController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: "e.g. 4500000",
              prefixIcon: const Icon(Icons.currency_rupee_outlined),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 20),

      // Total Land Value - Only numbers
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Land Value",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: totalLandPriceController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: "Calculated Automatically",
              prefixIcon: const Icon(Icons.calculate_outlined),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 20),

      // Passbook Photo
      _labelWithIcon("Passbook Photo", Icons.photo_library_outlined),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: _pickPassbookImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Change File",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: passbookImage == null
                  ? const Text(
                      "No file chosen",
                      style: TextStyle(color: Colors.grey),
                    )
                  : Row(
                      children: [
                        if (passbookImage!.existsSync())
                          Image.file(passbookImage!, height: 40, width: 40),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            path.basename(passbookImage!.path),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),

      // Land Type (Single Selection)
      _labelWithIcon("Land Type (Soil)", Icons.grass_outlined),
      _buildOptionGroupWithSelection(
        options: ["Red", "Black", "Sand"],
        selectedValue: selectedLandType,
        onSelect: (val) => setState(() => selectedLandType = val),
      ),

      // 🆕 WATER SOURCE - MULTIPLE SELECTION WITH GREEN COLOR
      _labelWithIcon("Water Source ", Icons.water_drop_outlined),
      _buildMultipleSelectionChips(
        options: ["tubewell", "Canal", "Bores", "Cheruvu", "Rain Water"],
        selectedOptions: selectedWaterSources,
        onToggle: _toggleWaterSource,
      ),

      // 🆕 GARDEN - MULTIPLE SELECTION WITH GREEN COLOR
      _labelWithIcon("Garden ", Icons.park_outlined),
      _buildMultipleSelectionChips(
        options: ["Mango", "Guava", "Coconut", "Sapota", "Other"],
        selectedOptions: selectedGardens,
        onToggle: _toggleGarden,
      ),

      // 🆕 SHED DETAILS - MULTIPLE SELECTION WITH GREEN COLOR
      _labelWithIcon("Shed Details ", Icons.agriculture_outlined),
      _buildMultipleSelectionChips(
        options: ["No", "Poultry", "Cow Shed"],
        selectedOptions: selectedSheds,
        onToggle: _toggleShed,
      ),

      // 🆕 FARM POND - MULTIPLE SELECTION WITH GREEN COLOR
      _labelWithIcon("Farm Pond ", Icons.water_outlined),
      _buildMultipleSelectionChips(
        options: ["Yes", "No"],
        selectedOptions: selectedFarmPonds,
        onToggle: _toggleFarmPond,
      ),

      // Residential (Single Selection)
      _labelWithIcon("Residential", Icons.home_work_outlined),
      _buildOptionGroupWithSelection(
        options: ["Yes", "Farm House", "RCC Home", "Asbestos Shelter", "Hut"],
        selectedValue: selectedResidential,
        onSelect: (val) => setState(() => selectedResidential = val),
      ),

      // Fencing (Single Selection)
      _labelWithIcon("Fencing", Icons.fence_outlined),
      _buildOptionGroupWithSelection(
        options: ["Complete", "With Gate", "All Sides", "Partially", "No"],
        selectedValue: selectedFencing,
        onSelect: (val) => setState(() => selectedFencing = val),
      ),
    ],
  );

  // 🆕 MULTIPLE SELECTION CHIPS WIDGET WITH GREEN COLOR
  Widget _buildMultipleSelectionChips({
    required List<String> options,
    required List<String> selectedOptions,
    required Function(String) onToggle,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final isSelected = selectedOptions.contains(option);
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (selected) => onToggle(option),
          selectedColor: Colors.blue.shade100, // ✅ blue COLOR
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          labelStyle: TextStyle(
            color: isSelected
                ? Colors.black
                : Colors.black87, // ✅ DARK GREEN TEXT
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        );
      }).toList(),
    );
  }

  // ====================== GPS & Path ======================
  Widget _buildGpsSection() => _sectionContainer(
    title: "GPS & Path Tracking",
    children: [
      // Road Path
      _labelWithIcon("Road Path", Icons.alt_route_outlined),
      _buildOptionGroupWithSelection(
        options: [
          "Concrete Road",
          "Mud Road",
          "No Connectivity",
          "Easy Access",
        ],
        selectedValue: selectedPath,
        onSelect: (val) => setState(() => selectedPath = val),
      ),
      const SizedBox(height: 20),

      // Coordinates
      _labelWithIcon("Coordinates", Icons.location_on_outlined),
      Row(
        children: [
          // Latitude - Allows decimals
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Latitude",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: latitudeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                  ],
                  decoration: InputDecoration(
                    hintText: "e.g. 28.60926",
                    prefixIcon: const Icon(Icons.gps_fixed),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),

          // Longitude - Allows decimals
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Longitude",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: longitudeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                  ],
                  decoration: InputDecoration(
                    hintText: "e.g. 77.03720",
                    prefixIcon: const Icon(Icons.gps_fixed),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      ElevatedButton.icon(
        onPressed: _getCurrentLocation,
        icon: const Icon(Icons.my_location_outlined),
        label: const Text("Get Current Location"),
        style: _outlinedButtonStyle(),
      ),
    ],
  );

  // ====================== Documents & Media ======================
  Widget _buildDocumentsSection() => _sectionContainer(
    title: "Documents & Media",
    children: [
      // EXISTING PHOTOS
      _labelWithIcon("Existing Land Photos", Icons.photo_library),
      if (existingPhotosUrls.isNotEmpty) ...[
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: existingPhotosUrls.map((url) {
            return GestureDetector(
              onTap: () => _showImageDialog(url),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _getFullImageUrl(url),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 15),
      ] else ...[
        const Text("No existing photos", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 15),
      ],

      // ADD NEW PHOTOS
      _labelWithIcon("Add New Photos", Icons.photo_camera_outlined),
      ElevatedButton.icon(
        onPressed: _pickLandPhotos,
        icon: const Icon(Icons.camera_alt_outlined),
        label: const Text("Add New Photos"),
        style: _outlinedButtonStyle(),
      ),
      const SizedBox(height: 10),

      // NEW PHOTOS PREVIEW
      if (landPhotos.isNotEmpty) ...[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: landPhotos.map((file) {
            return Stack(
              children: [
                Image.file(file, width: 80, height: 80, fit: BoxFit.cover),
                Positioned(
                  top: 2,
                  right: 2,
                  child: GestureDetector(
                    onTap: () => _removeLandPhoto(file),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],

      // EXISTING VIDEOS
      _labelWithIcon("Existing Land Videos", Icons.video_library),
      if (existingVideosUrls.isNotEmpty) ...[
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: existingVideosUrls.map((url) {
            return Container(
              width: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Icon(Icons.videocam, size: 40, color: Colors.blue),
                  const SizedBox(height: 4),
                  Text(
                    "Existing Video",
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 15),
      ] else ...[
        const Text("No existing videos", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 15),
      ],

      // ADD NEW VIDEOS
      _labelWithIcon("Add New Videos", Icons.videocam_outlined),
      ElevatedButton.icon(
        onPressed: _pickLandVideos,
        icon: const Icon(Icons.videocam_outlined),
        label: const Text("Add New Videos"),
        style: _outlinedButtonStyle(),
      ),
      const SizedBox(height: 10),

      // NEW VIDEOS PREVIEW
      if (landVideos.isNotEmpty) ...[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: landVideos.map((file) {
            return Container(
              width: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const Icon(Icons.videocam, size: 40),
                      Text(
                        path.basename(file.path),
                        style: const TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _removeLandVideo(file),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ],
  );

  // ✅ UPDATED SUBMIT BUTTONS WITH SAVE AS DRAFT
  Widget _buildSubmitButtons() => Column(
    children: [
      // Update Button (Submit)
      ElevatedButton.icon(
        onPressed: submitting ? null : () => _submitUpdate(isDraft: false),
        icon: const Icon(Icons.cloud_upload_outlined),
        label: submitting
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : const Text("Update Land"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700, // ✅ GREEN COLOR
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      const SizedBox(height: 15),

      // ✅ Save as Draft Button
      ElevatedButton.icon(
        onPressed: submitting ? null : () => _submitUpdate(isDraft: true),
        icon: const Icon(Icons.save_alt_outlined),
        label: submitting
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : const Text("Save as Draft"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade600,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      const SizedBox(height: 15),

      // Cancel Button
      ElevatedButton.icon(
        onPressed: submitting ? null : () => Navigator.pop(context),
        icon: const Icon(Icons.cancel_outlined),
        label: const Text("Cancel"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ],
  );

  // ====================== FIXED Option Group Widget ======================
  Widget _buildOptionGroupWithSelection({
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((text) {
        final isSelected = selectedValue == text;
        return GestureDetector(
          onTap: () => onSelect(text),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade100 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.blue.shade800 : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ====================== Helper Methods ======================
  void _removeLandPhoto(File file) {
    setState(() {
      landPhotos.remove(file);
    });
  }

  void _removeLandVideo(File file) {
    setState(() {
      landVideos.remove(file);
    });
  }

  String _getFullImageUrl(String url) {
    if (url.startsWith('http')) return url;
    return 'http://72.61.169.226/$url';
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(_getFullImageUrl(imageUrl)),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  // ✅ UPDATED SUBMIT METHOD WITH DRAFT SUPPORT
  Future<void> _submitUpdate({required bool isDraft}) async {
    if (_landId == null || _landId!.isEmpty) {
      _showErrorSnackbar('Land ID is missing. Cannot update.');
      return;
    }

    if (_apiToken == null || _apiToken!.isEmpty) {
      _showErrorSnackbar('Please login again. Token not found.');
      return;
    }

    if (farmerNameController.text.isEmpty) {
      _showErrorSnackbar('Please enter farmer name');
      return;
    }

    if (phoneController.text.isEmpty) {
      _showErrorSnackbar('Please enter phone number');
      return;
    }

    setState(() {
      submitting = true;
      this.isDraft = isDraft;
    });

    try {
      final response = await _updateLandDetails(isDraft: isDraft);

      if (response.statusCode == 200) {
        _showSuccessSnackbar(
          isDraft
              ? 'Saved as draft successfully!'
              : 'Land updated successfully!',
        );

        if (isDraft) {
          Navigator.pop(context, "draft");
        } else {
          Navigator.pop(context, "updated");
        }
      } else {
        _handleErrorResponse(response);
      }
    } catch (e) {
      print('Exception in submit: $e');
      _showErrorSnackbar('Error: ${e.toString()}');
    } finally {
      setState(() => submitting = false);
    }
  }

  Future<http.Response> _updateLandDetails({required bool isDraft}) async {
    if (_landId == null || _landId!.isEmpty) {
      throw Exception('Land ID is null or empty.');
    }

    final url = Uri.parse('http://72.61.169.226/field-executive/land/$_landId');

    var request = http.MultipartRequest('PUT', url);
    request.headers["Authorization"] = 'Bearer $_apiToken';

    // ============= ADD FORM FIELDS =============
    // Address fields
    request.fields['state'] = stateController.text.isNotEmpty
        ? stateController.text
        : '';
    request.fields['district'] = districtController.text.isNotEmpty
        ? districtController.text
        : '';
    request.fields['mandal'] = mandalController.text.isNotEmpty
        ? mandalController.text
        : '';
    request.fields['village'] = villageController.text.isNotEmpty
        ? villageController.text
        : '';
    request.fields['location'] = ''; // Hidden field

    // Farmer details
    request.fields['name'] = farmerNameController.text;
    request.fields['phone'] = phoneController.text;

    // WhatsApp number
    request.fields['whatsapp_number'] = phoneController.text;

    // Dropdown fields
    request.fields['literacy'] = selectedLiteracy ?? '';
    request.fields['age_group'] = selectedAgeGroup ?? '';
    request.fields['nature'] = selectedNature ?? '';
    request.fields['land_ownership'] = selectedOwnership ?? '';
    request.fields['mortgage'] = selectedMortgage ?? '';

    // Land details
    String landArea = landAreaController.text;
    if (landArea.isNotEmpty && !landArea.toLowerCase().contains('acres')) {
      landArea = '$landArea Acres';
    }
    request.fields['land_area'] = landArea.isNotEmpty ? landArea : '';

    request.fields['guntas'] = guntasController.text.isNotEmpty
        ? guntasController.text
        : '';
    request.fields['price_per_acre'] = pricePerAcreController.text.isNotEmpty
        ? pricePerAcreController.text
        : '';
    request.fields['total_land_price'] =
        totalLandPriceController.text.isNotEmpty
        ? totalLandPriceController.text
        : '';

    // Land characteristics - MULTIPLE SELECTIONS JOIN WITH COMMA
    request.fields['land_type'] = selectedLandType ?? '';
    request.fields['water_source'] = selectedWaterSources.join(',');
    request.fields['garden'] = selectedGardens.join(',');
    request.fields['shed'] = selectedSheds.join(
      ',',
    ); // ✅ CHANGED FROM shed_details TO shed
    request.fields['farm_pond'] = selectedFarmPonds.join(',');
    request.fields['residental'] = selectedResidential ?? '';
    request.fields['fencing'] = selectedFencing ?? '';

    // GPS and path
    request.fields['road_path'] = selectedPath ?? '';

    // Latitude and longitude
    String lat = latitudeController.text.isNotEmpty
        ? latitudeController.text
        : '';
    String lon = longitudeController.text.isNotEmpty
        ? longitudeController.text
        : '';
    if (lat.isNotEmpty && lon.isNotEmpty) {
      request.fields['latitude'] = '$lat,$lon';
      request.fields['longitude'] = '$lat,$lon';
    }

    // Dispute details
    request.fields['dispute_type'] = selectedDisputeType ?? '';
    request.fields['siblings_involve_in_dispute'] = selectedSibling ?? '';
    request.fields['path_to_land'] = selectedPath ?? '';

    // ✅ STATUS BASED ON DRAFT
    request.fields['status'] = isDraft ? 'false' : 'true';

    // ============= ADD FILES =============
    if (passbookImage != null && passbookImage!.existsSync()) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'passbook_photo',
          passbookImage!.path,
        ),
      );
    }

    for (var photo in landPhotos) {
      if (photo.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath('land_photo', photo.path),
        );
      }
    }

    for (var video in landVideos) {
      if (video.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath('land_video', video.path),
        );
      }
    }

    print('Sending update request for land: $_landId');
    print('Draft Mode: $isDraft');
    print('Status: ${isDraft ? 'false' : 'true'}');
    print('Water Sources: ${selectedWaterSources.join(',')}');
    print('Gardens: ${selectedGardens.join(',')}');
    print('Sheds: ${selectedSheds.join(',')}');
    print('Farm Ponds: ${selectedFarmPonds.join(',')}');

    try {
      final streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      print('Network error: $e');
      rethrow;
    }
  }

  void _handleErrorResponse(http.Response response) {
    try {
      final errorData = json.decode(response.body);
      _showErrorSnackbar(
        'Error: ${errorData['error'] ?? errorData['message'] ?? 'Failed to update'}',
      );
    } catch (e) {
      _showErrorSnackbar('Error ${response.statusCode}: ${response.body}');
    }
  }

  void _showSuccessSnackbar(String message, {Color color = Colors.green}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _pickPassbookImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => passbookImage = File(picked.path));
    }
  }

  Future<void> _pickLandPhotos() async {
    final picked = await _picker.pickMultiImage();
    if (picked != null && picked.isNotEmpty) {
      setState(() {
        landPhotos.addAll(picked.map((e) => File(e.path)));
      });
    }
  }

  Future<void> _pickLandVideos() async {
    final picked = await _picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => landVideos.add(File(picked.path)));
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      latitudeController.text = "28.60926";
      longitudeController.text = "77.03720";
    });
    _showSuccessSnackbar('Location captured');
  }

  // ====================== Reusable UI Components ======================
  Widget _sectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.grey[100],
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  Widget _inputField(
    String hint,
    IconData icon,
    TextEditingController? controller,
  ) => TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );

  Widget _labeledInputController(
    String label,
    String hint,
    IconData icon,
    TextEditingController controller,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 8),
      _inputField(hint, icon, controller),
    ],
  );

  Widget _labelWithIcon(String title, IconData icon) => Padding(
    padding: const EdgeInsets.only(top: 25, bottom: 10),
    child: Row(
      children: [
        Icon(icon, color: Colors.black87),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );

  ButtonStyle _outlinedButtonStyle() => ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    side: BorderSide(color: Colors.grey.shade300),
    minimumSize: const Size.fromHeight(50),
  );
}
