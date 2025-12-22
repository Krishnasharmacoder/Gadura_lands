// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:gadura_land/Auth/login.dart';
// import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:gadura_land/Screens/homepage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart'; // For MediaType
// import 'package:mime/mime.dart'; // For lookupMimeType

// enum ImageType { profile, idCard, aadharFront, aadharBack }

// class Regionalprofile extends StatefulWidget {
//   const Regionalprofile({super.key});

//   @override
//   State<Regionalprofile> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<Regionalprofile> {
//   bool isEditing = false;
//   String selectedPackage = "250";
//   String? _apiToken;
//   bool _isLoading = true;
//   bool _isSaving = false;

//   // Controllers
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final roleController = TextEditingController();
//   final phoneController = TextEditingController();
//   final bloodgroupController = TextEditingController();
//   final aadhaarController = TextEditingController();
//   final stateController = TextEditingController();
//   final districtController = TextEditingController();
//   final mandalController = TextEditingController();
//   final villageController = TextEditingController();
//   final pincodeController = TextEditingController();
//   final accountHolderController = TextEditingController();
//   final bankNameController = TextEditingController();
//   final accountNumberController = TextEditingController();
//   final ifscController = TextEditingController();
//   final workstateController = TextEditingController();
//   final workdistrictController = TextEditingController();
//   final workmandalController = TextEditingController();
//   final workvillageController = TextEditingController();
//   final vehicleTypeController = TextEditingController();
//   final vehicleNumberController = TextEditingController();

//   // नए बैंक फील्ड के लिए Controllers
//   final gpayPhoneController = TextEditingController();
//   final bankPhoneController = TextEditingController();
//   final upiIdController = TextEditingController();

//   // Images
//   File? profileImage;
//   File? idCardImage;
//   File? aadharFront;
//   File? aadharBack;

//   final picker = ImagePicker();

//   // API URLs
//   String? profileImageUrl;
//   String? idCardImageUrl;
//   String? aadharFrontUrl;
//   String? aadharBackUrl;

//   @override
//   void initState() {
//     super.initState();
//     _initProfile();
//   }

//   Future<void> _initProfile() async {
//     await _loadToken();
//     await _fetchProfileFromAPI();
//   }

//   Future<void> _loadToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _apiToken = prefs.getString("auth_token");
//     print("Token loaded: ${_apiToken != null}");
//   }

//   // ---------- GET API CALL ----------
//   Future<void> _fetchProfileFromAPI() async {
//     if (_apiToken == null || _apiToken!.isEmpty) {
//       print("No token available");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please login again")));
//       setState(() => _isLoading = false);
//       return;
//     }

//     try {
//       setState(() => _isLoading = true);
//       print("Fetching profile data...");

//       final response = await http.get(
//         Uri.parse(""),
//         headers: {
//           'Authorization': 'Bearer $_apiToken',
//           'Content-Type': 'application/json',
//         },
//       );

//       print("Response status: ${response.statusCode}");
//       print("Response body: ${response.body}");

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         print("Data received successfully");

//         // Populate controllers with API data
//         _populateControllers(data);

//         // Save to shared preferences
//         await _saveToSharedPreferences(data);

//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(content: Text("Profile loaded successfully")),
//         // );
//       } else {
//         print("API Error: ${response.statusCode}");
//         await _loadFromSharedPrefs();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Failed to load profile: ${response.statusCode}"),
//           ),
//         );
//       }
//     } catch (e) {
//       print("Error: $e");
//       await _loadFromSharedPrefs();
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error loading profile: $e")));
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _populateControllers(Map<String, dynamic> data) {
//     setState(() {
//       // User data
//       final user = data['user'] as Map<String, dynamic>? ?? {};
//       nameController.text = user['name']?.toString() ?? '';
//       emailController.text = user['email']?.toString() ?? '';
//       roleController.text = user['role']?.toString() ?? 'Field Executive';
//       phoneController.text = user['phone']?.toString() ?? '';
//       bloodgroupController.text = user['blood_group']?.toString() ?? '';
//       profileImageUrl = user['image']?.toString();
//       idCardImageUrl = user['photo']?.toString();

//       // Address data
//       final address = data['address'] as Map<String, dynamic>? ?? {};
//       stateController.text = address['state']?.toString() ?? 'Telangana';
//       districtController.text = address['district']?.toString() ?? 'Rangareddy';
//       mandalController.text = address['mandal']?.toString() ?? 'Kothur';
//       villageController.text = address['village']?.toString() ?? 'Ramapuram';
//       pincodeController.text = address['pincode']?.toString() ?? '500081';

//       // Aadhar data
//       final aadhar = data['aadhar'] as Map<String, dynamic>? ?? {};
//       aadhaarController.text = aadhar['aadhar_number']?.toString() ?? '';
//       aadharFrontUrl = aadhar['aadhar_front_image']?.toString();
//       aadharBackUrl = aadhar['aadhar_back_image']?.toString();

//       // Salary package
//       final salaryPackage =
//           data['salary_package'] as Map<String, dynamic>? ?? {};
//       selectedPackage = salaryPackage['package']?.toString() ?? '250';

//       // Bank account
//       final bankAccount = data['bank_account'] as Map<String, dynamic>? ?? {};
//       bankNameController.text =
//           bankAccount['bank_name']?.toString() ?? 'HDFC Bank';
//       accountNumberController.text =
//           bankAccount['account_number']?.toString() ?? '1234567890';
//       ifscController.text =
//           bankAccount['ifsc_code']?.toString() ?? 'HDFC0001234';

//       // नए बैंक फील्ड्स
//       gpayPhoneController.text = bankAccount['gpay_number']?.toString() ?? '';
//       bankPhoneController.text =
//           bankAccount['phonepe_number']?.toString() ?? '';
//       upiIdController.text = bankAccount['upi_id']?.toString() ?? '';

//       // Work location
//       final workLocation = data['work_location'] as Map<String, dynamic>? ?? {};
//       workstateController.text =
//           workLocation['work_state']?.toString() ?? 'Telangana';
//       workdistrictController.text =
//           workLocation['work_district']?.toString() ?? 'Rangareddy';
//       workmandalController.text =
//           workLocation['work_mandal']?.toString() ?? 'Kothur';
//       workvillageController.text =
//           workLocation['work_village']?.toString() ?? 'Ramapuram';

//       // Vehicle information
//       final vehicleInfo =
//           data['vehicle_information'] as Map<String, dynamic>? ?? {};
//       vehicleTypeController.text =
//           vehicleInfo['vehicle_type']?.toString() ?? 'Bike';
//       vehicleNumberController.text =
//           vehicleInfo['license_plate']?.toString() ?? 'TS09AB1234';
//     });
//   }

//   Future<void> _saveToSharedPreferences(Map<String, dynamic> data) async {
//     final sp = await SharedPreferences.getInstance();

//     final user = data['user'] ?? {};
//     final address = data['address'] ?? {};
//     final aadhar = data['aadhar'] ?? {};
//     final salaryPackage = data['salary_package'] ?? {};
//     final bankAccount = data['bank_account'] ?? {};
//     final workLocation = data['work_location'] ?? {};
//     final vehicleInfo = data['vehicle_information'] ?? {};

//     await sp.setString('name', user['name']?.toString() ?? '');
//     await sp.setString('email', user['email']?.toString() ?? '');
//     await sp.setString('phone', user['phone']?.toString() ?? '');
//     await sp.setString('blood', user['blood_group']?.toString() ?? '');

//     await sp.setString('state', address['state']?.toString() ?? 'Telangana');
//     await sp.setString(
//       'district',
//       address['district']?.toString() ?? 'Rangareddy',
//     );
//     await sp.setString('mandal', address['mandal']?.toString() ?? 'Kothur');
//     await sp.setString(
//       'village',
//       address['village']?.toString() ?? 'Ramapuram',
//     );
//     await sp.setString('pincode', address['pincode']?.toString() ?? '500081');

//     await sp.setString('aadhaar', aadhar['aadhar_number']?.toString() ?? '');

//     await sp.setString(
//       'package',
//       salaryPackage['package']?.toString() ?? '250',
//     );

//     await sp.setString(
//       'bankName',
//       bankAccount['bank_name']?.toString() ?? 'HDFC Bank',
//     );
//     await sp.setString(
//       'accountNumber',
//       bankAccount['account_number']?.toString() ?? '1234567890',
//     );
//     await sp.setString(
//       'ifsc',
//       bankAccount['ifsc_code']?.toString() ?? 'HDFC0001234',
//     );

//     // नए बैंक फील्ड्स को SharedPreferences में सेव करें
//     await sp.setString(
//       'gpayPhone',
//       bankAccount['gpay_phone']?.toString() ?? '',
//     );
//     await sp.setString(
//       'bankPhone',
//       bankAccount['bank_phone']?.toString() ?? '',
//     );
//     await sp.setString('upiId', bankAccount['upi_id']?.toString() ?? '');

//     await sp.setString(
//       'work_state',
//       workLocation['work_state']?.toString() ?? 'Telangana',
//     );
//     await sp.setString(
//       'work_district',
//       workLocation['work_district']?.toString() ?? 'Rangareddy',
//     );
//     await sp.setString(
//       'work_mandal',
//       workLocation['work_mandal']?.toString() ?? 'Kothur',
//     );
//     await sp.setString(
//       'work_village',
//       workLocation['work_village']?.toString() ?? 'Ramapuram',
//     );

//     await sp.setString(
//       'vehicletype',
//       vehicleInfo['vehicle_type']?.toString() ?? 'Bike',
//     );
//     await sp.setString(
//       'vehicleNumber',
//       vehicleInfo['license_plate']?.toString() ?? 'TS09AB1234',
//     );

//     // Store image URLs
//     if (user['image'] != null) {
//       await sp.setString('profileImageUrl', user['image'].toString());
//     }
//     if (user['photo'] != null) {
//       await sp.setString('idCardImageUrl', user['photo'].toString());
//     }
//     if (aadhar['aadhar_front_image'] != null) {
//       await sp.setString(
//         'aadharFrontUrl',
//         aadhar['aadhar_front_image'].toString(),
//       );
//     }
//     if (aadhar['aadhar_back_image'] != null) {
//       await sp.setString(
//         'aadharBackUrl',
//         aadhar['aadhar_back_image'].toString(),
//       );
//     }
//   }

//   Future<void> _loadFromSharedPrefs() async {
//     final sp = await SharedPreferences.getInstance();

//     setState(() {
//       nameController.text = sp.getString('name') ?? '';
//       emailController.text = sp.getString('email') ?? '';
//       roleController.text = 'Field Executive';
//       phoneController.text = sp.getString('phone') ?? '';
//       bloodgroupController.text = sp.getString('blood') ?? '';
//       aadhaarController.text = sp.getString('aadhaar') ?? '';
//       stateController.text = sp.getString('state') ?? 'Telangana';
//       districtController.text = sp.getString('district') ?? 'Rangareddy';
//       mandalController.text = sp.getString('mandal') ?? 'Kothur';
//       villageController.text = sp.getString('village') ?? 'Ramapuram';
//       pincodeController.text = sp.getString('pincode') ?? '500081';
//       bankNameController.text = sp.getString('bankName') ?? 'HDFC Bank';
//       accountNumberController.text =
//           sp.getString('accountNumber') ?? '1234567890';
//       ifscController.text = sp.getString('ifsc') ?? 'HDFC0001234';

//       // नए बैंक फील्ड्स को लोड करें
//       gpayPhoneController.text = sp.getString('gpay_number') ?? '';
//       bankPhoneController.text = sp.getString('phonepe_number') ?? '';
//       upiIdController.text = sp.getString('upi_id') ?? '';

//       workstateController.text = sp.getString('work_state') ?? 'Telangana';
//       workdistrictController.text =
//           sp.getString('work_district') ?? 'Rangareddy';
//       workmandalController.text = sp.getString('work_mandal') ?? 'Kothur';
//       workvillageController.text = sp.getString('work_village') ?? 'Ramapuram';
//       vehicleTypeController.text = sp.getString('vehicletype') ?? 'Bike';
//       vehicleNumberController.text =
//           sp.getString('vehicleNumber') ?? 'TS09AB1234';
//       selectedPackage = sp.getString('package') ?? '250';

//       // Load image URLs
//       profileImageUrl = sp.getString('profileImageUrl');
//       idCardImageUrl = sp.getString('idCardImageUrl');
//       aadharFrontUrl = sp.getString('aadharFrontUrl');
//       aadharBackUrl = sp.getString('aadharBackUrl');

//       // Load local images
//       profileImage = _getImageFile(sp.getString('profileImage'));
//       idCardImage = _getImageFile(sp.getString('idCardImage'));
//       aadharFront = _getImageFile(sp.getString('aadharFront'));
//       aadharBack = _getImageFile(sp.getString('aadharBack'));
//     });
//   }

//   File? _getImageFile(String? path) {
//     if (path != null && path.isNotEmpty && File(path).existsSync()) {
//       return File(path);
//     }
//     return null;
//   }

//   // ---------- PUT API CALL ----------

//   Future<void> _updateProfileApi() async {
//     if (_apiToken == null || _apiToken!.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please login again")));
//       return;
//     }

//     try {
//       setState(() => _isSaving = true);

//       final uri = Uri.parse("");
//       var request = http.MultipartRequest("PUT", uri);

//       // 1. Headers (Matches your cURL)
//       request.headers.addAll({
//         'Authorization': 'Bearer $_apiToken',
//         'Accept': 'application/json', // Good practice to add this
//       });

//       // 2. Text Fields (Matches your cURL form fields)
//       request.fields.addAll({
//         'name': nameController.text,
//         'email': emailController.text,
//         'phone': phoneController.text,
//         'blood_group': bloodgroupController.text,
//         'aadhar_number': aadhaarController.text,
//         'state': stateController.text,
//         'district': districtController.text,
//         'mandal': mandalController.text,
//         'village': villageController.text,
//         'pincode': pincodeController.text,
//         'package': selectedPackage ?? "350", // Ensure not null
//         'bank_name': bankNameController.text,
//         'account_number': accountNumberController.text,
//         'ifsc_code': ifscController.text,
//         'work_state': workstateController.text,
//         'work_district': workdistrictController.text,
//         'work_mandal': workmandalController.text,
//         'work_village': workvillageController.text,
//         'vehicle_type': vehicleTypeController.text,
//         'license_plate': vehicleNumberController.text,
//         'gpay_id': gpayPhoneController.text,
//         'phonepe_number': bankPhoneController.text,
//         'upi_id': upiIdController.text,
//       });

//       // 3. File Upload Helper Function (The Fix)
//       Future<void> addFile(String key, File? file) async {
//         if (file == null) return;
//         if (!await file.exists()) {
//           print("File does not exist: ${file.path}");
//           return;
//         }

//         // Detect file type (e.g., 'image/png')
//         final mimeType = lookupMimeType(file.path);
//         MediaType? contentType;

//         if (mimeType != null) {
//           final split = mimeType.split('/');
//           contentType = MediaType(split[0], split[1]);
//         }

//         print("Uploading $key: ${file.path} as $mimeType");

//         request.files.add(
//           await http.MultipartFile.fromPath(
//             key,
//             file.path,
//             contentType: contentType, // <--- CRITICAL FIX
//           ),
//         );
//       }

//       await addFile('image', profileImage);

//       await addFile('photo', idCardImage);
//       await addFile('aadhar_front_image', aadharFront);
//       await addFile('aadhar_back_image', aadharBack);

//       // 5. Send
//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();

//       print("Status: ${response.statusCode}");
//       print("Body: $responseBody");

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Profile updated successfully!")),
//         );
//         await _fetchProfileFromAPI(); // Refresh data
//         setState(() => isEditing = false);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed: ${response.statusCode}")),
//         );
//       }
//     } catch (e) {
//       print("Error: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: $e")));
//     } finally {
//       setState(() => _isSaving = false);
//     }
//   }

//   // ---------- IMAGE PICKER ----------
//   Future<void> pickImage(ImageType type) async {
//     final XFile? file = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 60,
//     );
//     if (file == null) return;
//     final img = File(file.path);
//     final sp = await SharedPreferences.getInstance();

//     setState(() {
//       switch (type) {
//         case ImageType.profile:
//           profileImage = img;
//           sp.setString('profileImage', img.path);
//           break;
//         case ImageType.idCard:
//           idCardImage = img;
//           sp.setString('idCardImage', img.path);
//           break;
//         case ImageType.aadharFront:
//           aadharFront = img;
//           sp.setString('aadharFront', img.path);
//           break;
//         case ImageType.aadharBack:
//           aadharBack = img;
//           sp.setString('aadharBack', img.path);
//           break;
//       }
//     });
//   }

//   Future<void> removeImage(ImageType type) async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       switch (type) {
//         case ImageType.profile:
//           profileImage = null;
//           sp.remove('profileImage');
//           break;
//         case ImageType.idCard:
//           idCardImage = null;
//           sp.remove('idCardImage');
//           break;
//         case ImageType.aadharFront:
//           aadharFront = null;
//           sp.remove('aadharFront');
//           break;
//         case ImageType.aadharBack:
//           aadharBack = null;
//           sp.remove('aadharBack');
//           break;
//       }
//     });
//   }

//   // ---------- LOGOUT ----------
//   Future<void> _logoutUser() async {
//     bool shouldLogout = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Logout"),
//         content: const Text("Are you sure you want to logout?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context, true),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             child: const Text("Logout", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );

//     if (shouldLogout == true) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.clear();

//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => const Login()),
//         (route) => false,
//       );
//     }
//   }

//   // ---------- WIDGET BUILDERS ----------
//   Widget _buildProfilePhoto() {
//     return Column(
//       children: [
//         Stack(
//           alignment: Alignment.bottomRight,
//           children: [
//             CircleAvatar(
//               radius: 55,
//               backgroundColor: Colors.grey.shade300,
//               backgroundImage: profileImage != null
//                   ? FileImage(profileImage!)
//                   : (profileImageUrl != null && profileImageUrl!.isNotEmpty
//                             ? NetworkImage(profileImageUrl!)
//                             : null)
//                         as ImageProvider?,
//               child:
//                   profileImage == null &&
//                       (profileImageUrl == null || profileImageUrl!.isEmpty)
//                   ? const Icon(Icons.person, size: 60, color: Colors.white)
//                   : null,
//             ),
//             if (isEditing)
//               GestureDetector(
//                 onTap: () => pickImage(ImageType.profile),
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.green,
//                   ),
//                   child: const Icon(Icons.edit, color: Colors.white, size: 20),
//                 ),
//               ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         if (isEditing &&
//             (profileImage != null ||
//                 (profileImageUrl != null && profileImageUrl!.isNotEmpty)))
//           TextButton.icon(
//             onPressed: () => removeImage(ImageType.profile),
//             icon: const Icon(Icons.delete),
//             label: const Text("Remove Photo"),
//           ),
//         const SizedBox(height: 12),
//         _isSaving
//             ? const CircularProgressIndicator()
//             : GestureDetector(
//                 onTap: () async {
//                   if (isEditing) {
//                     await _updateProfileApi();
//                   } else {
//                     setState(() => isEditing = true);
//                   }
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 12,
//                   ),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF4A845E),
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         isEditing ? Icons.save_alt : Icons.edit,
//                         color: Colors.white,
//                         size: 22,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         isEditing ? "Save Profile" : "Edit Profile",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }

//   Widget _card({
//     required String title,
//     required IconData icon,
//     required Widget child,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: Colors.green),
//               const SizedBox(width: 6),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           child,
//         ],
//       ),
//     );
//   }

//   Widget _label(String text) => Text(
//     text,
//     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//   );

//   Widget _infoBox(String text) => Container(
//     padding: const EdgeInsets.all(13),
//     width: double.infinity,
//     decoration: BoxDecoration(
//       color: const Color(0xFFF1F1F1),
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Text(text.isNotEmpty ? text : "Not provided"),
//   );

//   Widget _field(
//     String label,
//     TextEditingController controller, {
//     bool editable = true,
//   }) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       _label(label),
//       const SizedBox(height: 6),
//       isEditing && editable
//           ? TextField(
//               controller: controller,
//               decoration: const InputDecoration(border: OutlineInputBorder()),
//             )
//           : _infoBox(controller.text),
//       const SizedBox(height: 12),
//     ],
//   );

//   Widget _nonEditableField(String label, String value) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       _label(label),
//       const SizedBox(height: 6),
//       _infoBox(value),
//       const SizedBox(height: 12),
//     ],
//   );

//   Widget _imagePickerBox(
//     String title,
//     File? localImg,
//     ImageType type,
//     String? networkUrl,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _label(title),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: isEditing ? () => pickImage(type) : null,
//           child: Container(
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(10),
//               image: localImg != null
//                   ? DecorationImage(
//                       image: FileImage(localImg),
//                       fit: BoxFit.cover,
//                     )
//                   : (networkUrl != null && networkUrl.isNotEmpty
//                         ? DecorationImage(
//                             image: NetworkImage(networkUrl),
//                             fit: BoxFit.cover,
//                           )
//                         : null),
//             ),
//             child:
//                 localImg == null && (networkUrl == null || networkUrl.isEmpty)
//                 ? const Center(
//                     child: Icon(Icons.image, size: 40, color: Colors.grey),
//                   )
//                 : null,
//           ),
//         ),
//         const SizedBox(height: 6),
//         if (isEditing)
//           Row(
//             children: [
//               TextButton.icon(
//                 onPressed: () => pickImage(type),
//                 icon: const Icon(Icons.upload_file),
//                 label: const Text("Upload"),
//               ),
//               if (localImg != null ||
//                   (networkUrl != null && networkUrl.isNotEmpty))
//                 TextButton.icon(
//                   onPressed: () => removeImage(type),
//                   icon: const Icon(Icons.delete),
//                   label: const Text("Remove"),
//                 ),
//             ],
//           ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   Widget _buildPersonalInfoCard() {
//     return _card(
//       title: "Personal Information",
//       icon: Icons.person_outline,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _imagePickerBox(
//             "ID Card Photo",
//             idCardImage,
//             ImageType.idCard,
//             idCardImageUrl,
//           ),
//           _field("Full Name", nameController),
//           _nonEditableField(
//             "Role",
//             roleController.text.isNotEmpty
//                 ? roleController.text
//                 : "regional verification",
//           ),
//           _field("Email", emailController),
//           _field("Phone Number", phoneController),
//           _field("Blood Group", bloodgroupController),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddressCard() {
//     return _card(
//       title: "Address Details",
//       icon: Icons.location_on_outlined,
//       child: Column(
//         children: [
//           _field("State", stateController),
//           _field("District", districtController),
//           _field("Mandal", mandalController),
//           _field("Village", villageController),
//           _field("Pincode", pincodeController),
//         ],
//       ),
//     );
//   }

//   Widget _buildAadhaarCard() {
//     return _card(
//       title: "Aadhaar Card",
//       icon: Icons.credit_card,
//       child: Column(
//         children: [
//           _field("Aadhaar Number", aadhaarController),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: _imagePickerBox(
//                   "Front",
//                   aadharFront,
//                   ImageType.aadharFront,
//                   aadharFrontUrl,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _imagePickerBox(
//                   "Back",
//                   aadharBack,
//                   ImageType.aadharBack,
//                   aadharBackUrl,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSalaryPackageSection() {
//     return _card(
//       title: "Salary Package",
//       icon: Icons.card_giftcard,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "New Land Entry Package",
//             style: TextStyle(fontSize: 16, color: Colors.black87),
//           ),
//           const SizedBox(height: 16),
//           RadioListTile<String>(
//             title: const Text("₱250 Package"),
//             value: "250",
//             groupValue: selectedPackage,
//             onChanged: isEditing
//                 ? (v) => setState(() => selectedPackage = v!)
//                 : null,
//           ),
//           RadioListTile<String>(
//             title: const Text("₱350 Package"),
//             value: "350",
//             groupValue: selectedPackage,
//             onChanged: isEditing
//                 ? (v) => setState(() => selectedPackage = v!)
//                 : null,
//           ),
//           RadioListTile<String>(
//             title: const Text("₱450 Package"),
//             value: "450",
//             groupValue: selectedPackage,
//             onChanged: isEditing
//                 ? (v) => setState(() => selectedPackage = v!)
//                 : null,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBankAccountCard() {
//     return _card(
//       title: "Bank Account",
//       icon: Icons.account_balance,
//       child: Column(
//         children: [
//           _field("Bank Name", bankNameController),
//           _field("Account Number", accountNumberController),
//           _field("IFSC Code", ifscController),
//           const SizedBox(height: 12),
//           _field("GPay Id ", gpayPhoneController),
//           _field(" Phone Number", bankPhoneController),
//           _field("UPI ID", upiIdController),
//         ],
//       ),
//     );
//   }

//   Widget _buildWorkingLocationCard() {
//     return _card(
//       title: "Working Location",
//       icon: Icons.location_city,
//       child: Column(
//         children: [
//           _field("State", workstateController),
//           _field("District", workdistrictController),
//           _field("Mandal", workmandalController),
//           _field("Village", workvillageController),
//         ],
//       ),
//     );
//   }

//   Widget _buildVehicleInfoCard() {
//     return _card(
//       title: "Vehicle Information",
//       icon: Icons.directions_car,
//       child: Column(
//         children: [
//           _field("Vehicle Type", vehicleTypeController),
//           _field("Vehicle Number", vehicleNumberController),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogoutButton() {
//     return GestureDetector(
//       onTap: _logoutUser,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         decoration: BoxDecoration(
//           color: Colors.red.shade600,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: const Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.logout, color: Colors.white, size: 20),
//               SizedBox(width: 10),
//               Text(
//                 "Logout",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         backgroundColor: const Color(0xFFF5F6FA),
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text("Profile", style: TextStyle(color: Colors.black)),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const Homepage()),
//             ),
//           ),
//         ),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     return WillPopScope(
//       onWillPop: () async {
//         // Back press → homepage
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => Regionalhomepage()),
//         );
//         return false; // prevent default back
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F6FA),
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text("Profile", style: TextStyle(color: Colors.black)),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               if (isEditing) {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text("Discard Changes"),
//                     content: const Text("Do you want to discard your changes?"),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text("No"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() => isEditing = false);
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Yes"),
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const Regionalhomepage()),
//                 );
//               }
//             },
//           ),
//         ),
//         body: RefreshIndicator(
//           onRefresh: _fetchProfileFromAPI,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 _buildProfilePhoto(),
//                 const SizedBox(height: 20),
//                 _buildPersonalInfoCard(),
//                 const SizedBox(height: 16),
//                 _buildAddressCard(),
//                 const SizedBox(height: 16),
//                 _buildAadhaarCard(),
//                 const SizedBox(height: 16),
//                 _buildSalaryPackageSection(),
//                 const SizedBox(height: 16),
//                 _buildBankAccountCard(),
//                 const SizedBox(height: 16),
//                 _buildWorkingLocationCard(),
//                 const SizedBox(height: 16),
//                 _buildVehicleInfoCard(),
//                 const SizedBox(height: 16),
//                 _buildLogoutButton(),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gadura_land/Auth/login.dart';
import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // For MediaType
import 'package:mime/mime.dart'; // For lookupMimeType

enum ImageType { profile, idCard, aadharFront, aadharBack }

class Regionalprofile extends StatefulWidget {
  const Regionalprofile({super.key});

  @override
  State<Regionalprofile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Regionalprofile> {
  bool isEditing = false;
  String selectedPackage = "250";
  String? _apiToken;
  bool _isLoading = true;
  bool _isSaving = false;

  // API URLs - Replace with your actual URLs
  static const String BASE_URL = "http://72.61.169.226";
  final String _getProfileUrl = "$BASE_URL/regional/personal/details";
  final String _updateProfileUrl = "$BASE_URL/regional/personal/details";

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodgroupController = TextEditingController();
  final aadhaarController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final mandalController = TextEditingController();
  final villageController = TextEditingController();
  final pincodeController = TextEditingController();
  final accountHolderController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscController = TextEditingController();
  final workstateController = TextEditingController();
  final workdistrictController = TextEditingController();
  final workmandalController = TextEditingController();
  final workvillageController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final vehicleNumberController = TextEditingController();

  // नए बैंक फील्ड के लिए Controllers
  final gpayPhoneController = TextEditingController();
  final bankPhoneController = TextEditingController();
  final upiIdController = TextEditingController();

  // Images
  File? profileImage;
  File? idCardImage;
  File? aadharFront;
  File? aadharBack;

  final picker = ImagePicker();

  // API URLs for loaded images
  String? profileImageUrl;
  String? idCardImageUrl;
  String? aadharFrontUrl;
  String? aadharBackUrl;

  @override
  void initState() {
    super.initState();
    _initProfile();
  }

  Future<void> _initProfile() async {
    await _loadToken();
    await _fetchProfileFromAPI();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
    print("Token loaded: ${_apiToken != null}");
  }

  // ---------- GET API CALL ----------
  Future<void> _fetchProfileFromAPI() async {
    if (_apiToken == null || _apiToken!.isEmpty) {
      print("No token available");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please login again")));
      setState(() => _isLoading = false);
      return;
    }

    try {
      setState(() => _isLoading = true);
      print("Fetching profile data from: $_getProfileUrl");

      final response = await http.get(
        Uri.parse(_getProfileUrl),
        headers: {
          'Authorization': 'Bearer $_apiToken',
          'Content-Type': 'application/json',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print("Data received successfully");

        // Populate controllers with API data
        _populateControllers(data);

        // Save to shared preferences
        await _saveToSharedPreferences(data);

        print("Profile loaded successfully");
      } else if (response.statusCode == 401) {
        print("Unauthorized - Token expired");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Session expired. Please login again")),
        );
        _logoutUser();
      } else {
        print("API Error: ${response.statusCode}");
        await _loadFromSharedPrefs();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to load profile: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      await _loadFromSharedPrefs();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error loading profile: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _populateControllers(Map<String, dynamic> data) {
    setState(() {
      print("Populating data: ${data.keys}");

      // Set role to "Regional Verification"
      roleController.text = "Regional Verification";

      // Check the API response structure - based on your API documentation
      // The API might return data directly or nested

      // Try to extract user data
      dynamic userData = data['user'] ?? data;

      nameController.text = userData['name']?.toString() ?? '';
      emailController.text = userData['email']?.toString() ?? '';
      phoneController.text = userData['phone']?.toString() ?? '';
      bloodgroupController.text = userData['blood_group']?.toString() ?? '';

      // Handle image URLs - check different possible field names
      profileImageUrl =
          userData['image']?.toString() ??
          userData['profile_image']?.toString();
      idCardImageUrl =
          userData['photo']?.toString() ??
          userData['id_card_image']?.toString();

      // Aadhar data
      aadhaarController.text = userData['aadhar_number']?.toString() ?? '';
      aadharFrontUrl = userData['aadhar_front_image']?.toString();
      aadharBackUrl = userData['aadhar_back_image']?.toString();

      // Address data
      stateController.text = userData['state']?.toString() ?? 'Telangana';
      districtController.text =
          userData['district']?.toString() ?? 'Rangareddy';
      mandalController.text = userData['mandal']?.toString() ?? 'Kothur';
      villageController.text = userData['village']?.toString() ?? 'Ramapuram';
      pincodeController.text = userData['pincode']?.toString() ?? '500081';

      // Package data
      selectedPackage = userData['package']?.toString() ?? '250';

      // Bank account data
      bankNameController.text =
          userData['bank_name']?.toString() ?? 'HDFC Bank';
      accountNumberController.text =
          userData['account_number']?.toString() ?? '1234567890';
      ifscController.text = userData['ifsc_code']?.toString() ?? 'HDFC0001234';

      // नए बैंक फील्ड्स
      gpayPhoneController.text =
          userData['gpay_number']?.toString() ??
          userData['gpay_id']?.toString() ??
          '';
      bankPhoneController.text = userData['phonepe_number']?.toString() ?? '';
      upiIdController.text = userData['upi_id']?.toString() ?? '';

      // Work location
      workstateController.text =
          userData['work_state']?.toString() ?? 'Telangana';
      workdistrictController.text =
          userData['work_district']?.toString() ?? 'Rangareddy';
      workmandalController.text =
          userData['work_mandal']?.toString() ?? 'Kothur';
      workvillageController.text =
          userData['work_village']?.toString() ?? 'Ramapuram';

      // Vehicle information
      vehicleTypeController.text =
          userData['vehicle_type']?.toString() ?? 'Bike';
      vehicleNumberController.text =
          userData['license_plate']?.toString() ?? 'TS09AB1234';

      print("Data populated successfully");
    });
  }

  Future<void> _saveToSharedPreferences(Map<String, dynamic> data) async {
    try {
      final sp = await SharedPreferences.getInstance();

      // Try to extract user data
      dynamic userData = data['user'] ?? data;

      await sp.setString('name', userData['name']?.toString() ?? '');
      await sp.setString('email', userData['email']?.toString() ?? '');
      await sp.setString('phone', userData['phone']?.toString() ?? '');
      await sp.setString('blood', userData['blood_group']?.toString() ?? '');

      // Save role
      await sp.setString('role', "Regional Verification");

      await sp.setString('state', userData['state']?.toString() ?? 'Telangana');
      await sp.setString(
        'district',
        userData['district']?.toString() ?? 'Rangareddy',
      );
      await sp.setString('mandal', userData['mandal']?.toString() ?? 'Kothur');
      await sp.setString(
        'village',
        userData['village']?.toString() ?? 'Ramapuram',
      );
      await sp.setString(
        'pincode',
        userData['pincode']?.toString() ?? '500081',
      );

      await sp.setString(
        'aadhaar',
        userData['aadhar_number']?.toString() ?? '',
      );

      await sp.setString('package', userData['package']?.toString() ?? '250');

      await sp.setString(
        'bankName',
        userData['bank_name']?.toString() ?? 'HDFC Bank',
      );
      await sp.setString(
        'accountNumber',
        userData['account_number']?.toString() ?? '1234567890',
      );
      await sp.setString(
        'ifsc',
        userData['ifsc_code']?.toString() ?? 'HDFC0001234',
      );

      // नए बैंक फील्ड्स को SharedPreferences में सेव करें
      await sp.setString(
        'gpay_number',
        userData['gpay_number']?.toString() ??
            userData['gpay_id']?.toString() ??
            '',
      );
      await sp.setString(
        'phonepe_number',
        userData['phonepe_number']?.toString() ?? '',
      );
      await sp.setString('upi_id', userData['upi_id']?.toString() ?? '');

      await sp.setString(
        'work_state',
        userData['work_state']?.toString() ?? 'Telangana',
      );
      await sp.setString(
        'work_district',
        userData['work_district']?.toString() ?? 'Rangareddy',
      );
      await sp.setString(
        'work_mandal',
        userData['work_mandal']?.toString() ?? 'Kothur',
      );
      await sp.setString(
        'work_village',
        userData['work_village']?.toString() ?? 'Ramapuram',
      );

      await sp.setString(
        'vehicle_type',
        userData['vehicle_type']?.toString() ?? 'Bike',
      );
      await sp.setString(
        'license_plate',
        userData['license_plate']?.toString() ?? 'TS09AB1234',
      );

      // Store image URLs
      if (userData['image'] != null) {
        await sp.setString('profileImageUrl', userData['image'].toString());
      }
      if (userData['photo'] != null) {
        await sp.setString('idCardImageUrl', userData['photo'].toString());
      }
      if (userData['aadhar_front_image'] != null) {
        await sp.setString(
          'aadharFrontUrl',
          userData['aadhar_front_image'].toString(),
        );
      }
      if (userData['aadhar_back_image'] != null) {
        await sp.setString(
          'aadharBackUrl',
          userData['aadhar_back_image'].toString(),
        );
      }

      print("Data saved to SharedPreferences");
    } catch (e) {
      print("Error saving to SharedPreferences: $e");
    }
  }

  Future<void> _loadFromSharedPrefs() async {
    final sp = await SharedPreferences.getInstance();

    setState(() {
      nameController.text = sp.getString('name') ?? '';
      emailController.text = sp.getString('email') ?? '';
      roleController.text = sp.getString('role') ?? 'Regional Verification';
      phoneController.text = sp.getString('phone') ?? '';
      bloodgroupController.text = sp.getString('blood') ?? '';
      aadhaarController.text = sp.getString('aadhaar') ?? '';
      stateController.text = sp.getString('state') ?? 'Telangana';
      districtController.text = sp.getString('district') ?? 'Rangareddy';
      mandalController.text = sp.getString('mandal') ?? 'Kothur';
      villageController.text = sp.getString('village') ?? 'Ramapuram';
      pincodeController.text = sp.getString('pincode') ?? '500081';
      bankNameController.text = sp.getString('bankName') ?? 'HDFC Bank';
      accountNumberController.text =
          sp.getString('accountNumber') ?? '1234567890';
      ifscController.text = sp.getString('ifsc') ?? 'HDFC0001234';

      // नए बैंक फील्ड्स को लोड करें
      gpayPhoneController.text = sp.getString('gpay_number') ?? '';
      bankPhoneController.text = sp.getString('phonepe_number') ?? '';
      upiIdController.text = sp.getString('upi_id') ?? '';

      workstateController.text = sp.getString('work_state') ?? 'Telangana';
      workdistrictController.text =
          sp.getString('work_district') ?? 'Rangareddy';
      workmandalController.text = sp.getString('work_mandal') ?? 'Kothur';
      workvillageController.text = sp.getString('work_village') ?? 'Ramapuram';
      vehicleTypeController.text = sp.getString('vehicle_type') ?? 'Bike';
      vehicleNumberController.text =
          sp.getString('license_plate') ?? 'TS09AB1234';
      selectedPackage = sp.getString('package') ?? '250';

      // Load image URLs
      profileImageUrl = sp.getString('profileImageUrl');
      idCardImageUrl = sp.getString('idCardImageUrl');
      aadharFrontUrl = sp.getString('aadharFrontUrl');
      aadharBackUrl = sp.getString('aadharBackUrl');

      // Load local images
      profileImage = _getImageFile(sp.getString('profileImage'));
      idCardImage = _getImageFile(sp.getString('idCardImage'));
      aadharFront = _getImageFile(sp.getString('aadharFront'));
      aadharBack = _getImageFile(sp.getString('aadharBack'));
    });
  }

  File? _getImageFile(String? path) {
    if (path != null && path.isNotEmpty && File(path).existsSync()) {
      return File(path);
    }
    return null;
  }

  // ---------- PUT API CALL ----------
  Future<void> _updateProfileApi() async {
    if (_apiToken == null || _apiToken!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please login again")));
      return;
    }

    try {
      setState(() => _isSaving = true);

      final uri = Uri.parse(_updateProfileUrl);
      var request = http.MultipartRequest("PUT", uri);

      // 1. Headers
      request.headers.addAll({
        'Authorization': 'Bearer $_apiToken',
        'Accept': 'application/json',
      });

      // 2. Text Fields (Matches your API request)
      request.fields.addAll({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'blood_group': bloodgroupController.text,
        'aadhar_number': aadhaarController.text,
        'state': stateController.text,
        'district': districtController.text,
        'mandal': mandalController.text,
        'village': villageController.text,
        'pincode': pincodeController.text,
        'package': selectedPackage,
        'bank_name': bankNameController.text,
        'account_number': accountNumberController.text,
        'ifsc_code': ifscController.text,
        'gpay_number': gpayPhoneController.text,
        'phonepe_number': bankPhoneController.text,
        'upi_id': upiIdController.text,
        'work_state': workstateController.text,
        'work_district': workdistrictController.text,
        'work_mandal': workmandalController.text,
        'work_village': workvillageController.text,
        'vehicle_type': vehicleTypeController.text,
        'license_plate': vehicleNumberController.text,
      });

      // 3. File Upload Helper Function
      Future<void> addFile(String key, File? file) async {
        if (file == null) return;
        if (!await file.exists()) {
          print("File does not exist: ${file.path}");
          return;
        }

        // Detect file type
        final mimeType = lookupMimeType(file.path);
        MediaType? contentType;

        if (mimeType != null) {
          final split = mimeType.split('/');
          contentType = MediaType(split[0], split[1]);
        } else {
          contentType = MediaType('image', 'jpeg'); // Default
        }

        print("Uploading $key: ${file.path} as $mimeType");

        request.files.add(
          await http.MultipartFile.fromPath(
            key,
            file.path,
            contentType: contentType,
          ),
        );
      }

      // 4. Add all files
      await addFile('image', profileImage);
      await addFile('photo', idCardImage);
      await addFile('aadhar_front_image', aadharFront);
      await addFile('aadhar_back_image', aadharBack);

      // 5. Send request
      print("Sending PUT request to: $_updateProfileUrl");
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Status: ${response.statusCode}");
      print("Body: $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(responseBody);
        if (responseData['status'] == 'success' || response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully!")),
          );
          await _fetchProfileFromAPI(); // Refresh data
          setState(() => isEditing = false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed: ${responseData['message']}")),
          );
        }
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Session expired. Please login again")),
        );
        _logoutUser();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isSaving = false);
    }
  }

  // ---------- IMAGE PICKER ----------
  Future<void> pickImage(ImageType type) async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    if (file == null) return;
    final img = File(file.path);
    final sp = await SharedPreferences.getInstance();

    setState(() {
      switch (type) {
        case ImageType.profile:
          profileImage = img;
          sp.setString('profileImage', img.path);
          break;
        case ImageType.idCard:
          idCardImage = img;
          sp.setString('idCardImage', img.path);
          break;
        case ImageType.aadharFront:
          aadharFront = img;
          sp.setString('aadharFront', img.path);
          break;
        case ImageType.aadharBack:
          aadharBack = img;
          sp.setString('aadharBack', img.path);
          break;
      }
    });
  }

  Future<void> removeImage(ImageType type) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      switch (type) {
        case ImageType.profile:
          profileImage = null;
          sp.remove('profileImage');
          break;
        case ImageType.idCard:
          idCardImage = null;
          sp.remove('idCardImage');
          break;
        case ImageType.aadharFront:
          aadharFront = null;
          sp.remove('aadharFront');
          break;
        case ImageType.aadharBack:
          aadharBack = null;
          sp.remove('aadharBack');
          break;
      }
    });
  }

  // ---------- LOGOUT ----------
  Future<void> _logoutUser() async {
    bool shouldLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
        (route) => false,
      );
    }
  }

  // ---------- WIDGET BUILDERS ----------
  Widget _buildProfilePhoto() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: profileImage != null
                  ? FileImage(profileImage!)
                  : (profileImageUrl != null && profileImageUrl!.isNotEmpty
                            ? NetworkImage(profileImageUrl!)
                            : null)
                        as ImageProvider?,
              child:
                  profileImage == null &&
                      (profileImageUrl == null || profileImageUrl!.isEmpty)
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
            if (isEditing)
              GestureDetector(
                onTap: () => pickImage(ImageType.profile),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 20),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (isEditing &&
            (profileImage != null ||
                (profileImageUrl != null && profileImageUrl!.isNotEmpty)))
          TextButton.icon(
            onPressed: () => removeImage(ImageType.profile),
            icon: const Icon(Icons.delete),
            label: const Text("Remove Photo"),
          ),
        const SizedBox(height: 12),
        _isSaving
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap: () async {
                  if (isEditing) {
                    await _updateProfileApi();
                  } else {
                    setState(() => isEditing = true);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A845E),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isEditing ? Icons.save_alt : Icons.edit,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isEditing ? "Save Profile" : "Edit Profile",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Widget _card({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  Widget _infoBox(String text) => Container(
    padding: const EdgeInsets.all(13),
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFF1F1F1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text.isNotEmpty ? text : "Not provided"),
  );

  Widget _field(
    String label,
    TextEditingController controller, {
    bool editable = true,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label(label),
      const SizedBox(height: 6),
      isEditing && editable
          ? TextField(
              controller: controller,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            )
          : _infoBox(controller.text),
      const SizedBox(height: 12),
    ],
  );

  Widget _nonEditableField(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label(label),
      const SizedBox(height: 6),
      _infoBox(value),
      const SizedBox(height: 12),
    ],
  );

  Widget _imagePickerBox(
    String title,
    File? localImg,
    ImageType type,
    String? networkUrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(title),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isEditing ? () => pickImage(type) : null,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
              image: localImg != null
                  ? DecorationImage(
                      image: FileImage(localImg),
                      fit: BoxFit.cover,
                    )
                  : (networkUrl != null && networkUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(networkUrl),
                            fit: BoxFit.cover,
                          )
                        : null),
            ),
            child:
                localImg == null && (networkUrl == null || networkUrl.isEmpty)
                ? const Center(
                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 6),
        if (isEditing)
          Row(
            children: [
              TextButton.icon(
                onPressed: () => pickImage(type),
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload"),
              ),
              if (localImg != null ||
                  (networkUrl != null && networkUrl.isNotEmpty))
                TextButton.icon(
                  onPressed: () => removeImage(type),
                  icon: const Icon(Icons.delete),
                  label: const Text("Remove"),
                ),
            ],
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPersonalInfoCard() {
    return _card(
      title: "Personal Information",
      icon: Icons.person_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imagePickerBox(
            "ID Card Photo",
            idCardImage,
            ImageType.idCard,
            idCardImageUrl,
          ),
          _field("Full Name", nameController),
          _nonEditableField(
            "Role",
            "Regional Verification", // Changed role
          ),
          _field("Email", emailController),
          _field("Phone Number", phoneController),
          _field("Blood Group", bloodgroupController),
        ],
      ),
    );
  }

  Widget _buildAddressCard() {
    return _card(
      title: "Address Details",
      icon: Icons.location_on_outlined,
      child: Column(
        children: [
          _field("State", stateController),
          _field("District", districtController),
          _field("Mandal", mandalController),
          _field("Village", villageController),
          _field("Pincode", pincodeController),
        ],
      ),
    );
  }

  Widget _buildAadhaarCard() {
    return _card(
      title: "Aadhaar Card",
      icon: Icons.credit_card,
      child: Column(
        children: [
          _field("Aadhaar Number", aadhaarController),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _imagePickerBox(
                  "Front",
                  aadharFront,
                  ImageType.aadharFront,
                  aadharFrontUrl,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _imagePickerBox(
                  "Back",
                  aadharBack,
                  ImageType.aadharBack,
                  aadharBackUrl,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryPackageSection() {
    return _card(
      title: "Salary Package",
      icon: Icons.card_giftcard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "New Land Entry Package",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          RadioListTile<String>(
            title: const Text("₱250 Package"),
            value: "250",
            groupValue: selectedPackage,
            onChanged: isEditing
                ? (v) => setState(() => selectedPackage = v!)
                : null,
          ),
          RadioListTile<String>(
            title: const Text("₱350 Package"),
            value: "350",
            groupValue: selectedPackage,
            onChanged: isEditing
                ? (v) => setState(() => selectedPackage = v!)
                : null,
          ),
          RadioListTile<String>(
            title: const Text("₱450 Package"),
            value: "450",
            groupValue: selectedPackage,
            onChanged: isEditing
                ? (v) => setState(() => selectedPackage = v!)
                : null,
          ),
          RadioListTile<String>(
            title: const Text("₱560 Package"),
            value: "560",
            groupValue: selectedPackage,
            onChanged: isEditing
                ? (v) => setState(() => selectedPackage = v!)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildBankAccountCard() {
    return _card(
      title: "Bank Account",
      icon: Icons.account_balance,
      child: Column(
        children: [
          _field("Bank Name", bankNameController),
          _field("Account Number", accountNumberController),
          _field("IFSC Code", ifscController),
          const SizedBox(height: 12),
          _field("GPay Number", gpayPhoneController),
          _field("PhonePe Number", bankPhoneController),
          _field("UPI ID", upiIdController),
        ],
      ),
    );
  }

  Widget _buildWorkingLocationCard() {
    return _card(
      title: "Working Location",
      icon: Icons.location_city,
      child: Column(
        children: [
          _field("State", workstateController),
          _field("District", workdistrictController),
          _field("Mandal", workmandalController),
          _field("Village", workvillageController),
        ],
      ),
    );
  }

  Widget _buildVehicleInfoCard() {
    return _card(
      title: "Vehicle Information",
      icon: Icons.directions_car,
      child: Column(
        children: [
          _field("Vehicle Type", vehicleTypeController),
          _field("Vehicle Number", vehicleNumberController),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: _logoutUser,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.red.shade600,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Profile", style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Regionalhomepage()),
            ),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        // Back press → homepage
        if (isEditing) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Discard Changes"),
              content: const Text("Do you want to discard your changes?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("No"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() => isEditing = false);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Regionalhomepage(),
                      ),
                    );
                  },
                  child: const Text("Yes"),
                ),
              ],
            ),
          );
          return false;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Regionalhomepage()),
          );
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Profile", style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (isEditing) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Discard Changes"),
                    content: const Text("Do you want to discard your changes?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => isEditing = false);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Regionalhomepage(),
                            ),
                          );
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Regionalhomepage()),
                );
              }
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _fetchProfileFromAPI,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildProfilePhoto(),
                const SizedBox(height: 20),
                _buildPersonalInfoCard(),
                const SizedBox(height: 16),
                _buildAddressCard(),
                const SizedBox(height: 16),
                _buildAadhaarCard(),
                const SizedBox(height: 16),
                _buildSalaryPackageSection(),
                const SizedBox(height: 16),
                _buildBankAccountCard(),
                const SizedBox(height: 16),
                _buildWorkingLocationCard(),
                const SizedBox(height: 16),
                _buildVehicleInfoCard(),
                const SizedBox(height: 16),
                _buildLogoutButton(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
