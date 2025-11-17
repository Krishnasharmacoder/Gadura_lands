// import 'package:flutter/material.dart';

// // Dummy Pages (for bottom navigation)
// class ReviewPage extends StatelessWidget {
//   const ReviewPage({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Center(child: Text("Review Page", style: TextStyle(fontSize: 22)));
// }

// class SessionPage extends StatelessWidget {
//   const SessionPage({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Center(child: Text("Session Page", style: TextStyle(fontSize: 22)));
// }

// class WalletPage extends StatelessWidget {
//   const WalletPage({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Center(child: Text("Wallet Page", style: TextStyle(fontSize: 22)));
// }

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Center(child: Text("Profile Page", style: TextStyle(fontSize: 22)));
// }

// // ============================= HOMEPAGE =============================

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = const [
//     NewLandPage(),
//     ReviewPage(),
//     SessionPage(),
//     WalletPage(),
//     ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.green.shade700,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _selectedIndex,
//         onTap: (index) => setState(() => _selectedIndex = index),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_location_alt_outlined),
//             label: "New Land",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.reviews_outlined),
//             label: "Review",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule_outlined),
//             label: "Session",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_balance_wallet_outlined),
//             label: "Wallet",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ============================= NEW LAND PAGE =============================

// class NewLandPage extends StatefulWidget {
//   const NewLandPage({super.key});

//   @override
//   State<NewLandPage> createState() => _NewLandPageState();
// }

// class _NewLandPageState extends State<NewLandPage> {
//   bool isWhatsApp = false;

//   String? selectedState;
//   String? selectedDistrict;

//   // 👇 Selection Variables
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
//     'Telangana',
//     'Andhra Pradesh',
//     'Karnataka',
//     'Tamil Nadu',
//   ];

//   final List<String> districts = [
//     'Ranga Reddy',
//     'Hyderabad',
//     'Medchal',
//     'Nizamabad',
//   ];

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
//             _buildLandDetailsSection(), // 👈 Added Land Details Section
//           ],
//         ),
//       ),
//     );
//   }

//   // ====================== Address Section ======================
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
//       _inputField("Enter Village Name", Icons.home_outlined),
//       const SizedBox(height: 20),
//       _inputField("Capture GPS Location", Icons.gps_fixed),
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
//       _labeledInput(
//         "Other WhatsApp Number",
//         "Enter WhatsApp number",
//         Icons.wechat,
//       ),
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
//               onPressed: () {},
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
//             const Expanded(
//               child: Text(
//                 "No file chosen",
//                 style: TextStyle(color: Colors.grey),
//               ),
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
// }

import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/newland.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/profile.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/review.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/session.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/wallet.dart';

//============================= HOMEPAGE =============================

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    NewLandPage(),
    ReviewPage(),
    SessionPage(),
    WalletPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_alt_outlined),
            label: "New Land",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews_outlined),
            label: "Review",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined),
            label: "Session",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// ============================= NEW LAND PAGE =============================

// class NewLandPage extends StatefulWidget {
//   const NewLandPage({super.key});

//   @override
//   State<NewLandPage> createState() => _NewLandPageState();
// }

// class _NewLandPageState extends State<NewLandPage> {
//   bool isWhatsApp = false;

//   String? selectedState;
//   String? selectedDistrict;

//   // 👇 Selection Variables
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
//     'Telangana',
//     'Andhra Pradesh',
//     'Karnataka',
//     'Tamil Nadu',
//   ];

//   final List<String> districts = [
//     'Ranga Reddy',
//     'Hyderabad',
//     'Medchal',
//     'Nizamabad',
//   ];

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

//   // ====================== Address Section ======================
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
//       _inputField("Enter Village Name", Icons.home_outlined),
//       const SizedBox(height: 20),
//       _inputField("Capture GPS Location", Icons.gps_fixed),
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
//               onPressed: () {},
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
//             const Expanded(
//               child: Text(
//                 "No file chosen",
//                 style: TextStyle(color: Colors.grey),
//               ),
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
//         onPressed: () {},
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
//             child: _labeledInput("Latitude", "e.g. 17.4502", Icons.gps_fixed),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: _labeledInput("Longitude", "e.g. 78.3654", Icons.gps_fixed),
//           ),
//         ],
//       ),
//       const SizedBox(height: 15),
//       ElevatedButton.icon(
//         onPressed: () {},
//         icon: const Icon(Icons.my_location_outlined),
//         label: const Text("Get Location"),
//         style: _outlinedButtonStyle(),
//       ),
//       const SizedBox(height: 20),
//       _labelWithIcon("Land Border", Icons.map_outlined),
//       ElevatedButton.icon(
//         onPressed: () {},
//         icon: const Icon(Icons.map_outlined),
//         label: const Text("Draw Land Border"),
//         style: _outlinedButtonStyle(),
//       ),
//     ],
//   );

//   // ====================== DOCUMENTS & MEDIA SECTION (AFTER GPS) ======================
//   Widget _buildDocumentsSection() => _sectionContainer(
//     title: "Documents & Media",
//     children: [
//       _labelWithIcon("Land Photos", Icons.photo_camera_outlined),
//       ElevatedButton.icon(
//         onPressed: () {},
//         icon: const Icon(Icons.camera_alt_outlined),
//         label: const Text("Upload Photos"),
//         style: _outlinedButtonStyle(),
//       ),
//       const SizedBox(height: 20),
//       _labelWithIcon("Land Videos", Icons.videocam_outlined),
//       ElevatedButton.icon(
//         onPressed: () {},
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
//         onPressed: () {},
//         icon: const Icon(Icons.upload_file_outlined),
//         label: const Text("Upload Documents"),
//         style: _outlinedButtonStyle(),
//       ),
//     ],
//   );

//   // ====================== SUBMIT & SAVE BUTTONS ======================
//   Widget _buildSubmitButtons() => Column(
//     children: [
//       ElevatedButton.icon(
//         onPressed: () {
//           // Implement submit logic
//         },
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
//           // Implement save draft logic
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
