import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/landmodel.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as path;

class EditLandScreen extends StatefulWidget {
  final Datum landData;
  
  const EditLandScreen({super.key, required this.landData});

  @override
  State<EditLandScreen> createState() => _EditLandScreenState();
}

class _EditLandScreenState extends State<EditLandScreen> {
  // Controllers for text fields
  final TextEditingController mandalController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController farmerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otherWhatsappController = TextEditingController();
  final TextEditingController landAreaController = TextEditingController();
  final TextEditingController guntasController = TextEditingController();
  final TextEditingController pricePerAcreController = TextEditingController();
  final TextEditingController totalLandPriceController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
    final TextEditingController pincodecontroller = TextEditingController();

    final TextEditingController statecontroller = TextEditingController();
        final TextEditingController districtcontroller = TextEditingController();
  // Dropdown values
  String? selectedState;
  String? selectedDistrict;
  String? selectedLiteracy;
  String? selectedAgeGroup;
  String? selectedNature;
  String? selectedOwnership;
  String? selectedMortgage;
  String? selectedDisputeType;
  String? selectedSibling;
  String? selectedPath;
  String? selectedLandType;
  String? selectedWaterSource;
  String? selectedGarden;
  String? selectedShed;
  String? selectedFarmPond;
  String? selectedResidential;
  String? selectedFencing;

  // Checkbox
  bool isWhatsApp = false;

  // File pickers
  File? passbookImage;
  final List<File> mediaFiles = [];
  final ImagePicker _picker = ImagePicker();

  // GPS & Map
  List<LatLng> landBorderPoints = [];
  bool loadingGPS = false;
  bool submitting = false;

  // States and districts (you can replace with your actual data)
  final List<String> states = ['Andhra Pradesh', 'Telangana', 'Karnataka', 'Tamil Nadu'];
  final List<String> districts = ['Hyderabad', 'Rangareddy', 'Medak', 'Sangareddy'];

  @override
  void initState() {
    super.initState();
    // Pre-populate fields with existing data
    _populateExistingData();
  }

  void _populateExistingData() {
    final data = widget.landData;
    
    // Address Section from LandLocation
    statecontroller.text = data.landLocation.state;
    districtcontroller.text=data.landLocation.district.toString();
    mandalController.text = data.landLocation.mandal ?? '';
  
    villageController.text = data.landLocation.village ?? '';
    
    // Farmer Details
    farmerNameController.text = data.farmerDetails.name ?? '';
    phoneController.text = data.farmerDetails.phone ?? '';
    
    // Check if the phone number has WhatsApp
    isWhatsApp = data.farmerDetails.whatsappNumber != null && 
                data.farmerDetails.whatsappNumber!.isNotEmpty;
    
    otherWhatsappController.text = data.farmerDetails.whatsappNumber ?? '';
    selectedLiteracy = data.farmerDetails.literacy;
    selectedAgeGroup = data.farmerDetails.ageGroup;
    selectedNature = data.farmerDetails.nature;
    selectedOwnership = data.farmerDetails.landOwnership;
    selectedMortgage = data.farmerDetails.mortgage;
    
    // Dispute Details
    selectedDisputeType = data.disputeDetails.disputeType;
    selectedSibling = data.disputeDetails.siblingsInvolveInDispute;
    selectedPath = data.disputeDetails.pathToLand;
    
    // Land Details
    landAreaController.text = data.landDetails.landArea ?? '';
    guntasController.text = data.landDetails.guntas ?? '';
    pricePerAcreController.text = data.landDetails.pricePerAcre?.toString() ?? '';
    totalLandPriceController.text = data.landDetails.totalLandPrice?.toString() ?? '';
    selectedLandType = data.landDetails.landType;
    selectedWaterSource = data.landDetails.waterSource;
    selectedGarden = data.landDetails.garden;
    selectedShed = data.landDetails.shedDetails;
    selectedFarmPond = data.landDetails.farmPond;
    selectedResidential = data.landDetails.residental;
    selectedFencing = data.landDetails.fencing;
    
    // GPS Section
    latitudeController.text = data.gpsTracking.latitude ?? '';
    longitudeController.text = data.gpsTracking.longitude ?? '';
    selectedPath = data.gpsTracking.roadPath;
    
    // TODO: Load existing images/files if needed
    // passbookImage = data['passbookImage'];
    // mediaFiles = data['mediaFiles'];
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
      TextFormField(
        controller: statecontroller,
      //  keyboardType: TextInputType.number,
      //  maxLength: 6,
        decoration: InputDecoration(
          hintText: "Enter state",
          // prefixIcon: const Icon(Icons.search),
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      const SizedBox(height: 20),
       TextFormField(
        controller: districtcontroller,
      //  keyboardType: TextInputType.number,
      //  maxLength: 6,
        decoration: InputDecoration(
          hintText: "Enter state",
          // prefixIcon: const Icon(Icons.search),
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      
      // State dropdown
      // DropdownButtonFormField<String>(
      //   value: selectedState,
      //   decoration: _dropdownDecoration(" State", Icons.location_on),
      //   icon: const SizedBox.shrink(),
      //   items: states
      //       .map((state) => DropdownMenuItem(value: state, child: Text(state)))
      //       .toList(),
      //   onChanged: (value) => setState(() => selectedState = value),
      // ),
      const SizedBox(height: 20),

      // District dropdown
//      DropdownButtonFormField<String?>(
//   value: selectedDistrict,
//   decoration: _dropdownDecoration(" District", Icons.location_city_outlined),
//   icon: const SizedBox.shrink(),
//   items: [
//     DropdownMenuItem<String?>(
//       value: null,
//       child: Text(
//         'Select District',
//         style: TextStyle(color: Colors.grey),
//       ),
//     ),
//     ...districts.map((d) => DropdownMenuItem(
//       value: d,
//       child: Text(d),
//     )).toList(),
//     // Add API district if not in list
//     if (widget.landData.landLocation.district != null && 
//         !districts.contains(widget.landData.landLocation.district))
//       DropdownMenuItem(
//         value: widget.landData.landLocation.district,
//         child: Text(widget.landData.landLocation.district!),
//       ),
//   ],
//   onChanged: (value) => setState(() => selectedDistrict = value),
// ),
      const SizedBox(height: 20),

      // Pincode search button
      // SizedBox(
      //   width: double.infinity,
      //   child: ElevatedButton.icon(
      //     onPressed: loadingGPS ? null : fetchAddressFromPincode,
      //     icon: const Icon(Icons.search, color: Colors.black87),
      //     label: const Text(
      //       "SEARCH PINCODE",
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         color: Colors.black87,
      //       ),
      //     ),
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: Colors.white,
      //       padding: const EdgeInsets.symmetric(vertical: 14),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //     ),
      //   ),
      // ),
      const SizedBox(height: 20),

      // Mandal
      TextFormField(
        controller: mandalController,
        decoration: InputDecoration(
          hintText: "Enter Mandal",
          prefixIcon: const Icon(Icons.map_outlined),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      const SizedBox(height: 20),

      // Village
      TextFormField(
        controller: villageController,
        decoration: InputDecoration(
          hintText: "Enter Village Name",
          prefixIcon: const Icon(Icons.home_outlined),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      const SizedBox(height: 20),

      // Capture GPS button
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: loadingGPS ? null : fetchVillageGPSAndAddress,
          icon: const Icon(Icons.gps_fixed, color: Colors.black87),
          label: Text(
            loadingGPS ? 'Capturing...' : 'Capture GPS',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
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
      _labeledInputController(
        "Phone Number",
        "Enter phone number",
        Icons.phone_outlined,
        phoneController,
      ),
      Row(
        children: [
          Checkbox(
            value: isWhatsApp,
            onChanged: (v) => setState(() => isWhatsApp = v!),
          ),
          const Text(
            "This number has WhatsApp",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      const SizedBox(height: 10),
      _labeledInputController(
        "Other WhatsApp Number",
        "Enter other WhatsApp number",
        Icons.wechat,
        otherWhatsappController,
      ),
      const SizedBox(height: 25),
      _labelWithIcon("Literacy", Icons.menu_book_outlined),
      _optionGroup(
        ["High School", "Illiterate", "Literate", "Graduate"],
        selectedLiteracy,
        (val) => setState(() => selectedLiteracy = val),
      ),
      _labelWithIcon("Age Group", Icons.person_outline),
      _optionGroup(
        ["Upto 30", "30-50", "50+"],
        selectedAgeGroup,
        (val) => setState(() => selectedAgeGroup = val),
      ),
      _labelWithIcon("Nature", Icons.accessibility_new_outlined),
      _optionGroup(
        ["Calm", "Polite", "Medium", "Rude"],
        selectedNature,
        (val) => setState(() => selectedNature = val),
      ),
      _labelWithIcon("Land Ownership", Icons.percent_outlined),
      _optionGroup(
        ["Own", "Joint", "Single"],
        selectedOwnership,
        (val) => setState(() => selectedOwnership = val),
      ),
      _labelWithIcon("Ready for Mortgage", Icons.thumb_up_alt_outlined),
      _optionGroup(
        ["Yes", "No"],
        selectedMortgage,
        (val) => setState(() => selectedMortgage = val),
      ),
    ],
  );

  // ====================== Dispute Section ======================
  Widget _buildDisputeSection() => _sectionContainer(
    title: "Dispute Details",
    children: [
      _labelWithIcon("Type of Dispute", Icons.report_problem_outlined),
      _optionGroup(
        [
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
        selectedDisputeType,
        (val) => setState(() => selectedDisputeType = val),
      ),
      _labelWithIcon("Siblings Involved in Dispute", Icons.group_outlined),
      _optionGroup(
        ["Yes", "No"],
        selectedSibling,
        (val) => setState(() => selectedSibling = val),
      ),
      _labelWithIcon("Path to Land", Icons.route_outlined),
      _optionGroup(
        ["Easy Access", "No Path to Land"],
        selectedPath,
        (val) => setState(() => selectedPath = val),
      ),
    ],
  );

  // ====================== Land Details ======================
  Widget _buildLandDetailsSection() => _sectionContainer(
    title: "Land Details",
    children: [
      Row(
        children: [
          Expanded(
            flex: 2,
            child: _labeledInputController(
              "Land Area (Acres)",
              "e.g. 3.5",
              Icons.square_foot_outlined,
              landAreaController,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 1,
            child: _labeledInputController(
              "Guntas",
              "e.g. 12",
              Icons.straighten_outlined,
              guntasController,
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      _labeledInputController(
        "Price per Acre (in Rupees)",
        "e.g. 4500000",
        Icons.currency_rupee_outlined,
        pricePerAcreController,
      ),
      const SizedBox(height: 20),
      _labeledInputController(
        "Total Land Value",
        "Calculated Automatically",
        Icons.calculate_outlined,
        totalLandPriceController,
      ),
      const SizedBox(height: 20),
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
              onPressed: pickPassbookImage,
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
                        Image.file(passbookImage!, height: 40),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            passbookImage!.path.split('/').last,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      _labelWithIcon("Land Type (Soil)", Icons.grass_outlined),
      _optionGroup(
        ["agri", "Red", "Black", "Sandy"],
        selectedLandType,
        (val) => setState(() => selectedLandType = val),
      ),
      _labelWithIcon("Water Source", Icons.water_drop_outlined),
      _optionGroup(
        ["tubewell", "Canal", "Bores", "Cheruvu", "Rain Water"],
        selectedWaterSource,
        (val) => setState(() => selectedWaterSource = val),
      ),
      _labelWithIcon("Garden", Icons.park_outlined),
      _optionGroup(
        ["Yes", "No", "Mango", "Guava", "Coconut", "Sapota", "Other"],
        selectedGarden,
        (val) => setState(() => selectedGarden = val),
      ),
      _labelWithIcon("Shed Details", Icons.agriculture_outlined),
      _optionGroup(
        ["No", "Poultry", "Cow Shed"],
        selectedShed,
        (val) => setState(() => selectedShed = val),
      ),
      _labelWithIcon("Farm Pond", Icons.water_outlined),
      _optionGroup(
        ["Yes", "No"],
        selectedFarmPond,
        (val) => setState(() => selectedFarmPond = val),
      ),
      _labelWithIcon("Residential", Icons.home_work_outlined),
      _optionGroup(
        ["Yes", "Farm House", "RCC Home", "Asbestos Shelter", "Hut"],
        selectedResidential,
        (val) => setState(() => selectedResidential = val),
      ),
      _labelWithIcon("Fencing", Icons.fence_outlined),
      _optionGroup(
        ["Complete", "With Gate", "All Sides", "Partially", "No"],
        selectedFencing,
        (val) => setState(() => selectedFencing = val),
      ),
    ],
  );

  // ====================== GPS & Path ======================
  Widget _buildGpsSection() => _sectionContainer(
    title: "GPS & Path Tracking",
    children: [
      _labelWithIcon("Path from Main Road", Icons.alt_route_outlined),
      _optionGroup(
        ["Attached to Road", "No Connectivity", "Easy Access"],
        selectedPath,
        (val) => setState(() => selectedPath = val),
      ),
      const SizedBox(height: 20),
      // ElevatedButton.icon(
      //   onPressed: openMapForBorder,
      //   icon: const Icon(Icons.route_outlined),
      //   label: const Text("Record a Path"),
      //   style: _outlinedButtonStyle(),
      // ),
      const SizedBox(height: 20),
      _labelWithIcon("Land Entry Point (Coordinates)", Icons.location_on_outlined),
      Row(
        children: [
          Expanded(
            child: _labeledInputController(
              "Latitude",
              "e.g. 17.4502",
              Icons.gps_fixed,
              latitudeController,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _labeledInputController(
              "Longitude",
              "e.g. 78.3654",
              Icons.gps_fixed,
              longitudeController,
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      ElevatedButton.icon(
        onPressed: getCurrentLatLong,
        icon: const Icon(Icons.my_location_outlined),
        label: const Text("Update Location"),
        style: _outlinedButtonStyle(),
      ),
      const SizedBox(height: 20),
      // _labelWithIcon("Land Border", Icons.map_outlined),
      // ElevatedButton.icon(
      //   onPressed: openMapForBorder,
      //   icon: const Icon(Icons.map_outlined),
      //   label: const Text("Edit Land Border"),
      //   style: _outlinedButtonStyle(),
      // ),
      if (landBorderPoints.isNotEmpty) ...[
        const SizedBox(height: 12),
        Text("Border points: ${landBorderPoints.length}"),
      ],
    ],
  );

  // ====================== Documents & Media ======================
  Widget _buildDocumentsSection() => _sectionContainer(
    title: "Documents & Media",
    children: [
      _labelWithIcon("Land Photos", Icons.photo_camera_outlined),
      ElevatedButton.icon(
        onPressed: () async {
          final picked = await _picker.pickMultiImage();
          if (picked != null && picked.isNotEmpty) {
            setState(() {
              mediaFiles.addAll(picked.map((e) => File(e.path)));
            });
          }
        },
        icon: const Icon(Icons.camera_alt_outlined),
        label: const Text("Add More Photos"),
        style: _outlinedButtonStyle(),
      ),
      const SizedBox(height: 20),
      _labelWithIcon("Land Videos", Icons.videocam_outlined),
      ElevatedButton.icon(
        onPressed: () async {
          final picked = await _picker.pickVideo(source: ImageSource.gallery);
          if (picked != null) setState(() => mediaFiles.add(File(picked.path)));
        },
        icon: const Icon(Icons.videocam_outlined),
        label: const Text("Add More Videos"),
        style: _outlinedButtonStyle(),
      ),
      const SizedBox(height: 20),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: mediaFiles.map((f) {
          final ext = f.path.split('.').last.toLowerCase();
          if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
            return GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (_) => Dialog(child: Image.file(f)),
              ),
              child: Stack(
                children: [
                  Image.file(f, width: 90, height: 90, fit: BoxFit.cover),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () => _removeMediaFile(f),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.insert_drive_file,
                        size: 28,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 6),
                      Flexible(
                        child: Text(
                          f.path.split('/').last,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _removeMediaFile(f),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }).toList(),
      ),
    ],
  );

  Widget _buildSubmitButtons() => Column(
    children: [
      // ------------------ Update Button ------------------
      ElevatedButton.icon(
        onPressed: (){
          
        },
       // onPressed: () => _submitUpdate(),
        icon: const Icon(Icons.save_outlined),
        label: const Text("Update Land Details"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      const SizedBox(height: 15),

      // ------------------ Save as Draft ------------------
      // ElevatedButton.icon(
      //   onPressed: () => _saveAsDraft(),
      //   icon: const Icon(Icons.save_alt_outlined),
      //   label: const Text("Save as Draft"),
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: Colors.grey.shade600,
      //     foregroundColor: Colors.white,
      //     minimumSize: const Size.fromHeight(55),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //   ),
      // ),
      // const SizedBox(height: 15),

      // // ------------------ Cancel Button ------------------
      // ElevatedButton.icon(
      //   onPressed: () => Navigator.pop(context),
      //   icon: const Icon(Icons.cancel_outlined),
      //   label: const Text("Cancel"),
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: Colors.red.shade600,
      //     foregroundColor: Colors.white,
      //     minimumSize: const Size.fromHeight(55),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //   ),
      // ),
    ],
  );

  // ====================== Helper Methods ======================
  void _removeMediaFile(File file) {
    setState(() {
      mediaFiles.remove(file);
    });
  }

  //  Future<void> _submitUpdate() async {
  //   setState(() {
  //     submitting = true;
  //     isDraft = false;
  //   });

  //   try {
  //     final response = await _updateLandDetails();
      
  //     if (response.statusCode == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Land details updated successfully!'),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //       Navigator.pop(context, true); // Return success
  //     } else {
  //       final errorData = json.decode(response.body);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error: ${errorData['message'] ?? 'Failed to update land details'}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       submitting = false;
  //     });
  //   }
  // }

  // Future<void> _saveAsDraft() async {
  //   setState(() {
  //     submitting = true;
  //     isDraft = true;
  //   });

  //   try {
  //     final response = await _updateLandDetails(isDraft: true);
      
  //     if (response.statusCode == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Saved as draft successfully!'),
  //           backgroundColor: Colors.blue,
  //         ),
  //       );
  //     } else {
  //       final errorData = json.decode(response.body);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error: ${errorData['message'] ?? 'Failed to save draft'}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       submitting = false;
  //     });
  //   }
  // }

  // Future<http.Response> _updateLandDetails({bool isDraft = false}) async {
  //   final url = Uri.parse('http://72.61.169.226/field-executive/land/${widget.landData.id}');
    
  //   var request = http.MultipartRequest('PUT', url);
    
  //   // Add headers
  //   request.headers['Authorization'] = 'Bearer ${widget.authToken}';
    
  //   // Add form fields
  //   request.fields['state'] = selectedState ?? '';
  //   request.fields['district'] = selectedDistrict ?? '';
  //   request.fields['mandal'] = mandalController.text;
  //   request.fields['village'] = villageController.text;
  //   request.fields['name'] = farmerNameController.text;
  //   request.fields['phone'] = phoneController.text;
  //   request.fields['whatsapp_number'] = isWhatsApp ? phoneController.text : otherWhatsappController.text;
  //   request.fields['literacy'] = selectedLiteracy ?? '';
  //   request.fields['age_group'] = selectedAgeGroup ?? '';
  //   request.fields['nature'] = selectedNature ?? '';
  //   request.fields['land_ownership'] = selectedOwnership ?? '';
  //   request.fields['mortgage'] = selectedMortgage ?? '';
  //   request.fields['land_area'] = landAreaController.text;
  //   request.fields['guntas'] = guntasController.text;
  //   request.fields['price_per_acre'] = pricePerAcreController.text;
  //   request.fields['total_land_price'] = totalLandPriceController.text;
  //   request.fields['land_type'] = selectedLandType ?? '';
  //   request.fields['water_source'] = selectedWaterSource ?? '';
  //   request.fields['garden'] = selectedGarden ?? '';
  //   request.fields['shed_details'] = selectedShed ?? '';
  //   request.fields['farm_pond'] = selectedFarmPond ?? '';
  //   request.fields['residental'] = selectedResidential ?? '';
  //   request.fields['fencing'] = selectedFencing ?? '';
  //   request.fields['road_path'] = selectedRoadPath ?? '';
    
  //   // Combine latitude and longitude
  //   if (latitudeController.text.isNotEmpty && longitudeController.text.isNotEmpty) {
  //     request.fields['latitude'] = '${latitudeController.text},${longitudeController.text}';
  //     request.fields['longitude'] = '${latitudeController.text},${longitudeController.text}';
  //   }
    
  //   request.fields['dispute_type'] = selectedDisputeType ?? '';
  //   request.fields['siblings_involve_in_dispute'] = selectedSibling ?? '';
  //   request.fields['path_to_land'] = selectedPath ?? '';
  //   request.fields['status'] = isDraft ? 'false' : 'true';
    
  //   // Add passbook photo
  //   if (passbookImage != null) {
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'passbook_photo',
  //         passbookImage!.path,
  //         filename: 'passbook_${DateTime.now().millisecondsSinceEpoch}${path.extension(passbookImage!.path)}',
  //       ),
  //     );
  //   }
    
  //   // Add land border file
  //   if (landBorderFile != null) {
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'land_border',
  //         landBorderFile!.path,
  //         filename: 'border_${DateTime.now().millisecondsSinceEpoch}${path.extension(landBorderFile!.path)}',
  //       ),
  //     );
  //   }
    
  //   // Add land photos
  //   for (var photo in landPhotos) {
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'land_photo',
  //         photo.path,
  //         filename: 'photo_${DateTime.now().millisecondsSinceEpoch}_${landPhotos.indexOf(photo)}${path.extension(photo.path)}',
  //       ),
  //     );
  //   }
    
  //   // Add land videos
  //   for (var video in landVideos) {
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'land_video',
  //         video.path,
  //         filename: 'video_${DateTime.now().millisecondsSinceEpoch}_${landVideos.indexOf(video)}${path.extension(video.path)}',
  //       ),
  //     );
  //   }
    
  //   final streamedResponse = await request.send();
  //   return await http.Response.fromStream(streamedResponse);
  // },

  // void _saveAsDraft() {
  //   // Implement save as draft logic
  //   setState(() => submitting = true);
  //   // TODO: API call to save as draft
  //   Future.delayed(const Duration(seconds: 2), () {
  //     setState(() => submitting = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Saved as draft successfully!')),
  //     );
  //   });
  // }

  Future<void> pickPassbookImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => passbookImage = File(picked.path));
    }
  }

  Future<void> fetchAddressFromPincode() async {
    // TODO: Implement pincode lookup
  }

  Future<void> fetchVillageGPSAndAddress() async {
    // TODO: Implement GPS capture
  }

  Future<void> getCurrentLatLong() async {
    // TODO: Implement current location
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

  InputDecoration _dropdownDecoration(String hint, IconData icon) =>
      InputDecoration(
        prefixIcon: Icon(icon),
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      );

  Widget _inputField(
    String hint,
    IconData icon, [
    TextEditingController? controller,
  ]) => TextFormField(
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

  Widget _optionGroup(
    List<String> options,
    String? selectedValue,
    Function(String) onSelect,
  ) => Wrap(
    spacing: 12,
    runSpacing: 12,
    children: options
        .map((text) => _buildOptionBox(text, selectedValue, onSelect))
        .toList(),
  );

  Widget _buildOptionBox(
    String text,
    String? selectedValue,
    Function(String) onSelect,
  ) {
    final bool isSelected = selectedValue == text;
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
  }

  ButtonStyle _outlinedButtonStyle() => ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    side: BorderSide(color: Colors.grey.shade300),
    minimumSize: const Size.fromHeight(50),
  );
}