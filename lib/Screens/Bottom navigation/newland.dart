// // // ignore_for_file: depend_on_referenced_packages

// // // lib/new_land_page.dart
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // class NewLandPage extends StatefulWidget {
// //   const NewLandPage({super.key});

// //   @override
// //   State<NewLandPage> createState() => _NewLandPageState();
// // }

// // class _NewLandPageState extends State<NewLandPage> {
// //   // Basic state fields (kept same names + controllers for GPS fields)
// //   bool isWhatsApp = false;

// //   String? selectedState;
// //   String? selectedDistrict;

// //   // selection variables (kept)
// //   String? selectedLiteracy;
// //   String? selectedAgeGroup;
// //   String? selectedNature;
// //   String? selectedOwnership;
// //   String? selectedMortgage;
// //   String? selectedDisputeType;
// //   String? selectedSibling;
// //   String? selectedPath;
// //   String? selectedLandType;
// //   String? selectedWaterSource;
// //   String? selectedGarden;
// //   String? selectedShed;
// //   String? selectedFarmPond;
// //   String? selectedResidential;
// //   String? selectedFencing;

// //   final List<String> states = [
// //     'Telangana',
// //     'Andhra Pradesh',
// //     'Karnataka',
// //     'Tamil Nadu',
// //   ];

// //   final List<String> districts = [
// //     'Ranga Reddy',
// //     'Hyderabad',
// //     'Medchal',
// //     'Nizamabad',
// //   ];

// //   // Controllers for village and coordinates
// //   final TextEditingController villageController = TextEditingController();
// //   final TextEditingController latitudeController = TextEditingController();
// //   final TextEditingController longitudeController = TextEditingController();

// //   // Passbook image
// //   File? passbookImage;

// //   // Media / Documents list
// //   List<File> mediaFiles = [];

// //   // Land border points returned from map
// //   List<LatLng> landBorderPoints = [];

// //   bool loadingGPS = false;

// //   final ImagePicker _picker = ImagePicker();

// //   @override
// //   void dispose() {
// //     villageController.dispose();
// //     latitudeController.dispose();
// //     longitudeController.dispose();
// //     super.dispose();
// //   }

// //   // ---------------- GPS & Reverse Geocoding ----------------
// //   Future<bool> _ensureLocationPermission() async {
// //     LocationPermission p = await Geolocator.checkPermission();
// //     if (p == LocationPermission.denied) {
// //       p = await Geolocator.requestPermission();
// //     }
// //     if (p == LocationPermission.deniedForever ||
// //         p == LocationPermission.denied) {
// //       // cannot proceed
// //       return false;
// //     }
// //     return true;
// //   }

// //   Future<void> fetchVillageGPSAndAddress() async {
// //     setState(() => loadingGPS = true);

// //     final serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       await Geolocator.openLocationSettings();
// //       setState(() => loadingGPS = false);
// //       return;
// //     }

// //     final ok = await _ensureLocationPermission();
// //     if (!ok) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Location permission required')),
// //       );
// //       setState(() => loadingGPS = false);
// //       return;
// //     }

// //     try {
// //       final pos = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );
// //       latitudeController.text = pos.latitude.toStringAsFixed(6);
// //       longitudeController.text = pos.longitude.toStringAsFixed(6);

// //       // reverse geocode to get locality/village
// //       final placemarks = await placemarkFromCoordinates(
// //         pos.latitude,
// //         pos.longitude,
// //       );
// //       if (placemarks.isNotEmpty) {
// //         final p = placemarks.first;
// //         // try different fields for village/locality
// //         final village =
// //             p.locality ??
// //             p.subLocality ??
// //             p.subAdministrativeArea ??
// //             p.name ??
// //             '';
// //         villageController.text = village;
// //       }
// //     } catch (e) {
// //       // handle error
// //       debugPrint("fetchVillageGPS error: $e");
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Failed to get location: $e')));
// //     } finally {
// //       setState(() => loadingGPS = false);
// //     }
// //   }

// //   // This is used by the GPS & Path Tracking "Get Location" button (fills lat/long)
// //   Future<void> getCurrentLatLong() async {
// //     final serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       await Geolocator.openLocationSettings();
// //       return;
// //     }
// //     final ok = await _ensureLocationPermission();
// //     if (!ok) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Location permission required')),
// //       );
// //       return;
// //     }

// //     try {
// //       final pos = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.best,
// //       );
// //       latitudeController.text = pos.latitude.toStringAsFixed(6);
// //       longitudeController.text = pos.longitude.toStringAsFixed(6);
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(const SnackBar(content: Text('Location captured')));
// //     } catch (e) {
// //       debugPrint('getCurrentLatLong error: $e');
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Failed to capture location: $e')));
// //     }
// //   }

// //   // ---------------- Passbook Upload (camera/gallery) ----------------
// //   Future<void> pickPassbookImage() async {
// //     final statusCamera = await Permission.camera.request();
// //     final statusStorage = await Permission.photos
// //         .request(); // for iOS/Android13 mapping
// //     if (!statusCamera.isGranted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Camera permission required')),
// //       );
// //       return;
// //     }

// //     final picked = await showModalBottomSheet<XFile?>(
// //       context: context,
// //       builder: (_) => _chooseImageSourceBottomSheet(),
// //     );

// //     if (picked != null) {
// //       setState(() => passbookImage = File(picked.path));
// //     }
// //   }

// //   Widget _chooseImageSourceBottomSheet() {
// //     return SafeArea(
// //       child: Wrap(
// //         children: [
// //           ListTile(
// //             leading: const Icon(Icons.camera_alt),
// //             title: const Text('Camera'),
// //             onTap: () async {
// //               Navigator.pop(
// //                 context,
// //                 await _picker.pickImage(source: ImageSource.camera),
// //               );
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.photo),
// //             title: const Text('Gallery'),
// //             onTap: () async {
// //               Navigator.pop(
// //                 context,
// //                 await _picker.pickImage(source: ImageSource.gallery),
// //               );
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.close),
// //             title: const Text('Cancel'),
// //             onTap: () => Navigator.pop(context, null),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ---------------- Media / Documents Upload ----------------
// //   Future<void> pickMediaAndDocs() async {
// //     // request storage / photos permission
// //     await Permission.storage.request();
// //     await Permission.photos.request();

// //     final result = await FilePicker.platform.pickFiles(
// //       allowMultiple: true,
// //       type: FileType.any,
// //       //allowedExtensions: ['jpg','png','mp4','pdf','doc','docx'],
// //     );

// //     if (result != null && result.paths.isNotEmpty) {
// //       setState(() {
// //         mediaFiles.addAll(
// //           result.paths.where((p) => p != null).map((p) => File(p!)),
// //         );
// //       });
// //     }
// //   }

// //   // ---------------- Draw Land Border (open map and get polygon) ----------------
// //   Future<void> openMapForBorder() async {
// //     // navigate to map screen and await points
// //     final points = await Navigator.push<List<LatLng>>(
// //       context,
// //       MaterialPageRoute(
// //         builder: (_) => LandBorderMapScreen(initialPoints: landBorderPoints),
// //       ),
// //     );

// //     if (points != null) {
// //       setState(() {
// //         landBorderPoints = points;
// //       });
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Border captured: ${points.length} points')),
// //       );
// //     }
// //   }

// //   // ---------------- Submit / Save (simple mock) ----------------
// //   void submitNewLand() {
// //     // Basic validation sample:
// //     if (villageController.text.isEmpty ||
// //         latitudeController.text.isEmpty ||
// //         longitudeController.text.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Please capture GPS/location before submit'),
// //         ),
// //       );
// //       return;
// //     }

// //     // Collect data and send to backend / local DB...
// //     // For demo - just show success
// //     ScaffoldMessenger.of(
// //       context,
// //     ).showSnackBar(const SnackBar(content: Text('New Land submitted (mock)')));
// //   }

// //   // ====================== UI BUILD (keeps your original structure + functionality) ======================
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         toolbarHeight: 80,
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             const Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "Suresh",
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 SizedBox(height: 4),
// //                 Text(
// //                   "Field Executive",
// //                   style: TextStyle(fontSize: 14, color: Colors.grey),
// //                 ),
// //               ],
// //             ),
// //             CircleAvatar(
// //               radius: 24,
// //               backgroundColor: Colors.green,
// //               child: const Icon(Icons.person, color: Colors.white, size: 28),
// //             ),
// //           ],
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               "New Land Details",
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 20),
// //             _buildAddressSection(),
// //             const SizedBox(height: 40),
// //             _buildFarmerDetails(),
// //             const SizedBox(height: 40),
// //             _buildDisputeSection(),
// //             const SizedBox(height: 40),
// //             _buildLandDetailsSection(), // 👈 Land Details
// //             const SizedBox(height: 40),
// //             _buildGpsSection(), // 👈 GPS & Path Tracking (after Land Details)
// //             const SizedBox(height: 40),
// //             _buildDocumentsSection(), // 👈 Documents & Media (after GPS)
// //             const SizedBox(height: 30),
// //             _buildSubmitButtons(), // 👈 Submit & Save
// //             const SizedBox(height: 30),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ====================== Address Section (with GPS capture) ======================

// //   Widget _buildAddressSection() => _sectionContainer(
// //     title: "Village Address",
// //     children: [
// //       DropdownButtonFormField<String>(
// //         value: selectedState,
// //         decoration: _dropdownDecoration("Select State", Icons.location_on),
// //         items: states
// //             .map((state) => DropdownMenuItem(value: state, child: Text(state)))
// //             .toList(),
// //         onChanged: (value) => setState(() => selectedState = value),
// //       ),

// //       SizedBox(height: 20),

// //       DropdownButtonFormField<String>(
// //         value: selectedDistrict,
// //         decoration: _dropdownDecoration(
// //           "Select District",
// //           Icons.location_city_outlined,
// //         ),
// //         items: districts
// //             .map((d) => DropdownMenuItem(value: d, child: Text(d)))
// //             .toList(),
// //         onChanged: (value) => setState(() => selectedDistrict = value),
// //       ),

// //       SizedBox(height: 20),

// //       TextFormField(
// //         controller: villageController,
// //         decoration: InputDecoration(
// //           hintText: "Enter Village Name",
// //           prefixIcon: Icon(Icons.home_outlined),
// //           filled: true,
// //           fillColor: Colors.white,
// //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
// //         ),
// //       ),

// //       SizedBox(height: 20),

// //       SizedBox(
// //         width: double.infinity, // FULL WIDTH
// //         child: ElevatedButton.icon(
// //           onPressed: loadingGPS ? null : fetchVillageGPSAndAddress,
// //           icon: Icon(Icons.gps_fixed),
// //           label: Text(loadingGPS ? 'Capturing...' : 'Capture GPS'),
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: Colors.green,
// //             padding: EdgeInsets.symmetric(vertical: 16),
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //           ),
// //         ),
// //       ),
// //     ],
// //   );

// //   // ====================== Farmer Details ======================
// //   Widget _buildFarmerDetails() => _sectionContainer(
// //     title: "Farmer Details",
// //     children: [
// //       _labeledInput("Farmer Name", "Enter Farmer's name", Icons.person_outline),
// //       const SizedBox(height: 20),
// //       _labeledInput("Phone Number", "Enter phone number", Icons.phone_outlined),
// //       Row(
// //         children: [
// //           Checkbox(
// //             value: isWhatsApp,
// //             onChanged: (v) => setState(() => isWhatsApp = v!),
// //           ),
// //           const Text(
// //             "This number has WhatsApp",
// //             style: TextStyle(fontSize: 16),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 10),
// //       _labeledInput(
// //         "Other WhatsApp Number",
// //         "Enter other WhatsApp number",
// //         Icons.wechat,
// //       ),
// //       const SizedBox(height: 25),

// //       // Literacy
// //       _labelWithIcon("Literacy", Icons.menu_book_outlined),
// //       _optionGroup(
// //         ["Illiterate", "Literate", "Graduate"],
// //         selectedLiteracy,
// //         (val) => setState(() => selectedLiteracy = val),
// //       ),

// //       // Age
// //       _labelWithIcon("Age Group", Icons.person_outline),
// //       _optionGroup(
// //         ["Upto 30", "30-50", "50+"],
// //         selectedAgeGroup,
// //         (val) => setState(() => selectedAgeGroup = val),
// //       ),

// //       // Nature
// //       _labelWithIcon("Nature", Icons.accessibility_new_outlined),
// //       _optionGroup(
// //         ["Polite", "Medium", "Rude"],
// //         selectedNature,
// //         (val) => setState(() => selectedNature = val),
// //       ),

// //       // Ownership
// //       _labelWithIcon("Land Ownership", Icons.percent_outlined),
// //       _optionGroup(
// //         ["Joint", "Single"],
// //         selectedOwnership,
// //         (val) => setState(() => selectedOwnership = val),
// //       ),

// //       // Mortgage
// //       _labelWithIcon("Ready for Mortgage", Icons.thumb_up_alt_outlined),
// //       _optionGroup(
// //         ["Yes", "No"],
// //         selectedMortgage,
// //         (val) => setState(() => selectedMortgage = val),
// //       ),
// //     ],
// //   );

// //   // ====================== Dispute Section ======================
// //   Widget _buildDisputeSection() => _sectionContainer(
// //     title: "Dispute Details",
// //     children: [
// //       _labelWithIcon("Type of Dispute", Icons.report_problem_outlined),
// //       _optionGroup(
// //         [
// //           "Boundary",
// //           "Ownership",
// //           "Family",
// //           "Other",
// //           "Budhan",
// //           "Land Sealing",
// //           "Electric Poles",
// //           "Canal Planning",
// //         ],
// //         selectedDisputeType,
// //         (val) => setState(() => selectedDisputeType = val),
// //       ),
// //       _labelWithIcon("Siblings Involved in Dispute", Icons.group_outlined),
// //       _optionGroup(
// //         ["Yes", "No"],
// //         selectedSibling,
// //         (val) => setState(() => selectedSibling = val),
// //       ),
// //       _labelWithIcon("Path to Land", Icons.route_outlined),
// //       _optionGroup(
// //         ["No Path to Land"],
// //         selectedPath,
// //         (val) => setState(() => selectedPath = val),
// //       ),
// //     ],
// //   );

// //   // ====================== Land Details Section ======================
// //   Widget _buildLandDetailsSection() => _sectionContainer(
// //     title: "Land Details",
// //     children: [
// //       // 👇 Row for Acres + Guntas
// //       Row(
// //         children: [
// //           Expanded(
// //             flex: 2,
// //             child: _labeledInput(
// //               "Land Area (Acres)",
// //               "e.g. 3.5",
// //               Icons.square_foot_outlined,
// //             ),
// //           ),
// //           const SizedBox(width: 15),
// //           Expanded(
// //             flex: 1,
// //             child: _labeledInput(
// //               "Guntas",
// //               "e.g. 12",
// //               Icons.straighten_outlined,
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
// //       _labeledInput(
// //         "Price per Acre (in Lakhs)",
// //         "e.g. 10",
// //         Icons.currency_rupee_outlined,
// //       ),
// //       const SizedBox(height: 20),
// //       _labeledInput(
// //         "Total Land Value",
// //         "Calculated Automatically",
// //         Icons.calculate_outlined,
// //       ),
// //       const SizedBox(height: 20),

// //       // Passbook upload
// //       _labelWithIcon("Passbook Photo", Icons.photo_library_outlined),
// //       Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           border: Border.all(color: Colors.grey.shade300),
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Row(
// //           children: [
// //             ElevatedButton(
// //               onPressed: pickPassbookImage,
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.green,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //               ),
// //               child: const Text(
// //                 "Choose File",
// //                 style: TextStyle(color: Colors.white),
// //               ),
// //             ),
// //             const SizedBox(width: 10),
// //             Expanded(
// //               child: passbookImage == null
// //                   ? const Text(
// //                       "No file chosen",
// //                       style: TextStyle(color: Colors.grey),
// //                     )
// //                   : Row(
// //                       children: [
// //                         Image.file(passbookImage!, height: 40),
// //                         const SizedBox(width: 8),
// //                         Flexible(
// //                           child: Text(
// //                             passbookImage!.path.split('/').last,
// //                             overflow: TextOverflow.ellipsis,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //             ),
// //           ],
// //         ),
// //       ),

// //       _labelWithIcon("Land Type (Soil)", Icons.grass_outlined),
// //       _optionGroup(
// //         ["Red", "Black", "Sandy"],
// //         selectedLandType,
// //         (val) => setState(() => selectedLandType = val),
// //       ),

// //       _labelWithIcon("Water Source", Icons.water_drop_outlined),
// //       _optionGroup(
// //         ["Canal", "Bores", "Cheruvu", "Rain Water"],
// //         selectedWaterSource,
// //         (val) => setState(() => selectedWaterSource = val),
// //       ),

// //       _labelWithIcon("Garden", Icons.park_outlined),
// //       _optionGroup(
// //         ["Mango", "Guava", "Coconut", "Sapota", "Other"],
// //         selectedGarden,
// //         (val) => setState(() => selectedGarden = val),
// //       ),

// //       _labelWithIcon("Shed Details", Icons.agriculture_outlined),
// //       _optionGroup(
// //         ["Poultry", "Cow Shed"],
// //         selectedShed,
// //         (val) => setState(() => selectedShed = val),
// //       ),

// //       _labelWithIcon("Farm Pond", Icons.water_outlined),
// //       _optionGroup(
// //         ["Yes", "No"],
// //         selectedFarmPond,
// //         (val) => setState(() => selectedFarmPond = val),
// //       ),

// //       _labelWithIcon("Residential", Icons.home_work_outlined),
// //       _optionGroup(
// //         ["Farm House", "RCC Home", "Asbestos Shelter", "Hut"],
// //         selectedResidential,
// //         (val) => setState(() => selectedResidential = val),
// //       ),

// //       _labelWithIcon("Fencing", Icons.fence_outlined),
// //       _optionGroup(
// //         ["With Gate", "All Sides", "Partially", "No"],
// //         selectedFencing,
// //         (val) => setState(() => selectedFencing = val),
// //       ),
// //     ],
// //   );

// //   // ====================== GPS & PATH SECTION (AFTER LAND DETAILS) ======================
// //   Widget _buildGpsSection() => _sectionContainer(
// //     title: "GPS & Path Tracking",
// //     children: [
// //       _labelWithIcon("Path from Main Road", Icons.alt_route_outlined),
// //       _optionGroup(
// //         ["Attached to Road", "No Connectivity"],
// //         selectedPath,
// //         (val) => setState(() => selectedPath = val),
// //       ),
// //       const SizedBox(height: 20),
// //       ElevatedButton.icon(
// //         onPressed: () {
// //           // record a path: for now open map screen where user can tap sequence
// //           openMapForBorder();
// //         },
// //         icon: const Icon(Icons.route_outlined),
// //         label: const Text("Record a Path"),
// //         style: _outlinedButtonStyle(),
// //       ),
// //       const SizedBox(height: 20),
// //       _labelWithIcon(
// //         "Land Entry Point (Coordinates)",
// //         Icons.location_on_outlined,
// //       ),
// //       Row(
// //         children: [
// //           Expanded(
// //             child: _labeledInputController(
// //               "Latitude",
// //               "e.g. 17.4502",
// //               Icons.gps_fixed,
// //               latitudeController,
// //             ),
// //           ),
// //           const SizedBox(width: 15),
// //           Expanded(
// //             child: _labeledInputController(
// //               "Longitude",
// //               "e.g. 78.3654",
// //               Icons.gps_fixed,
// //               longitudeController,
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 15),
// //       ElevatedButton.icon(
// //         onPressed: getCurrentLatLong,
// //         icon: const Icon(Icons.my_location_outlined),
// //         label: const Text("Get Location"),
// //         style: _outlinedButtonStyle(),
// //       ),
// //       const SizedBox(height: 20),
// //       _labelWithIcon("Land Border", Icons.map_outlined),
// //       ElevatedButton.icon(
// //         onPressed: openMapForBorder,
// //         icon: const Icon(Icons.map_outlined),
// //         label: const Text("Draw Land Border"),
// //         style: _outlinedButtonStyle(),
// //       ),

// //       if (landBorderPoints.isNotEmpty) ...[
// //         const SizedBox(height: 12),
// //         Text("Border points: ${landBorderPoints.length}"),
// //       ],
// //     ],
// //   );

// //   // ====================== DOCUMENTS & MEDIA SECTION (AFTER GPS) ======================
// //   Widget _buildDocumentsSection() => _sectionContainer(
// //     title: "Documents & Media",
// //     children: [
// //       _labelWithIcon("Land Photos", Icons.photo_camera_outlined),
// //       ElevatedButton.icon(
// //         onPressed: () async {
// //           // use image picker for photos (multi - use file picker for many)
// //           final picked = await _picker.pickMultiImage();
// //           if (picked != null && picked.isNotEmpty) {
// //             setState(() {
// //               mediaFiles.addAll(picked.map((e) => File(e.path)));
// //             });
// //           }
// //         },
// //         icon: const Icon(Icons.camera_alt_outlined),
// //         label: const Text("Upload Photos"),
// //         style: _outlinedButtonStyle(),
// //       ),
// //       const SizedBox(height: 20),
// //       _labelWithIcon("Land Videos", Icons.videocam_outlined),
// //       ElevatedButton.icon(
// //         onPressed: () async {
// //           final picked = await _picker.pickVideo(source: ImageSource.gallery);
// //           if (picked != null) {
// //             setState(() => mediaFiles.add(File(picked.path)));
// //           }
// //         },
// //         icon: const Icon(Icons.videocam_outlined),
// //         label: const Text("Upload Videos"),
// //         style: _outlinedButtonStyle(),
// //       ),
// //       const SizedBox(height: 20),
// //       _labelWithIcon(
// //         "Other Documents (Passbook / Deeds)",
// //         Icons.insert_drive_file_outlined,
// //       ),
// //       ElevatedButton.icon(
// //         onPressed: pickMediaAndDocs,
// //         icon: const Icon(Icons.upload_file_outlined),
// //         label: const Text("Upload Documents"),
// //         style: _outlinedButtonStyle(),
// //       ),

// //       const SizedBox(height: 12),

// //       // Preview uploaded files (show thumbnails for images if possible)
// //       Wrap(
// //         spacing: 8,
// //         runSpacing: 8,
// //         children: mediaFiles.map((f) {
// //           final ext = f.path.split('.').last.toLowerCase();
// //           if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
// //             return GestureDetector(
// //               onTap: () {
// //                 // open full image viewer? For now simple dialog
// //                 showDialog(
// //                   context: context,
// //                   builder: (_) => Dialog(child: Image.file(f)),
// //                 );
// //               },
// //               child: Image.file(f, width: 90, height: 90, fit: BoxFit.cover),
// //             );
// //           } else {
// //             return Container(
// //               width: 90,
// //               height: 90,
// //               padding: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(8),
// //                 border: Border.all(color: Colors.grey.shade300),
// //                 color: Colors.white,
// //               ),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   const Icon(
// //                     Icons.insert_drive_file,
// //                     size: 28,
// //                     color: Colors.grey,
// //                   ),
// //                   const SizedBox(height: 6),
// //                   Flexible(
// //                     child: Text(
// //                       f.path.split('/').last,
// //                       textAlign: TextAlign.center,
// //                       style: const TextStyle(fontSize: 11),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           }
// //         }).toList(),
// //       ),
// //     ],
// //   );

// //   // ====================== SUBMIT & SAVE BUTTONS ======================
// //   Widget _buildSubmitButtons() => Column(
// //     children: [
// //       ElevatedButton.icon(
// //         onPressed: submitNewLand,
// //         icon: const Icon(Icons.cloud_upload_outlined),
// //         label: const Text("Submit New Land"),
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Colors.green.shade700,
// //           foregroundColor: Colors.white,
// //           minimumSize: const Size.fromHeight(55),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //         ),
// //       ),
// //       const SizedBox(height: 15),
// //       ElevatedButton.icon(
// //         onPressed: () {
// //           // implement save draft logic if needed
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Saved as draft (mock)')),
// //           );
// //         },
// //         icon: const Icon(Icons.save_outlined),
// //         label: const Text("Save as Draft"),
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Colors.grey.shade200,
// //           foregroundColor: Colors.black,
// //           minimumSize: const Size.fromHeight(55),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //         ),
// //       ),
// //     ],
// //   );

// //   // ====================== Reusable Widgets ======================
// //   Widget _sectionContainer({
// //     required String title,
// //     required List<Widget> children,
// //   }) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(16),
// //       decoration: _boxDecoration(),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             title,
// //             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 20),
// //           ...children,
// //         ],
// //       ),
// //     );
// //   }

// //   BoxDecoration _boxDecoration() => BoxDecoration(
// //     color: Colors.grey[100],
// //     borderRadius: BorderRadius.circular(15),
// //     boxShadow: [
// //       BoxShadow(
// //         color: Colors.grey.withOpacity(0.2),
// //         blurRadius: 8,
// //         offset: const Offset(0, 4),
// //       ),
// //     ],
// //   );

// //   InputDecoration _dropdownDecoration(String hint, IconData icon) =>
// //       InputDecoration(
// //         prefixIcon: Icon(icon),
// //         fillColor: Colors.white,
// //         filled: true,
// //         hintText: hint,
// //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
// //       );

// //   Widget _inputField(String hint, IconData icon) => TextFormField(
// //     decoration: InputDecoration(
// //       hintText: hint,
// //       prefixIcon: Icon(icon),
// //       fillColor: Colors.white,
// //       filled: true,
// //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
// //     ),
// //   );

// //   Widget _labeledInput(String label, String hint, IconData icon) => Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       Text(
// //         label,
// //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //       ),
// //       const SizedBox(height: 8),
// //       _inputField(hint, icon),
// //     ],
// //   );

// //   Widget _labeledInputController(
// //     String label,
// //     String hint,
// //     IconData icon,
// //     TextEditingController controller,
// //   ) => Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       Text(
// //         label,
// //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //       ),
// //       const SizedBox(height: 8),
// //       TextFormField(
// //         controller: controller,
// //         decoration: InputDecoration(
// //           hintText: hint,
// //           prefixIcon: Icon(icon),
// //           fillColor: Colors.white,
// //           filled: true,
// //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
// //         ),
// //       ),
// //     ],
// //   );

// //   Widget _labelWithIcon(String title, IconData icon) => Padding(
// //     padding: const EdgeInsets.only(top: 25, bottom: 10),
// //     child: Row(
// //       children: [
// //         Icon(icon, color: Colors.black87),
// //         const SizedBox(width: 8),
// //         Text(
// //           title,
// //           style: const TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.w600,
// //             color: Colors.black,
// //           ),
// //         ),
// //       ],
// //     ),
// //   );

// //   Widget _optionGroup(
// //     List<String> options,
// //     String? selectedValue,
// //     Function(String) onSelect,
// //   ) => Wrap(
// //     spacing: 12,
// //     runSpacing: 12,
// //     children: options
// //         .map((text) => _buildOptionBox(text, selectedValue, onSelect))
// //         .toList(),
// //   );

// //   Widget _buildOptionBox(
// //     String text,
// //     String? selectedValue,
// //     Function(String) onSelect,
// //   ) {
// //     final bool isSelected = selectedValue == text;
// //     return GestureDetector(
// //       onTap: () => onSelect(text),
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
// //         decoration: BoxDecoration(
// //           color: isSelected ? Colors.green.shade100 : Colors.white,
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(
// //             color: isSelected ? Colors.green : Colors.grey.shade300,
// //             width: isSelected ? 2 : 1,
// //           ),
// //         ),
// //         child: Text(
// //           text,
// //           style: TextStyle(
// //             fontSize: 15,
// //             fontWeight: FontWeight.w500,
// //             color: isSelected ? Colors.green.shade800 : Colors.black,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   ButtonStyle _outlinedButtonStyle() => ElevatedButton.styleFrom(
// //     backgroundColor: Colors.white,
// //     foregroundColor: Colors.black87,
// //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //     side: BorderSide(color: Colors.grey.shade300),
// //     minimumSize: const Size.fromHeight(50),
// //   );
// // }

// // // =========== Land Border Map Screen (separate widget) ===========
// // class LandBorderMapScreen extends StatefulWidget {
// //   final List<LatLng> initialPoints;
// //   const LandBorderMapScreen({super.key, required this.initialPoints});

// //   @override
// //   State<LandBorderMapScreen> createState() => _LandBorderMapScreenState();
// // }

// // class _LandBorderMapScreenState extends State<LandBorderMapScreen> {
// //   late GoogleMapController _mapController;
// //   List<LatLng> _points = [];
// //   BitmapDescriptor? markerIcon;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _points = List.from(widget.initialPoints);
// //   }

// //   void _onMapCreated(GoogleMapController controller) {
// //     _mapController = controller;
// //   }

// //   void _addPoint(LatLng p) {
// //     setState(() {
// //       _points.add(p);
// //     });
// //   }

// //   void _undo() {
// //     if (_points.isNotEmpty) {
// //       setState(() {
// //         _points.removeLast();
// //       });
// //     }
// //   }

// //   void _clear() {
// //     setState(() {
// //       _points.clear();
// //     });
// //   }

// //   void _finish() {
// //     // return points to previous screen
// //     Navigator.pop(context, _points);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final initialCamera = _points.isNotEmpty
// //         ? CameraPosition(target: _points.first, zoom: 18)
// //         : const CameraPosition(target: LatLng(17.4402, 78.3489), zoom: 14);

// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Draw Land Border')),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             initialCameraPosition: initialCamera,
// //             onMapCreated: _onMapCreated,
// //             onTap: (p) => _addPoint(p),
// //             markers: _points
// //                 .asMap()
// //                 .entries
// //                 .map(
// //                   (e) => Marker(
// //                     markerId: MarkerId('m${e.key}'),
// //                     position: e.value,
// //                     infoWindow: InfoWindow(title: 'P${e.key + 1}'),
// //                   ),
// //                 )
// //                 .toSet(),
// //             polygons: {
// //               if (_points.length >= 3)
// //                 Polygon(
// //                   polygonId: const PolygonId('land'),
// //                   points: _points,
// //                   strokeWidth: 2,
// //                   strokeColor: Colors.green,
// //                   fillColor: Colors.green.withOpacity(0.2),
// //                 ),
// //             },
// //             polylines: {
// //               if (_points.length >= 2)
// //                 Polyline(
// //                   polylineId: const PolylineId('line'),
// //                   points: _points,
// //                   color: Colors.green,
// //                   width: 2,
// //                 ),
// //             },
// //           ),
// //           Positioned(
// //             right: 12,
// //             top: 12,
// //             child: Column(
// //               children: [
// //                 FloatingActionButton.small(
// //                   heroTag: 'undo',
// //                   onPressed: _undo,
// //                   backgroundColor: Colors.white,
// //                   child: const Icon(Icons.undo, color: Colors.black),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 FloatingActionButton.small(
// //                   heroTag: 'clear',
// //                   onPressed: _clear,
// //                   backgroundColor: Colors.white,
// //                   child: const Icon(Icons.clear, color: Colors.red),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 FloatingActionButton.small(
// //                   heroTag: 'finish',
// //                   onPressed: _finish,
// //                   backgroundColor: Colors.green,
// //                   child: const Icon(Icons.check, color: Colors.white),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           if (_points.isNotEmpty)
// //             Positioned(
// //               left: 12,
// //               bottom: 12,
// //               right: 12,
// //               child: Container(
// //                 padding: const EdgeInsets.all(8),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white70,
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Text(
// //                   'Points: ${_points.length}  — Tap map to add points.',
// //                 ),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // ignore_for_file: depend_on_referenced_packages

// // lib/new_land_page.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class NewLandPage extends StatefulWidget {
//   const NewLandPage({super.key});

//   @override
//   State<NewLandPage> createState() => _NewLandPageState();
// }

// class _NewLandPageState extends State<NewLandPage> {
//   // Basic state fields (kept same names + controllers for GPS fields)
//   bool isWhatsApp = false;

//   String? selectedState;
//   String? selectedDistrict;

//   // selection variables (kept)
//   String? selectedLiteracy;
//   String? selectedAgeGroup;
//   String? selectedNature;
//   String? selectedOwnership;
//   String? selectedMortgage;
//   String? selectedDisputeType;
//   String? selectedSibling;
//   String? selectedPath;
//   String? selectedLandType;
//   String? selectedWaterSource;
//   String? selectedGarden;
//   String? selectedShed;
//   String? selectedFarmPond;
//   String? selectedResidential;
//   String? selectedFencing;

//   final List<String> states = [
//     //'Telangana',
//     //'Andhra Pradesh',
//     //'Karnataka',
//     //'Tamil Nadu',
//   ];

//   final List<String> districts = [
//     //'Ranga Reddy',
//     //'Hyderabad',
//     // 'Medchal',
//     //'Nizamabad',
//   ];

//   // Controllers for village, mandal and coordinates
//   final TextEditingController villageController = TextEditingController();
//   final TextEditingController mandalController = TextEditingController();
//   final TextEditingController latitudeController = TextEditingController();
//   final TextEditingController longitudeController = TextEditingController();

//   // Passbook image
//   File? passbookImage;

//   // Media / Documents list
//   List<File> mediaFiles = [];

//   // Land border points returned from map
//   List<LatLng> landBorderPoints = [];

//   bool loadingGPS = false;

//   final ImagePicker _picker = ImagePicker();

//   @override
//   void dispose() {
//     villageController.dispose();
//     mandalController.dispose();
//     latitudeController.dispose();
//     longitudeController.dispose();
//     super.dispose();
//   }

//   // ---------------- GPS & Reverse Geocoding ----------------
//   Future<bool> _ensureLocationPermission() async {
//     LocationPermission p = await Geolocator.checkPermission();
//     if (p == LocationPermission.denied) {
//       p = await Geolocator.requestPermission();
//     }
//     if (p == LocationPermission.deniedForever ||
//         p == LocationPermission.denied) {
//       // cannot proceed
//       return false;
//     }
//     return true;
//   }

//   Future<void> fetchVillageGPSAndAddress() async {
//     setState(() => loadingGPS = true);

//     final serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       setState(() => loadingGPS = false);
//       return;
//     }

//     final ok = await _ensureLocationPermission();
//     if (!ok) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Location permission required')),
//       );
//       setState(() => loadingGPS = false);
//       return;
//     }

//     try {
//       final pos = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       latitudeController.text = pos.latitude.toStringAsFixed(6);
//       longitudeController.text = pos.longitude.toStringAsFixed(6);

//       // reverse geocode to get fields
//       final placemarks = await placemarkFromCoordinates(
//         pos.latitude,
//         pos.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         final p = placemarks.first;

//         // administrativeArea -> State
//         final reverseState = p.administrativeArea?.trim();
//         if (reverseState != null && reverseState.isNotEmpty) {
//           // ensure state exists in list so dropdown can show it
//           if (!states.contains(reverseState)) {
//             setState(() {
//               states.insert(0, reverseState);
//               selectedState = reverseState;
//             });
//           } else {
//             setState(() {
//               selectedState = reverseState;
//             });
//           }
//         }

//         // subAdministrativeArea -> District
//         final reverseDistrict = p.subAdministrativeArea?.trim();
//         if (reverseDistrict != null && reverseDistrict.isNotEmpty) {
//           if (!districts.contains(reverseDistrict)) {
//             setState(() {
//               districts.insert(0, reverseDistrict);
//               selectedDistrict = reverseDistrict;
//             });
//           } else {
//             setState(() {
//               selectedDistrict = reverseDistrict;
//             });
//           }
//         }

//         // Mandal (locality or subLocality)
//         final mandal =
//             (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
//             (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null) ??
//             null;

//         if (mandal != null) {
//           mandalController.text = mandal;
//         }

//         // Village: try subLocality then locality then name
//         final village =
//             (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null) ??
//             (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
//             (p.name?.trim().isNotEmpty == true ? p.name : null) ??
//             '';

//         villageController.text = village ?? '';

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location and address captured')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No address information found')),
//         );
//       }
//     } catch (e) {
//       debugPrint("fetchVillageGPS error: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Failed to get location: $e')));
//     } finally {
//       setState(() => loadingGPS = false);
//     }
//   }

//   // This is used by the GPS & Path Tracking "Get Location" button (fills lat/long)
//   Future<void> getCurrentLatLong() async {
//     final serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }
//     final ok = await _ensureLocationPermission();
//     if (!ok) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Location permission required')),
//       );
//       return;
//     }

//     try {
//       final pos = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best,
//       );
//       latitudeController.text = pos.latitude.toStringAsFixed(6);
//       longitudeController.text = pos.longitude.toStringAsFixed(6);
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Location captured')));
//     } catch (e) {
//       debugPrint('getCurrentLatLong error: $e');
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Failed to capture location: $e')));
//     }
//   }

//   // ---------------- Passbook Upload (camera/gallery) ----------------
//   Future<void> pickPassbookImage() async {
//     final statusCamera = await Permission.camera.request();
//     final statusStorage = await Permission.photos
//         .request(); // for iOS/Android13 mapping
//     if (!statusCamera.isGranted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Camera permission required')),
//       );
//       return;
//     }

//     final picked = await showModalBottomSheet<XFile?>(
//       context: context,
//       builder: (_) => _chooseImageSourceBottomSheet(),
//     );

//     if (picked != null) {
//       setState(() => passbookImage = File(picked.path));
//     }
//   }

//   Widget _chooseImageSourceBottomSheet() {
//     return SafeArea(
//       child: Wrap(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.camera_alt),
//             title: const Text('Camera'),
//             onTap: () async {
//               Navigator.pop(
//                 context,
//                 await _picker.pickImage(source: ImageSource.camera),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.photo),
//             title: const Text('Gallery'),
//             onTap: () async {
//               Navigator.pop(
//                 context,
//                 await _picker.pickImage(source: ImageSource.gallery),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.close),
//             title: const Text('Cancel'),
//             onTap: () => Navigator.pop(context, null),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------- Media / Documents Upload ----------------
//   Future<void> pickMediaAndDocs() async {
//     // request storage / photos permission
//     await Permission.storage.request();
//     await Permission.photos.request();

//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.any,
//       //allowedExtensions: ['jpg','png','mp4','pdf','doc','docx'],
//     );

//     if (result != null && result.paths.isNotEmpty) {
//       setState(() {
//         mediaFiles.addAll(
//           result.paths.where((p) => p != null).map((p) => File(p!)),
//         );
//       });
//     }
//   }

//   // ---------------- Draw Land Border (open map and get polygon) ----------------
//   Future<void> openMapForBorder() async {
//     // navigate to map screen and await points
//     final points = await Navigator.push<List<LatLng>>(
//       context,
//       MaterialPageRoute(
//         builder: (_) => LandBorderMapScreen(initialPoints: landBorderPoints),
//       ),
//     );

//     if (points != null) {
//       setState(() {
//         landBorderPoints = points;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Border captured: ${points.length} points')),
//       );
//     }
//   }

//   // ---------------- Submit / Save (simple mock) ----------------
//   void submitNewLand() {
//     // Basic validation sample:
//     if (villageController.text.isEmpty ||
//         latitudeController.text.isEmpty ||
//         longitudeController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please capture GPS/location before submit'),
//         ),
//       );
//       return;
//     }

//     // Collect data and send to backend / local DB...
//     // For demo - just show success
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('New Land submitted (mock)')));
//   }

//   // ====================== UI BUILD (keeps your original structure + functionality) ======================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         toolbarHeight: 80,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Suresh",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Field Executive",
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//             CircleAvatar(
//               radius: 24,
//               backgroundColor: Colors.green,
//               child: const Icon(Icons.person, color: Colors.white, size: 28),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "New Land Details",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             _buildAddressSection(),
//             const SizedBox(height: 40),
//             _buildFarmerDetails(),
//             const SizedBox(height: 40),
//             _buildDisputeSection(),
//             const SizedBox(height: 40),
//             _buildLandDetailsSection(), // 👈 Land Details
//             const SizedBox(height: 40),
//             _buildGpsSection(), // 👈 GPS & Path Tracking (after Land Details)
//             const SizedBox(height: 40),
//             _buildDocumentsSection(), // 👈 Documents & Media (after GPS)
//             const SizedBox(height: 30),
//             _buildSubmitButtons(), // 👈 Submit & Save
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   // ====================== Address Section (with GPS capture) ======================

//   Widget _buildAddressSection() => _sectionContainer(
//     title: "Village Address",
//     children: [
//       DropdownButtonFormField<String>(
//         value: selectedState,
//         decoration: _dropdownDecoration("Select State", Icons.location_on),
//         items: states
//             .map((state) => DropdownMenuItem(value: state, child: Text(state)))
//             .toList(),
//         onChanged: (value) => setState(() => selectedState = value),
//       ),

//       const SizedBox(height: 20),

//       DropdownButtonFormField<String>(
//         value: selectedDistrict,
//         decoration: _dropdownDecoration(
//           "Select District",
//           Icons.location_city_outlined,
//         ),
//         items: districts
//             .map((d) => DropdownMenuItem(value: d, child: Text(d)))
//             .toList(),
//         onChanged: (value) => setState(() => selectedDistrict = value),
//       ),

//       const SizedBox(height: 20),

//       // MANDAL TEXT FIELD (Added under District as requested)
//       TextFormField(
//         controller: mandalController,
//         decoration: InputDecoration(
//           hintText: "Enter Mandal",
//           prefixIcon: Icon(Icons.map_outlined),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         ),
//       ),

//       const SizedBox(height: 20),

//       TextFormField(
//         controller: villageController,
//         decoration: InputDecoration(
//           hintText: "Enter Village Name",
//           prefixIcon: Icon(Icons.home_outlined),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         ),
//       ),

//       const SizedBox(height: 20),

//       SizedBox(
//         width: double.infinity, // FULL WIDTH
//         child: ElevatedButton.icon(
//           onPressed: loadingGPS ? null : fetchVillageGPSAndAddress,
//           icon: const Icon(Icons.gps_fixed),
//           label: Text(loadingGPS ? 'Capturing...' : 'Capture GPS'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.green,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );

//   // ====================== Farmer Details ======================
//   Widget _buildFarmerDetails() => _sectionContainer(
//     title: "Farmer Details",
//     children: [
//       _labeledInput("Farmer Name", "Enter Farmer's name", Icons.person_outline),
//       const SizedBox(height: 20),
//       _labeledInput("Phone Number", "Enter phone number", Icons.phone_outlined),
//       Row(
//         children: [
//           Checkbox(
//             value: isWhatsApp,
//             onChanged: (v) => setState(() => isWhatsApp = v!),
//           ),
//           const Text(
//             "This number has WhatsApp",
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//       const SizedBox(height: 10),
//       _labeledInput(
//         "Other WhatsApp Number",
//         "Enter other WhatsApp number",
//         Icons.wechat,
//       ),
//       const SizedBox(height: 25),

//       // Literacy
//       _labelWithIcon("Literacy", Icons.menu_book_outlined),
//       _optionGroup(
//         ["Illiterate", "Literate", "Graduate"],
//         selectedLiteracy,
//         (val) => setState(() => selectedLiteracy = val),
//       ),

//       // Age
//       _labelWithIcon("Age Group", Icons.person_outline),
//       _optionGroup(
//         ["Upto 30", "30-50", "50+"],
//         selectedAgeGroup,
//         (val) => setState(() => selectedAgeGroup = val),
//       ),

//       // Nature
//       _labelWithIcon("Nature", Icons.accessibility_new_outlined),
//       _optionGroup(
//         ["Polite", "Medium", "Rude"],
//         selectedNature,
//         (val) => setState(() => selectedNature = val),
//       ),

//       // Ownership
//       _labelWithIcon("Land Ownership", Icons.percent_outlined),
//       _optionGroup(
//         ["Joint", "Single"],
//         selectedOwnership,
//         (val) => setState(() => selectedOwnership = val),
//       ),

//       // Mortgage
//       _labelWithIcon("Ready for Mortgage", Icons.thumb_up_alt_outlined),
//       _optionGroup(
//         ["Yes", "No"],
//         selectedMortgage,
//         (val) => setState(() => selectedMortgage = val),
//       ),
//     ],
//   );

//   // ====================== Dispute Section ======================
//   Widget _buildDisputeSection() => _sectionContainer(
//     title: "Dispute Details",
//     children: [
//       _labelWithIcon("Type of Dispute", Icons.report_problem_outlined),
//       _optionGroup(
//         [
//           "Boundary",
//           "Ownership",
//           "Family",
//           "Other",
//           "Budhan",
//           "Land Sealing",
//           "Electric Poles",
//           "Canal Planning",
//         ],
//         selectedDisputeType,
//         (val) => setState(() => selectedDisputeType = val),
//       ),
//       _labelWithIcon("Siblings Involved in Dispute", Icons.group_outlined),
//       _optionGroup(
//         ["Yes", "No"],
//         selectedSibling,
//         (val) => setState(() => selectedSibling = val),
//       ),
//       _labelWithIcon("Path to Land", Icons.route_outlined),
//       _optionGroup(
//         ["No Path to Land"],
//         selectedPath,
//         (val) => setState(() => selectedPath = val),
//       ),
//     ],
//   );

//   // ====================== Land Details Section ======================
//   Widget _buildLandDetailsSection() => _sectionContainer(
//     title: "Land Details",
//     children: [
//       // 👇 Row for Acres + Guntas
//       Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: _labeledInput(
//               "Land Area (Acres)",
//               "e.g. 3.5",
//               Icons.square_foot_outlined,
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             flex: 1,
//             child: _labeledInput(
//               "Guntas",
//               "e.g. 12",
//               Icons.straighten_outlined,
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       _labeledInput(
//         "Price per Acre (in Lakhs)",
//         "e.g. 10",
//         Icons.currency_rupee_outlined,
//       ),
//       const SizedBox(height: 20),
//       _labeledInput(
//         "Total Land Value",
//         "Calculated Automatically",
//         Icons.calculate_outlined,
//       ),
//       const SizedBox(height: 20),

//       // Passbook upload
//       _labelWithIcon("Passbook Photo", Icons.photo_library_outlined),
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             ElevatedButton(
//               onPressed: pickPassbookImage,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: const Text(
//                 "Choose File",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: passbookImage == null
//                   ? const Text(
//                       "No file chosen",
//                       style: TextStyle(color: Colors.grey),
//                     )
//                   : Row(
//                       children: [
//                         Image.file(passbookImage!, height: 40),
//                         const SizedBox(width: 8),
//                         Flexible(
//                           child: Text(
//                             passbookImage!.path.split('/').last,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ],
//         ),
//       ),

//       _labelWithIcon("Land Type (Soil)", Icons.grass_outlined),
//       _optionGroup(
//         ["Red", "Black", "Sandy"],
//         selectedLandType,
//         (val) => setState(() => selectedLandType = val),
//       ),

//       _labelWithIcon("Water Source", Icons.water_drop_outlined),
//       _optionGroup(
//         ["Canal", "Bores", "Cheruvu", "Rain Water"],
//         selectedWaterSource,
//         (val) => setState(() => selectedWaterSource = val),
//       ),

//       _labelWithIcon("Garden", Icons.park_outlined),
//       _optionGroup(
//         ["Mango", "Guava", "Coconut", "Sapota", "Other"],
//         selectedGarden,
//         (val) => setState(() => selectedGarden = val),
//       ),

//       _labelWithIcon("Shed Details", Icons.agriculture_outlined),
//       _optionGroup(
//         ["Poultry", "Cow Shed"],
//         selectedShed,
//         (val) => setState(() => selectedShed = val),
//       ),

//       _labelWithIcon("Farm Pond", Icons.water_outlined),
//       _optionGroup(
//         ["Yes", "No"],
//         selectedFarmPond,
//         (val) => setState(() => selectedFarmPond = val),
//       ),

//       _labelWithIcon("Residential", Icons.home_work_outlined),
//       _optionGroup(
//         ["Farm House", "RCC Home", "Asbestos Shelter", "Hut"],
//         selectedResidential,
//         (val) => setState(() => selectedResidential = val),
//       ),

//       _labelWithIcon("Fencing", Icons.fence_outlined),
//       _optionGroup(
//         ["With Gate", "All Sides", "Partially", "No"],
//         selectedFencing,
//         (val) => setState(() => selectedFencing = val),
//       ),
//     ],
//   );

//   // ====================== GPS & PATH SECTION (AFTER LAND DETAILS) ======================
//   Widget _buildGpsSection() => _sectionContainer(
//     title: "GPS & Path Tracking",
//     children: [
//       _labelWithIcon("Path from Main Road", Icons.alt_route_outlined),
//       _optionGroup(
//         ["Attached to Road", "No Connectivity"],
//         selectedPath,
//         (val) => setState(() => selectedPath = val),
//       ),
//       const SizedBox(height: 20),
//       ElevatedButton.icon(
//         onPressed: () {
//           // record a path: for now open map screen where user can tap sequence
//           openMapForBorder();
//         },
//         icon: const Icon(Icons.route_outlined),
//         label: const Text("Record a Path"),
//         style: _outlinedButtonStyle(),
//       ),
//       const SizedBox(height: 20),
//       _labelWithIcon(
//         "Land Entry Point (Coordinates)",
//         Icons.location_on_outlined,
//       ),
//       Row(
//         children: [
//           Expanded(
//             child: _labeledInputController(
//               "Latitude",
//               "e.g. 17.4502",
//               Icons.gps_fixed,
//               latitudeController,
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: _labeledInputController(
//               "Longitude",
//               "e.g. 78.3654",
//               Icons.gps_fixed,
//               longitudeController,
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 15),
//       ElevatedButton.icon(
//         onPressed: getCurrentLatLong,
//         icon: const Icon(Icons.my_location_outlined),
//         label: const Text("Get Location"),
//         style: _outlinedButtonStyle(),
//       ),
//       const SizedBox(height: 20),
//       _labelWithIcon("Land Border", Icons.map_outlined),
//       ElevatedButton.icon(
//         onPressed: openMapForBorder,
//         icon: const Icon(Icons.map_outlined),
//         label: const Text("Draw Land Border"),
//         style: _outlinedButtonStyle(),
//       ),

//       if (landBorderPoints.isNotEmpty) ...[
//         const SizedBox(height: 12),
//         Text("Border points: ${landBorderPoints.length}"),
//       ],
//     ],
//   );

//   // ====================== DOCUMENTS & MEDIA SECTION (AFTER GPS) ======================
//   Widget _buildDocumentsSection() => _sectionContainer(
//     title: "Documents & Media",
//     children: [
//       _labelWithIcon("Land Photos", Icons.photo_camera_outlined),
//       ElevatedButton.icon(
//         onPressed: () async {
//           // use image picker for photos (multi - use file picker for many)
//           final picked = await _picker.pickMultiImage();
//           if (picked != null && picked.isNotEmpty) {
//             setState(() {
//               mediaFiles.addAll(picked.map((e) => File(e.path)));
//             });
//           }
//         },
//         icon: const Icon(Icons.camera_alt_outlined),
//         label: const Text("Upload Photos"),
//         style: _outlinedButtonStyle(),
//       ),
//       const SizedBox(height: 20),
//       _labelWithIcon("Land Videos", Icons.videocam_outlined),
//       ElevatedButton.icon(
//         onPressed: () async {
//           final picked = await _picker.pickVideo(source: ImageSource.gallery);
//           if (picked != null) {
//             setState(() => mediaFiles.add(File(picked.path)));
//           }
//         },
//         icon: const Icon(Icons.videocam_outlined),
//         label: const Text("Upload Videos"),
//         style: _outlinedButtonStyle(),
//       ),
//       const SizedBox(height: 20),
//       _labelWithIcon(
//         "Other Documents (Passbook / Deeds)",
//         Icons.insert_drive_file_outlined,
//       ),
//       ElevatedButton.icon(
//         onPressed: pickMediaAndDocs,
//         icon: const Icon(Icons.upload_file_outlined),
//         label: const Text("Upload Documents"),
//         style: _outlinedButtonStyle(),
//       ),

//       const SizedBox(height: 12),

//       // Preview uploaded files (show thumbnails for images if possible)
//       Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children: mediaFiles.map((f) {
//           final ext = f.path.split('.').last.toLowerCase();
//           if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
//             return GestureDetector(
//               onTap: () {
//                 // open full image viewer? For now simple dialog
//                 showDialog(
//                   context: context,
//                   builder: (_) => Dialog(child: Image.file(f)),
//                 );
//               },
//               child: Image.file(f, width: 90, height: 90, fit: BoxFit.cover),
//             );
//           } else {
//             return Container(
//               width: 90,
//               height: 90,
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade300),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.insert_drive_file,
//                     size: 28,
//                     color: Colors.grey,
//                   ),
//                   const SizedBox(height: 6),
//                   Flexible(
//                     child: Text(
//                       f.path.split('/').last,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontSize: 11),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         }).toList(),
//       ),
//     ],
//   );

//   // ====================== SUBMIT & SAVE BUTTONS ======================
//   Widget _buildSubmitButtons() => Column(
//     children: [
//       ElevatedButton.icon(
//         onPressed: submitNewLand,
//         icon: const Icon(Icons.cloud_upload_outlined),
//         label: const Text("Submit New Land"),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green.shade700,
//           foregroundColor: Colors.white,
//           minimumSize: const Size.fromHeight(55),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//       const SizedBox(height: 15),
//       ElevatedButton.icon(
//         onPressed: () {
//           // implement save draft logic if needed
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Saved as draft (mock)')),
//           );
//         },
//         icon: const Icon(Icons.save_outlined),
//         label: const Text("Save as Draft"),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.grey.shade200,
//           foregroundColor: Colors.black,
//           minimumSize: const Size.fromHeight(55),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     ],
//   );

//   // ====================== Reusable Widgets ======================
//   Widget _sectionContainer({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: _boxDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           ...children,
//         ],
//       ),
//     );
//   }

//   BoxDecoration _boxDecoration() => BoxDecoration(
//     color: Colors.grey[100],
//     borderRadius: BorderRadius.circular(15),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.2),
//         blurRadius: 8,
//         offset: const Offset(0, 4),
//       ),
//     ],
//   );

//   InputDecoration _dropdownDecoration(String hint, IconData icon) =>
//       InputDecoration(
//         prefixIcon: Icon(icon),
//         fillColor: Colors.white,
//         filled: true,
//         hintText: hint,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//       );

//   Widget _inputField(String hint, IconData icon) => TextFormField(
//     decoration: InputDecoration(
//       hintText: hint,
//       prefixIcon: Icon(icon),
//       fillColor: Colors.white,
//       filled: true,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//     ),
//   );

//   Widget _labeledInput(String label, String hint, IconData icon) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       const SizedBox(height: 8),
//       _inputField(hint, icon),
//     ],
//   );

//   Widget _labeledInputController(
//     String label,
//     String hint,
//     IconData icon,
//     TextEditingController controller,
//   ) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       const SizedBox(height: 8),
//       TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: hint,
//           prefixIcon: Icon(icon),
//           fillColor: Colors.white,
//           filled: true,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         ),
//       ),
//     ],
//   );

//   Widget _labelWithIcon(String title, IconData icon) => Padding(
//     padding: const EdgeInsets.only(top: 25, bottom: 10),
//     child: Row(
//       children: [
//         Icon(icon, color: Colors.black87),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     ),
//   );

//   Widget _optionGroup(
//     List<String> options,
//     String? selectedValue,
//     Function(String) onSelect,
//   ) => Wrap(
//     spacing: 12,
//     runSpacing: 12,
//     children: options
//         .map((text) => _buildOptionBox(text, selectedValue, onSelect))
//         .toList(),
//   );

//   Widget _buildOptionBox(
//     String text,
//     String? selectedValue,
//     Function(String) onSelect,
//   ) {
//     final bool isSelected = selectedValue == text;
//     return GestureDetector(
//       onTap: () => onSelect(text),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.green.shade100 : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? Colors.green : Colors.grey.shade300,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//             color: isSelected ? Colors.green.shade800 : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   ButtonStyle _outlinedButtonStyle() => ElevatedButton.styleFrom(
//     backgroundColor: Colors.white,
//     foregroundColor: Colors.black87,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     side: BorderSide(color: Colors.grey.shade300),
//     minimumSize: const Size.fromHeight(50),
//   );
// }

// // =========== Land Border Map Screen (separate widget) ===========
// class LandBorderMapScreen extends StatefulWidget {
//   final List<LatLng> initialPoints;
//   const LandBorderMapScreen({super.key, required this.initialPoints});

//   @override
//   State<LandBorderMapScreen> createState() => _LandBorderMapScreenState();
// }

// class _LandBorderMapScreenState extends State<LandBorderMapScreen> {
//   late GoogleMapController _mapController;
//   List<LatLng> _points = [];
//   BitmapDescriptor? markerIcon;

//   @override
//   void initState() {
//     super.initState();
//     _points = List.from(widget.initialPoints);
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }

//   void _addPoint(LatLng p) {
//     setState(() {
//       _points.add(p);
//     });
//   }

//   void _undo() {
//     if (_points.isNotEmpty) {
//       setState(() {
//         _points.removeLast();
//       });
//     }
//   }

//   void _clear() {
//     setState(() {
//       _points.clear();
//     });
//   }

//   void _finish() {
//     // return points to previous screen
//     Navigator.pop(context, _points);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final initialCamera = _points.isNotEmpty
//         ? CameraPosition(target: _points.first, zoom: 18)
//         : const CameraPosition(target: LatLng(17.4402, 78.3489), zoom: 14);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Draw Land Border')),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: initialCamera,
//             onMapCreated: _onMapCreated,
//             onTap: (p) => _addPoint(p),
//             markers: _points
//                 .asMap()
//                 .entries
//                 .map(
//                   (e) => Marker(
//                     markerId: MarkerId('m${e.key}'),
//                     position: e.value,
//                     infoWindow: InfoWindow(title: 'P${e.key + 1}'),
//                   ),
//                 )
//                 .toSet(),
//             polygons: {
//               if (_points.length >= 3)
//                 Polygon(
//                   polygonId: const PolygonId('land'),
//                   points: _points,
//                   strokeWidth: 2,
//                   strokeColor: Colors.green,
//                   fillColor: Colors.green.withOpacity(0.2),
//                 ),
//             },
//             polylines: {
//               if (_points.length >= 2)
//                 Polyline(
//                   polylineId: const PolylineId('line'),
//                   points: _points,
//                   color: Colors.green,
//                   width: 2,
//                 ),
//             },
//           ),
//           Positioned(
//             right: 12,
//             top: 12,
//             child: Column(
//               children: [
//                 FloatingActionButton.small(
//                   heroTag: 'undo',
//                   onPressed: _undo,
//                   backgroundColor: Colors.white,
//                   child: const Icon(Icons.undo, color: Colors.black),
//                 ),
//                 const SizedBox(height: 8),
//                 FloatingActionButton.small(
//                   heroTag: 'clear',
//                   onPressed: _clear,
//                   backgroundColor: Colors.white,
//                   child: const Icon(Icons.clear, color: Colors.red),
//                 ),
//                 const SizedBox(height: 8),
//                 FloatingActionButton.small(
//                   heroTag: 'finish',
//                   onPressed: _finish,
//                   backgroundColor: Colors.green,
//                   child: const Icon(Icons.check, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           if (_points.isNotEmpty)
//             Positioned(
//               left: 12,
//               bottom: 12,
//               right: 12,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white70,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   'Points: ${_points.length}  — Tap map to add points.',
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class NewLandPage extends StatefulWidget {
  const NewLandPage({super.key});

  @override
  State<NewLandPage> createState() => _NewLandPageState();
}

class _NewLandPageState extends State<NewLandPage> {
  // Basic state fields
  bool isWhatsApp = false;

  String? selectedState;
  String? selectedDistrict;

  // other selection variables
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

  final List<String> states = [];
  final List<String> districts = [];

  // Controllers
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController mandalController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  // Media & others
  File? passbookImage;
  List<File> mediaFiles = [];
  List<LatLng> landBorderPoints = [];

  bool loadingGPS = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    pincodeController.dispose();
    villageController.dispose();
    mandalController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  // ---------------- Location permission helpers ----------------
  Future<bool> _ensureLocationPermission() async {
    LocationPermission p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
    }
    if (p == LocationPermission.deniedForever ||
        p == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  // ---------------- Capture GPS -> only fill mandal & village (and lat/lng) ----------------
  Future<void> fetchVillageGPSAndAddress() async {
    setState(() => loadingGPS = true);

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      setState(() => loadingGPS = false);
      return;
    }

    final ok = await _ensureLocationPermission();
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission required')),
      );
      setState(() => loadingGPS = false);
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitudeController.text = pos.latitude.toStringAsFixed(6);
      longitudeController.text = pos.longitude.toStringAsFixed(6);

      // reverse geocode - but IMPORTANT: we will only use it to fill mandal & village,
      // NOT to overwrite state/district (per your request).
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;

        // get mandal (locality or subLocality)
        final mandal =
            (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
            (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null);

        if (mandal != null) {
          mandalController.text = mandal;
        }

        // village: prefer subLocality -> locality -> name
        final village =
            (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null) ??
            (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
            (p.name?.trim().isNotEmpty == true ? p.name : null);

        if (village != null) {
          villageController.text = village;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('GPS captured — Mandal & Village filled'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No address information found from GPS'),
          ),
        );
      }
    } catch (e) {
      debugPrint("fetchVillageGPS error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to get location: $e')));
    } finally {
      setState(() => loadingGPS = false);
    }
  }

  // ---------------- Simple Get Lat/Lng (fills only coordinates) ----------------
  Future<void> getCurrentLatLong() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    final ok = await _ensureLocationPermission();
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission required')),
      );
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      latitudeController.text = pos.latitude.toStringAsFixed(6);
      longitudeController.text = pos.longitude.toStringAsFixed(6);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Location captured')));
    } catch (e) {
      debugPrint('getCurrentLatLong error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to capture location: $e')));
    }
  }

  // ---------------- PINCODE -> auto-fill state & district only ----------------
  Future<void> fetchAddressFromPincode() async {
    final pin = pincodeController.text.trim();
    if (pin.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit Pincode')),
      );
      return;
    }

    setState(() => loadingGPS = true);
    try {
      final url = Uri.parse("https://api.postalpincode.in/pincode/$pin");
      final request = await HttpClient().getUrl(url);
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      final data = jsonDecode(body);

      if (data is List && data.isNotEmpty) {
        final first = data[0];
        if (first["Status"] != "Success") {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Invalid Pincode')));
          return;
        }

        final postOffices = first["PostOffice"];
        if (postOffices != null &&
            postOffices is List &&
            postOffices.isNotEmpty) {
          final po = postOffices[0];

          final state = (po["State"] as String?)?.trim() ?? '';
          final district = (po["District"] as String?)?.trim() ?? '';

          // Update state dropdown (insert at top if not already present)
          if (state.isNotEmpty) {
            if (!states.contains(state)) {
              setState(() {
                states.insert(0, state);
                selectedState = state;
              });
            } else {
              setState(() => selectedState = state);
            }
          }

          // Update district dropdown
          if (district.isNotEmpty) {
            if (!districts.contains(district)) {
              setState(() {
                districts.insert(0, district);
                selectedDistrict = district;
              });
            } else {
              setState(() => selectedDistrict = district);
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('State & District auto-filled from Pincode'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No PostOffice data for this pincode'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unexpected response from pincode API')),
        );
      }
    } catch (e) {
      debugPrint("fetchAddressFromPincode error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to fetch address: $e')));
    } finally {
      setState(() => loadingGPS = false);
    }
  }

  // ---------------- Passbook / Media ----------------
  Future<void> pickPassbookImage() async {
    final statusCamera = await Permission.camera.request();
    final statusStorage = await Permission.photos.request();
    if (!statusCamera.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission required')),
      );
      return;
    }

    final picked = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (_) => _chooseImageSourceBottomSheet(),
    );

    if (picked != null) {
      setState(() => passbookImage = File(picked.path));
    }
  }

  Widget _chooseImageSourceBottomSheet() {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              Navigator.pop(
                context,
                await _picker.pickImage(source: ImageSource.camera),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gallery'),
            onTap: () async {
              Navigator.pop(
                context,
                await _picker.pickImage(source: ImageSource.gallery),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Cancel'),
            onTap: () => Navigator.pop(context, null),
          ),
        ],
      ),
    );
  }

  Future<void> pickMediaAndDocs() async {
    await Permission.storage.request();
    await Permission.photos.request();

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if (result != null && result.paths.isNotEmpty) {
      setState(() {
        mediaFiles.addAll(
          result.paths.where((p) => p != null).map((p) => File(p!)),
        );
      });
    }
  }

  // ---------------- Map border (same as before) ----------------
  Future<void> openMapForBorder() async {
    final points = await Navigator.push<List<LatLng>>(
      context,
      MaterialPageRoute(
        builder: (_) => LandBorderMapScreen(initialPoints: landBorderPoints),
      ),
    );

    if (points != null) {
      setState(() {
        landBorderPoints = points;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Border captured: ${points.length} points')),
      );
    }
  }

  // ---------------- Submit ----------------
  void submitNewLand() {
    if (villageController.text.isEmpty ||
        latitudeController.text.isEmpty ||
        longitudeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please capture GPS/location before submit'),
        ),
      );
      return;
    }

    // Collect and send to backend...
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('New Land submitted (mock)')));
  }

  // ====================== UI BUILD ======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Suresh",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Field Executive",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.green,
              child: const Icon(Icons.person, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New Land Details",
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
    );
  }

  // ====================== Address Section (State / District / Pincode / Mandal / Village) ======================
  Widget _buildAddressSection() => _sectionContainer(
    title: "Village Address",
    children: [
      // State dropdown
      DropdownButtonFormField<String>(
        value: selectedState,
        decoration: _dropdownDecoration("Select State", Icons.location_on),
        items: states
            .map((state) => DropdownMenuItem(value: state, child: Text(state)))
            .toList(),
        onChanged: (value) => setState(() => selectedState = value),
      ),
      const SizedBox(height: 20),

      // District dropdown
      DropdownButtonFormField<String>(
        value: selectedDistrict,
        decoration: _dropdownDecoration(
          "Select District",
          Icons.location_city_outlined,
        ),
        items: districts
            .map((d) => DropdownMenuItem(value: d, child: Text(d)))
            .toList(),
        onChanged: (value) => setState(() => selectedDistrict = value),
      ),
      const SizedBox(height: 20),

      // <-- Pincode placed right under District as requested -->
      TextFormField(
        controller: pincodeController,
        keyboardType: TextInputType.number,
        maxLength: 6,
        decoration: InputDecoration(
          hintText: "Enter Pincode",
          prefixIcon: const Icon(Icons.search),
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: loadingGPS ? null : fetchAddressFromPincode,
          icon: const Icon(Icons.search),
          label: const Text("SEARCH PINCODE "),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),

      // Mandal (will be filled by Capture GPS)
      TextFormField(
        controller: mandalController,
        decoration: InputDecoration(
          hintText: "Enter Mandal ",
          prefixIcon: const Icon(Icons.map_outlined),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      const SizedBox(height: 20),

      // Village (will be filled by Capture GPS)
      TextFormField(
        controller: villageController,
        decoration: InputDecoration(
          hintText: "Enter Village Name (or capture GPS to fill)",
          prefixIcon: const Icon(Icons.home_outlined),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      const SizedBox(height: 20),

      // Capture GPS button (fills lat/lng + mandal & village only)
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: loadingGPS ? null : fetchVillageGPSAndAddress,
          icon: const Icon(Icons.gps_fixed),
          label: Text(
            loadingGPS
                ? 'Capturing...'
                : 'Capture GPS (fills Mandal & Village)',
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
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
      _labeledInput("Farmer Name", "Enter Farmer's name", Icons.person_outline),
      const SizedBox(height: 20),
      _labeledInput("Phone Number", "Enter phone number", Icons.phone_outlined),
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
      _labeledInput(
        "Other WhatsApp Number",
        "Enter other WhatsApp number",
        Icons.wechat,
      ),
      const SizedBox(height: 25),

      _labelWithIcon("Literacy", Icons.menu_book_outlined),
      _optionGroup(
        ["Illiterate", "Literate", "Graduate"],
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
        ["Polite", "Medium", "Rude"],
        selectedNature,
        (val) => setState(() => selectedNature = val),
      ),

      _labelWithIcon("Land Ownership", Icons.percent_outlined),
      _optionGroup(
        ["Joint", "Single"],
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
        ["No Path to Land"],
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
            child: _labeledInput(
              "Land Area (Acres)",
              "e.g. 3.5",
              Icons.square_foot_outlined,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 1,
            child: _labeledInput(
              "Guntas",
              "e.g. 12",
              Icons.straighten_outlined,
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      _labeledInput(
        "Price per Acre (in Lakhs)",
        "e.g. 10",
        Icons.currency_rupee_outlined,
      ),
      const SizedBox(height: 20),
      _labeledInput(
        "Total Land Value",
        "Calculated Automatically",
        Icons.calculate_outlined,
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
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Choose File",
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
        ["Red", "Black", "Sandy"],
        selectedLandType,
        (val) => setState(() => selectedLandType = val),
      ),

      _labelWithIcon("Water Source", Icons.water_drop_outlined),
      _optionGroup(
        ["Canal", "Bores", "Cheruvu", "Rain Water"],
        selectedWaterSource,
        (val) => setState(() => selectedWaterSource = val),
      ),

      _labelWithIcon("Garden", Icons.park_outlined),
      _optionGroup(
        ["Mango", "Guava", "Coconut", "Sapota", "Other"],
        selectedGarden,
        (val) => setState(() => selectedGarden = val),
      ),

      _labelWithIcon("Shed Details", Icons.agriculture_outlined),
      _optionGroup(
        ["Poultry", "Cow Shed"],
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
        ["Farm House", "RCC Home", "Asbestos Shelter", "Hut"],
        selectedResidential,
        (val) => setState(() => selectedResidential = val),
      ),

      _labelWithIcon("Fencing", Icons.fence_outlined),
      _optionGroup(
        ["With Gate", "All Sides", "Partially", "No"],
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
        ["Attached to Road", "No Connectivity"],
        selectedPath,
        (val) => setState(() => selectedPath = val),
      ),
      const SizedBox(height: 20),
      ElevatedButton.icon(
        onPressed: () {
          openMapForBorder();
        },
        icon: const Icon(Icons.route_outlined),
        label: const Text("Record a Path"),
        style: _outlinedButtonStyle(),
      ),
      const SizedBox(height: 20),
      _labelWithIcon(
        "Land Entry Point (Coordinates)",
        Icons.location_on_outlined,
      ),
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
        label: const Text("Get Location"),
        style: _outlinedButtonStyle(),
      ),
      const SizedBox(height: 20),
      _labelWithIcon("Land Border", Icons.map_outlined),
      ElevatedButton.icon(
        onPressed: openMapForBorder,
        icon: const Icon(Icons.map_outlined),
        label: const Text("Draw Land Border"),
        style: _outlinedButtonStyle(),
      ),
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
        label: const Text("Upload Photos"),
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
        label: const Text("Upload Videos"),
        style: _outlinedButtonStyle(),
      ),
      const SizedBox(height: 20),
      _labelWithIcon(
        "Other Documents (Passbook / Deeds)",
        Icons.insert_drive_file_outlined,
      ),
      ElevatedButton.icon(
        onPressed: pickMediaAndDocs,
        icon: const Icon(Icons.upload_file_outlined),
        label: const Text("Upload Documents"),
        style: _outlinedButtonStyle(),
      ),
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
              child: Image.file(f, width: 90, height: 90, fit: BoxFit.cover),
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
              child: Column(
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
            );
          }
        }).toList(),
      ),
    ],
  );

  // ====================== Submit Buttons ======================
  Widget _buildSubmitButtons() => Column(
    children: [
      ElevatedButton.icon(
        onPressed: submitNewLand,
        icon: const Icon(Icons.cloud_upload_outlined),
        label: const Text("Submit New Land"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      const SizedBox(height: 15),
      ElevatedButton.icon(
        onPressed: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Saved as draft (mock)'))),
        icon: const Icon(Icons.save_outlined),
        label: const Text("Save as Draft"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.black,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ],
  );

  // ====================== Reusable UI helpers ======================
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

  Widget _inputField(String hint, IconData icon) => TextFormField(
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );

  Widget _labeledInput(String label, String hint, IconData icon) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 8),
      _inputField(hint, icon),
    ],
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
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
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
          color: isSelected ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.green.shade800 : Colors.black,
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

// =========== Land Border Map Screen (unchanged) ===========
class LandBorderMapScreen extends StatefulWidget {
  final List<LatLng> initialPoints;
  const LandBorderMapScreen({super.key, required this.initialPoints});

  @override
  State<LandBorderMapScreen> createState() => _LandBorderMapScreenState();
}

class _LandBorderMapScreenState extends State<LandBorderMapScreen> {
  late GoogleMapController _mapController;
  List<LatLng> _points = [];

  @override
  void initState() {
    super.initState();
    _points = List.from(widget.initialPoints);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addPoint(LatLng p) {
    setState(() {
      _points.add(p);
    });
  }

  void _undo() {
    if (_points.isNotEmpty) {
      setState(() {
        _points.removeLast();
      });
    }
  }

  void _clear() {
    setState(() {
      _points.clear();
    });
  }

  void _finish() {
    Navigator.pop(context, _points);
  }

  @override
  Widget build(BuildContext context) {
    final initialCamera = _points.isNotEmpty
        ? CameraPosition(target: _points.first, zoom: 18)
        : const CameraPosition(target: LatLng(17.4402, 78.3489), zoom: 14);

    return Scaffold(
      appBar: AppBar(title: const Text('Draw Land Border')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCamera,
            onMapCreated: _onMapCreated,
            onTap: (p) => _addPoint(p),
            markers: _points
                .asMap()
                .entries
                .map(
                  (e) => Marker(
                    markerId: MarkerId('m${e.key}'),
                    position: e.value,
                    infoWindow: InfoWindow(title: 'P${e.key + 1}'),
                  ),
                )
                .toSet(),
            polygons: {
              if (_points.length >= 3)
                Polygon(
                  polygonId: const PolygonId('land'),
                  points: _points,
                  strokeWidth: 2,
                  strokeColor: Colors.green,
                  fillColor: Colors.green.withOpacity(0.2),
                ),
            },
            polylines: {
              if (_points.length >= 2)
                Polyline(
                  polylineId: const PolylineId('line'),
                  points: _points,
                  color: Colors.green,
                  width: 2,
                ),
            },
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'undo',
                  onPressed: _undo,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.undo, color: Colors.black),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.small(
                  heroTag: 'clear',
                  onPressed: _clear,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.clear, color: Colors.red),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.small(
                  heroTag: 'finish',
                  onPressed: _finish,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.check, color: Colors.white),
                ),
              ],
            ),
          ),
          if (_points.isNotEmpty)
            Positioned(
              left: 12,
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Points: ${_points.length}  — Tap map to add points.',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
