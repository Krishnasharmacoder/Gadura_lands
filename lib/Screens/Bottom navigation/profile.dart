// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:gadura_land/Screens/homepage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum ImageType { profile, idCard, aadharFront, aadharBack }

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   bool isEditing = false;
//   String selectedPackage = "250"; // default salary package

//   // ---------- Controllers ----------
//   final nameController = TextEditingController(text: "Suresh Kumar");
//   final emailController = TextEditingController(text: "suresh@rolesync.app");
//   final roleController = TextEditingController(text: "Field Executive");
//   final phoneController = TextEditingController(text: "981105445");
//   final bloodgroupController = TextEditingController(text: "O+");
//   final aadhaarController = TextEditingController(text: "");

//   final stateController = TextEditingController(text: "Telangana");
//   final districtController = TextEditingController(text: "Rangareddy");
//   final mandalController = TextEditingController(text: "Kothur");
//   final villageController = TextEditingController(text: "Ramapuram");
//   final pincodeController = TextEditingController(text: "500081");

//   // Salary
//   final baseSalaryController = TextEditingController(text: "15000");
//   final incentivesController = TextEditingController(text: "3000");
//   final travelAllowanceController = TextEditingController(text: "1500");

//   // Bank
//   final accountHolderController = TextEditingController(text: "Suresh Kumar");
//   final bankNameController = TextEditingController(text: "HDFC Bank");
//   final accountNumberController = TextEditingController(text: "1234567890");
//   final ifscController = TextEditingController(text: "HDFC0001234");

//   // Working location
//   final workstateController = TextEditingController(text: "Telangana");
//   final workdistrictController = TextEditingController(text: "Rangareddy");
//   final workmandalController = TextEditingController(text: "Kothur");
//   final workvillageController = TextEditingController(text: "Ramapuram");

//   // Vehicle
//   final vehicleTypeController = TextEditingController(text: "Bike");
//   final vehicleNumberController = TextEditingController(text: "TS09AB1234");
//   //final dlNumberController = TextEditingController(text: "DL-2024-9988");

//   // ---------- Images ----------
//   File? profileImage;
//   File? idCardImage;
//   File? aadharFront;
//   File? aadharBack;

//   final picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }

//   Future<void> _loadProfile() async {
//     final sp = await SharedPreferences.getInstance();

//     // Text fields
//     nameController.text = sp.getString('name') ?? nameController.text;
//     emailController.text = sp.getString('email') ?? emailController.text;
//     phoneController.text = sp.getString('phone') ?? phoneController.text;
//     bloodgroupController.text =
//         sp.getString('blood') ?? bloodgroupController.text;
//     aadhaarController.text = sp.getString('aadhaar') ?? aadhaarController.text;

//     stateController.text = sp.getString('state') ?? stateController.text;
//     districtController.text =
//         sp.getString('district') ?? districtController.text;
//     mandalController.text = sp.getString('mandal') ?? mandalController.text;
//     villageController.text = sp.getString('village') ?? villageController.text;
//     pincodeController.text = sp.getString('pincode') ?? pincodeController.text;

//     baseSalaryController.text =
//         sp.getString('baseSalary') ?? baseSalaryController.text;
//     incentivesController.text =
//         sp.getString('incentives') ?? incentivesController.text;
//     travelAllowanceController.text =
//         sp.getString('travelAllowance') ?? travelAllowanceController.text;

//     accountHolderController.text =
//         sp.getString('accountHolder') ?? accountHolderController.text;
//     bankNameController.text =
//         sp.getString('bankName') ?? bankNameController.text;
//     accountNumberController.text =
//         sp.getString('accountNumber') ?? accountNumberController.text;
//     ifscController.text = sp.getString('ifsc') ?? ifscController.text;
//     workstateController.text =
//         sp.getString('state') ?? workstateController.text;
//     workdistrictController.text =
//         sp.getString('district') ?? workdistrictController.text;
//     workmandalController.text =
//         sp.getString('mandal') ?? workmandalController.text;
//     workvillageController.text =
//         sp.getString('village') ?? workvillageController.text;

//     vehicleNumberController.text =
//         sp.getString('vehicleNumber') ?? vehicleNumberController.text;

//     vehicleTypeController.text =
//         sp.getString("vehicletype") ?? vehicleTypeController.text;

//     // Images (load only if file exists; if not, remove the saved key)
//     final profilePath = sp.getString('profileImage');
//     if (profilePath != null && File(profilePath).existsSync()) {
//       profileImage = File(profilePath);
//     } else {
//       sp.remove('profileImage');
//       profileImage = null;
//     }

//     final idCardPath = sp.getString('idCardImage');
//     if (idCardPath != null && File(idCardPath).existsSync()) {
//       idCardImage = File(idCardPath);
//     } else {
//       sp.remove('idCardImage');
//       idCardImage = null;
//     }

//     final aadharFrontPath = sp.getString('aadharFront');
//     if (aadharFrontPath != null && File(aadharFrontPath).existsSync()) {
//       aadharFront = File(aadharFrontPath);
//     } else {
//       sp.remove('aadharFront');
//       aadharFront = null;
//     }

//     final aadharBackPath = sp.getString('aadharBack');
//     if (aadharBackPath != null && File(aadharBackPath).existsSync()) {
//       aadharBack = File(aadharBackPath);
//     } else {
//       sp.remove('aadharBack');
//       aadharBack = null;
//     }

//     setState(() {});
//   }

//   // Save all profile fields (images are saved immediately when picked; but keeping this for full save)
//   Future<void> saveProfile() async {
//     final sp = await SharedPreferences.getInstance();

//     await sp.setString('name', nameController.text);
//     await sp.setString('email', emailController.text);
//     await sp.setString('phone', phoneController.text);
//     await sp.setString('blood', bloodgroupController.text);
//     await sp.setString('aadhaar', aadhaarController.text);

//     await sp.setString('state', stateController.text);
//     await sp.setString('district', districtController.text);
//     await sp.setString('mandal', mandalController.text);
//     await sp.setString('village', villageController.text);
//     await sp.setString('pincode', pincodeController.text);

//     await sp.setString('baseSalary', baseSalaryController.text);
//     await sp.setString('incentives', incentivesController.text);
//     await sp.setString('travelAllowance', travelAllowanceController.text);

//     await sp.setString('accountHolder', accountHolderController.text);
//     await sp.setString('bankName', bankNameController.text);
//     await sp.setString('accountNumber', accountNumberController.text);
//     await sp.setString('ifsc', ifscController.text);

//     await sp.setString('vehicletype', vehicleTypeController.text);
//     await sp.setString('vehicleNumber', vehicleNumberController.text);

//     await sp.setString("state", workstateController.text);
//     await sp.setString("district", workdistrictController.text);
//     await sp.setString("mandal", workmandalController.text);
//     await sp.setString("village", workvillageController.text);

//     // Images paths are handled in pickImage/removeImage immediately.
//   }

//   // ---------- Image pick - now saves path to SharedPreferences immediately ----------
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

//   // ---------- Image remove - now removes key from SharedPreferences immediately ----------
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

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         bool exitPopup = await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Exit profile"),
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

//         return exitPopup;
//       },
//       child: Scaffold(
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
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               _buildProfilePhoto(),
//               const SizedBox(height: 20),
//               _buildPersonalInfoCard(),
//               const SizedBox(height: 16),
//               _buildAddressCard(),
//               const SizedBox(height: 16),
//               _buildAadhaarCard(),
//               const SizedBox(height: 16),
//               buildSalaryPackageSection(),

//               const SizedBox(height: 16),
//               _buildBankAccountCard(),
//               const SizedBox(height: 16),
//               _buildWorkingLocationCard(),
//               const SizedBox(height: 16),
//               _buildVehicleInfoCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ---------------- UI Widgets ----------------

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
//                   : null,
//               child: profileImage == null
//                   ? const Icon(Icons.person, size: 60, color: Colors.white)
//                   : null,
//             ),
//             GestureDetector(
//               onTap: () {
//                 // allow picking profile even if not in edit mode
//                 pickImage(ImageType.profile);
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.green,
//                 ),
//                 child: const Icon(Icons.edit, color: Colors.white, size: 20),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),

//         // Remove button for circular profile (visible when editing or if you want to always allow)
//         if (isEditing && profileImage != null)
//           TextButton.icon(
//             onPressed: () => removeImage(ImageType.profile),
//             icon: const Icon(Icons.delete),
//             label: const Text("Remove Photo"),
//           ),

//         const SizedBox(height: 12),

//         GestureDetector(
//           onTap: () async {
//             if (isEditing) {
//               await saveProfile();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Profile saved successfully!")),
//               );
//             }
//             setState(() {
//               isEditing = !isEditing;
//             });
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFF4A845E),
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   isEditing ? Icons.save_alt : Icons.edit,
//                   color: Colors.white,
//                   size: 22,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   isEditing ? "Save Profile" : "Edit Profile",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ---------------- Reusable Widgets ----------------

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

//   Widget _infoBox(String text) {
//     return Container(
//       padding: const EdgeInsets.all(13),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: const Color(0xFFF1F1F1),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Text(text),
//     );
//   }

//   Widget _field(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _label(label),
//         const SizedBox(height: 6),
//         isEditing
//             ? TextField(
//                 controller: controller,
//                 decoration: const InputDecoration(border: OutlineInputBorder()),
//               )
//             : _infoBox(controller.text),
//         const SizedBox(height: 12),
//       ],
//     );
//   }

//   Widget _nonEditableField(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _label(label),
//         const SizedBox(height: 6),
//         _infoBox(value),
//         const SizedBox(height: 12),
//       ],
//     );
//   }

//   Widget _imagePickerBox(String title, File? img, ImageType type) {
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
//               image: img != null
//                   ? DecorationImage(image: FileImage(img), fit: BoxFit.cover)
//                   : null,
//             ),
//             child: img == null
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
//               if (img != null)
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

//   // ---------------- Cards ----------------

//   Widget _buildPersonalInfoCard() {
//     return _card(
//       title: "Personal Information",
//       icon: Icons.person_outline,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _imagePickerBox("ID Card Photo", idCardImage, ImageType.idCard),
//           _field("Full Name", nameController),
//           _nonEditableField("Role", roleController.text),
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
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _imagePickerBox(
//                   "Back",
//                   aadharBack,
//                   ImageType.aadharBack,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------- SALARY PACKAGE SECTION ----------------------
//   Widget buildSalaryPackageSection() {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 12),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: const [
//               Icon(Icons.card_giftcard, color: Colors.green),
//               SizedBox(width: 8),
//               Text(
//                 "Salary Package",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),

//           const SizedBox(height: 18),

//           const Text(
//             "New Land Entry Package",
//             style: TextStyle(fontSize: 16, color: Colors.black87),
//           ),

//           const SizedBox(height: 16),

//           // Package 250
//           buildSalaryOption(
//             amount: "₱250 Package",
//             description: "50% paid daily, 50% after 30 working days.",
//             value: "250",
//           ),

//           const SizedBox(height: 12),

//           // Package 300
//           buildSalaryOption(
//             amount: "₱300 Package",
//             description: "25% paid daily, 75% after 30 working days.",
//             value: "300",
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildSalaryOption({
//     required String amount,
//     required String description,
//     required String value,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         if (isEditing) {
//           setState(() {
//             selectedPackage = value;
//           });
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           children: [
//             Radio<String>(
//               value: value,
//               groupValue: selectedPackage,
//               onChanged: isEditing
//                   ? (v) {
//                       setState(() {
//                         selectedPackage = v!;
//                       });
//                     }
//                   : null,
//               activeColor: Colors.green,
//             ),
//             const SizedBox(width: 6),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     amount,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     description,
//                     style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBankAccountCard() {
//     return _card(
//       title: "Bank Account Details",
//       icon: Icons.account_balance,
//       child: Column(
//         children: [
//           _field("Account Holder Name", accountHolderController),
//           _field("Bank Name", bankNameController),
//           _field("Account Number", accountNumberController),
//           _field("IFSC Code", ifscController),
//         ],
//       ),
//     );
//   }

//   Widget _buildWorkingLocationCard() {
//     return _card(
//       title: "Working Location",
//       icon: Icons.map_outlined,
//       child: Column(
//         children: [
//           _locationField("State", workstateController),
//           _locationField("District", workdistrictController),
//           _locationField("Mandal", workmandalController),
//           _locationField("Village", workvillageController),
//         ],
//       ),
//     );
//   }

//   Widget _locationField(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _label(label),
//         const SizedBox(height: 6),
//         isEditing
//             ? TextField(
//                 controller: controller,
//                 decoration: const InputDecoration(border: OutlineInputBorder()),
//               )
//             : _infoBox(controller.text),
//         const SizedBox(height: 12),
//       ],
//     );
//   }

//   Widget _buildVehicleInfoCard() {
//     return _card(
//       title: "Vehicle Information",
//       icon: Icons.directions_bike,
//       child: Column(
//         children: [
//           _field("Vehicle Type", vehicleTypeController),
//           _field("Vehicle Number", vehicleNumberController),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gadura_land/Screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

enum ImageType { profile, idCard, aadharFront, aadharBack }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  String selectedPackage = "250";
  String? _apiToken;

  final picker = ImagePicker();

  // ---------- Controllers ----------
  final nameController = TextEditingController(text: "Suresh Kumar");
  final emailController = TextEditingController(text: "suresh@rolesync.app");
  final roleController = TextEditingController(text: "Field Executive");
  final phoneController = TextEditingController(text: "981105445");
  final bloodgroupController = TextEditingController(text: "O+");
  final aadhaarController = TextEditingController(text: "");

  final stateController = TextEditingController(text: "Telangana");
  final districtController = TextEditingController(text: "Rangareddy");
  final mandalController = TextEditingController(text: "Kothur");
  final villageController = TextEditingController(text: "Ramapuram");
  final pincodeController = TextEditingController(text: "500081");

  final baseSalaryController = TextEditingController(text: "15000");
  final incentivesController = TextEditingController(text: "3000");
  final travelAllowanceController = TextEditingController(text: "1500");

  final accountHolderController = TextEditingController(text: "Suresh Kumar");
  final bankNameController = TextEditingController(text: "HDFC Bank");
  final accountNumberController = TextEditingController(text: "1234567890");
  final ifscController = TextEditingController(text: "HDFC0001234");

  final workstateController = TextEditingController(text: "Telangana");
  final workdistrictController = TextEditingController(text: "Rangareddy");
  final workmandalController = TextEditingController(text: "Kothur");
  final workvillageController = TextEditingController(text: "Ramapuram");

  final vehicleTypeController = TextEditingController(text: "Bike");
  final vehicleNumberController = TextEditingController(text: "TS09AB1234");

  // ---------- Images ----------
  File? profileImage;
  File? idCardImage;
  File? aadharFront;
  File? aadharBack;

  @override
  void initState() {
    super.initState();
    _initProfile();
  }

  Future<void> _initProfile() async {
    await loadToken();
    await _loadProfile();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
  }

  Future<void> _loadProfile() async {
    final sp = await SharedPreferences.getInstance();
    Map<String, TextEditingController> fields = {
      'name': nameController,
      'email': emailController,
      'phone': phoneController,
      'blood': bloodgroupController,
      'aadhaar': aadhaarController,
      'state': stateController,
      'district': districtController,
      'mandal': mandalController,
      'village': villageController,
      'pincode': pincodeController,
      'baseSalary': baseSalaryController,
      'incentives': incentivesController,
      'travelAllowance': travelAllowanceController,
      'accountHolder': accountHolderController,
      'bankName': bankNameController,
      'accountNumber': accountNumberController,
      'ifsc': ifscController,
      'work_state': workstateController,
      'work_district': workdistrictController,
      'work_mandal': workmandalController,
      'work_village': workvillageController,
      'vehicletype': vehicleTypeController,
      'vehicleNumber': vehicleNumberController,
    };

    for (var key in fields.keys) {
      fields[key]!.text = sp.getString(key) ?? fields[key]!.text;
    }

    profileImage = _getImageFile(sp.getString('profileImage'));
    idCardImage = _getImageFile(sp.getString('idCardImage'));
    aadharFront = _getImageFile(sp.getString('aadharFront'));
    aadharBack = _getImageFile(sp.getString('aadharBack'));

    setState(() {});
  }

  File? _getImageFile(String? path) {
    if (path != null && File(path).existsSync()) return File(path);
    return null;
  }

  Future<void> saveProfile() async {
    final sp = await SharedPreferences.getInstance();
    Map<String, String> fields = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'blood': bloodgroupController.text,
      'aadhaar': aadhaarController.text,
      'state': stateController.text,
      'district': districtController.text,
      'mandal': mandalController.text,
      'village': villageController.text,
      'pincode': pincodeController.text,
      'baseSalary': baseSalaryController.text,
      'incentives': incentivesController.text,
      'travelAllowance': travelAllowanceController.text,
      'accountHolder': accountHolderController.text,
      'bankName': bankNameController.text,
      'accountNumber': accountNumberController.text,
      'ifsc': ifscController.text,
      'vehicletype': vehicleTypeController.text,
      'vehicleNumber': vehicleNumberController.text,
      'work_state': workstateController.text,
      'work_district': workdistrictController.text,
      'work_mandal': workmandalController.text,
      'work_village': workvillageController.text,
    };

    for (var key in fields.keys) await sp.setString(key, fields[key]!);
  }

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

  Future<void> updateProfileApi() async {
    if (_apiToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token not found. Please login again.")),
      );
      return;
    }

    final uri = Uri.parse(
      "http://72.61.169.226/field-executive/personal/details",
    );
    var request = http.MultipartRequest("PUT", uri);
    request.headers['Authorization'] = 'Bearer $_apiToken';

    request.fields.addAll({
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'blood_group': bloodgroupController.text,
      'state': stateController.text,
      'district': districtController.text,
      'mandal': mandalController.text,
      'village': villageController.text,
      'pincode': pincodeController.text,
      'aadhar_number': aadhaarController.text,
      'package': selectedPackage,
      'bank_name': bankNameController.text,
      'account_number': accountNumberController.text,
      'ifsc_code': ifscController.text,
      'work_state': workstateController.text,
      'work_district': workdistrictController.text,
      'work_mandal': workmandalController.text,
      'work_village': workvillageController.text,
      'vehicle_type': vehicleTypeController.text,
      'license_plate': vehicleNumberController.text,
    });

    if (profileImage != null)
      request.files.add(
        await http.MultipartFile.fromPath('image', profileImage!.path),
      );
    if (idCardImage != null)
      request.files.add(
        await http.MultipartFile.fromPath('id_card_image', idCardImage!.path),
      );
    if (aadharFront != null)
      request.files.add(
        await http.MultipartFile.fromPath(
          'aadhar_front_image',
          aadharFront!.path,
        ),
      );
    if (aadharBack != null)
      request.files.add(
        await http.MultipartFile.fromPath(
          'aadhar_back_image',
          aadharBack!.path,
        ),
      );

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to update profile. Status: ${response.statusCode}",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitPopup = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit profile"),
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
        return exitPopup;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Profile", style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Homepage()),
            ),
          ),
        ),
        body: SingleChildScrollView(
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
              buildSalaryPackageSection(),
              const SizedBox(height: 16),
              _buildBankAccountCard(),
              const SizedBox(height: 16),
              _buildWorkingLocationCard(),
              const SizedBox(height: 16),
              _buildVehicleInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------ WIDGETS ------------------

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
                  : null,
              child: profileImage == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
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
        if (isEditing && profileImage != null)
          TextButton.icon(
            onPressed: () => removeImage(ImageType.profile),
            icon: const Icon(Icons.delete),
            label: const Text("Remove Photo"),
          ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            if (isEditing) {
              await saveProfile();
              await updateProfileApi();
            }
            setState(() => isEditing = !isEditing);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
    child: Text(text),
  );

  Widget _field(String label, TextEditingController controller) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label(label),
      const SizedBox(height: 6),
      isEditing
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

  Widget _imagePickerBox(String title, File? img, ImageType type) {
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
              image: img != null
                  ? DecorationImage(image: FileImage(img), fit: BoxFit.cover)
                  : null,
            ),
            child: img == null
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
              if (img != null)
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

  // ----------------- Cards -----------------

  Widget _buildPersonalInfoCard() {
    return _card(
      title: "Personal Information",
      icon: Icons.person_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imagePickerBox("ID Card Photo", idCardImage, ImageType.idCard),
          _field("Full Name", nameController),
          _nonEditableField("Role", roleController.text),
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
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _imagePickerBox(
                  "Back",
                  aadharBack,
                  ImageType.aadharBack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSalaryPackageSection() {
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
          buildSalaryOption(amount: "₱250 Package", value: "250"),
          buildSalaryOption(amount: "₱350 Package", value: "350"),
          buildSalaryOption(amount: "₱450 Package", value: "450"),
        ],
      ),
    );
  }

  Widget buildSalaryOption({required String amount, required String value}) {
    return RadioListTile<String>(
      title: Text(amount),
      value: value,
      groupValue: selectedPackage,
      onChanged: isEditing ? (v) => setState(() => selectedPackage = v!) : null,
    );
  }

  Widget _buildBankAccountCard() {
    return _card(
      title: "Bank Account",
      icon: Icons.account_balance,
      child: Column(
        children: [
          _field("Account Holder Name", accountHolderController),
          _field("Bank Name", bankNameController),
          _field("Account Number", accountNumberController),
          _field("IFSC Code", ifscController),
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
}
