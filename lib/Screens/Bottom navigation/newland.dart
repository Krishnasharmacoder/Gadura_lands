// import 'dart:convert';
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
//   // Basic state fields
//   bool isWhatsApp = false;

//   String? selectedState;
//   String? selectedDistrict;

//   // other selection variables
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

//   final List<String> states = [];
//   final List<String> districts = [];

//   // Controllers
//   final TextEditingController pincodeController = TextEditingController();
//   final TextEditingController villageController = TextEditingController();
//   final TextEditingController mandalController = TextEditingController();
//   final TextEditingController latitudeController = TextEditingController();
//   final TextEditingController longitudeController = TextEditingController();

//   // Media & others
//   File? passbookImage;
//   List<File> mediaFiles = [];
//   List<LatLng> landBorderPoints = [];

//   bool loadingGPS = false;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void dispose() {
//     pincodeController.dispose();
//     villageController.dispose();
//     mandalController.dispose();
//     latitudeController.dispose();
//     longitudeController.dispose();
//     super.dispose();
//   }

//   // ---------------- Location permission helpers ----------------
//   Future<bool> _ensureLocationPermission() async {
//     LocationPermission p = await Geolocator.checkPermission();
//     if (p == LocationPermission.denied) {
//       p = await Geolocator.requestPermission();
//     }
//     if (p == LocationPermission.deniedForever ||
//         p == LocationPermission.denied) {
//       return false;
//     }
//     return true;
//   }

//   // ---------------- Capture GPS -> only fill mandal & village (and lat/lng) ----------------
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

//       // reverse geocode - but IMPORTANT: we will only use it to fill mandal & village,
//       // NOT to overwrite state/district (per your request).
//       final placemarks = await placemarkFromCoordinates(
//         pos.latitude,
//         pos.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         final p = placemarks.first;

//         // get mandal (locality or subLocality)
//         final mandal =
//             (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
//             (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null);

//         if (mandal != null) {
//           mandalController.text = mandal;
//         }

//         // village: prefer subLocality -> locality -> name
//         final village =
//             (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null) ??
//             (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
//             (p.name?.trim().isNotEmpty == true ? p.name : null);

//         if (village != null) {
//           villageController.text = village;
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('GPS captured — Mandal & Village filled'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('No address information found from GPS'),
//           ),
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

//   // ---------------- Simple Get Lat/Lng (fills only coordinates) ----------------
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

//   // ---------------- PINCODE -> auto-fill state & district only ----------------
//   Future<void> fetchAddressFromPincode() async {
//     final pin = pincodeController.text.trim();
//     if (pin.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid 6-digit Pincode')),
//       );
//       return;
//     }

//     setState(() => loadingGPS = true);
//     try {
//       final url = Uri.parse("https://api.postalpincode.in/pincode/$pin");
//       final request = await HttpClient().getUrl(url);
//       final response = await request.close();
//       final body = await response.transform(utf8.decoder).join();
//       final data = jsonDecode(body);

//       if (data is List && data.isNotEmpty) {
//         final first = data[0];
//         if (first["Status"] != "Success") {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text('Invalid Pincode')));
//           return;
//         }

//         final postOffices = first["PostOffice"];
//         if (postOffices != null &&
//             postOffices is List &&
//             postOffices.isNotEmpty) {
//           final po = postOffices[0];

//           final state = (po["State"] as String?)?.trim() ?? '';
//           final district = (po["District"] as String?)?.trim() ?? '';

//           // Update state dropdown (insert at top if not already present)
//           if (state.isNotEmpty) {
//             if (!states.contains(state)) {
//               setState(() {
//                 states.insert(0, state);
//                 selectedState = state;
//               });
//             } else {
//               setState(() => selectedState = state);
//             }
//           }

//           // Update district dropdown
//           if (district.isNotEmpty) {
//             if (!districts.contains(district)) {
//               setState(() {
//                 districts.insert(0, district);
//                 selectedDistrict = district;
//               });
//             } else {
//               setState(() => selectedDistrict = district);
//             }
//           }

//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('State & District auto-filled from Pincode'),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('No PostOffice data for this pincode'),
//             ),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Unexpected response from pincode API')),
//         );
//       }
//     } catch (e) {
//       debugPrint("fetchAddressFromPincode error: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Failed to fetch address: $e')));
//     } finally {
//       setState(() => loadingGPS = false);
//     }
//   }

//   // ---------------- Passbook / Media ----------------
//   Future<void> pickPassbookImage() async {
//     final statusCamera = await Permission.camera.request();
//     final statusStorage = await Permission.photos.request();
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

//   Future<void> pickMediaAndDocs() async {
//     await Permission.storage.request();
//     await Permission.photos.request();

//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.any,
//     );
//     if (result != null && result.paths.isNotEmpty) {
//       setState(() {
//         mediaFiles.addAll(
//           result.paths.where((p) => p != null).map((p) => File(p!)),
//         );
//       });
//     }
//   }

//   // ---------------- Map border (same as before) ----------------
//   Future<void> openMapForBorder() async {
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

//   // ---------------- Submit ----------------
//   void submitNewLand() {
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

//     // Collect and send to backend...
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('New Land submitted (mock)')));
//   }

//   // ====================== UI BUILD ======================
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         bool exitPopup = await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Exit New Land"),
//             content: const Text("Do you really want to exit the app?"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: const Text("No"),
//               ),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context, true),
//                 child: const Text("Yes"),
//               ),
//             ],
//           ),
//         );

//         return exitPopup; // true = exit, false = stay
//       },

//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           toolbarHeight: 80,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Suresh",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     "Field Executive",
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                 ],
//               ),
//               CircleAvatar(
//                 radius: 24,
//                 backgroundColor: Colors.green,
//                 child: const Icon(Icons.person, color: Colors.white, size: 28),
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "New Land Details",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               _buildAddressSection(),
//               const SizedBox(height: 40),
//               _buildFarmerDetails(),
//               const SizedBox(height: 40),
//               _buildDisputeSection(),
//               const SizedBox(height: 40),
//               _buildLandDetailsSection(),
//               const SizedBox(height: 40),
//               _buildGpsSection(),
//               const SizedBox(height: 40),
//               _buildDocumentsSection(),
//               const SizedBox(height: 30),
//               _buildSubmitButtons(),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ====================== Address Section (State / District / Pincode / Mandal / Village) ======================
//   Widget _buildAddressSection() => _sectionContainer(
//     title: "Village Address",
//     children: [
//       // State dropdown
//       DropdownButtonFormField<String>(
//         value: selectedState,
//         decoration: _dropdownDecoration("Select State", Icons.location_on),
//         items: states
//             .map((state) => DropdownMenuItem(value: state, child: Text(state)))
//             .toList(),
//         onChanged: (value) => setState(() => selectedState = value),
//       ),
//       const SizedBox(height: 20),

//       // District dropdown
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

//       // <-- Pincode placed right under District as requested -->
//       TextFormField(
//         controller: pincodeController,
//         keyboardType: TextInputType.number,
//         maxLength: 6,
//         decoration: InputDecoration(
//           hintText: "Enter Pincode",
//           prefixIcon: const Icon(Icons.search),
//           counterText: "",
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         ),
//       ),
//       const SizedBox(height: 12),
//       SizedBox(
//         width: double.infinity,
//         child: ElevatedButton.icon(
//           onPressed: loadingGPS ? null : fetchAddressFromPincode,
//           icon: const Icon(Icons.search, color: Colors.black87),
//           label: const Text(
//             "SEARCH PINCODE ",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//       const SizedBox(height: 20),

//       // Mandal (will be filled by Capture GPS)
//       TextFormField(
//         controller: mandalController,
//         decoration: InputDecoration(
//           hintText: "Enter Mandal ",
//           prefixIcon: const Icon(Icons.map_outlined),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         ),
//       ),
//       const SizedBox(height: 20),

//       // Village (will be filled by Capture GPS)
//       TextFormField(
//         controller: villageController,
//         decoration: InputDecoration(
//           hintText: "Enter Village Name ",
//           prefixIcon: const Icon(Icons.home_outlined),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         ),
//       ),
//       const SizedBox(height: 20),

//       // Capture GPS button (fills lat/lng + mandal & village only)
//       SizedBox(
//         width: double.infinity,
//         child: ElevatedButton.icon(
//           onPressed: loadingGPS ? null : fetchVillageGPSAndAddress,
//           icon: const Icon(Icons.gps_fixed, color: Colors.black87),

//           label: Text(
//             loadingGPS ? 'Capturing...' : 'Capture GPS ',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
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

//       _labelWithIcon("Literacy", Icons.menu_book_outlined),
//       _optionGroup(
//         ["Illiterate", "Literate", "Graduate"],
//         selectedLiteracy,
//         (val) => setState(() => selectedLiteracy = val),
//       ),

//       _labelWithIcon("Age Group", Icons.person_outline),
//       _optionGroup(
//         ["Upto 30", "30-50", "50+"],
//         selectedAgeGroup,
//         (val) => setState(() => selectedAgeGroup = val),
//       ),

//       _labelWithIcon("Nature", Icons.accessibility_new_outlined),
//       _optionGroup(
//         ["Polite", "Medium", "Rude"],
//         selectedNature,
//         (val) => setState(() => selectedNature = val),
//       ),

//       _labelWithIcon("Land Ownership", Icons.percent_outlined),
//       _optionGroup(
//         ["Joint", "Single"],
//         selectedOwnership,
//         (val) => setState(() => selectedOwnership = val),
//       ),

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

//   // ====================== Land Details ======================
//   Widget _buildLandDetailsSection() => _sectionContainer(
//     title: "Land Details",
//     children: [
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

//   // ====================== GPS & Path ======================
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

//   // ====================== Documents & Media ======================
//   Widget _buildDocumentsSection() => _sectionContainer(
//     title: "Documents & Media",
//     children: [
//       _labelWithIcon("Land Photos", Icons.photo_camera_outlined),
//       ElevatedButton.icon(
//         onPressed: () async {
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
//           if (picked != null) setState(() => mediaFiles.add(File(picked.path)));
//         },
//         icon: const Icon(Icons.videocam_outlined),
//         label: const Text("Upload Videos"),
//         style: _outlinedButtonStyle(),
//       ),
//       const SizedBox(height: 20),

//       const SizedBox(height: 12),
//       Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children: mediaFiles.map((f) {
//           final ext = f.path.split('.').last.toLowerCase();
//           if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
//             return GestureDetector(
//               onTap: () => showDialog(
//                 context: context,
//                 builder: (_) => Dialog(child: Image.file(f)),
//               ),
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

//   // ====================== Submit Buttons ======================
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
//         onPressed: () => ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Saved as draft (mock)'))),
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

//   // ====================== Reusable UI helpers ======================
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

// // =========== Land Border Map Screen (unchanged) ===========
// class LandBorderMapScreen extends StatefulWidget {
//   final List<LatLng> initialPoints;
//   const LandBorderMapScreen({super.key, required this.initialPoints});

//   @override
//   State<LandBorderMapScreen> createState() => _LandBorderMapScreenState();
// }

// class _LandBorderMapScreenState extends State<LandBorderMapScreen> {
//   late GoogleMapController _mapController;
//   List<LatLng> _points = [];

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
import 'package:gadura_land/Screens/homepage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewLandPage extends StatefulWidget {
  //const NewLandPage({super.key});
  final Map<String, dynamic>? landData; // 👈 receive data here

  const NewLandPage({super.key, this.landData});
  @override
  State<NewLandPage> createState() => _NewLandPageState();
}

class _NewLandPageState extends State<NewLandPage> {
  // ---------- Authorization ----------
  // Replace with your real token (or obtain from secure storage)
  // static const String _apiToken =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidW5pcXVlX2lkIjoiYWdlbnQwIiwiZW1haWwiOiJhZ2VudEBnbWFpbC5jb20iLCJyb2xlIjoiYWdlbnQiLCJpYXQiOjE3NjM3MDg4ODUsImV4cCI6MTc2NDMxMzY4NX0.pTdY0V5mG-5qo3rI9NobV36CnrjPdgqx6Y7REZuc3NY';
  String? _apiToken;
  bool get isEditMode => widget.landData != null;
  bool isDraft = false;

  @override
  void initState() {
    super.initState();
    loadToken();

    if (widget.landData != null) {
      fillEditData(widget.landData!);
    }
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
  }

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

  // Controllers (added for fields that were previously uncontrolled)
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController mandalController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  // Farmer & land controllers
  final TextEditingController farmerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otherWhatsappController = TextEditingController();
  final TextEditingController landAreaController = TextEditingController();
  final TextEditingController guntasController = TextEditingController();
  final TextEditingController pricePerAcreController = TextEditingController();
  final TextEditingController totalLandPriceController =
      TextEditingController();
  final TextEditingController locationController =
      TextEditingController(); // "location" field
  final TextEditingController shedDetailsController = TextEditingController();

  // Media & others
  File? passbookImage;
  List<File> mediaFiles = [];
  List<LatLng> landBorderPoints = [];

  bool loadingGPS = false;
  bool submitting = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    pincodeController.dispose();
    villageController.dispose();
    mandalController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    farmerNameController.dispose();
    phoneController.dispose();
    otherWhatsappController.dispose();
    landAreaController.dispose();
    guntasController.dispose();
    pricePerAcreController.dispose();
    totalLandPriceController.dispose();
    locationController.dispose();
    shedDetailsController.dispose();
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

  void fillEditData(Map<String, dynamic> data) {
    // Location
    pincodeController.text = data['land_location']['pincode']?.toString() ?? '';
    villageController.text = data['land_location']['village'] ?? '';
    mandalController.text = data['land_location']['mandal'] ?? '';
    latitudeController.text =
        data['land_location']['latitude']?.toString() ?? '';
    longitudeController.text =
        data['land_location']['longitude']?.toString() ?? '';

    // FARMER DETAILS
    farmerNameController.text = data['farmer_details']['name'] ?? '';
    phoneController.text = data['farmer_details']['phone'] ?? '';
    otherWhatsappController.text = data['farmer_details']['whatsapp'] ?? '';

    // LAND DETAILS
    landAreaController.text =
        data['land_details']['land_area']?.toString() ?? '';
    guntasController.text = data['land_details']['guntas']?.toString() ?? '';
    pricePerAcreController.text =
        data['land_details']['price_per_acre']?.toString() ?? '';
    totalLandPriceController.text =
        data['land_details']['total_land_price']?.toString() ?? '';

    // Dropdown selections
    selectedState = data['land_location']['state'];
    selectedDistrict = data['land_location']['district'];
    selectedLiteracy = data['farmer_details']['literacy_status'];
    selectedAgeGroup = data['farmer_details']['age_group'];
    selectedNature = data['land_details']['nature'];
    selectedOwnership = data['land_details']['ownership'];
    selectedMortgage = data['land_details']['mortgage'];
    selectedDisputeType = data['land_details']['dispute_type'];
    selectedSibling = data['land_details']['siblings'];
    selectedPath = data['land_details']['road_path'];
    selectedLandType = data['land_details']['land_type'];
    selectedWaterSource = data['land_details']['water_source'];
    selectedGarden = data['land_details']['garden'];
    selectedShed = data['land_details']['shed'];
    selectedFarmPond = data['land_details']['farm_pond'];
    selectedResidential = data['land_details']['residential'];
    selectedFencing = data['land_details']['fencing'];
  }

  Future<void> saveEditedLand() async {
    if (_apiToken == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Token not found")));
      return;
    }

    if (widget.landData == null) return;

    setState(() => submitting = true);

    try {
      final landId =
          widget.landData!['id']; // ya widget.landData!['land_id'] jo unique ho
      final uri = Uri.parse(
        "http://72.61.169.226/field-executive/land/$landId",
      );
      final request = http.MultipartRequest('PUT', uri);

      request.headers['Authorization'] = 'Bearer $_apiToken';

      // Add all form fields just like submitNewLand
      request.fields['state'] = selectedState ?? '';
      request.fields['district'] = selectedDistrict ?? '';
      request.fields['mandal'] = mandalController.text;
      request.fields['village'] = villageController.text;
      request.fields['location'] = locationController.text;
      request.fields['name'] = farmerNameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['whatsapp_number'] = otherWhatsappController.text;
      request.fields['literacy'] = selectedLiteracy ?? '';
      request.fields['age_group'] = selectedAgeGroup ?? '';
      request.fields['nature'] = selectedNature ?? '';
      request.fields['land_ownership'] = selectedOwnership ?? '';
      request.fields['mortgage'] = selectedMortgage ?? '';
      request.fields['land_area'] = landAreaController.text;
      request.fields['guntas'] = guntasController.text;
      request.fields['price_per_acre'] = pricePerAcreController.text;
      request.fields['total_land_price'] = totalLandPriceController.text;
      request.fields['land_type'] = selectedLandType ?? '';
      request.fields['water_source'] = selectedWaterSource ?? '';
      request.fields['garden'] = selectedGarden ?? '';
      request.fields['shed_details'] = shedDetailsController.text;
      request.fields['farm_pond'] = selectedFarmPond ?? '';
      request.fields['residental'] = selectedResidential ?? '';
      request.fields['fencing'] = selectedFencing ?? '';
      request.fields['road_path'] = selectedPath ?? '';
      request.fields['land_location_gps'] =
          "${latitudeController.text},${longitudeController.text}";
      request.fields['dispute_type'] = selectedDisputeType ?? '';
      request.fields['siblings_involve_in_dispute'] = selectedSibling ?? '';
      request.fields['path_to_land'] = selectedPath ?? '';

      // Add images/videos same as submitNewLand
      // Example:
      if (passbookImage != null) {
        final stream = http.ByteStream(passbookImage!.openRead());
        final length = await passbookImage!.length();
        request.files.add(
          http.MultipartFile(
            'passbook_photo',
            stream,
            length,
            filename: passbookImage!.path.split('/').last,
          ),
        );
      }

      // Send request
      final streamed = await request.send();
      final respStr = await streamed.stream.bytesToString();

      if (streamed.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Land updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Update failed: ${streamed.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => submitting = false);
    }
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

      // reverse geocode - but IMPORTANT: we will only use it to fill mandal & village
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;

        final mandal =
            (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
            (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null);

        if (mandal != null) {
          mandalController.text = mandal;
        }

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
          setState(() => loadingGPS = false);
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

  //---------------- Submit (API integration) ----------------
  Future<void> submitNewLand() async {
    // basic validations
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

    setState(() => submitting = true);

    try {
      final uri = Uri.parse("http://72.61.169.226/field-executive/land");
      final request = http.MultipartRequest('POST', uri);

      // Authorization
      //request.headers['Authorization'] = 'Bearer $_apiToken';
      if (_apiToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Token not found. Please login again.")),
        );
        return;
      }

      request.headers['Authorization'] = 'Bearer $_apiToken';

      // Add text fields (matching your Postman keys)
      if (isDraft = true) {
        request.fields['state'] = selectedState ?? '';
        request.fields['district'] = selectedDistrict ?? '';
        request.fields['mandal'] = mandalController.text;
        request.fields['village'] = villageController.text;
        request.fields['location'] = locationController.text;
        request.fields['name'] = farmerNameController.text;
        request.fields['phone'] = phoneController.text;
        request.fields['whatsapp_number'] = otherWhatsappController.text;
        request.fields['literacy'] = selectedLiteracy ?? ''; //no
        request.fields['age_group'] = selectedAgeGroup ?? ''; //done
        request.fields['nature'] = selectedNature ?? ''; //no
        request.fields['Land_ownership'] = selectedOwnership ?? '';
        request.fields['mortgage'] = selectedMortgage ?? '';
        request.fields['land_area'] = landAreaController.text;
        request.fields['guntas'] = guntasController.text;
        request.fields['price_per_acre'] = pricePerAcreController.text;
        request.fields['total_land_price'] = totalLandPriceController.text;
        request.fields['land_type'] = selectedLandType ?? '';
        request.fields['water_source'] = selectedWaterSource ?? '';
        request.fields['garden'] = selectedGarden ?? '';
        request.fields['shed_details'] = shedDetailsController.text;
        request.fields['farm_pond'] = selectedFarmPond ?? '';
        request.fields['residental'] = selectedResidential ?? '';
        request.fields['fencing'] = selectedFencing ?? '';
        request.fields['road_path'] = selectedPath ?? '';
        request.fields['land_location_gps'] =
            "${latitudeController.text},${longitudeController.text}";
        request.fields['dispute_type'] = selectedDisputeType ?? '';
        request.fields['siblings_involve_in_dispute'] = selectedSibling ?? '';
        request.fields['path_to_land'] = selectedPath ?? '';
      }
      // If you have border points, send them as JSON string under 'land_border_points'
      if (landBorderPoints.isNotEmpty) {
        final coords = landBorderPoints
            .map((p) => {'lat': p.latitude, 'lng': p.longitude})
            .toList();
        request.fields['land_border_points'] = jsonEncode(coords);
      }

      // Attach passbook image if available
      if (passbookImage != null) {
        final passbookStream = http.ByteStream(passbookImage!.openRead());
        final passbookLength = await passbookImage!.length();
        final multipartFile = http.MultipartFile(
          'passbook_photo',
          passbookStream,
          passbookLength,
          filename: passbookImage!.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      // Attach at least one land photo (if available) as 'land_photo'
      final firstImage = mediaFiles.firstWhere(
        (f) => _isImageFile(f),
        orElse: () => File(''),
      );
      if (firstImage.path.isNotEmpty && _isImageFile(firstImage)) {
        final imgStream = http.ByteStream(firstImage.openRead());
        final imgLen = await firstImage.length();
        request.files.add(
          http.MultipartFile(
            'land_photo',
            imgStream,
            imgLen,
            filename: firstImage.path.split('/').last,
          ),
        );
      }

      // Attach first video (if available) as 'land_video'
      final firstVideo = mediaFiles.firstWhere(
        (f) => _isVideoFile(f),
        orElse: () => File(''),
      );
      if (firstVideo.path.isNotEmpty && _isVideoFile(firstVideo)) {
        final vidStream = http.ByteStream(firstVideo.openRead());
        final vidLen = await firstVideo.length();
        request.files.add(
          http.MultipartFile(
            'land_video',
            vidStream,
            vidLen,
            filename: firstVideo.path.split('/').last,
          ),
        );
      }

      // Attach remaining media as media_files[] (optional)
      for (var f in mediaFiles) {
        // skip the ones we've already added
        if ((f.path == firstImage.path && _isImageFile(f)) ||
            (f.path == firstVideo.path && _isVideoFile(f))) {
          continue;
        }
        final stream = http.ByteStream(f.openRead());
        final len = await f.length();
        request.files.add(
          http.MultipartFile(
            'media_files[]',
            stream,
            len,
            filename: f.path.split('/').last,
          ),
        );
      }

      // Send request
      final streamed = await request.send();
      final respStr = await streamed.stream.bytesToString();

      if (streamed.statusCode == 200 || streamed.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Land submitted successfully')),
        );
        // Optionally clear form or navigate back
      } else {
        debugPrint('API Error ${streamed.statusCode}: $respStr');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Submission failed: ${streamed.statusCode} — ${_shorten(respStr, 200)}',
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('submitNewLand error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Submission error: $e')));
    } finally {
      setState(() => submitting = false);
    }
  }

  // Helper utilities
  bool _isImageFile(File f) {
    final ext = f.path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'heic'].contains(ext);
  }

  bool _isVideoFile(File f) {
    final ext = f.path.split('.').last.toLowerCase();
    return ['mp4', 'mov', 'wmv', 'avi', 'mkv'].contains(ext);
  }

  String _shorten(String s, int max) {
    if (s.length <= max) return s;
    return s.substring(0, max) + '...';
  }

  // ====================== UI BUILD ======================
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitPopup = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit New Land"),
            content: const Text("Do you really want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Yes"),
              ),
            ],
          ),
        );

        return exitPopup; // true = exit, false = stay
      },

      child: Scaffold(
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
        body: Stack(
          children: [
            SingleChildScrollView(
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
            if (submitting)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  // ====================== Address Section (State / District / Pincode / Mandal / Village) ======================
  Widget _buildAddressSection() => _sectionContainer(
    title: "Village Address",
    children: [
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

      SizedBox(height: 20),
      // State dropdown
      DropdownButtonFormField<String>(
        value: selectedState,
        decoration: _dropdownDecoration(" State", Icons.location_on),
        icon: SizedBox.shrink(),
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
          " District",
          Icons.location_city_outlined,
        ),
        icon: SizedBox.shrink(),
        items: districts
            .map((d) => DropdownMenuItem(value: d, child: Text(d)))
            .toList(),
        onChanged: (value) => setState(() => selectedDistrict = value),
      ),
      const SizedBox(height: 20),

      // Pincode
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: loadingGPS ? null : fetchAddressFromPincode,
          icon: const Icon(Icons.search, color: Colors.black87),
          label: const Text(
            "SEARCH PINCODE ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),

      // Mandal
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

      // Village
      TextFormField(
        controller: villageController,
        decoration: InputDecoration(
          hintText: "Enter Village Name ",
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
          icon: const Icon(Icons.gps_fixed, color: Colors.black87),
          label: Text(
            loadingGPS ? 'Capturing...' : 'Capture GPS ',
            style: TextStyle(
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
      //   onPressed: () {
      //     openMapForBorder();
      //   },
      //   icon: const Icon(Icons.route_outlined),
      //   label: const Text("Record a Path"),
      //   style: _outlinedButtonStyle(),
      // ),
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
      // _labelWithIcon("Land Border", Icons.map_outlined),
      // ElevatedButton.icon(
      //   onPressed: openMapForBorder,
      //   icon: const Icon(Icons.map_outlined),
      //   label: const Text("Draw Land Border"),
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

  Widget _buildSubmitButtons() => Column(
    children: [
      // ------------------ Submit New Land ------------------
      if (!isEditMode)
        ElevatedButton.icon(
          onPressed: () {
            isDraft = false; // ⭐ SUBMIT
            submitNewLand();
          },
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

      // ------------------ Update Land ------------------
      if (isEditMode)
        ElevatedButton.icon(
          onPressed: () {
            isDraft = false; // ⭐ UPDATE = submitted
            submitNewLand();
          },
          icon: const Icon(Icons.save_outlined),
          label: const Text("Update Land"),
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
      ElevatedButton.icon(
        onPressed: () {
          isDraft = true; // ⭐ DRAFT
          submitNewLand();
        },
        icon: const Icon(Icons.save_alt_outlined),
        label: const Text("Save as Draft"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade600,
          foregroundColor: Colors.white,
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
