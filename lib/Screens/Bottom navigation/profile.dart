// // // import 'dart:io';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:gadura_land/Screens/homepage.dart';

// // // enum ImageType { profile, idCard, aadharFront, aadharBack }

// // // class ProfilePage extends StatefulWidget {
// // //   const ProfilePage({super.key});

// // //   @override
// // //   State<ProfilePage> createState() => _ProfilePageState();
// // // }

// // // class _ProfilePageState extends State<ProfilePage> {
// // //   // ---------- Controllers ----------
// // //   final TextEditingController nameController = TextEditingController(
// // //     text: "Suresh Kumar",
// // //   );
// // //   final TextEditingController emailController = TextEditingController(
// // //     text: "suresh@rolesync.app",
// // //   );
// // //   final TextEditingController roleController = TextEditingController(
// // //     text: "Field Executive",
// // //   );
// // //   final TextEditingController phoneController = TextEditingController(
// // //     text: "981105445",
// // //   );
// // //   final TextEditingController bloodgroupController = TextEditingController(
// // //     text: "O+",
// // //   );
// // //   final TextEditingController aadhaarController = TextEditingController(
// // //     text: "",
// // //   );

// // //   // Address controllers (for display / optional free text)
// // //   final TextEditingController stateController = TextEditingController(
// // //     text: "Telangana",
// // //   );
// // //   final TextEditingController districtController = TextEditingController(
// // //     text: "Rangareddy",
// // //   );
// // //   final TextEditingController mandalController = TextEditingController(
// // //     text: "Kothur",
// // //   );
// // //   final TextEditingController villageController = TextEditingController(
// // //     text: "Ramapuram",
// // //   );
// // //   final TextEditingController pincodeController = TextEditingController(
// // //     text: "500081",
// // //   );

// // //   // ---------- Images ----------
// // //   File? profileImage;
// // //   File? idCardImage;
// // //   File? aadharFront;
// // //   File? aadharBack;

// // //   final ImagePicker picker = ImagePicker();

// // //   // ---------- Static dropdown data ----------
// // //   final List<String> states = ['Telangana'];
// // //   final List<String> districts = ['Rangareddy'];
// // //   final List<String> mandals = ['Kothur'];
// // //   final List<String> villages = ['Ramapuram'];
// // //   final List<String> pincodes = ['500081'];

// // //   String selectedState = 'Telangana';
// // //   String selectedDistrict = 'Rangareddy';
// // //   String selectedMandal = 'Kothur';
// // //   String selectedVillage = 'Ramapuram';
// // //   String selectedPincode = '500081';

// // //   // Pick Image (single function)
// // //   Future<void> pickImage(ImageType type) async {
// // //     final XFile? file = await picker.pickImage(
// // //       source: ImageSource.gallery,
// // //       imageQuality: 60,
// // //     );
// // //     if (file == null) return;
// // //     setState(() {
// // //       final f = File(file.path);
// // //       switch (type) {
// // //         case ImageType.profile:
// // //           profileImage = f;
// // //           break;
// // //         case ImageType.idCard:
// // //           idCardImage = f;
// // //           break;
// // //         case ImageType.aadharFront:
// // //           aadharFront = f;
// // //           break;
// // //         case ImageType.aadharBack:
// // //           aadharBack = f;
// // //           break;
// // //       }
// // //     });
// // //   }

// // //   @override
// // //   void dispose() {
// // //     nameController.dispose();
// // //     emailController.dispose();
// // //     roleController.dispose();
// // //     phoneController.dispose();
// // //     bloodgroupController.dispose();
// // //     aadhaarController.dispose();
// // //     stateController.dispose();
// // //     districtController.dispose();
// // //     mandalController.dispose();
// // //     villageController.dispose();
// // //     pincodeController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF5F6FA),
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         title: const Text("Profile", style: TextStyle(color: Colors.black)),
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back),
// // //           onPressed: () {
// // //             Navigator.push(
// // //               context,
// // //               MaterialPageRoute(builder: (_) => const Homepage()),
// // //             );
// // //           },
// // //         ),
// // //         centerTitle: true,
// // //       ),
// // //       body: SingleChildScrollView(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             const SizedBox(height: 20),

// // //             // PROFILE PHOTO
// // //             Stack(
// // //               alignment: Alignment.bottomRight,
// // //               children: [
// // //                 CircleAvatar(
// // //                   radius: 55,
// // //                   backgroundColor: Colors.grey.shade300,
// // //                   backgroundImage: profileImage != null
// // //                       ? FileImage(profileImage!)
// // //                       : null,
// // //                   child: profileImage == null
// // //                       ? const Icon(Icons.person, size: 60, color: Colors.white)
// // //                       : null,
// // //                 ),
// // //                 GestureDetector(
// // //                   onTap: () => pickImage(ImageType.profile),
// // //                   child: Container(
// // //                     padding: const EdgeInsets.all(6),
// // //                     decoration: const BoxDecoration(
// // //                       shape: BoxShape.circle,
// // //                       color: Colors.green,
// // //                     ),
// // //                     child: const Icon(
// // //                       Icons.edit,
// // //                       color: Colors.white,
// // //                       size: 20,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),

// // //             const SizedBox(height: 10),

// // //             // EDIT BUTTON
// // //             ElevatedButton.icon(
// // //               onPressed: () => openEditDialog(),
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color(0xFF00A86B),
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(10),
// // //                 ),
// // //               ),
// // //               icon: const Icon(Icons.edit, color: Colors.white),
// // //               label: const Text(
// // //                 "Edit Profile",
// // //                 style: TextStyle(color: Colors.white),
// // //               ),
// // //             ),

// // //             const SizedBox(height: 20),

// // //             // PERSONAL INFO CARD
// // //             _buildPersonalInfoCard(),

// // //             const SizedBox(height: 16),

// // //             // ADDRESS DETAILS CARD (added below Personal Info)
// // //             _buildAddressCard(),
// // //             const SizedBox(height: 16),

// // //             // AADHAAR CARD
// // //             _buildAadhaarCard(),

// // //             const SizedBox(height: 24),

// // //             const SizedBox(height: 16),
// // //             _buildSalaryPackageCard(),

// // //             const SizedBox(height: 16),
// // //             _buildBankAccountCard(),

// // //             const SizedBox(height: 16),
// // //             _buildWorkingLocationCard(),

// // //             const SizedBox(height: 16),
// // //             _buildVehicleInfoCard(),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildPersonalInfoCard() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(15),
// // //         border: Border.all(color: Colors.grey.shade200),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: const [
// // //               Icon(Icons.person_outline, color: Colors.green),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Personal Information",
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 20),

// // //           // ID CARD PHOTO
// // //           const Text(
// // //             "ID Card Photo:",
// // //             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
// // //           ),
// // //           const SizedBox(height: 10),
// // //           Center(
// // //             child: Column(
// // //               children: [
// // //                 Container(
// // //                   height: 140,
// // //                   width: 140,
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.grey.shade200,
// // //                     borderRadius: BorderRadius.circular(10),
// // //                     image: idCardImage != null
// // //                         ? DecorationImage(
// // //                             image: FileImage(idCardImage!),
// // //                             fit: BoxFit.cover,
// // //                           )
// // //                         : null,
// // //                   ),
// // //                   child: idCardImage == null
// // //                       ? const Icon(Icons.image, size: 50, color: Colors.grey)
// // //                       : null,
// // //                 ),
// // //                 const SizedBox(height: 10),
// // //                 TextButton.icon(
// // //                   onPressed: () => pickImage(ImageType.idCard),
// // //                   icon: const Icon(Icons.upload_file),
// // //                   label: const Text("Upload"),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           const SizedBox(height: 20),

// // //           _label("Full Name:"),
// // //           _infoBox(nameController.text),

// // //           const SizedBox(height: 15),

// // //           _label("Role:"),
// // //           _infoBox(roleController.text),

// // //           const SizedBox(height: 15),

// // //           _label("Email Address:"),
// // //           _infoBox(emailController.text),

// // //           const SizedBox(height: 15),

// // //           _label("Phone Number :"),
// // //           _infoBox(phoneController.text),

// // //           const SizedBox(height: 15),

// // //           _label("Blood Group :"),
// // //           _infoBox(bloodgroupController.text),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAddressCard() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(15),
// // //         border: Border.all(color: Colors.grey.shade200),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: const [
// // //               Icon(Icons.location_on_outlined, color: Colors.green),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Address Details",
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),

// // //           // State Dropdown (static)
// // //           _label("State"),
// // //           const SizedBox(height: 6),
// // //           DropdownButtonFormField<String>(
// // //             value: selectedState,
// // //             items: states
// // //                 .map((s) => DropdownMenuItem(value: s, child: Text(s)))
// // //                 .toList(),
// // //             onChanged: (v) {
// // //               if (v == null) return;
// // //               setState(() {
// // //                 selectedState = v;
// // //                 stateController.text = v;
// // //               });
// // //             },
// // //             decoration: const InputDecoration(border: OutlineInputBorder()),
// // //           ),

// // //           const SizedBox(height: 12),

// // //           _label("District"),
// // //           const SizedBox(height: 6),
// // //           DropdownButtonFormField<String>(
// // //             value: selectedDistrict,
// // //             items: districts
// // //                 .map((d) => DropdownMenuItem(value: d, child: Text(d)))
// // //                 .toList(),
// // //             onChanged: (v) {
// // //               if (v == null) return;
// // //               setState(() {
// // //                 selectedDistrict = v;
// // //                 districtController.text = v;
// // //               });
// // //             },
// // //             decoration: const InputDecoration(border: OutlineInputBorder()),
// // //           ),

// // //           const SizedBox(height: 12),

// // //           _label("Mandal"),
// // //           const SizedBox(height: 6),
// // //           DropdownButtonFormField<String>(
// // //             value: selectedMandal,
// // //             items: mandals
// // //                 .map((m) => DropdownMenuItem(value: m, child: Text(m)))
// // //                 .toList(),
// // //             onChanged: (v) {
// // //               if (v == null) return;
// // //               setState(() {
// // //                 selectedMandal = v;
// // //                 mandalController.text = v;
// // //               });
// // //             },
// // //             decoration: const InputDecoration(border: OutlineInputBorder()),
// // //           ),

// // //           const SizedBox(height: 12),

// // //           _label("Village"),
// // //           const SizedBox(height: 6),
// // //           DropdownButtonFormField<String>(
// // //             value: selectedVillage,
// // //             items: villages
// // //                 .map((v) => DropdownMenuItem(value: v, child: Text(v)))
// // //                 .toList(),
// // //             onChanged: (v) {
// // //               if (v == null) return;
// // //               setState(() {
// // //                 selectedVillage = v;
// // //                 villageController.text = v;
// // //               });
// // //             },
// // //             decoration: const InputDecoration(border: OutlineInputBorder()),
// // //           ),

// // //           const SizedBox(height: 12),

// // //           _label("Pincode"),
// // //           const SizedBox(height: 6),
// // //           DropdownButtonFormField<String>(
// // //             value: selectedPincode,
// // //             items: pincodes
// // //                 .map((p) => DropdownMenuItem(value: p, child: Text(p)))
// // //                 .toList(),
// // //             onChanged: (v) {
// // //               if (v == null) return;
// // //               setState(() {
// // //                 selectedPincode = v;
// // //                 pincodeController.text = v;
// // //               });
// // //             },
// // //             decoration: const InputDecoration(border: OutlineInputBorder()),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAadhaarCard() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(15),
// // //         border: Border.all(color: Colors.grey.shade200),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: const [
// // //               Icon(Icons.credit_card, color: Colors.green),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Aadhaar Card",
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),

// // //           _label("Aadhaar Number"),
// // //           const SizedBox(height: 8),
// // //           TextField(
// // //             controller: aadhaarController,
// // //             keyboardType: TextInputType.number,
// // //             decoration: const InputDecoration(
// // //               border: OutlineInputBorder(),
// // //               hintText: "Enter Aadhaar number",
// // //             ),
// // //           ),

// // //           const SizedBox(height: 16),

// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: _buildAadhaarImageBox(
// // //                   title: "Front",
// // //                   file: aadharFront,
// // //                   type: ImageType.aadharFront,
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 12),
// // //               Expanded(
// // //                 child: _buildAadhaarImageBox(
// // //                   title: "Back",
// // //                   file: aadharBack,
// // //                   type: ImageType.aadharBack,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildSalaryPackageCard() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(15),
// // //         border: Border.all(color: Colors.grey.shade200),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: const [
// // //               Icon(Icons.wallet_giftcard, color: Colors.green),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Salary Package",
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),

// // //           const SizedBox(height: 16),
// // //           const Text(
// // //             "New Land Entry Package",
// // //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// // //           ),

// // //           const SizedBox(height: 16),

// // //           // 250 package
// // //           Container(
// // //             padding: const EdgeInsets.all(16),
// // //             decoration: BoxDecoration(
// // //               borderRadius: BorderRadius.circular(15),
// // //               border: Border.all(color: Colors.grey.shade300),
// // //             ),
// // //             child: Row(
// // //               children: const [
// // //                 Icon(Icons.radio_button_checked, color: Colors.green),
// // //                 SizedBox(width: 10),
// // //                 Expanded(
// // //                   child: Text(
// // //                     "₱250 Package\n50% paid daily, 50% after 30 working days.",
// // //                     style: TextStyle(fontSize: 15),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           const SizedBox(height: 16),

// // //           // 300 package
// // //           Container(
// // //             padding: const EdgeInsets.all(16),
// // //             decoration: BoxDecoration(
// // //               borderRadius: BorderRadius.circular(15),
// // //               border: Border.all(color: Colors.grey.shade300),
// // //             ),
// // //             child: Row(
// // //               children: const [
// // //                 Icon(Icons.radio_button_unchecked, color: Colors.grey),
// // //                 SizedBox(width: 10),
// // //                 Expanded(
// // //                   child: Text(
// // //                     "₱300 Package\n25% paid daily, 75% after 30 working days.",
// // //                     style: TextStyle(fontSize: 15),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildBankAccountCard() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(15),
// // //         border: Border.all(color: Colors.grey.shade200),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: const [
// // //               Icon(Icons.account_balance_wallet, color: Colors.green),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Bank Account",
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),

// // //           const SizedBox(height: 20),

// // //           _bankField("Bank Name", "Telangana Grameena Bank"),
// // //           const SizedBox(height: 12),

// // //           _bankField("Account Number", "**** **** **** 5678"),
// // //           const SizedBox(height: 12),

// // //           _bankField("IFSC Code", "TGB0000001"),
// // //           const SizedBox(height: 12),

// // //           _bankField("GPay Number", "+91-9876543210"),
// // //           const SizedBox(height: 12),

// // //           _bankField("PhonePe Number", "+91-9876543210"),
// // //           const SizedBox(height: 12),

// // //           _bankField("UPI ID", "suresh@upi"),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _bankField(String label, String value) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(
// // //           label,
// // //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// // //         ),
// // //         const SizedBox(height: 6),
// // //         Container(
// // //           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
// // //           decoration: BoxDecoration(
// // //             color: const Color(0xFFF6F8F9),
// // //             borderRadius: BorderRadius.circular(10),
// // //           ),
// // //           child: Text(
// // //             value,
// // //             style: const TextStyle(fontSize: 15, color: Colors.black54),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildWorkingLocationCard() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(15),
// // //         border: Border.all(color: Colors.grey.shade200),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: const [
// // //               Icon(Icons.map_outlined, color: Colors.green),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Working Location",
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),

// // //           const SizedBox(height: 20),

// // //           _chipField("State", ["Telangana"]),
// // //           const SizedBox(height: 14),

// // //           _chipField("District", ["Rangareddy"]),
// // //           const SizedBox(height: 14),

// // //           _chipField("Mandal", ["Kothur"]),
// // //           const SizedBox(height: 14),

// // //           _chipField("Village", ["Ramapuram"]),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _chipField(String label, List<String> chips) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(
// // //           label,
// // //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// // //         ),
// // //         const SizedBox(height: 6),
// // //         Container(
// // //           padding: const EdgeInsets.all(12),
// // //           decoration: BoxDecoration(
// // //             color: const Color(0xFFF7F9FA),
// // //             borderRadius: BorderRadius.circular(12),
// // //           ),
// // //           child: Row(
// // //             children: [
// // //               Wrap(
// // //                 spacing: 8,
// // //                 children: chips
// // //                     .map(
// // //                       (c) => Container(
// // //                         padding: const EdgeInsets.symmetric(
// // //                           horizontal: 12,
// // //                           vertical: 6,
// // //                         ),
// // //                         decoration: BoxDecoration(
// // //                           border: Border.all(color: Colors.grey.shade400),
// // //                           borderRadius: BorderRadius.circular(20),
// // //                         ),
// // //                         child: Row(
// // //                           mainAxisSize: MainAxisSize.min,
// // //                           children: [
// // //                             Text(
// // //                               c,
// // //                               style: const TextStyle(color: Colors.black87),
// // //                             ),
// // //                             const SizedBox(width: 4),
// // //                             const Icon(
// // //                               Icons.close,
// // //                               size: 16,
// // //                               color: Colors.grey,
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     )
// // //                     .toList(),
// // //               ),
// // //               const Spacer(),
// // //               const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildVehicleInfoCard() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(15),
// // //         border: Border.all(color: Colors.grey.shade200),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: const [
// // //               Icon(Icons.electric_bike, color: Colors.green),
// // //               SizedBox(width: 6),
// // //               Text(
// // //                 "Vehicle Information",
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ],
// // //           ),

// // //           const SizedBox(height: 20),

// // //           _vehicleField("Vehicle Type", "Motorcycle"),
// // //           const SizedBox(height: 16),

// // //           _vehicleField("License Plate", "SYNC-R1DE"),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _vehicleField(String label, String value) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(
// // //           label,
// // //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// // //         ),
// // //         const SizedBox(height: 6),
// // //         Container(
// // //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
// // //           decoration: BoxDecoration(
// // //             color: const Color(0xFFF7F9FA),
// // //             borderRadius: BorderRadius.circular(12),
// // //           ),
// // //           child: Text(
// // //             value,
// // //             style: const TextStyle(fontSize: 15, color: Colors.black54),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildAadhaarImageBox({
// // //     required String title,
// // //     required File? file,
// // //     required ImageType type,
// // //   }) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
// // //         const SizedBox(height: 8),
// // //         Container(
// // //           height: 120,
// // //           decoration: BoxDecoration(
// // //             color: Colors.grey.shade200,
// // //             borderRadius: BorderRadius.circular(10),
// // //             image: file != null
// // //                 ? DecorationImage(image: FileImage(file), fit: BoxFit.cover)
// // //                 : null,
// // //           ),
// // //           child: file == null
// // //               ? const Center(
// // //                   child: Icon(Icons.image, size: 36, color: Colors.grey),
// // //                 )
// // //               : null,
// // //         ),
// // //         const SizedBox(height: 8),
// // //         TextButton.icon(
// // //           onPressed: () => pickImage(type),
// // //           icon: const Icon(Icons.upload_file),
// // //           label: const Text("Upload"),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _infoBox(String text) {
// // //     return Container(
// // //       padding: const EdgeInsets.all(13),
// // //       width: double.infinity,
// // //       decoration: BoxDecoration(
// // //         color: const Color(0xFFF1F1F1),
// // //         borderRadius: BorderRadius.circular(10),
// // //       ),
// // //       child: Text(text),
// // //     );
// // //   }

// // //   Widget _label(String text) {
// // //     return Text(
// // //       text,
// // //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// // //     );
// // //   }

// // //   // EDIT POPUP (same as before)
// // //   void openEditDialog() {
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: const Text("Edit Profile"),
// // //         content: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             TextField(
// // //               controller: nameController,
// // //               decoration: const InputDecoration(labelText: "Full Name"),
// // //             ),
// // //             TextField(
// // //               controller: roleController,
// // //               decoration: const InputDecoration(labelText: "Role"),
// // //             ),
// // //             TextField(
// // //               controller: emailController,
// // //               decoration: const InputDecoration(labelText: "Email"),
// // //             ),
// // //             TextField(
// // //               controller: phoneController,
// // //               decoration: const InputDecoration(labelText: "phone number"),
// // //             ),
// // //             TextField(
// // //               controller: bloodgroupController,
// // //               decoration: const InputDecoration(labelText: "Blood Group"),
// // //             ),
// // //           ],
// // //         ),

// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context),
// // //             child: const Text("Cancel"),
// // //           ),
// // //           ElevatedButton(
// // //             onPressed: () {
// // //               setState(() {});
// // //               Navigator.pop(context);
// // //             },
// // //             child: const Text("Save"),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // ✔ SAME UI — ✔ FULL EDIT MODE — ❌ ROLE FIELD NON-EDITABLE
// // // YOUR FINAL CLEAN REWRITTEN CODE

// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:gadura_land/Screens/homepage.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // enum ImageType { profile, idCard, aadharFront, aadharBack }

// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});

// //   @override
// //   State<ProfilePage> createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   bool isEditing = false; // EDIT MODE TOGGLE

// //   // ---------- Controllers ----------
// //   final nameController = TextEditingController(text: "Suresh Kumar");
// //   final emailController = TextEditingController(text: "suresh@rolesync.app");
// //   final roleController = TextEditingController(text: "Field Executive");
// //   final phoneController = TextEditingController(text: "981105445");
// //   final bloodgroupController = TextEditingController(text: "O+");
// //   final aadhaarController = TextEditingController(text: "");

// //   final stateController = TextEditingController(text: "Telangana");
// //   final districtController = TextEditingController(text: "Rangareddy");
// //   final mandalController = TextEditingController(text: "Kothur");
// //   final villageController = TextEditingController(text: "Ramapuram");
// //   final pincodeController = TextEditingController(text: "500081");

// //   // ---------- Images ----------
// //   File? profileImage;
// //   File? idCardImage;
// //   File? aadharFront;
// //   File? aadharBack;

// //   final picker = ImagePicker();

// //   Future<void> pickImage(ImageType type) async {
// //     final XFile? file = await picker.pickImage(
// //       source: ImageSource.gallery,
// //       imageQuality: 60,
// //     );
// //     if (file == null) return;
// //     setState(() {
// //       final img = File(file.path);
// //       switch (type) {
// //         case ImageType.profile:
// //           profileImage = img;
// //           break;
// //         case ImageType.idCard:
// //           idCardImage = img;
// //           break;
// //         case ImageType.aadharFront:
// //           aadharFront = img;
// //           break;
// //         case ImageType.aadharBack:
// //           aadharBack = img;
// //           break;
// //       }
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         bool exitPopup = await showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //             title: const Text("Exit profile"),
// //             content: const Text("Do you really want to exit the app?"),
// //             actions: [
// //               TextButton(
// //                 onPressed: () => Navigator.pop(context, false),
// //                 child: const Text("No"),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () => Navigator.pop(context, true),
// //                 child: const Text("Yes"),
// //               ),
// //             ],
// //           ),
// //         );

// //         return exitPopup; // true = exit, false = stay
// //       },
// //       child: Scaffold(
// //         backgroundColor: const Color(0xFFF5F6FA),
// //         appBar: AppBar(
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           title: const Text("Profile", style: TextStyle(color: Colors.black)),
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back),
// //             onPressed: () => Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (_) => const Homepage()),
// //             ),
// //           ),
// //         ),

// //         body: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             children: [
// //               const SizedBox(height: 20),
// //               _buildProfilePhoto(),
// //               const SizedBox(height: 20),
// //               _buildPersonalInfoCard(),
// //               const SizedBox(height: 16),
// //               _buildAddressCard(),
// //               const SizedBox(height: 16),
// //               _buildAadhaarCard(),
// //               const SizedBox(height: 16),
// //               _buildSalaryPackageCard(),
// //               const SizedBox(height: 16),
// //               _buildBankAccountCard(),
// //               const SizedBox(height: 16),
// //               _buildWorkingLocationCard(),
// //               const SizedBox(height: 16),
// //               _buildVehicleInfoCard(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // PROFILE PHOTO
// //   // --------------------------------------------------------------
// //   Widget _buildProfilePhoto() {
// //     return Column(
// //       children: [
// //         Stack(
// //           alignment: Alignment.bottomRight,
// //           children: [
// //             CircleAvatar(
// //               radius: 55,
// //               backgroundColor: Colors.grey.shade300,
// //               backgroundImage: profileImage != null
// //                   ? FileImage(profileImage!)
// //                   : null,
// //               child: profileImage == null
// //                   ? const Icon(Icons.person, size: 60, color: Colors.white)
// //                   : null,
// //             ),
// //             GestureDetector(
// //               onTap: () => pickImage(ImageType.profile),
// //               child: Container(
// //                 padding: const EdgeInsets.all(6),
// //                 decoration: const BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: Colors.green,
// //                 ),
// //                 child: const Icon(Icons.edit, color: Colors.white, size: 20),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),

// //         // GestureDetector(
// //         //   onTap: () {
// //         //     setState(() {
// //         //       isEditing = !isEditing;
// //         //     });
// //         //   },
// //         //   child: Container(
// //         //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //         //     decoration: BoxDecoration(
// //         //       color: const Color(0xFF4A845E), // green shade like your image
// //         //       borderRadius: BorderRadius.circular(25),
// //         //     ),
// //         //     child: Row(
// //         //       mainAxisSize: MainAxisSize.min,
// //         //       children: [
// //         //         Icon(
// //         //           isEditing ? Icons.save_alt : Icons.edit,
// //         //           color: Colors.white,
// //         //           size: 22,
// //         //         ),
// //         //         const SizedBox(width: 10),
// //         //         Text(
// //         //           isEditing ? "Save Profile" : "Edit Profile",
// //         //           style: const TextStyle(
// //         //             color: Colors.white,
// //         //             fontSize: 16,
// //         //             fontWeight: FontWeight.w500,
// //         //           ),
// //         //         ),
// //         //       ],
// //         //     ),
// //         //   ),
// //         // ),
// //         GestureDetector(
// //           onTap: () async {
// //             if (isEditing) {
// //               await saveProfile(); // Save changes
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 const SnackBar(content: Text("Profile saved successfully!")),
// //               );
// //             }
// //             setState(() {
// //               isEditing = !isEditing; // Toggle edit mode
// //             });
// //           },
// //           child: Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //             decoration: BoxDecoration(
// //               color: const Color(0xFF4A845E),
// //               borderRadius: BorderRadius.circular(25),
// //             ),
// //             child: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Icon(
// //                   isEditing ? Icons.save_alt : Icons.edit,
// //                   color: Colors.white,
// //                   size: 22,
// //                 ),
// //                 const SizedBox(width: 10),
// //                 Text(
// //                   isEditing ? "Save Profile" : "Edit Profile",
// //                   style: const TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // PERSONAL INFO CARD — ALL EDITABLE EXCEPT ROLE
// //   // --------------------------------------------------------------
// //   Widget _buildPersonalInfoCard() {
// //     return _card(
// //       title: "Personal Information",
// //       icon: Icons.person_outline,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           _imagePickerBox("ID Card Photo", idCardImage, ImageType.idCard),

// //           _field("Full Name", nameController),
// //           _nonEditableField(
// //             "Role",
// //             roleController.text,
// //           ), // ROLE cannot be edited
// //           _field("Email", emailController),
// //           _field("Phone Number", phoneController),
// //           _field("Blood Group", bloodgroupController),
// //         ],
// //       ),
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // ADDRESS CARD — FULL EDIT MODE
// //   // --------------------------------------------------------------
// //   Widget _buildAddressCard() {
// //     return _card(
// //       title: "Address Details",
// //       icon: Icons.location_on_outlined,
// //       child: Column(
// //         children: [
// //           _field("State", stateController),
// //           _field("District", districtController),
// //           _field("Mandal", mandalController),
// //           _field("Village", villageController),
// //           _field("Pincode", pincodeController),
// //         ],
// //       ),
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // AADHAAR CARD — FULL EDIT MODE
// //   // --------------------------------------------------------------
// //   Widget _buildAadhaarCard() {
// //     return _card(
// //       title: "Aadhaar Card",
// //       icon: Icons.credit_card,
// //       child: Column(
// //         children: [
// //           _field("Aadhaar Number", aadhaarController),
// //           const SizedBox(height: 16),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: _imagePickerBox(
// //                   "Front",
// //                   aadharFront,
// //                   ImageType.aadharFront,
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: _imagePickerBox(
// //                   "Back",
// //                   aadharBack,
// //                   ImageType.aadharBack,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // REUSABLE FIELD WIDGET
// //   // --------------------------------------------------------------
// //   Widget _field(String label, TextEditingController controller) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _label(label),
// //         const SizedBox(height: 6),
// //         isEditing
// //             ? TextField(
// //                 controller: controller,
// //                 decoration: const InputDecoration(border: OutlineInputBorder()),
// //               )
// //             : _infoBox(controller.text),
// //         const SizedBox(height: 12),
// //       ],
// //     );
// //   }

// //   Widget _nonEditableField(String label, String value) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _label(label),
// //         const SizedBox(height: 6),
// //         _infoBox(value),
// //         const SizedBox(height: 12),
// //       ],
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // IMAGE UPLOAD BOX
// //   // --------------------------------------------------------------
// //   Widget _imagePickerBox(String title, File? img, ImageType type) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _label(title),
// //         const SizedBox(height: 8),
// //         GestureDetector(
// //           onTap: isEditing ? () => pickImage(type) : null,
// //           child: Container(
// //             height: 120,
// //             decoration: BoxDecoration(
// //               color: Colors.grey.shade200,
// //               borderRadius: BorderRadius.circular(10),
// //               image: img != null
// //                   ? DecorationImage(image: FileImage(img), fit: BoxFit.cover)
// //                   : null,
// //             ),
// //             child: img == null
// //                 ? const Center(
// //                     child: Icon(Icons.image, size: 40, color: Colors.grey),
// //                   )
// //                 : null,
// //           ),
// //         ),
// //         const SizedBox(height: 6),
// //         if (isEditing)
// //           TextButton.icon(
// //             onPressed: () => pickImage(type),
// //             icon: const Icon(Icons.upload_file),
// //             label: const Text("Upload"),
// //           ),
// //         const SizedBox(height: 10),
// //       ],
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // CARD WRAPPER
// //   // --------------------------------------------------------------
// //   Widget _card({
// //     required String title,
// //     required IconData icon,
// //     required Widget child,
// //   }) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(15),
// //         border: Border.all(color: Colors.grey.shade200),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               Icon(icon, color: Colors.green),
// //               const SizedBox(width: 6),
// //               Text(
// //                 title,
// //                 style: const TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 16),
// //           child,
// //         ],
// //       ),
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // SMALL UI HELPERS
// //   // --------------------------------------------------------------
// //   Widget _label(String text) => Text(
// //     text,
// //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// //   );

// //   Widget _infoBox(String text) {
// //     return Container(
// //       padding: const EdgeInsets.all(13),
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         color: const Color(0xFFF1F1F1),
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Text(text),
// //     );
// //   }

// //   // --------------------------------------------------------------
// //   // REMAINING CARDS — SAME UI (NOW IMPLEMENTED)

// //   Widget _buildSalaryPackageCard() => _card(
// //     title: "Salary Package",
// //     icon: Icons.wallet_outlined,
// //     child: Column(
// //       children: [
// //         _field("Base Salary", TextEditingController(text: "15000")),
// //         _field("Incentives", TextEditingController(text: "3000")),
// //         _field("Travel Allowance", TextEditingController(text: "1500")),
// //       ],
// //     ),
// //   );

// //   Widget _buildBankAccountCard() => _card(
// //     title: "Bank Account Details",
// //     icon: Icons.account_balance,
// //     child: Column(
// //       children: [
// //         _field(
// //           "Account Holder Name",
// //           TextEditingController(text: "Suresh Kumar"),
// //         ),
// //         _field("Bank Name", TextEditingController(text: "HDFC Bank")),
// //         _field("Account Number", TextEditingController(text: "1234567890")),
// //         _field("IFSC Code", TextEditingController(text: "HDFC0001234")),
// //       ],
// //     ),
// //   );

// //   Widget _buildWorkingLocationCard() => _card(
// //     title: "Working Location",
// //     icon: Icons.location_city,
// //     child: Column(
// //       children: [
// //         _field("City", TextEditingController(text: "Hyderabad")),
// //         _field("Route Area", TextEditingController(text: "Kothur – Shadnagar")),
// //       ],
// //     ),
// //   );

// //   Widget _buildVehicleInfoCard() => _card(
// //     title: "Vehicle Information",
// //     icon: Icons.directions_bike,
// //     child: Column(
// //       children: [
// //         _field("Vehicle Type", TextEditingController(text: "Bike")),
// //         _field("Vehicle Number", TextEditingController(text: "TS09AB1234")),
// //         _field("DL Number", TextEditingController(text: "DL-2024-9988")),
// //       ],
// //     ),
// //   );

// //   // ---------------------- SHARED PREFERENCES ----------------------
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadProfile();
// //   }

// //   Future<void> _loadProfile() async {
// //     final sp = await SharedPreferences.getInstance();

// //     nameController.text = sp.getString('name') ?? nameController.text;
// //     emailController.text = sp.getString('email') ?? emailController.text;
// //     phoneController.text = sp.getString('phone') ?? phoneController.text;
// //     bloodgroupController.text =
// //         sp.getString('blood') ?? bloodgroupController.text;
// //     aadhaarController.text = sp.getString('aadhaar') ?? aadhaarController.text;

// //     stateController.text = sp.getString('state') ?? stateController.text;
// //     districtController.text =
// //         sp.getString('district') ?? districtController.text;
// //     mandalController.text = sp.getString('mandal') ?? mandalController.text;
// //     villageController.text = sp.getString('village') ?? villageController.text;
// //     pincodeController.text = sp.getString('pincode') ?? pincodeController.text;
// //   }

// //   Future<void> saveProfile() async {
// //     final sp = await SharedPreferences.getInstance();

// //     await sp.setString('name', nameController.text);
// //     await sp.setString('email', emailController.text);
// //     await sp.setString('phone', phoneController.text);
// //     await sp.setString('blood', bloodgroupController.text);
// //     await sp.setString('aadhaar', aadhaarController.text);

// //     await sp.setString('state', stateController.text);
// //     await sp.setString('district', districtController.text);
// //     await sp.setString('mandal', mandalController.text);
// //     await sp.setString('village', villageController.text);
// //     await sp.setString('pincode', pincodeController.text);
// //   }
// // }

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
//   final cityController = TextEditingController(text: "Hyderabad");
//   final routeAreaController = TextEditingController(text: "Kothur – Shadnagar");

//   // Vehicle
//   final vehicleTypeController = TextEditingController(text: "Bike");
//   final vehicleNumberController = TextEditingController(text: "TS09AB1234");
//   final dlNumberController = TextEditingController(text: "DL-2024-9988");

//   // ---------- Images ----------
//   File? profileImage;
//   File? idCardImage;
//   File? aadharFront;
//   File? aadharBack;

//   final picker = ImagePicker();

//   Future<void> pickImage(ImageType type) async {
//     final XFile? file = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 60,
//     );
//     if (file == null) return;
//     setState(() {
//       final img = File(file.path);
//       switch (type) {
//         case ImageType.profile:
//           profileImage = img;
//           break;
//         case ImageType.idCard:
//           idCardImage = img;
//           break;
//         case ImageType.aadharFront:
//           aadharFront = img;
//           break;
//         case ImageType.aadharBack:
//           aadharBack = img;
//           break;
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }

//   Future<void> _loadProfile() async {
//     final sp = await SharedPreferences.getInstance();

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

//     cityController.text = sp.getString('city') ?? cityController.text;
//     routeAreaController.text =
//         sp.getString('routeArea') ?? routeAreaController.text;

//     vehicleTypeController.text =
//         sp.getString('vehicleType') ?? vehicleTypeController.text;
//     vehicleNumberController.text =
//         sp.getString('vehicleNumber') ?? vehicleNumberController.text;
//     dlNumberController.text =
//         sp.getString('dlNumber') ?? dlNumberController.text;

//     final profilePath = sp.getString('profileImage');
//     if (profilePath != null && File(profilePath).existsSync()) {
//       profileImage = File(profilePath);
//     }

//     final idCardPath = sp.getString('idCardImage');
//     if (idCardPath != null && File(idCardPath).existsSync()) {
//       idCardImage = File(idCardPath);
//     }

//     final aadharFrontPath = sp.getString('aadharFront');
//     if (aadharFrontPath != null && File(aadharFrontPath).existsSync()) {
//       aadharFront = File(aadharFrontPath);
//     }

//     final aadharBackPath = sp.getString('aadharBack');
//     if (aadharBackPath != null && File(aadharBackPath).existsSync()) {
//       aadharBack = File(aadharBackPath);
//     }

//     setState(() {});
//   }

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

//     await sp.setString('city', cityController.text);
//     await sp.setString('routeArea', routeAreaController.text);

//     await sp.setString('vehicleType', vehicleTypeController.text);
//     await sp.setString('vehicleNumber', vehicleNumberController.text);
//     await sp.setString('dlNumber', dlNumberController.text);

//     if (profileImage != null)
//       await sp.setString('profileImage', profileImage!.path);
//     if (idCardImage != null)
//       await sp.setString('idCardImage', idCardImage!.path);
//     if (aadharFront != null)
//       await sp.setString('aadharFront', aadharFront!.path);
//     if (aadharBack != null) await sp.setString('aadharBack', aadharBack!.path);
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
//               _buildSalaryPackageCard(),
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

//   // ---------------- UI Widgets (same as before, just now using persistent controllers) ----------------

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
//               onTap: () => pickImage(ImageType.profile),
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
//                   onPressed: () {
//                     // Remove image
//                     setState(() {
//                       switch (type) {
//                         case ImageType.profile:
//                           profileImage = null;
//                           break;
//                         case ImageType.idCard:
//                           idCardImage = null;
//                           break;
//                         case ImageType.aadharFront:
//                           aadharFront = null;
//                           break;
//                         case ImageType.aadharBack:
//                           aadharBack = null;
//                           break;
//                       }
//                     });
//                   },
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

//   Widget _buildSalaryPackageCard() {
//     return _card(
//       title: "Salary Package",
//       icon: Icons.wallet_outlined,
//       child: Column(
//         children: [
//           _field("Base Salary", baseSalaryController),
//           _field("Incentives", incentivesController),
//           _field("Travel Allowance", travelAllowanceController),
//         ],
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
//       icon: Icons.location_city,
//       child: Column(
//         children: [
//           _field("City", cityController),
//           _field("Route Area", routeAreaController),
//         ],
//       ),
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
//           _field("DL Number", dlNumberController),
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

enum ImageType { profile, idCard, aadharFront, aadharBack }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

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

  // Salary
  final baseSalaryController = TextEditingController(text: "15000");
  final incentivesController = TextEditingController(text: "3000");
  final travelAllowanceController = TextEditingController(text: "1500");

  // Bank
  final accountHolderController = TextEditingController(text: "Suresh Kumar");
  final bankNameController = TextEditingController(text: "HDFC Bank");
  final accountNumberController = TextEditingController(text: "1234567890");
  final ifscController = TextEditingController(text: "HDFC0001234");

  // Working location
  final cityController = TextEditingController(text: "Hyderabad");
  final routeAreaController = TextEditingController(text: "Kothur – Shadnagar");

  // Vehicle
  final vehicleTypeController = TextEditingController(text: "Bike");
  final vehicleNumberController = TextEditingController(text: "TS09AB1234");
  final dlNumberController = TextEditingController(text: "DL-2024-9988");

  // ---------- Images ----------
  File? profileImage;
  File? idCardImage;
  File? aadharFront;
  File? aadharBack;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final sp = await SharedPreferences.getInstance();

    // Text fields
    nameController.text = sp.getString('name') ?? nameController.text;
    emailController.text = sp.getString('email') ?? emailController.text;
    phoneController.text = sp.getString('phone') ?? phoneController.text;
    bloodgroupController.text =
        sp.getString('blood') ?? bloodgroupController.text;
    aadhaarController.text = sp.getString('aadhaar') ?? aadhaarController.text;

    stateController.text = sp.getString('state') ?? stateController.text;
    districtController.text =
        sp.getString('district') ?? districtController.text;
    mandalController.text = sp.getString('mandal') ?? mandalController.text;
    villageController.text = sp.getString('village') ?? villageController.text;
    pincodeController.text = sp.getString('pincode') ?? pincodeController.text;

    baseSalaryController.text =
        sp.getString('baseSalary') ?? baseSalaryController.text;
    incentivesController.text =
        sp.getString('incentives') ?? incentivesController.text;
    travelAllowanceController.text =
        sp.getString('travelAllowance') ?? travelAllowanceController.text;

    accountHolderController.text =
        sp.getString('accountHolder') ?? accountHolderController.text;
    bankNameController.text =
        sp.getString('bankName') ?? bankNameController.text;
    accountNumberController.text =
        sp.getString('accountNumber') ?? accountNumberController.text;
    ifscController.text = sp.getString('ifsc') ?? ifscController.text;

    cityController.text = sp.getString('city') ?? cityController.text;
    routeAreaController.text =
        sp.getString('routeArea') ?? routeAreaController.text;

    vehicleTypeController.text =
        sp.getString('vehicleType') ?? vehicleTypeController.text;
    vehicleNumberController.text =
        sp.getString('vehicleNumber') ?? vehicleNumberController.text;
    dlNumberController.text =
        sp.getString('dlNumber') ?? dlNumberController.text;

    // Images (load only if file exists; if not, remove the saved key)
    final profilePath = sp.getString('profileImage');
    if (profilePath != null && File(profilePath).existsSync()) {
      profileImage = File(profilePath);
    } else {
      sp.remove('profileImage');
      profileImage = null;
    }

    final idCardPath = sp.getString('idCardImage');
    if (idCardPath != null && File(idCardPath).existsSync()) {
      idCardImage = File(idCardPath);
    } else {
      sp.remove('idCardImage');
      idCardImage = null;
    }

    final aadharFrontPath = sp.getString('aadharFront');
    if (aadharFrontPath != null && File(aadharFrontPath).existsSync()) {
      aadharFront = File(aadharFrontPath);
    } else {
      sp.remove('aadharFront');
      aadharFront = null;
    }

    final aadharBackPath = sp.getString('aadharBack');
    if (aadharBackPath != null && File(aadharBackPath).existsSync()) {
      aadharBack = File(aadharBackPath);
    } else {
      sp.remove('aadharBack');
      aadharBack = null;
    }

    setState(() {});
  }

  // Save all profile fields (images are saved immediately when picked; but keeping this for full save)
  Future<void> saveProfile() async {
    final sp = await SharedPreferences.getInstance();

    await sp.setString('name', nameController.text);
    await sp.setString('email', emailController.text);
    await sp.setString('phone', phoneController.text);
    await sp.setString('blood', bloodgroupController.text);
    await sp.setString('aadhaar', aadhaarController.text);

    await sp.setString('state', stateController.text);
    await sp.setString('district', districtController.text);
    await sp.setString('mandal', mandalController.text);
    await sp.setString('village', villageController.text);
    await sp.setString('pincode', pincodeController.text);

    await sp.setString('baseSalary', baseSalaryController.text);
    await sp.setString('incentives', incentivesController.text);
    await sp.setString('travelAllowance', travelAllowanceController.text);

    await sp.setString('accountHolder', accountHolderController.text);
    await sp.setString('bankName', bankNameController.text);
    await sp.setString('accountNumber', accountNumberController.text);
    await sp.setString('ifsc', ifscController.text);

    await sp.setString('city', cityController.text);
    await sp.setString('routeArea', routeAreaController.text);

    await sp.setString('vehicleType', vehicleTypeController.text);
    await sp.setString('vehicleNumber', vehicleNumberController.text);
    await sp.setString('dlNumber', dlNumberController.text);

    // Images paths are handled in pickImage/removeImage immediately.
  }

  // ---------- Image pick - now saves path to SharedPreferences immediately ----------
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

  // ---------- Image remove - now removes key from SharedPreferences immediately ----------
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
              _buildSalaryPackageCard(),
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

  // ---------------- UI Widgets ----------------

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
              onTap: () {
                // allow picking profile even if not in edit mode
                pickImage(ImageType.profile);
              },
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

        // Remove button for circular profile (visible when editing or if you want to always allow)
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile saved successfully!")),
              );
            }
            setState(() {
              isEditing = !isEditing;
            });
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

  // ---------------- Reusable Widgets ----------------

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

  Widget _infoBox(String text) {
    return Container(
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Column(
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
  }

  Widget _nonEditableField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        const SizedBox(height: 6),
        _infoBox(value),
        const SizedBox(height: 12),
      ],
    );
  }

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

  // ---------------- Cards ----------------

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

  Widget _buildSalaryPackageCard() {
    return _card(
      title: "Salary Package",
      icon: Icons.wallet_outlined,
      child: Column(
        children: [
          _field("Base Salary", baseSalaryController),
          _field("Incentives", incentivesController),
          _field("Travel Allowance", travelAllowanceController),
        ],
      ),
    );
  }

  Widget _buildBankAccountCard() {
    return _card(
      title: "Bank Account Details",
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
          _field("City", cityController),
          _field("Route Area", routeAreaController),
        ],
      ),
    );
  }

  Widget _buildVehicleInfoCard() {
    return _card(
      title: "Vehicle Information",
      icon: Icons.directions_bike,
      child: Column(
        children: [
          _field("Vehicle Type", vehicleTypeController),
          _field("Vehicle Number", vehicleNumberController),
          _field("DL Number", dlNumberController),
        ],
      ),
    );
  }
}
