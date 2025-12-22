// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:image_picker/image_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:gadura_land/Screens/FieldExecutive/edit_land_details.dart';

// // class Regionalverification extends StatefulWidget {
// //   const Regionalverification({super.key});

// //   @override
// //   State<Regionalverification> createState() => _RegionalverificationState();
// // }

// // class _RegionalverificationState extends State<Regionalverification>
// //     with SingleTickerProviderStateMixin {
// //   late TabController _tabController;
// //   List<dynamic> unverifiedLands = []; // API se aane wala data
// //   bool isLoading = true;
// //   String? _apiToken;
// //   final String baseUrl = "http://72.61.169.226";
// //   late Timer _autoRefreshTimer;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 2, vsync: this);
// //     loadToken();
// //     _fetchUnverifiedLands();
// //     // Auto refresh every 15 seconds
// //     _autoRefreshTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
// //       if (mounted && _tabController.index == 0 && !isLoading) {
// //         _fetchUnverifiedLands();
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _tabController.dispose();
// //     _autoRefreshTimer.cancel();
// //     super.dispose();
// //   }

// //   Future<void> loadToken() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     _apiToken = prefs.getString("auth_token");
// //   }

// //   // ========== FETCH UNVERIFIED LANDS FROM API ==========
// //   Future<void> _fetchUnverifiedLands() async {
// //     if (_apiToken == null) {
// //       await loadToken();
// //       if (_apiToken == null) return;
// //     }

// //     setState(() => isLoading = true);
// //     try {
// //       // Aapka API endpoint
// //       final response = await http.get(
// //         Uri.parse('$baseUrl/regional/land/unverified'),
// //         headers: {'Authorization': 'Bearer $_apiToken'},
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);

// //         // Check API response structure
// //         if (data is Map && data.containsKey('data')) {
// //           final apiData = data['data'];

// //           // Agar data Map hai (key-value pairs)
// //           if (apiData is Map) {
// //             List<dynamic> landList = [];
// //             apiData.forEach((key, value) {
// //               if (value is Map) {
// //                 landList.add({'id': key, ...value});
// //               }
// //             });
// //             setState(() {
// //               unverifiedLands = landList;
// //             });
// //           }
// //           // Agar data List hai
// //           else if (apiData is List) {
// //             setState(() {
// //               unverifiedLands = apiData;
// //             });
// //           }
// //         }
// //         // Direct list response
// //         else if (data is List) {
// //           setState(() {
// //             unverifiedLands = data;
// //           });
// //         }
// //       } else {
// //         print("Failed to fetch unverified lands: ${response.statusCode}");
// //         setState(() {
// //           unverifiedLands = [];
// //         });
// //       }
// //     } catch (e) {
// //       print("Error fetching unverified lands: $e");
// //       setState(() {
// //         unverifiedLands = [];
// //       });
// //     } finally {
// //       setState(() => isLoading = false);
// //     }
// //   }

// //   // ========== VERIFY LAND ==========
// //   Future<void> _verifyLand(String landId) async {
// //     try {
// //       final response = await http.post(
// //         Uri.parse('$baseUrl/regional/land/verify/$landId'),
// //         headers: {
// //           'Authorization': 'Bearer $_apiToken',
// //           'Content-Type': 'application/json',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Land $landId verified successfully'),
// //             backgroundColor: Colors.green,
// //           ),
// //         );
// //         // Refresh the list
// //         _fetchUnverifiedLands();
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Failed to verify land: ${response.statusCode}'),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
// //       );
// //     }
// //   }

// //   // ========== REJECT LAND ==========
// //   Future<void> _rejectLand(String landId, String reason) async {
// //     try {
// //       final response = await http.post(
// //         Uri.parse('$baseUrl/regional/land/reject/$landId'),
// //         headers: {
// //           'Authorization': 'Bearer $_apiToken',
// //           'Content-Type': 'application/json',
// //         },
// //         body: jsonEncode({'reason': reason}),
// //       );

// //       if (response.statusCode == 200) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Land $landId rejected'),
// //             backgroundColor: Colors.orange,
// //           ),
// //         );
// //         // Refresh the list
// //         _fetchUnverifiedLands();
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Failed to reject land: ${response.statusCode}'),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
// //       );
// //     }
// //   }

// //   // ========== SHOW REJECT DIALOG ==========
// //   void _showRejectDialog(String landId, String farmerName) {
// //     TextEditingController reasonController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text("Reject Land $landId"),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Text("Farmer: $farmerName"),
// //             SizedBox(height: 8),
// //             Text("Please provide reason for rejection:"),
// //             SizedBox(height: 16),
// //             TextField(
// //               controller: reasonController,
// //               decoration: InputDecoration(
// //                 hintText: "Enter rejection reason",
// //                 border: OutlineInputBorder(),
// //                 contentPadding: EdgeInsets.all(12),
// //               ),
// //               maxLines: 3,
// //             ),
// //           ],
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: Text('Cancel', style: TextStyle(color: Colors.black)),
// //           ),
// //           ElevatedButton(
// //             onPressed: () {
// //               if (reasonController.text.trim().isNotEmpty) {
// //                 _rejectLand(landId, reasonController.text.trim());
// //                 Navigator.pop(context);
// //               } else {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text('Please enter rejection reason')),
// //                 );
// //               }
// //             },
// //             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
// //             child: Text('Reject', style: TextStyle(color: Colors.white)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ========== SHOW LAND DETAILS ==========
// //   void _showLandDetails(Map<String, dynamic> land) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (context) => DraggableScrollableSheet(
// //         initialChildSize: 0.9,
// //         maxChildSize: 0.95,
// //         minChildSize: 0.5,
// //         expand: false,
// //         builder: (context, scrollController) {
// //           return SingleChildScrollView(
// //             controller: scrollController,
// //             child: Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Center(
// //                     child: Container(
// //                       width: 60,
// //                       height: 5,
// //                       decoration: BoxDecoration(
// //                         color: Colors.grey[300],
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),

// //                   // Land ID and Status
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         "Land ID: ${land['id'] ?? land['land_id'] ?? 'N/A'}",
// //                         style: TextStyle(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       Container(
// //                         padding: EdgeInsets.symmetric(
// //                           horizontal: 12,
// //                           vertical: 6,
// //                         ),
// //                         decoration: BoxDecoration(
// //                           color: Colors.orange.shade50,
// //                           borderRadius: BorderRadius.circular(20),
// //                           border: Border.all(color: Colors.orange.shade200),
// //                         ),
// //                         child: Text(
// //                           "PENDING",
// //                           style: TextStyle(
// //                             color: Colors.orange.shade800,
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 12,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),

// //                   SizedBox(height: 20),

// //                   // Farmer Details
// //                   Text(
// //                     "👤 Farmer Details",
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   SizedBox(height: 10),
// //                   _detailRow(
// //                     "Name",
// //                     land['farmer_name'] ?? land['name'] ?? "N/A",
// //                   ),
// //                   _detailRow("Phone", land['phone'] ?? "N/A"),
// //                   _detailRow("WhatsApp", land['whatsapp_number'] ?? "N/A"),
// //                   _detailRow("Literacy", land['literacy'] ?? "N/A"),
// //                   _detailRow("Age Group", land['age_group'] ?? "N/A"),
// //                   _detailRow("Nature", land['nature'] ?? "N/A"),

// //                   SizedBox(height: 20),

// //                   // Land Details
// //                   Text(
// //                     "📍 Land Details",
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   SizedBox(height: 10),
// //                   _detailRow("Village", land['village'] ?? "N/A"),
// //                   _detailRow("Mandal", land['mandal'] ?? "N/A"),
// //                   _detailRow("District", land['district'] ?? "N/A"),
// //                   _detailRow("State", land['state'] ?? "N/A"),
// //                   _detailRow("Survey No", land['survey_number'] ?? "N/A"),
// //                   _detailRow(
// //                     "Area",
// //                     "${land['land_area'] ?? land['area'] ?? "N/A"} Acres",
// //                   ),
// //                   _detailRow("Guntas", land['guntas'] ?? "N/A"),
// //                   _detailRow(
// //                     "Price per Acre",
// //                     "₹${land['price_per_acre'] ?? "N/A"}",
// //                   ),
// //                   _detailRow(
// //                     "Total Price",
// //                     "₹${land['total_land_price'] ?? land['price'] ?? "N/A"}",
// //                   ),
// //                   _detailRow("Land Type", land['land_type'] ?? "N/A"),
// //                   _detailRow("Ownership", land['land_ownership'] ?? "N/A"),

// //                   if (land.containsKey('water_source') &&
// //                       land['water_source'] != null)
// //                     _detailRow("Water Source", land['water_source']),

// //                   if (land.containsKey('dispute_type') &&
// //                       land['dispute_type'] != null)
// //                     _detailRow("Dispute Type", land['dispute_type']),

// //                   SizedBox(height: 20),

// //                   // Action Buttons
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: OutlinedButton.icon(
// //                           onPressed: () {
// //                             Navigator.pop(context);
// //                             _navigateToEdit(land);
// //                           },
// //                           icon: Icon(Icons.edit_outlined, size: 18),
// //                           label: Text("Edit"),
// //                           style: OutlinedButton.styleFrom(
// //                             padding: EdgeInsets.symmetric(vertical: 12),
// //                             side: BorderSide(color: Colors.blue),
// //                             foregroundColor: Colors.blue,
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(width: 10),
// //                       Expanded(
// //                         child: ElevatedButton.icon(
// //                           onPressed: () {
// //                             Navigator.pop(context);
// //                             _verifyLand(
// //                               land['id']?.toString() ??
// //                                   land['land_id']?.toString() ??
// //                                   "",
// //                             );
// //                           },
// //                           icon: Icon(Icons.check_circle_outline, size: 18),
// //                           label: Text("Verify"),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.green,
// //                             foregroundColor: Colors.white,
// //                             padding: EdgeInsets.symmetric(vertical: 12),
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(width: 10),
// //                       Expanded(
// //                         // child: OutlinedButton.icon(
// //                         //   onPressed: () {
// //                         //     Navigator.pop(context);
// //                         //     _showRejectDialog(
// //                         //       land['id']?.toString() ??
// //                         //           land['land_id']?.toString() ??
// //                         //           "",
// //                         //       land['farmer_name'] ?? land['name'] ?? "Unknown",
// //                         //     );
// //                         //   },
// //                         //   icon: Icon(Icons.close_outlined, size: 18),
// //                         //   label: Text("Reject"),
// //                         //   style: OutlinedButton.styleFrom(
// //                         //     padding: EdgeInsets.symmetric(vertical: 12),
// //                         //     side: BorderSide(color: Colors.red),
// //                         //     foregroundColor: Colors.red,
// //                         //   ),
// //                         // ),
// //                         child: OutlinedButton.icon(
// //                           onPressed: () {
// //                             Navigator.pop(context);
// //                             _showRejectDialog(
// //                               land['']?.toString() ??
// //                                   "", // CORRECT: Use land_id not id
// //                               land['farmer_details']?['name']?.toString() ??
// //                                   "Unknown Farmer", // CORRECT: Access nested farmer name
// //                             );
// //                           },
// //                           icon: Icon(Icons.close_outlined, size: 18),
// //                           label: Text("Reject"),
// //                           style: OutlinedButton.styleFrom(
// //                             padding: EdgeInsets.symmetric(vertical: 12),
// //                             side: BorderSide(color: Colors.red),
// //                             foregroundColor: Colors.red,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),

// //                   SizedBox(height: 30),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   // EDIT NAVIGATION FUNCTION
// //   void _navigateToEdit(Map<String, dynamic> land) {
// //     // Since we don't have the exact Datum model, we'll create a simple edit screen
// //     // Or navigate to existing EditLandScreen if you convert the data
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text("Edit Land"),
// //         content: Text(
// //           "Edit functionality for API data would need custom implementation",
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: Text("OK"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _detailRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 6),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           SizedBox(
// //             width: 120,
// //             child: Text(
// //               "$label:",
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w500,
// //                 color: Colors.grey.shade700,
// //               ),
// //             ),
// //           ),
// //           SizedBox(width: 10),
// //           Expanded(child: Text(value, style: TextStyle(fontSize: 14))),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               "Land Verification",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             Text(
// //               "Regional Verifier",
// //               style: TextStyle(fontSize: 12, color: Colors.white70),
// //             ),
// //           ],
// //         ),
// //         bottom: TabBar(
// //           controller: _tabController,
// //           labelColor: Colors.green,
// //           unselectedLabelColor: Colors.grey,
// //           indicatorColor: Colors.green,
// //           tabs: const [
// //             Tab(text: "Unverified Lands"),
// //             Tab(text: "New Land"),
// //           ],
// //         ),
// //       ),
// //       body: TabBarView(
// //         controller: _tabController,
// //         children: [
// //           // TAB 1: UNVERIFIED LANDS FROM API
// //           _buildUnverifiedLands(),

// //           // TAB 2: NEW LAND FORM
// //           NewLandForm(),
// //         ],
// //       ),
// //     );
// //   }

// //   // ========== TAB 1: UNVERIFIED LANDS ==========
// //   Widget _buildUnverifiedLands() {
// //     return Column(
// //       children: [
// //         // Auto refresh indicator
// //         if (isLoading)
// //           Container(
// //             padding: EdgeInsets.symmetric(vertical: 8),
// //             color: Colors.green.shade50,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Icon(Icons.refresh, size: 16, color: Colors.green),
// //                 SizedBox(width: 8),
// //                 Text(
// //                   "Refreshing...",
// //                   style: TextStyle(
// //                     fontSize: 12,
// //                     color: Colors.green,
// //                     fontStyle: FontStyle.italic,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //         Expanded(
// //           child: isLoading && unverifiedLands.isEmpty
// //               ? Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       CircularProgressIndicator(color: Colors.green),
// //                       SizedBox(height: 16),
// //                       Text(
// //                         "Loading unverified lands...",
// //                         style: TextStyle(color: Colors.grey),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //               : unverifiedLands.isEmpty
// //               ? Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         Icons.assignment_turned_in_outlined,
// //                         size: 64,
// //                         color: Colors.grey,
// //                       ),
// //                       SizedBox(height: 16),
// //                       Text(
// //                         "No unverified lands found",
// //                         style: TextStyle(fontSize: 18, color: Colors.grey),
// //                       ),
// //                       SizedBox(height: 8),
// //                       ElevatedButton.icon(
// //                         onPressed: _fetchUnverifiedLands,
// //                         icon: Icon(Icons.refresh),
// //                         label: Text("Refresh"),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.green,
// //                           foregroundColor: Colors.white,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //               : RefreshIndicator(
// //                   onRefresh: _fetchUnverifiedLands,
// //                   child: ListView.builder(
// //                     padding: const EdgeInsets.all(16),
// //                     itemCount: unverifiedLands.length,
// //                     itemBuilder: (context, index) {
// //                       final land = unverifiedLands[index];
// //                       return Card(
// //                         margin: const EdgeInsets.only(bottom: 12),
// //                         elevation: 3,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                         child: InkWell(
// //                           onTap: () => _showLandDetails(land),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(16),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 // Land ID and Status
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     Text(
// //                                       "Land ID: ${land['id'] ?? land['land_id'] ?? "N/A"}",
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 16,
// //                                       ),
// //                                     ),
// //                                     Container(
// //                                       padding: EdgeInsets.symmetric(
// //                                         horizontal: 10,
// //                                         vertical: 4,
// //                                       ),
// //                                       decoration: BoxDecoration(
// //                                         color: Colors.orange.shade50,
// //                                         borderRadius: BorderRadius.circular(20),
// //                                         border: Border.all(
// //                                           color: Colors.orange.shade200,
// //                                         ),
// //                                       ),
// //                                       child: Text(
// //                                         "PENDING",
// //                                         style: TextStyle(
// //                                           color: Colors.orange.shade800,
// //                                           fontSize: 11,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),

// //                                 SizedBox(height: 12),

// //                                 // Farmer Name
// //                                 // Row(
// //                                 //   children: [
// //                                 //     Icon(
// //                                 //       Icons.person_outline,
// //                                 //       size: 16,
// //                                 //       color: Colors.grey,
// //                                 //     ),
// //                                 //     SizedBox(width: 8),
// //                                 //     Text(
// //                                 //       land['farmer_name'] ??
// //                                 //           land['farmer_name'] ??
// //                                 //           "Unknowns",
// //                                 //       style: TextStyle(fontSize: 15),
// //                                 //     ),
// //                                 //   ],
// //                                 // ),
// //                                 Row(
// //                                   children: [
// //                                     Icon(
// //                                       Icons.person_outline,
// //                                       size: 16,
// //                                       color: Colors.grey,
// //                                     ),
// //                                     SizedBox(width: 8),
// //                                     Expanded(
// //                                       child: Text(
// //                                         (land['farmer_details']
// //                                                     as Map<
// //                                                       String,
// //                                                       dynamic
// //                                                     >)?['name']
// //                                                 ?.toString() ??
// //                                             "Unknown Farmer",
// //                                         style: TextStyle(fontSize: 15),
// //                                         overflow: TextOverflow.ellipsis,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),

// //                                 SizedBox(height: 8),

// //                                 // Village
// //                                 Row(
// //                                   children: [
// //                                     Icon(
// //                                       Icons.location_on_outlined,
// //                                       size: 16,
// //                                       color: Colors.grey,
// //                                     ),
// //                                     SizedBox(width: 8),
// //                                     Expanded(
// //                                       child: Text(
// //                                         (land['land_location']
// //                                                     as Map<
// //                                                       String,
// //                                                       dynamic
// //                                                     >)?['village']
// //                                                 ?.toString() ??
// //                                             "Unknown Village",
// //                                         style: TextStyle(fontSize: 15),
// //                                         overflow: TextOverflow.ellipsis,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),

// //                                 SizedBox(height: 8),

// //                                 // Land Area and Price
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     Row(
// //                                       children: [
// //                                         Icon(
// //                                           Icons.square_foot_outlined,
// //                                           size: 16,
// //                                           color: Colors.grey,
// //                                         ),
// //                                         SizedBox(width: 8),
// //                                         Text(
// //                                           "${(land['land_details'] as Map<String, dynamic>)?['land_area']?.toString() ?? "0"} Acres",
// //                                           style: TextStyle(
// //                                             fontSize: 14,
// //                                             color: Colors.grey.shade700,
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                     Container(
// //                                       padding: EdgeInsets.symmetric(
// //                                         horizontal: 12,
// //                                         vertical: 4,
// //                                       ),
// //                                       decoration: BoxDecoration(
// //                                         color: Colors.green.shade50,
// //                                         borderRadius: BorderRadius.circular(6),
// //                                       ),
// //                                       child: Text(
// //                                         "₹${land['total_land_price'] ?? land['price'] ?? "0"}",
// //                                         style: TextStyle(
// //                                           fontSize: 14,
// //                                           fontWeight: FontWeight.bold,
// //                                           color: Colors.green.shade800,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),

// //                                 SizedBox(height: 16),

// //                                 // Action Buttons
// //                                 Row(
// //                                   children: [
// //                                     Expanded(
// //                                       child: OutlinedButton.icon(
// //                                         onPressed: () => _showLandDetails(land),
// //                                         icon: Icon(
// //                                           Icons.remove_red_eye_outlined,
// //                                           size: 18,
// //                                         ),
// //                                         label: Text("View"),
// //                                         style: OutlinedButton.styleFrom(
// //                                           foregroundColor: Colors.blue,
// //                                           side: BorderSide(color: Colors.blue),
// //                                           padding: EdgeInsets.symmetric(
// //                                             vertical: 10,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 10),
// //                                     Expanded(
// //                                       child: ElevatedButton.icon(
// //                                         onPressed: () => _verifyLand(
// //                                           land['id']?.toString() ??
// //                                               land['land_id']?.toString() ??
// //                                               "",
// //                                         ),
// //                                         icon: Icon(
// //                                           Icons.check_circle_outline,
// //                                           size: 18,
// //                                         ),
// //                                         label: Text("Verify"),
// //                                         style: ElevatedButton.styleFrom(
// //                                           backgroundColor: Colors.green,
// //                                           foregroundColor: Colors.white,
// //                                           padding: EdgeInsets.symmetric(
// //                                             vertical: 10,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 10),
// //                                     Expanded(
// //                                       child: OutlinedButton.icon(
// //                                         onPressed: () => _showRejectDialog(
// //                                           land['id']?.toString() ??
// //                                               land['land_id']?.toString() ??
// //                                               "",
// //                                           land['farmer_name'] ??
// //                                               land['name'] ??
// //                                               "Unknown",
// //                                         ),
// //                                         icon: Icon(
// //                                           Icons.close_outlined,
// //                                           size: 18,
// //                                         ),
// //                                         label: Text("Reject"),
// //                                         style: OutlinedButton.styleFrom(
// //                                           foregroundColor: Colors.red,
// //                                           side: BorderSide(color: Colors.red),
// //                                           padding: EdgeInsets.symmetric(
// //                                             vertical: 10,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // ========== NEW LAND FORM (YOUR EXISTING CODE - SAME) ==========
// // class NewLandForm extends StatefulWidget {
// //   const NewLandForm({super.key});

// //   @override
// //   State<NewLandForm> createState() => _NewLandFormState();
// // }

// // class _NewLandFormState extends State<NewLandForm> {
// //   String? _apiToken;
// //   bool isDraft = false;
// //   int? selectedGuntas;

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadToken();
// //     _fetchStates();
// //   }

// //   Future<void> loadToken() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     _apiToken = prefs.getString("auth_token");
// //   }

// //   // Basic state fields
// //   bool isWhatsApp = false;
// //   String? selectedState;
// //   String? selectedDistrict;
// //   String? selectedMandal;
// //   String? selectedVillage;
// //   String? selectedLiteracy;
// //   String? selectedAgeGroup;
// //   String? selectedNature;
// //   String? selectedOwnership;
// //   String? selectedMortgage;
// //   String? selectedDisputeType;
// //   String? selectedSibling;
// //   String? selectedPath;
// //   String? selectedLandType;
// //   String? selectedResidential;
// //   String? selectedFencing;

// //   // MULTIPLE SELECTION FIELDS
// //   List<String> selectedWaterSources = [];
// //   List<String> selectedGardens = [];
// //   List<String> selectedSheds = [];
// //   List<String> selectedFarmPonds = [];

// //   // API से लोड किए गए डेटा
// //   List<String> statesList = [];
// //   List<String> districtsList = [];
// //   List<String> mandalsList = [];
// //   List<String> villagesList = [];

// //   // Controllers
// //   final TextEditingController villageController = TextEditingController();
// //   final TextEditingController mandalController = TextEditingController();
// //   final TextEditingController latitudeController = TextEditingController();
// //   final TextEditingController longitudeController = TextEditingController();
// //   final TextEditingController farmerNameController = TextEditingController();
// //   final TextEditingController phoneController = TextEditingController();
// //   final TextEditingController otherWhatsappController = TextEditingController();
// //   final TextEditingController landAreaController = TextEditingController();
// //   final TextEditingController guntasController = TextEditingController();
// //   final TextEditingController pricePerAcreController = TextEditingController();
// //   final TextEditingController totalLandPriceController =
// //       TextEditingController();
// //   final TextEditingController locationController = TextEditingController();
// //   final TextEditingController shedDetailsController = TextEditingController();

// //   // Media & others
// //   File? passbookImage;
// //   List<File> mediaFiles = [];

// //   bool loadingGPS = false;
// //   bool submitting = false;
// //   bool loadingStates = false;
// //   bool loadingDistricts = false;
// //   bool loadingMandals = false;
// //   bool loadingVillages = false;
// //   final ImagePicker _picker = ImagePicker();

// //   final String baseUrl = "http://72.61.169.226";

// //   @override
// //   void dispose() {
// //     villageController.dispose();
// //     mandalController.dispose();
// //     latitudeController.dispose();
// //     longitudeController.dispose();
// //     farmerNameController.dispose();
// //     phoneController.dispose();
// //     otherWhatsappController.dispose();
// //     landAreaController.dispose();
// //     guntasController.dispose();
// //     pricePerAcreController.dispose();
// //     totalLandPriceController.dispose();
// //     locationController.dispose();
// //     shedDetailsController.dispose();
// //     super.dispose();
// //   }

// //   // ====================== API CALLS ======================
// //   Future<void> _fetchStates() async {
// //     setState(() => loadingStates = true);
// //     try {
// //       final response = await http.get(Uri.parse('$baseUrl/location/states'));
// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         if (data is Map && data.containsKey('data')) {
// //           final List<dynamic> stateData = data['data'];
// //           setState(() {
// //             statesList = stateData
// //                 .map<String>((state) => state['name']?.toString() ?? '')
// //                 .where((name) => name.isNotEmpty)
// //                 .toList();
// //           });
// //         } else if (data is List) {
// //           setState(() {
// //             statesList = data
// //                 .map<String>((state) => state['name']?.toString() ?? '')
// //                 .where((name) => name.isNotEmpty)
// //                 .toList();
// //           });
// //         }
// //       }
// //     } catch (e) {
// //       print("Error fetching states: $e");
// //     } finally {
// //       setState(() => loadingStates = false);
// //     }
// //   }

// //   Future<void> _fetchDistricts(String stateName) async {
// //     setState(() {
// //       loadingDistricts = true;
// //       districtsList.clear();
// //       selectedDistrict = null;
// //       mandalsList.clear();
// //       selectedMandal = null;
// //       villagesList.clear();
// //       selectedVillage = null;
// //     });

// //     try {
// //       final statesResponse = await http.get(
// //         Uri.parse('$baseUrl/location/states'),
// //       );
// //       if (statesResponse.statusCode == 200) {
// //         final statesData = jsonDecode(statesResponse.body);
// //         List<dynamic> statesListData = [];
// //         if (statesData is Map && statesData.containsKey('data')) {
// //           statesListData = statesData['data'];
// //         } else if (statesData is List) {
// //           statesListData = statesData;
// //         }

// //         final state = statesListData.firstWhere(
// //           (s) => s['name'] == stateName,
// //           orElse: () => {'id': 1},
// //         );

// //         final stateId = state['id'];
// //         final response = await http.get(
// //           Uri.parse('$baseUrl/location/states/$stateId/districts'),
// //         );

// //         if (response.statusCode == 200) {
// //           final data = jsonDecode(response.body);
// //           if (data is Map && data.containsKey('data')) {
// //             final List<dynamic> districtData = data['data'];
// //             setState(() {
// //               districtsList = districtData
// //                   .map<String>((district) => district['name']?.toString() ?? '')
// //                   .where((name) => name.isNotEmpty)
// //                   .toList();
// //             });
// //           } else if (data is List) {
// //             setState(() {
// //               districtsList = data
// //                   .map<String>((district) => district['name']?.toString() ?? '')
// //                   .where((name) => name.isNotEmpty)
// //                   .toList();
// //             });
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       print("Error fetching districts: $e");
// //     } finally {
// //       setState(() => loadingDistricts = false);
// //     }
// //   }

// //   Future<void> _fetchMandals(String districtName) async {
// //     setState(() {
// //       loadingMandals = true;
// //       mandalsList.clear();
// //       selectedMandal = null;
// //       villagesList.clear();
// //       selectedVillage = null;
// //     });

// //     try {
// //       if (selectedState == null) return;
// //       final statesResponse = await http.get(
// //         Uri.parse('$baseUrl/location/states'),
// //       );
// //       if (statesResponse.statusCode == 200) {
// //         final statesData = jsonDecode(statesResponse.body);
// //         List<dynamic> statesListData = [];
// //         if (statesData is Map && statesData.containsKey('data')) {
// //           statesListData = statesData['data'];
// //         } else if (statesData is List) {
// //           statesListData = statesData;
// //         }

// //         final state = statesListData.firstWhere(
// //           (s) => s['name'] == selectedState,
// //           orElse: () => {'id': 1},
// //         );

// //         final stateId = state['id'];
// //         final districtsResponse = await http.get(
// //           Uri.parse('$baseUrl/location/states/$stateId/districts'),
// //         );

// //         if (districtsResponse.statusCode == 200) {
// //           final districtsData = jsonDecode(districtsResponse.body);
// //           List<dynamic> districtsListData = [];
// //           if (districtsData is Map && districtsData.containsKey('data')) {
// //             districtsListData = districtsData['data'];
// //           } else if (districtsData is List) {
// //             districtsListData = districtsData;
// //           }

// //           final district = districtsListData.firstWhere(
// //             (d) => d['name'] == districtName,
// //             orElse: () => {'id': 1},
// //           );

// //           final districtId = district['id'];
// //           final response = await http.get(
// //             Uri.parse('$baseUrl/location/districts/$districtId/mandals'),
// //           );

// //           if (response.statusCode == 200) {
// //             final data = jsonDecode(response.body);
// //             if (data is Map && data.containsKey('data')) {
// //               final List<dynamic> mandalData = data['data'];
// //               setState(() {
// //                 mandalsList = mandalData
// //                     .map<String>((mandal) => mandal['name']?.toString() ?? '')
// //                     .where((name) => name.isNotEmpty)
// //                     .toList();
// //               });
// //             } else if (data is List) {
// //               setState(() {
// //                 mandalsList = data
// //                     .map<String>((mandal) => mandal['name']?.toString() ?? '')
// //                     .where((name) => name.isNotEmpty)
// //                     .toList();
// //               });
// //             }
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       print("Error fetching mandals: $e");
// //     } finally {
// //       setState(() => loadingMandals = false);
// //     }
// //   }

// //   Future<void> _fetchVillages(String mandalName) async {
// //     setState(() {
// //       loadingVillages = true;
// //       villagesList.clear();
// //       selectedVillage = null;
// //     });

// //     try {
// //       if (selectedState == null || selectedDistrict == null) return;

// //       final statesResponse = await http.get(
// //         Uri.parse('$baseUrl/location/states'),
// //       );
// //       if (statesResponse.statusCode == 200) {
// //         final statesData = jsonDecode(statesResponse.body);
// //         List<dynamic> statesListData = [];
// //         if (statesData is Map && statesData.containsKey('data')) {
// //           statesListData = statesData['data'];
// //         } else if (statesData is List) {
// //           statesListData = statesData;
// //         }

// //         final state = statesListData.firstWhere(
// //           (s) => s['name'] == selectedState,
// //           orElse: () => {'id': 1},
// //         );

// //         final stateId = state['id'];
// //         final districtsResponse = await http.get(
// //           Uri.parse('$baseUrl/location/states/$stateId/districts'),
// //         );

// //         if (districtsResponse.statusCode == 200) {
// //           final districtsData = jsonDecode(districtsResponse.body);
// //           List<dynamic> districtsListData = [];
// //           if (districtsData is Map && districtsData.containsKey('data')) {
// //             districtsListData = districtsData['data'];
// //           } else if (districtsData is List) {
// //             districtsListData = districtsData;
// //           }

// //           final district = districtsListData.firstWhere(
// //             (d) => d['name'] == selectedDistrict,
// //             orElse: () => {'id': 1},
// //           );

// //           final districtId = district['id'];
// //           final mandalsResponse = await http.get(
// //             Uri.parse('$baseUrl/location/districts/$districtId/mandals'),
// //           );

// //           if (mandalsResponse.statusCode == 200) {
// //             final mandalsData = jsonDecode(mandalsResponse.body);
// //             List<dynamic> mandalsListData = [];
// //             if (mandalsData is Map && mandalsData.containsKey('data')) {
// //               mandalsListData = mandalsData['data'];
// //             } else if (mandalsData is List) {
// //               mandalsListData = mandalsData;
// //             }

// //             final mandal = mandalsListData.firstWhere(
// //               (m) => m['name'] == mandalName,
// //               orElse: () => {'id': 1},
// //             );

// //             final mandalId = mandal['id'];
// //             final response = await http.get(
// //               Uri.parse('$baseUrl/location/mandals/$mandalId/villages'),
// //             );

// //             if (response.statusCode == 200) {
// //               final data = jsonDecode(response.body);
// //               if (data is Map && data.containsKey('data')) {
// //                 final List<dynamic> villageData = data['data'];
// //                 setState(() {
// //                   villagesList = villageData
// //                       .map<String>(
// //                         (village) => village['name']?.toString() ?? '',
// //                       )
// //                       .where((name) => name.isNotEmpty)
// //                       .toList();
// //                 });
// //               } else if (data is List) {
// //                 setState(() {
// //                   villagesList = data
// //                       .map<String>(
// //                         (village) => village['name']?.toString() ?? '',
// //                       )
// //                       .where((name) => name.isNotEmpty)
// //                       .toList();
// //                 });
// //               }
// //             }
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       print("Error fetching villages: $e");
// //     } finally {
// //       setState(() => loadingVillages = false);
// //     }
// //   }

// //   void _resetForm() {
// //     setState(() {
// //       isWhatsApp = false;
// //       selectedState = null;
// //       selectedDistrict = null;
// //       selectedMandal = null;
// //       selectedVillage = null;
// //       selectedLiteracy = null;
// //       selectedAgeGroup = null;
// //       selectedNature = null;
// //       selectedOwnership = null;
// //       selectedMortgage = null;
// //       selectedDisputeType = null;
// //       selectedSibling = null;
// //       selectedPath = null;
// //       selectedLandType = null;
// //       selectedResidential = null;
// //       selectedFencing = null;
// //       selectedWaterSources.clear();
// //       selectedGardens.clear();
// //       selectedSheds.clear();
// //       selectedFarmPonds.clear();
// //       villageController.clear();
// //       mandalController.clear();
// //       latitudeController.clear();
// //       longitudeController.clear();
// //       farmerNameController.clear();
// //       phoneController.clear();
// //       otherWhatsappController.clear();
// //       landAreaController.clear();
// //       guntasController.clear();
// //       pricePerAcreController.clear();
// //       totalLandPriceController.clear();
// //       locationController.clear();
// //       shedDetailsController.clear();
// //       passbookImage = null;
// //       mediaFiles.clear();
// //       isDraft = false;
// //       districtsList.clear();
// //       mandalsList.clear();
// //       villagesList.clear();
// //     });
// //   }

// //   void _toggleWaterSource(String source) {
// //     setState(() {
// //       if (selectedWaterSources.contains(source)) {
// //         selectedWaterSources.remove(source);
// //       } else {
// //         selectedWaterSources.add(source);
// //       }
// //     });
// //   }

// //   void _toggleGarden(String garden) {
// //     setState(() {
// //       if (selectedGardens.contains(garden)) {
// //         selectedGardens.remove(garden);
// //       } else {
// //         selectedGardens.add(garden);
// //       }
// //     });
// //   }

// //   void _toggleShed(String shed) {
// //     setState(() {
// //       if (selectedSheds.contains(shed)) {
// //         selectedSheds.remove(shed);
// //       } else {
// //         selectedSheds.add(shed);
// //       }
// //     });
// //   }

// //   void _toggleFarmPond(String pond) {
// //     setState(() {
// //       selectedFarmPonds.clear();
// //       selectedFarmPonds.add(pond);
// //     });
// //   }

// //   Future<bool> _ensureLocationPermission() async {
// //     LocationPermission p = await Geolocator.checkPermission();
// //     if (p == LocationPermission.denied) {
// //       p = await Geolocator.requestPermission();
// //     }
// //     if (p == LocationPermission.deniedForever ||
// //         p == LocationPermission.denied) {
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

// //       final placemarks = await placemarkFromCoordinates(
// //         pos.latitude,
// //         pos.longitude,
// //       );
// //       if (placemarks.isNotEmpty) {
// //         final p = placemarks.first;
// //         final mandal =
// //             (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
// //             (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null);

// //         if (mandal != null) {
// //           if (!mandalsList.contains(mandal)) {
// //             setState(() => mandalsList.add(mandal));
// //           }
// //           selectedMandal = mandal;
// //           mandalController.text = mandal;
// //         }

// //         final village =
// //             (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null) ??
// //             (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
// //             (p.name?.trim().isNotEmpty == true ? p.name : null);

// //         if (village != null) {
// //           if (!villagesList.contains(village)) {
// //             setState(() => villagesList.add(village));
// //           }
// //           selectedVillage = village;
// //           villageController.text = village;
// //         }

// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('GPS captured — Mandal & Village filled'),
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       debugPrint("fetchVillageGPS error: $e");
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Failed to get location: $e')));
// //     } finally {
// //       setState(() => loadingGPS = false);
// //     }
// //   }

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
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Failed to capture location: $e')));
// //     }
// //   }

// //   Future<void> pickPassbookImage() async {
// //     final statusCamera = await Permission.camera.request();
// //     final statusStorage = await Permission.photos.request();
// //     if (!statusCamera.isGranted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Camera permission required')),
// //       );
// //       return;
// //     }

// //     final picked = await showModalBottomSheet<XFile?>(
// //       context: context,
// //       builder: (_) => SafeArea(
// //         child: Wrap(
// //           children: [
// //             ListTile(
// //               leading: const Icon(Icons.camera_alt),
// //               title: const Text('Camera'),
// //               onTap: () async {
// //                 Navigator.pop(
// //                   context,
// //                   await _picker.pickImage(source: ImageSource.camera),
// //                 );
// //               },
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.photo),
// //               title: const Text('Gallery'),
// //               onTap: () async {
// //                 Navigator.pop(
// //                   context,
// //                   await _picker.pickImage(source: ImageSource.gallery),
// //                 );
// //               },
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.close),
// //               title: const Text('Cancel'),
// //               onTap: () => Navigator.pop(context, null),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );

// //     if (picked != null) {
// //       setState(() => passbookImage = File(picked.path));
// //     }
// //   }

// //   Future<void> pickMediaAndDocs() async {
// //     await Permission.storage.request();
// //     await Permission.photos.request();

// //     final result = await FilePicker.platform.pickFiles(
// //       allowMultiple: true,
// //       type: FileType.any,
// //     );
// //     if (result != null && result.paths.isNotEmpty) {
// //       setState(() {
// //         mediaFiles.addAll(
// //           result.paths.where((p) => p != null).map((p) => File(p!)),
// //         );
// //       });
// //     }
// //   }

// //   Future<void> submitNewLand() async {
// //     if ((selectedVillage == null || selectedVillage!.isEmpty) ||
// //         latitudeController.text.isEmpty ||
// //         longitudeController.text.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text(
// //             'Please select village and capture GPS/location before submit',
// //           ),
// //         ),
// //       );
// //       return;
// //     }

// //     setState(() => submitting = true);
// //     try {
// //       final uri = Uri.parse("$baseUrl/field-executive/land");
// //       final request = http.MultipartRequest('POST', uri);

// //       if (_apiToken == null) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Token not found. Please login again.")),
// //         );
// //         setState(() => submitting = false);
// //         return;
// //       }

// //       request.headers['Authorization'] = 'Bearer $_apiToken';
// //       request.fields['state'] = selectedState ?? '';
// //       request.fields['district'] = selectedDistrict ?? '';
// //       request.fields['mandal'] = selectedMandal ?? '';
// //       request.fields['village'] = selectedVillage ?? '';
// //       request.fields['location'] = locationController.text;
// //       request.fields['name'] = farmerNameController.text;
// //       request.fields['phone'] = phoneController.text;
// //       request.fields['whatsapp_number'] = otherWhatsappController.text;
// //       request.fields['literacy'] = selectedLiteracy ?? '';
// //       request.fields['age_group'] = selectedAgeGroup ?? '';
// //       request.fields['nature'] = selectedNature ?? '';
// //       request.fields['land_ownership'] = selectedOwnership ?? '';
// //       request.fields['mortgage'] = selectedMortgage ?? '';
// //       request.fields['land_area'] = landAreaController.text;
// //       request.fields['guntas'] = guntasController.text;
// //       request.fields['price_per_acre'] = pricePerAcreController.text;
// //       request.fields['total_land_price'] = totalLandPriceController.text;
// //       request.fields['land_type'] = selectedLandType ?? '';
// //       request.fields['water_source'] = selectedWaterSources.join(',');
// //       request.fields['garden'] = selectedGardens.join(',');
// //       request.fields['shed'] = selectedSheds.join(',');
// //       request.fields['farm_pond'] = selectedFarmPonds.join(',');
// //       request.fields['shed_details'] = shedDetailsController.text;
// //       request.fields['residental'] = selectedResidential ?? '';
// //       request.fields['fencing'] = selectedFencing ?? '';
// //       request.fields['road_path'] = selectedPath ?? '';
// //       request.fields['land_location_gps'] =
// //           "${latitudeController.text},${longitudeController.text}";
// //       request.fields['dispute_type'] = selectedDisputeType ?? '';
// //       request.fields['siblings_involve_in_dispute'] = selectedSibling ?? '';
// //       request.fields['path_to_land'] = selectedPath ?? '';
// //       request.fields['latitude'] = latitudeController.text;
// //       request.fields['longitude'] = longitudeController.text;
// //       request.fields['status'] = isDraft ? 'false' : 'true';

// //       if (passbookImage != null && await passbookImage!.exists()) {
// //         final passbookStream = http.ByteStream(passbookImage!.openRead());
// //         final passbookLength = await passbookImage!.length();
// //         request.files.add(
// //           http.MultipartFile(
// //             'passbook_photo',
// //             passbookStream,
// //             passbookLength,
// //             filename: passbookImage!.path.split('/').last,
// //           ),
// //         );
// //       }

// //       final streamed = await request.send();
// //       final respStr = await streamed.stream.bytesToString();

// //       if (streamed.statusCode == 200 || streamed.statusCode == 201) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text(
// //               isDraft
// //                   ? 'Land saved as draft successfully'
// //                   : 'Land submitted successfully',
// //             ),
// //           ),
// //         );
// //         _resetForm();
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Submission failed: ${streamed.statusCode}')),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Submission error: $e')));
// //     } finally {
// //       setState(() => submitting = false);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "New Land Details",
// //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 20),
// //           _buildAddressSection(),
// //           const SizedBox(height: 40),
// //           _buildFarmerDetails(),
// //           const SizedBox(height: 40),
// //           _buildDisputeSection(),
// //           const SizedBox(height: 40),
// //           _buildLandDetailsSection(),
// //           const SizedBox(height: 40),
// //           _buildGpsSection(),
// //           const SizedBox(height: 40),
// //           _buildDocumentsSection(),
// //           const SizedBox(height: 30),
// //           _buildSubmitButtons(),
// //           const SizedBox(height: 30),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildAddressSection() => _sectionContainer(
// //     title: "Village Address",
// //     children: [
// //       Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "State",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 8),
// //           Container(
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(15),
// //               border: Border.all(color: Colors.grey.shade300),
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 12),
// //               child: DropdownButton<String>(
// //                 value: selectedState,
// //                 isExpanded: true,
// //                 underline: const SizedBox(),
// //                 hint: const Text("Select State"),
// //                 icon: loadingStates
// //                     ? const CircularProgressIndicator(strokeWidth: 2)
// //                     : const Icon(Icons.arrow_drop_down),
// //                 items: statesList.map((String state) {
// //                   return DropdownMenuItem<String>(
// //                     value: state,
// //                     child: Text(state),
// //                   );
// //                 }).toList(),
// //                 onChanged: (String? newValue) {
// //                   if (newValue != null) {
// //                     setState(() {
// //                       selectedState = newValue;
// //                       selectedDistrict = null;
// //                       selectedMandal = null;
// //                       selectedVillage = null;
// //                       districtsList.clear();
// //                       mandalsList.clear();
// //                       villagesList.clear();
// //                     });
// //                     _fetchDistricts(newValue);
// //                   }
// //                 },
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
// //       Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "District",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 8),
// //           Container(
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(15),
// //               border: Border.all(color: Colors.grey.shade300),
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 12),
// //               child: DropdownButton<String>(
// //                 value: selectedDistrict,
// //                 isExpanded: true,
// //                 underline: const SizedBox(),
// //                 hint: const Text("Select District"),
// //                 icon: loadingDistricts
// //                     ? const CircularProgressIndicator(strokeWidth: 2)
// //                     : const Icon(Icons.arrow_drop_down),
// //                 items: districtsList.map((String district) {
// //                   return DropdownMenuItem<String>(
// //                     value: district,
// //                     child: Text(district),
// //                   );
// //                 }).toList(),
// //                 onChanged: (String? newValue) {
// //                   if (newValue != null) {
// //                     setState(() {
// //                       selectedDistrict = newValue;
// //                       selectedMandal = null;
// //                       selectedVillage = null;
// //                       mandalsList.clear();
// //                       villagesList.clear();
// //                     });
// //                     _fetchMandals(newValue);
// //                   }
// //                 },
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
// //       Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Mandal",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 8),
// //           Container(
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(15),
// //               border: Border.all(color: Colors.grey.shade300),
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 12),
// //               child: DropdownButton<String>(
// //                 value: selectedMandal,
// //                 isExpanded: true,
// //                 underline: const SizedBox(),
// //                 hint: const Text("Select Mandal"),
// //                 icon: loadingMandals
// //                     ? const CircularProgressIndicator(strokeWidth: 2)
// //                     : const Icon(Icons.arrow_drop_down),
// //                 items: mandalsList.map((String mandal) {
// //                   return DropdownMenuItem<String>(
// //                     value: mandal,
// //                     child: Text(mandal),
// //                   );
// //                 }).toList(),
// //                 onChanged: (String? newValue) {
// //                   if (newValue != null) {
// //                     setState(() {
// //                       selectedMandal = newValue;
// //                       selectedVillage = null;
// //                       villagesList.clear();
// //                     });
// //                     _fetchVillages(newValue);
// //                   }
// //                 },
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
// //       Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Village",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 8),
// //           Container(
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(15),
// //               border: Border.all(color: Colors.grey.shade300),
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 12),
// //               child: DropdownButton<String>(
// //                 value: selectedVillage,
// //                 isExpanded: true,
// //                 underline: const SizedBox(),
// //                 hint: const Text("Select Village"),
// //                 icon: loadingVillages
// //                     ? const CircularProgressIndicator(strokeWidth: 2)
// //                     : const Icon(Icons.arrow_drop_down),
// //                 items: villagesList.map((String village) {
// //                   return DropdownMenuItem<String>(
// //                     value: village,
// //                     child: Text(village),
// //                   );
// //                 }).toList(),
// //                 onChanged: (String? newValue) {
// //                   setState(() => selectedVillage = newValue);
// //                 },
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
// //       SizedBox(
// //         width: double.infinity,
// //         child: ElevatedButton.icon(
// //           onPressed: loadingGPS ? null : fetchVillageGPSAndAddress,
// //           icon: const Icon(Icons.gps_fixed, color: Colors.black87),
// //           label: Text(loadingGPS ? 'Capturing...' : 'Capture GPS location'),
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: Colors.white,
// //             padding: const EdgeInsets.symmetric(vertical: 16),
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //           ),
// //         ),
// //       ),
// //     ],
// //   );

// //   Widget _buildFarmerDetails() => _sectionContainer(
// //     title: "Farmer Details",
// //     children: [
// //       _labeledInputController(
// //         "Farmer Name",
// //         "Enter Farmer's name",
// //         Icons.person_outline,
// //         farmerNameController,
// //       ),
// //       const SizedBox(height: 20),
// //       Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Phone Number",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 8),
// //           TextFormField(
// //             controller: phoneController,
// //             keyboardType: TextInputType.phone,
// //             maxLength: 10,
// //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //             decoration: InputDecoration(
// //               hintText: "Enter phone number",
// //               prefixIcon: const Icon(Icons.phone_outlined),
// //               counterText: "",
// //               filled: true,
// //               fillColor: Colors.white,
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
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
// //       Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Other WhatsApp Number",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 8),
// //           TextFormField(
// //             controller: otherWhatsappController,
// //             keyboardType: TextInputType.phone,
// //             maxLength: 10,
// //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //             decoration: InputDecoration(
// //               hintText: "Enter other WhatsApp number",
// //               prefixIcon: const Icon(Icons.wechat),
// //               counterText: "",
// //               filled: true,
// //               fillColor: Colors.white,
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 25),
// //       _labelWithIcon("Literacy", Icons.menu_book_outlined),
// //       _optionGroup(
// //         ["High School", "Illiterate", "Literate", "Graduate"],
// //         selectedLiteracy,
// //         (val) => setState(() => selectedLiteracy = val),
// //       ),
// //       _labelWithIcon("Age Group", Icons.person_outlined),
// //       _optionGroup(
// //         ["Upto 30", "30-50", "50+"],
// //         selectedAgeGroup,
// //         (val) => setState(() => selectedAgeGroup = val),
// //       ),
// //       _labelWithIcon("Nature", Icons.accessibility_new_outlined),
// //       _optionGroup(
// //         ["Calm", "Polite", "Medium", "Rude"],
// //         selectedNature,
// //         (val) => setState(() => selectedNature = val),
// //       ),
// //       _labelWithIcon("Land Ownership", Icons.percent_outlined),
// //       _optionGroup(
// //         ["Own", "Joint", "Single"],
// //         selectedOwnership,
// //         (val) => setState(() => selectedOwnership = val),
// //       ),
// //       _labelWithIcon("Ready for Mortgage", Icons.thumb_up_alt_outlined),
// //       _optionGroup(
// //         ["Yes", "No"],
// //         selectedMortgage,
// //         (val) => setState(() => selectedMortgage = val),
// //       ),
// //     ],
// //   );

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
// //           "None",
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
// //         ["Easy Access", "No Path to Land"],
// //         selectedPath,
// //         (val) => setState(() => selectedPath = val),
// //       ),
// //     ],
// //   );

// //   Widget _buildLandDetailsSection() => _sectionContainer(
// //     title: "Land Details",
// //     children: [
// //       Row(
// //         children: [
// //           Expanded(
// //             flex: 2,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text(
// //                   "Land Area (Acres)",
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 TextFormField(
// //                   controller: landAreaController,
// //                   keyboardType: TextInputType.numberWithOptions(decimal: true),
// //                   inputFormatters: [
// //                     FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
// //                   ],
// //                   decoration: InputDecoration(
// //                     hintText: "e.g. 3.5",
// //                     prefixIcon: const Icon(Icons.square_foot_outlined),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(15),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           const SizedBox(width: 15),
// //           Expanded(
// //             flex: 2,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text(
// //                   "Guntas",
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 DropdownButtonFormField<int>(
// //                   isExpanded: true,
// //                   value: selectedGuntas,
// //                   decoration: InputDecoration(
// //                     hintText: "Select",
// //                     prefixIcon: const Icon(Icons.straighten_outlined),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(15),
// //                     ),
// //                   ),
// //                   items: List.generate(
// //                     39,
// //                     (index) => DropdownMenuItem(
// //                       value: index + 1,
// //                       child: Text((index + 1).toString()),
// //                     ),
// //                   ),
// //                   onChanged: (value) => setState(() => selectedGuntas = value),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
// //       Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Price per Acre (in Lakhs)",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 8),
// //           TextFormField(
// //             controller: pricePerAcreController,
// //             keyboardType: TextInputType.number,
// //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //             decoration: InputDecoration(
// //               hintText: "e.g. 4500000",
// //               prefixIcon: const Icon(Icons.currency_rupee_outlined),
// //               filled: true,
// //               fillColor: Colors.white,
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
// //       Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Total Land Value",
// //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //           ),
// //           const SizedBox(height: 8),
// //           TextFormField(
// //             controller: totalLandPriceController,
// //             keyboardType: TextInputType.number,
// //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //             decoration: InputDecoration(
// //               hintText: "Calculated Automatically",
// //               prefixIcon: const Icon(Icons.calculate_outlined),
// //               filled: true,
// //               fillColor: Colors.white,
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       const SizedBox(height: 20),
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
// //         ["agri", "Red", "Black", "Sandy"],
// //         selectedLandType,
// //         (val) => setState(() => selectedLandType = val),
// //       ),
// //       _labelWithIcon("Water Source ", Icons.water_drop_outlined),
// //       _buildMultipleSelectionChips(
// //         options: ["tubewell", "Canal", "Bores", "Cheruvu", "Rain Water"],
// //         selectedOptions: selectedWaterSources,
// //         onToggle: _toggleWaterSource,
// //       ),
// //       _labelWithIcon("Garden ", Icons.park_outlined),
// //       _buildMultipleSelectionChips(
// //         options: ["Mango", "Guava", "Coconut", "Sapota", "Other"],
// //         selectedOptions: selectedGardens,
// //         onToggle: _toggleGarden,
// //       ),
// //       _labelWithIcon("Shed Details ", Icons.agriculture_outlined),
// //       _buildMultipleSelectionChips(
// //         options: ["Poultry", "Cow Shed"],
// //         selectedOptions: selectedSheds,
// //         onToggle: _toggleShed,
// //       ),
// //       _labelWithIcon("Farm Pond ", Icons.water_outlined),
// //       _buildMultipleSelectionChips(
// //         options: ["Yes", "No"],
// //         selectedOptions: selectedFarmPonds,
// //         onToggle: _toggleFarmPond,
// //       ),
// //       _labelWithIcon("Residential", Icons.home_work_outlined),
// //       _optionGroup(
// //         ["Yes", "Farm House", "RCC Home", "Asbestos Shelter", "Hut"],
// //         selectedResidential,
// //         (val) => setState(() => selectedResidential = val),
// //       ),
// //       _labelWithIcon("Fencing", Icons.fence_outlined),
// //       _optionGroup(
// //         ["Complete", "With Gate", "All Sides", "Partially", "No"],
// //         selectedFencing,
// //         (val) => setState(() => selectedFencing = val),
// //       ),
// //     ],
// //   );

// //   Widget _buildMultipleSelectionChips({
// //     required List<String> options,
// //     required List<String> selectedOptions,
// //     required Function(String) onToggle,
// //   }) {
// //     return Wrap(
// //       spacing: 10,
// //       runSpacing: 10,
// //       children: options.map((option) {
// //         final isSelected = selectedOptions.contains(option);
// //         return ChoiceChip(
// //           label: Text(option),
// //           selected: isSelected,
// //           onSelected: (selected) => onToggle(option),
// //           selectedColor: Colors.green.shade100,
// //           backgroundColor: Colors.white,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //             side: BorderSide(
// //               color: isSelected ? Colors.green : Colors.grey.shade300,
// //               width: isSelected ? 2 : 1,
// //             ),
// //           ),
// //           labelStyle: TextStyle(
// //             color: isSelected ? Colors.green.shade800 : Colors.black87,
// //             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }

// //   Widget _buildGpsSection() => _sectionContainer(
// //     title: "GPS & Path Tracking",
// //     children: [
// //       _labelWithIcon("Path from Main Road", Icons.alt_route_outlined),
// //       _optionGroup(
// //         ["Attached to Road", "No Connectivity", "Easy Access"],
// //         selectedPath,
// //         (val) => setState(() => selectedPath = val),
// //       ),
// //       const SizedBox(height: 20),
// //       _labelWithIcon(
// //         "Land Entry Point (Coordinates)",
// //         Icons.location_on_outlined,
// //       ),
// //       Row(
// //         children: [
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text(
// //                   "Latitude",
// //                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 TextFormField(
// //                   controller: latitudeController,
// //                   keyboardType: TextInputType.numberWithOptions(decimal: true),
// //                   inputFormatters: [
// //                     FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
// //                   ],
// //                   decoration: InputDecoration(
// //                     hintText: "e.g. 17.4502",
// //                     prefixIcon: const Icon(Icons.gps_fixed),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(15),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           const SizedBox(width: 15),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text(
// //                   "Longitude",
// //                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 TextFormField(
// //                   controller: longitudeController,
// //                   keyboardType: TextInputType.numberWithOptions(decimal: true),
// //                   inputFormatters: [
// //                     FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
// //                   ],
// //                   decoration: InputDecoration(
// //                     hintText: "e.g. 78.3654",
// //                     prefixIcon: const Icon(Icons.gps_fixed),
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(15),
// //                     ),
// //                   ),
// //                 ),
// //               ],
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
// //     ],
// //   );

// //   Widget _buildDocumentsSection() => _sectionContainer(
// //     title: "Documents & Media",
// //     children: [
// //       _labelWithIcon("Land Photos", Icons.photo_camera_outlined),
// //       ElevatedButton.icon(
// //         onPressed: () async {
// //           final picked = await _picker.pickMultiImage();
// //           if (picked != null && picked.isNotEmpty) {
// //             setState(() => mediaFiles.addAll(picked.map((e) => File(e.path))));
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
// //           if (picked != null) setState(() => mediaFiles.add(File(picked.path)));
// //         },
// //         icon: const Icon(Icons.videocam_outlined),
// //         label: const Text("Upload Videos"),
// //         style: _outlinedButtonStyle(),
// //       ),
// //       const SizedBox(height: 20),
// //       Wrap(
// //         spacing: 8,
// //         runSpacing: 8,
// //         children: mediaFiles.map((f) {
// //           final ext = f.path.split('.').last.toLowerCase();
// //           if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
// //             return Image.file(f, width: 90, height: 90, fit: BoxFit.cover);
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

// //   Widget _buildSubmitButtons() => Column(
// //     children: [
// //       ElevatedButton.icon(
// //         onPressed: () {
// //           isDraft = false;
// //           submitNewLand();
// //         },
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
// //           isDraft = true;
// //           submitNewLand();
// //         },
// //         icon: const Icon(Icons.save_alt_outlined),
// //         label: const Text("Save as Draft"),
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Colors.grey.shade600,
// //           foregroundColor: Colors.white,
// //           minimumSize: const Size.fromHeight(55),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //         ),
// //       ),
// //     ],
// //   );

// //   // ====================== REUSABLE UI HELPERS ======================
// //   Widget _sectionContainer({
// //     required String title,
// //     required List<Widget> children,
// //   }) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[100],
// //         borderRadius: BorderRadius.circular(15),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.2),
// //             blurRadius: 8,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
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
// //         .map(
// //           (text) => GestureDetector(
// //             onTap: () => onSelect(text),
// //             child: Container(
// //               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
// //               decoration: BoxDecoration(
// //                 color: selectedValue == text
// //                     ? Colors.green.shade100
// //                     : Colors.white,
// //                 borderRadius: BorderRadius.circular(12),
// //                 border: Border.all(
// //                   color: selectedValue == text
// //                       ? Colors.green
// //                       : Colors.grey.shade300,
// //                   width: selectedValue == text ? 2 : 1,
// //                 ),
// //               ),
// //               child: Text(
// //                 text,
// //                 style: TextStyle(
// //                   fontSize: 15,
// //                   fontWeight: FontWeight.w500,
// //                   color: selectedValue == text
// //                       ? Colors.green.shade800
// //                       : Colors.black,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         )
// //         .toList(),
// //   );

// //   ButtonStyle _outlinedButtonStyle() => ElevatedButton.styleFrom(
// //     backgroundColor: Colors.white,
// //     foregroundColor: Colors.black87,
// //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //     side: BorderSide(color: Colors.grey.shade300),
// //     minimumSize: const Size.fromHeight(50),
// //   );
// // }

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gadura_land/Screens/Regional/regionaldetails.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:gadura_land/Screens/FieldExecutive/edit_land_details.dart';
// import 'package:gadura_land/Screens/FieldExecutive/landmodel.dart';

// class Regionalverification extends StatefulWidget {
//   const Regionalverification({super.key});

//   @override
//   State<Regionalverification> createState() => _RegionalverificationState();
// }

// class _RegionalverificationState extends State<Regionalverification>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<dynamic> unverifiedLands = [];
//   bool isLoading = true;
//   String? _apiToken;
//   final String baseUrl = "http://72.61.169.226";
//   late Timer _autoRefreshTimer;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     loadToken();
//     _fetchUnverifiedLands();
//     // Auto refresh every 15 seconds
//     _autoRefreshTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
//       if (mounted && _tabController.index == 0 && !isLoading) {
//         _fetchUnverifiedLands();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _autoRefreshTimer.cancel();
//     super.dispose();
//   }

//   Future<void> loadToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _apiToken = prefs.getString("auth_token");
//   }

//   // ========== FETCH UNVERIFIED LANDS FROM API ==========
//   Future<void> _fetchUnverifiedLands() async {
//     if (_apiToken == null) {
//       await loadToken();
//       if (_apiToken == null) return;
//     }

//     setState(() => isLoading = true);
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/regional/land/unverified'),
//         headers: {'Authorization': 'Bearer $_apiToken'},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _processApiResponse(data);
//       } else {
//         print("Failed to fetch unverified lands: ${response.statusCode}");
//         setState(() {
//           unverifiedLands = [];
//         });
//       }
//     } catch (e) {
//       print("Error fetching unverified lands: $e");
//       setState(() {
//         unverifiedLands = [];
//       });
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   void _processApiResponse(dynamic data) {
//     if (data is Map && data.containsKey('data')) {
//       final apiData = data['data'];

//       // Agar data Map hai (key-value pairs)
//       if (apiData is Map) {
//         List<dynamic> landList = [];
//         apiData.forEach((key, value) {
//           if (value is Map) {
//             landList.add({'id': key.toString(), ...value});
//           }
//         });
//         setState(() {
//           unverifiedLands = landList;
//         });
//       }
//       // Agar data List hai
//       else if (apiData is List) {
//         setState(() {
//           unverifiedLands = apiData;
//         });
//       }
//     }
//     // Direct list response
//     else if (data is List) {
//       setState(() {
//         unverifiedLands = data;
//       });
//     }
//   }

//   // ========== VERIFY LAND ==========
//   // ========== VERIFY LAND ==========
//   Future<void> _verifyLand(String landId) async {
//     try {
//       // ✅ Create multipart request for PUT
//       final request = http.MultipartRequest(
//         'PUT',
//         Uri.parse('$baseUrl/regional/land/$landId'),
//       );

//       // Add authorization header
//       request.headers['Authorization'] = 'Bearer $_apiToken';

//       // Add verification status
//       request.fields['verification'] = 'verified';
//       request.fields['status'] = 'true';

//       // Send request
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('✅ Land $landId verified successfully'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 2),
//           ),
//         );

//         // List refresh करें
//         _fetchUnverifiedLands();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to verify land: ${response.statusCode}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   // ========== REJECT LAND ==========
//   Future<void> _rejectLand(String landId, String reason) async {
//     try {
//       // ✅ Create multipart request for PUT
//       final request = http.MultipartRequest(
//         'PUT',
//         Uri.parse('$baseUrl/regional/land/$landId'),
//       );

//       // Add authorization header
//       request.headers['Authorization'] = 'Bearer $_apiToken';

//       // Add rejection details
//       request.fields['verification'] = 'rejected';
//       request.fields['status'] = 'true';
//       request.fields['remarks'] = reason; // Rejection reason

//       // Send request
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         // ✅ Reject success - RegionalDetails (Review Again) पर navigate करें
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Land $landId rejected ❌'),
//             backgroundColor: Colors.orange,
//             duration: Duration(seconds: 2),
//           ),
//         );

//         // थोड़ी देर wait करें और फिर navigate करें
//         await Future.delayed(const Duration(milliseconds: 800));

//         if (mounted) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => RegionalDetails()),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to reject land: ${response.statusCode}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   // ========== SHOW REJECT DIALOG ==========
//   void _showRejectDialog(String landId, String farmerName) {
//     TextEditingController reasonController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Reject Land $landId"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Farmer: $farmerName"),
//             SizedBox(height: 8),
//             Text("Please provide reason for rejection:"),
//             SizedBox(height: 16),
//             TextField(
//               controller: reasonController,
//               decoration: InputDecoration(
//                 hintText: "Enter rejection reason",
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.all(12),
//               ),
//               maxLines: 3,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel', style: TextStyle(color: Colors.black)),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (reasonController.text.trim().isNotEmpty) {
//                 _rejectLand(landId, reasonController.text.trim());
//                 Navigator.pop(context);
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Please enter rejection reason')),
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             child: Text('Reject', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   // ========== SHOW LAND DETAILS ==========
//   void _showLandDetails(Map<String, dynamic> land) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => DraggableScrollableSheet(
//         initialChildSize: 0.9,
//         maxChildSize: 0.95,
//         minChildSize: 0.5,
//         expand: false,
//         builder: (context, scrollController) {
//           return SingleChildScrollView(
//             controller: scrollController,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       width: 60,
//                       height: 5,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // Land ID and Status
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Land ID: ${land['id'] ?? land['land_id'] ?? 'N/A'}",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.orange.shade50,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.orange.shade200),
//                         ),
//                         child: Text(
//                           "PENDING",
//                           style: TextStyle(
//                             color: Colors.orange.shade800,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 20),

//                   // Farmer Details
//                   Text(
//                     "👤 Farmer Details",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   _detailRow(
//                     "Name",
//                     land['farmer_details']?['name']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "Phone",
//                     land['farmer_details']?['phone']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "WhatsApp",
//                     land['farmer_details']?['whatsapp_number']?.toString() ??
//                         "N/A",
//                   ),
//                   _detailRow(
//                     "Literacy",
//                     land['farmer_details']?['literacy']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "Age Group",
//                     land['farmer_details']?['age_group']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "Nature",
//                     land['farmer_details']?['nature']?.toString() ?? "N/A",
//                   ),

//                   SizedBox(height: 20),

//                   // Land Details
//                   Text(
//                     "📍 Land Details",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   _detailRow(
//                     "Village",
//                     land['land_location']?['village']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "Mandal",
//                     land['land_location']?['mandal']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "District",
//                     land['land_location']?['district']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "State",
//                     land['land_location']?['state']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "Survey No",
//                     land['land_details']?['survey_number']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "Area",
//                     "${land['land_details']?['land_area']?.toString() ?? "N/A"} Acres",
//                   ),
//                   _detailRow(
//                     "Guntas",
//                     land['land_details']?['guntas']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "Price per Acre",
//                     "₹${land['land_details']?['price_per_acre']?.toString() ?? "N/A"}",
//                   ),
//                   _detailRow(
//                     "Total Price",
//                     "₹${land['land_details']?['total_land_price']?.toString() ?? "N/A"}",
//                   ),
//                   _detailRow(
//                     "Land Type",
//                     land['land_details']?['land_type']?.toString() ?? "N/A",
//                   ),
//                   _detailRow(
//                     "Ownership",
//                     land['farmer_details']?['land_ownership']?.toString() ??
//                         "N/A",
//                   ),

//                   if (land['land_details']?['water_source'] != null)
//                     _detailRow(
//                       "Water Source",
//                       land['land_details']?['water_source']?.toString() ??
//                           "N/A",
//                     ),

//                   if (land['land_details']?['dispute_type'] != null)
//                     _detailRow(
//                       "Dispute Type",
//                       land['land_details']?['dispute_type']?.toString() ??
//                           "N/A",
//                     ),

//                   SizedBox(height: 20),

//                   // Action Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             _navigateToEditLand(land);
//                           },
//                           icon: Icon(Icons.edit_outlined, size: 18),
//                           label: Text("Edit"),
//                           style: OutlinedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: 12),
//                             side: BorderSide(color: Colors.blue),
//                             foregroundColor: Colors.blue,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: ElevatedButton.icon(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             _verifyLand(
//                               land['id']?.toString() ??
//                                   land['land_id']?.toString() ??
//                                   "",
//                             );
//                           },
//                           icon: Icon(Icons.check_circle_outline, size: 18),
//                           label: Text("Verify"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                             padding: EdgeInsets.symmetric(vertical: 12),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             _showRejectDialog(
//                               land['id']?.toString() ??
//                                   land['land_id']?.toString() ??
//                                   "",
//                               land['farmer_details']?['name']?.toString() ??
//                                   "Unknown Farmer",
//                             );
//                           },
//                           icon: Icon(Icons.close_outlined, size: 18),
//                           label: Text("Reject"),
//                           style: OutlinedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: 12),
//                             side: BorderSide(color: Colors.red),
//                             foregroundColor: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ✅ UPDATED EDIT NAVIGATION FUNCTION
//   void _navigateToEditLand(Map<String, dynamic> land) {
//     // पहले EditLandScreen के लिए Datum model create करें
//     final Datum = _createDatumFromLandData(land);

//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => EditLandScreen(
//     //       landData: Datum,
//     //       landId: land['id']?.toString() ?? land['land_id']?.toString(),
//     //     ),
//     //   ),
//     // );
//   }

//   // ✅ HELPER: Create Datum object from API land data
//   Datum _createDatumFromLandData(Map<String, dynamic> land) {
//     return Datum(
//       id: int.tryParse(land['id']?.toString() ?? '0'),
//       landId: land['land_id']?.toString() ?? land['id']?.toString(),
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//       status: land['status']?.toString(),

//       // Farmer Details
//       farmerDetails: FarmerDetails(
//         name: land['farmer_details']?['name']?.toString(),
//         phone: land['farmer_details']?['phone']?.toString(),
//         whatsappNumber: land['farmer_details']?['whatsapp_number']?.toString(),
//         literacy: land['farmer_details']?['literacy']?.toString(),
//         ageGroup: land['farmer_details']?['age_group']?.toString(),
//         nature: land['farmer_details']?['nature']?.toString(),
//         landOwnership: land['farmer_details']?['land_ownership']?.toString(),
//         mortgage: land['farmer_details']?['mortgage']?.toString(),
//       ),

//       // Land Location
//       landLocation: LandLocation(
//         state: land['land_location']?['state']?.toString(),
//         district: land['land_location']?['district']?.toString(),
//         mandal: land['land_location']?['mandal']?.toString(),
//         village: land['land_location']?['village']?.toString(),
//         location: land['land_location']?['location']?.toString(),
//       ),

//       // Land Details
//       landDetails: LandDetails(
//         surveyNumber: land['land_details']?['survey_number']?.toString(),
//         landArea: land['land_details']?['land_area']?.toString(),
//         guntas: land['land_details']?['guntas']?.toString(),
//         pricePerAcre: double.tryParse(
//           land['land_details']?['price_per_acre']?.toString() ?? '0',
//         ),
//         totalLandPrice: double.tryParse(
//           land['land_details']?['total_land_price']?.toString() ?? '0',
//         ),
//         landType: land['land_details']?['land_type']?.toString(),
//         waterSource: land['land_details']?['water_source']?.toString(),
//         garden: land['land_details']?['garden']?.toString(),
//         shedDetails: land['land_details']?['shed']?.toString(),
//         farmPond: land['land_details']?['farm_pond']?.toString(),
//         residental: land['land_details']?['residental']?.toString(),
//         fencing: land['land_details']?['fencing']?.toString(),
//         shed: land['land_details']?['shed']?.toString(),
//       ),

//       // Dispute Details
//       disputeDetails: DisputeDetails(
//         disputeType: land['land_details']?['dispute_type']?.toString(),
//         siblingsInvolveInDispute:
//             land['land_details']?['siblings_involve_in_dispute']?.toString(),
//         pathToLand: land['land_details']?['path_to_land']?.toString(),
//       ),

//       // GPS Tracking
//       gpsTracking: GpsTracking(
//         latitude: land['land_details']?['latitude']?.toString(),
//         longitude: land['land_details']?['longitude']?.toString(),
//         roadPath: land['land_details']?['road_path']?.toString(),
//       ),

//       // Document Media
//       documentMedia: DocumentMedia(
//         passbookPhoto: land['document_media']?['passbook_photo']?.toString(),
//         landPhotos: (land['document_media']?['land_photos'] as List<dynamic>?)
//             ?.cast<String>(),
//         landVideos: (land['document_media']?['land_videos'] as List<dynamic>?)
//             ?.cast<String>(),
//       ),
//     );
//   }

//   Widget _detailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               "$label:",
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey.shade700,
//               ),
//             ),
//           ),
//           SizedBox(width: 10),
//           Expanded(child: Text(value, style: TextStyle(fontSize: 14))),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Land Verification",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "Regional Verifier",
//               style: TextStyle(fontSize: 12, color: Colors.white70),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.assignment_outlined),
//             tooltip: "Review Lands",
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => RegionalDetails()),
//               );
//             },
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: Colors.green,
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: Colors.green,
//           tabs: const [
//             Tab(text: "Unverified Lands"),
//             Tab(text: "New Land"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // TAB 1: UNVERIFIED LANDS FROM API
//           _buildUnverifiedLands(),

//           // TAB 2: NEW LAND FORM
//           NewLandForm(),
//         ],
//       ),
//     );
//   }

//   // ========== TAB 1: UNVERIFIED LANDS ==========
//   Widget _buildUnverifiedLands() {
//     return Column(
//       children: [
//         // Auto refresh indicator
//         if (isLoading)
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 8),
//             color: Colors.green.shade50,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.refresh, size: 16, color: Colors.green),
//                 SizedBox(width: 8),
//                 Text(
//                   "Refreshing...",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.green,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//         Expanded(
//           child: isLoading && unverifiedLands.isEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircularProgressIndicator(color: Colors.green),
//                       SizedBox(height: 16),
//                       Text(
//                         "Loading unverified lands...",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 )
//               : unverifiedLands.isEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.assignment_turned_in_outlined,
//                         size: 64,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         "No unverified lands found",
//                         style: TextStyle(fontSize: 18, color: Colors.grey),
//                       ),
//                       SizedBox(height: 8),
//                       ElevatedButton.icon(
//                         onPressed: _fetchUnverifiedLands,
//                         icon: Icon(Icons.refresh),
//                         label: Text("Refresh"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           foregroundColor: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : RefreshIndicator(
//                   onRefresh: _fetchUnverifiedLands,
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: unverifiedLands.length,
//                     itemBuilder: (context, index) {
//                       final land = unverifiedLands[index];
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: InkWell(
//                           onTap: () => _showLandDetails(land),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Land ID and Status
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Land ID: ${land['id'] ?? land['land_id'] ?? "N/A"}",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 10,
//                                         vertical: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: Colors.orange.shade50,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: Colors.orange.shade200,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         "PENDING",
//                                         style: TextStyle(
//                                           color: Colors.orange.shade800,
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 SizedBox(height: 12),

//                                 // Farmer Name
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.person_outline,
//                                       size: 16,
//                                       color: Colors.grey,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Expanded(
//                                       child: Text(
//                                         (land['farmer_details']
//                                                     as Map<
//                                                       String,
//                                                       dynamic
//                                                     >)?['name']
//                                                 ?.toString() ??
//                                             "Unknown Farmer",
//                                         style: TextStyle(fontSize: 15),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 SizedBox(height: 8),

//                                 // Village
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on_outlined,
//                                       size: 16,
//                                       color: Colors.grey,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Expanded(
//                                       child: Text(
//                                         (land['land_location']
//                                                     as Map<
//                                                       String,
//                                                       dynamic
//                                                     >)?['village']
//                                                 ?.toString() ??
//                                             "Unknown Village",
//                                         style: TextStyle(fontSize: 15),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 SizedBox(height: 8),

//                                 // Land Area and Price
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.square_foot_outlined,
//                                           size: 16,
//                                           color: Colors.grey,
//                                         ),
//                                         SizedBox(width: 8),
//                                         Text(
//                                           "${(land['land_details'] as Map<String, dynamic>)?['land_area']?.toString() ?? "0"} Acres",
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.grey.shade700,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 12,
//                                         vertical: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: Colors.green.shade50,
//                                         borderRadius: BorderRadius.circular(6),
//                                       ),
//                                       child: Text(
//                                         "₹${land['land_details']?['total_land_price']?.toString() ?? "0"}",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.green.shade800,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 SizedBox(height: 16),

//                                 // Action Buttons
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: OutlinedButton.icon(
//                                         onPressed: () => _showLandDetails(land),
//                                         icon: Icon(
//                                           Icons.remove_red_eye_outlined,
//                                           size: 18,
//                                         ),
//                                         label: Text("View"),
//                                         style: OutlinedButton.styleFrom(
//                                           foregroundColor: Colors.blue,
//                                           side: BorderSide(color: Colors.blue),
//                                           padding: EdgeInsets.symmetric(
//                                             vertical: 10,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),
//                                     Expanded(
//                                       child: ElevatedButton.icon(
//                                         onPressed: () => _verifyLand(
//                                           land['id']?.toString() ??
//                                               land['land_id']?.toString() ??
//                                               "",
//                                         ),
//                                         icon: Icon(
//                                           Icons.check_circle_outline,
//                                           size: 18,
//                                         ),
//                                         label: Text("Verify"),
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.green,
//                                           foregroundColor: Colors.white,
//                                           padding: EdgeInsets.symmetric(
//                                             vertical: 10,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),
//                                     Expanded(
//                                       child: OutlinedButton.icon(
//                                         onPressed: () => _showRejectDialog(
//                                           land['id']?.toString() ??
//                                               land['land_id']?.toString() ??
//                                               "",
//                                           land['farmer_details']?['name']
//                                                   ?.toString() ??
//                                               "Unknown Farmer",
//                                         ),
//                                         icon: Icon(
//                                           Icons.close_outlined,
//                                           size: 18,
//                                         ),
//                                         label: Text("Reject"),
//                                         style: OutlinedButton.styleFrom(
//                                           foregroundColor: Colors.red,
//                                           side: BorderSide(color: Colors.red),
//                                           padding: EdgeInsets.symmetric(
//                                             vertical: 10,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//         ),
//       ],
//     );
//   }
// }

// // ========== NEW LAND FORM ==========
// class NewLandForm extends StatefulWidget {
//   const NewLandForm({super.key});

//   @override
//   State<NewLandForm> createState() => _NewLandFormState();
// }

// class _NewLandFormState extends State<NewLandForm> {
//   String? _apiToken;
//   bool isDraft = false;
//   int? selectedGuntas;

//   @override
//   void initState() {
//     super.initState();
//     loadToken();
//     _fetchStates();
//   }

//   Future<void> loadToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _apiToken = prefs.getString("auth_token");
//   }

//   // Basic state fields
//   bool isWhatsApp = false;
//   String? selectedState;
//   String? selectedDistrict;
//   String? selectedMandal;
//   String? selectedVillage;
//   String? selectedLiteracy;
//   String? selectedAgeGroup;
//   String? selectedNature;
//   String? selectedOwnership;
//   String? selectedMortgage;
//   String? selectedDisputeType;
//   String? selectedSibling;
//   String? selectedPath;
//   String? selectedLandType;
//   String? selectedResidential;
//   String? selectedFencing;

//   // MULTIPLE SELECTION FIELDS
//   List<String> selectedWaterSources = [];
//   List<String> selectedGardens = [];
//   List<String> selectedSheds = [];
//   List<String> selectedFarmPonds = [];

//   // API से लोड किए गए डेटा
//   List<String> statesList = [];
//   List<String> districtsList = [];
//   List<String> mandalsList = [];
//   List<String> villagesList = [];

//   // Controllers
//   final TextEditingController villageController = TextEditingController();
//   final TextEditingController mandalController = TextEditingController();
//   final TextEditingController latitudeController = TextEditingController();
//   final TextEditingController longitudeController = TextEditingController();
//   final TextEditingController farmerNameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController otherWhatsappController = TextEditingController();
//   final TextEditingController landAreaController = TextEditingController();
//   final TextEditingController guntasController = TextEditingController();
//   final TextEditingController pricePerAcreController = TextEditingController();
//   final TextEditingController totalLandPriceController =
//       TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController shedDetailsController = TextEditingController();

//   // Media & others
//   File? passbookImage;
//   List<File> mediaFiles = [];

//   bool loadingGPS = false;
//   bool submitting = false;
//   bool loadingStates = false;
//   bool loadingDistricts = false;
//   bool loadingMandals = false;
//   bool loadingVillages = false;
//   final ImagePicker _picker = ImagePicker();

//   final String baseUrl = "http://72.61.169.226";

//   @override
//   void dispose() {
//     villageController.dispose();
//     mandalController.dispose();
//     latitudeController.dispose();
//     longitudeController.dispose();
//     farmerNameController.dispose();
//     phoneController.dispose();
//     otherWhatsappController.dispose();
//     landAreaController.dispose();
//     guntasController.dispose();
//     pricePerAcreController.dispose();
//     totalLandPriceController.dispose();
//     locationController.dispose();
//     shedDetailsController.dispose();
//     super.dispose();
//   }

//   // ====================== API CALLS ======================
//   Future<void> _fetchStates() async {
//     setState(() => loadingStates = true);
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/location/states'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data is Map && data.containsKey('data')) {
//           final List<dynamic> stateData = data['data'];
//           setState(() {
//             statesList = stateData
//                 .map<String>((state) => state['name']?.toString() ?? '')
//                 .where((name) => name.isNotEmpty)
//                 .toList();
//           });
//         } else if (data is List) {
//           setState(() {
//             statesList = data
//                 .map<String>((state) => state['name']?.toString() ?? '')
//                 .where((name) => name.isNotEmpty)
//                 .toList();
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching states: $e");
//     } finally {
//       setState(() => loadingStates = false);
//     }
//   }

//   Future<void> _fetchDistricts(String stateName) async {
//     setState(() {
//       loadingDistricts = true;
//       districtsList.clear();
//       selectedDistrict = null;
//       mandalsList.clear();
//       selectedMandal = null;
//       villagesList.clear();
//       selectedVillage = null;
//     });

//     try {
//       final statesResponse = await http.get(
//         Uri.parse('$baseUrl/location/states'),
//       );
//       if (statesResponse.statusCode == 200) {
//         final statesData = jsonDecode(statesResponse.body);
//         List<dynamic> statesListData = [];
//         if (statesData is Map && statesData.containsKey('data')) {
//           statesListData = statesData['data'];
//         } else if (statesData is List) {
//           statesListData = statesData;
//         }

//         final state = statesListData.firstWhere(
//           (s) => s['name'] == stateName,
//           orElse: () => {'id': 1},
//         );

//         final stateId = state['id'];
//         final response = await http.get(
//           Uri.parse('$baseUrl/location/states/$stateId/districts'),
//         );

//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           if (data is Map && data.containsKey('data')) {
//             final List<dynamic> districtData = data['data'];
//             setState(() {
//               districtsList = districtData
//                   .map<String>((district) => district['name']?.toString() ?? '')
//                   .where((name) => name.isNotEmpty)
//                   .toList();
//             });
//           } else if (data is List) {
//             setState(() {
//               districtsList = data
//                   .map<String>((district) => district['name']?.toString() ?? '')
//                   .where((name) => name.isNotEmpty)
//                   .toList();
//             });
//           }
//         }
//       }
//     } catch (e) {
//       print("Error fetching districts: $e");
//     } finally {
//       setState(() => loadingDistricts = false);
//     }
//   }

//   Future<void> _fetchMandals(String districtName) async {
//     setState(() {
//       loadingMandals = true;
//       mandalsList.clear();
//       selectedMandal = null;
//       villagesList.clear();
//       selectedVillage = null;
//     });

//     try {
//       if (selectedState == null) return;
//       final statesResponse = await http.get(
//         Uri.parse('$baseUrl/location/states'),
//       );
//       if (statesResponse.statusCode == 200) {
//         final statesData = jsonDecode(statesResponse.body);
//         List<dynamic> statesListData = [];
//         if (statesData is Map && statesData.containsKey('data')) {
//           statesListData = statesData['data'];
//         } else if (statesData is List) {
//           statesListData = statesData;
//         }

//         final state = statesListData.firstWhere(
//           (s) => s['name'] == selectedState,
//           orElse: () => {'id': 1},
//         );

//         final stateId = state['id'];
//         final districtsResponse = await http.get(
//           Uri.parse('$baseUrl/location/states/$stateId/districts'),
//         );

//         if (districtsResponse.statusCode == 200) {
//           final districtsData = jsonDecode(districtsResponse.body);
//           List<dynamic> districtsListData = [];
//           if (districtsData is Map && districtsData.containsKey('data')) {
//             districtsListData = districtsData['data'];
//           } else if (districtsData is List) {
//             districtsListData = districtsData;
//           }

//           final district = districtsListData.firstWhere(
//             (d) => d['name'] == districtName,
//             orElse: () => {'id': 1},
//           );

//           final districtId = district['id'];
//           final response = await http.get(
//             Uri.parse('$baseUrl/location/districts/$districtId/mandals'),
//           );

//           if (response.statusCode == 200) {
//             final data = jsonDecode(response.body);
//             if (data is Map && data.containsKey('data')) {
//               final List<dynamic> mandalData = data['data'];
//               setState(() {
//                 mandalsList = mandalData
//                     .map<String>((mandal) => mandal['name']?.toString() ?? '')
//                     .where((name) => name.isNotEmpty)
//                     .toList();
//               });
//             } else if (data is List) {
//               setState(() {
//                 mandalsList = data
//                     .map<String>((mandal) => mandal['name']?.toString() ?? '')
//                     .where((name) => name.isNotEmpty)
//                     .toList();
//               });
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error fetching mandals: $e");
//     } finally {
//       setState(() => loadingMandals = false);
//     }
//   }

//   Future<void> _fetchVillages(String mandalName) async {
//     setState(() {
//       loadingVillages = true;
//       villagesList.clear();
//       selectedVillage = null;
//     });

//     try {
//       if (selectedState == null || selectedDistrict == null) return;

//       final statesResponse = await http.get(
//         Uri.parse('$baseUrl/location/states'),
//       );
//       if (statesResponse.statusCode == 200) {
//         final statesData = jsonDecode(statesResponse.body);
//         List<dynamic> statesListData = [];
//         if (statesData is Map && statesData.containsKey('data')) {
//           statesListData = statesData['data'];
//         } else if (statesData is List) {
//           statesListData = statesData;
//         }

//         final state = statesListData.firstWhere(
//           (s) => s['name'] == selectedState,
//           orElse: () => {'id': 1},
//         );

//         final stateId = state['id'];
//         final districtsResponse = await http.get(
//           Uri.parse('$baseUrl/location/states/$stateId/districts'),
//         );

//         if (districtsResponse.statusCode == 200) {
//           final districtsData = jsonDecode(districtsResponse.body);
//           List<dynamic> districtsListData = [];
//           if (districtsData is Map && districtsData.containsKey('data')) {
//             districtsListData = districtsData['data'];
//           } else if (districtsData is List) {
//             districtsListData = districtsData;
//           }

//           final district = districtsListData.firstWhere(
//             (d) => d['name'] == selectedDistrict,
//             orElse: () => {'id': 1},
//           );

//           final districtId = district['id'];
//           final mandalsResponse = await http.get(
//             Uri.parse('$baseUrl/location/districts/$districtId/mandals'),
//           );

//           if (mandalsResponse.statusCode == 200) {
//             final mandalsData = jsonDecode(mandalsResponse.body);
//             List<dynamic> mandalsListData = [];
//             if (mandalsData is Map && mandalsData.containsKey('data')) {
//               mandalsListData = mandalsData['data'];
//             } else if (mandalsData is List) {
//               mandalsListData = mandalsData;
//             }

//             final mandal = mandalsListData.firstWhere(
//               (m) => m['name'] == mandalName,
//               orElse: () => {'id': 1},
//             );

//             final mandalId = mandal['id'];
//             final response = await http.get(
//               Uri.parse('$baseUrl/location/mandals/$mandalId/villages'),
//             );

//             if (response.statusCode == 200) {
//               final data = jsonDecode(response.body);
//               if (data is Map && data.containsKey('data')) {
//                 final List<dynamic> villageData = data['data'];
//                 setState(() {
//                   villagesList = villageData
//                       .map<String>(
//                         (village) => village['name']?.toString() ?? '',
//                       )
//                       .where((name) => name.isNotEmpty)
//                       .toList();
//                 });
//               } else if (data is List) {
//                 setState(() {
//                   villagesList = data
//                       .map<String>(
//                         (village) => village['name']?.toString() ?? '',
//                       )
//                       .where((name) => name.isNotEmpty)
//                       .toList();
//                 });
//               }
//             }
//           }
//         }
//       }
//     } catch (e) {
//       print("Error fetching villages: $e");
//     } finally {
//       setState(() => loadingVillages = false);
//     }
//   }

//   void _resetForm() {
//     setState(() {
//       isWhatsApp = false;
//       selectedState = null;
//       selectedDistrict = null;
//       selectedMandal = null;
//       selectedVillage = null;
//       selectedLiteracy = null;
//       selectedAgeGroup = null;
//       selectedNature = null;
//       selectedOwnership = null;
//       selectedMortgage = null;
//       selectedDisputeType = null;
//       selectedSibling = null;
//       selectedPath = null;
//       selectedLandType = null;
//       selectedResidential = null;
//       selectedFencing = null;
//       selectedWaterSources.clear();
//       selectedGardens.clear();
//       selectedSheds.clear();
//       selectedFarmPonds.clear();
//       villageController.clear();
//       mandalController.clear();
//       latitudeController.clear();
//       longitudeController.clear();
//       farmerNameController.clear();
//       phoneController.clear();
//       otherWhatsappController.clear();
//       landAreaController.clear();
//       guntasController.clear();
//       pricePerAcreController.clear();
//       totalLandPriceController.clear();
//       locationController.clear();
//       shedDetailsController.clear();
//       passbookImage = null;
//       mediaFiles.clear();
//       isDraft = false;
//       districtsList.clear();
//       mandalsList.clear();
//       villagesList.clear();
//     });
//   }

//   void _toggleWaterSource(String source) {
//     setState(() {
//       if (selectedWaterSources.contains(source)) {
//         selectedWaterSources.remove(source);
//       } else {
//         selectedWaterSources.add(source);
//       }
//     });
//   }

//   void _toggleGarden(String garden) {
//     setState(() {
//       if (selectedGardens.contains(garden)) {
//         selectedGardens.remove(garden);
//       } else {
//         selectedGardens.add(garden);
//       }
//     });
//   }

//   void _toggleShed(String shed) {
//     setState(() {
//       if (selectedSheds.contains(shed)) {
//         selectedSheds.remove(shed);
//       } else {
//         selectedSheds.add(shed);
//       }
//     });
//   }

//   void _toggleFarmPond(String pond) {
//     setState(() {
//       selectedFarmPonds.clear();
//       selectedFarmPonds.add(pond);
//     });
//   }

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

//       final placemarks = await placemarkFromCoordinates(
//         pos.latitude,
//         pos.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         final p = placemarks.first;
//         final mandal =
//             (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
//             (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null);

//         if (mandal != null) {
//           if (!mandalsList.contains(mandal)) {
//             setState(() => mandalsList.add(mandal));
//           }
//           selectedMandal = mandal;
//           mandalController.text = mandal;
//         }

//         final village =
//             (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null) ??
//             (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
//             (p.name?.trim().isNotEmpty == true ? p.name : null);

//         if (village != null) {
//           if (!villagesList.contains(village)) {
//             setState(() => villagesList.add(village));
//           }
//           selectedVillage = village;
//           villageController.text = village;
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('GPS captured — Mandal & Village filled'),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Failed to capture location: $e')));
//     }
//   }

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
//       builder: (_) => SafeArea(
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text('Camera'),
//               onTap: () async {
//                 Navigator.pop(
//                   context,
//                   await _picker.pickImage(source: ImageSource.camera),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo),
//               title: const Text('Gallery'),
//               onTap: () async {
//                 Navigator.pop(
//                   context,
//                   await _picker.pickImage(source: ImageSource.gallery),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.close),
//               title: const Text('Cancel'),
//               onTap: () => Navigator.pop(context, null),
//             ),
//           ],
//         ),
//       ),
//     );

//     if (picked != null) {
//       setState(() => passbookImage = File(picked.path));
//     }
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

//   Future<void> submitNewLand() async {
//     if ((selectedVillage == null || selectedVillage!.isEmpty) ||
//         latitudeController.text.isEmpty ||
//         longitudeController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Please select village and capture GPS/location before submit',
//           ),
//         ),
//       );
//       return;
//     }

//     setState(() => submitting = true);
//     try {
//       final uri = Uri.parse("$baseUrl/field-executive/land");
//       final request = http.MultipartRequest('POST', uri);

//       if (_apiToken == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Token not found. Please login again.")),
//         );
//         setState(() => submitting = false);
//         return;
//       }

//       request.headers['Authorization'] = 'Bearer $_apiToken';
//       request.fields['state'] = selectedState ?? '';
//       request.fields['district'] = selectedDistrict ?? '';
//       request.fields['mandal'] = selectedMandal ?? '';
//       request.fields['village'] = selectedVillage ?? '';
//       request.fields['location'] = locationController.text;
//       request.fields['name'] = farmerNameController.text;
//       request.fields['phone'] = phoneController.text;
//       request.fields['whatsapp_number'] = otherWhatsappController.text;
//       request.fields['literacy'] = selectedLiteracy ?? '';
//       request.fields['age_group'] = selectedAgeGroup ?? '';
//       request.fields['nature'] = selectedNature ?? '';
//       request.fields['land_ownership'] = selectedOwnership ?? '';
//       request.fields['mortgage'] = selectedMortgage ?? '';
//       request.fields['land_area'] = landAreaController.text;
//       request.fields['guntas'] = guntasController.text;
//       request.fields['price_per_acre'] = pricePerAcreController.text;
//       request.fields['total_land_price'] = totalLandPriceController.text;
//       request.fields['land_type'] = selectedLandType ?? '';
//       request.fields['water_source'] = selectedWaterSources.join(',');
//       request.fields['garden'] = selectedGardens.join(',');
//       request.fields['shed'] = selectedSheds.join(',');
//       request.fields['farm_pond'] = selectedFarmPonds.join(',');
//       request.fields['shed_details'] = shedDetailsController.text;
//       request.fields['residental'] = selectedResidential ?? '';
//       request.fields['fencing'] = selectedFencing ?? '';
//       request.fields['road_path'] = selectedPath ?? '';
//       request.fields['land_location_gps'] =
//           "${latitudeController.text},${longitudeController.text}";
//       request.fields['dispute_type'] = selectedDisputeType ?? '';
//       request.fields['siblings_involve_in_dispute'] = selectedSibling ?? '';
//       request.fields['path_to_land'] = selectedPath ?? '';
//       request.fields['latitude'] = latitudeController.text;
//       request.fields['longitude'] = longitudeController.text;
//       request.fields['status'] = isDraft ? 'false' : 'true';

//       if (passbookImage != null && await passbookImage!.exists()) {
//         final passbookStream = http.ByteStream(passbookImage!.openRead());
//         final passbookLength = await passbookImage!.length();
//         request.files.add(
//           http.MultipartFile(
//             'passbook_photo',
//             passbookStream,
//             passbookLength,
//             filename: passbookImage!.path.split('/').last,
//           ),
//         );
//       }

//       final streamed = await request.send();
//       final respStr = await streamed.stream.bytesToString();

//       if (streamed.statusCode == 200 || streamed.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               isDraft
//                   ? 'Land saved as draft successfully'
//                   : 'Land submitted successfully',
//             ),
//           ),
//         );
//         _resetForm();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Submission failed: ${streamed.statusCode}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Submission error: $e')));
//     } finally {
//       setState(() => submitting = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "New Land Details",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           _buildAddressSection(),
//           const SizedBox(height: 40),
//           _buildFarmerDetails(),
//           const SizedBox(height: 40),
//           _buildDisputeSection(),
//           const SizedBox(height: 40),
//           _buildLandDetailsSection(),
//           const SizedBox(height: 40),
//           _buildGpsSection(),
//           const SizedBox(height: 40),
//           _buildDocumentsSection(),
//           const SizedBox(height: 30),
//           _buildSubmitButtons(),
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddressSection() => _sectionContainer(
//     title: "Village Address",
//     children: [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "State",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: DropdownButton<String>(
//                 value: selectedState,
//                 isExpanded: true,
//                 underline: const SizedBox(),
//                 hint: const Text("Select State"),
//                 icon: loadingStates
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Icon(Icons.arrow_drop_down),
//                 items: statesList.map((String state) {
//                   return DropdownMenuItem<String>(
//                     value: state,
//                     child: Text(state),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     setState(() {
//                       selectedState = newValue;
//                       selectedDistrict = null;
//                       selectedMandal = null;
//                       selectedVillage = null;
//                       districtsList.clear();
//                       mandalsList.clear();
//                       villagesList.clear();
//                     });
//                     _fetchDistricts(newValue);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "District",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: DropdownButton<String>(
//                 value: selectedDistrict,
//                 isExpanded: true,
//                 underline: const SizedBox(),
//                 hint: const Text("Select District"),
//                 icon: loadingDistricts
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Icon(Icons.arrow_drop_down),
//                 items: districtsList.map((String district) {
//                   return DropdownMenuItem<String>(
//                     value: district,
//                     child: Text(district),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     setState(() {
//                       selectedDistrict = newValue;
//                       selectedMandal = null;
//                       selectedVillage = null;
//                       mandalsList.clear();
//                       villagesList.clear();
//                     });
//                     _fetchMandals(newValue);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Mandal",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: DropdownButton<String>(
//                 value: selectedMandal,
//                 isExpanded: true,
//                 underline: const SizedBox(),
//                 hint: const Text("Select Mandal"),
//                 icon: loadingMandals
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Icon(Icons.arrow_drop_down),
//                 items: mandalsList.map((String mandal) {
//                   return DropdownMenuItem<String>(
//                     value: mandal,
//                     child: Text(mandal),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     setState(() {
//                       selectedMandal = newValue;
//                       selectedVillage = null;
//                       villagesList.clear();
//                     });
//                     _fetchVillages(newValue);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Village",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: DropdownButton<String>(
//                 value: selectedVillage,
//                 isExpanded: true,
//                 underline: const SizedBox(),
//                 hint: const Text("Select Village"),
//                 icon: loadingVillages
//                     ? const CircularProgressIndicator(strokeWidth: 2)
//                     : const Icon(Icons.arrow_drop_down),
//                 items: villagesList.map((String village) {
//                   return DropdownMenuItem<String>(
//                     value: village,
//                     child: Text(village),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() => selectedVillage = newValue);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       SizedBox(
//         width: double.infinity,
//         child: ElevatedButton.icon(
//           onPressed: loadingGPS ? null : fetchVillageGPSAndAddress,
//           icon: const Icon(Icons.gps_fixed, color: Colors.black87),
//           label: Text(loadingGPS ? 'Capturing...' : 'Capture GPS location'),
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

//   Widget _buildFarmerDetails() => _sectionContainer(
//     title: "Farmer Details",
//     children: [
//       _labeledInputController(
//         "Farmer Name",
//         "Enter Farmer's name",
//         Icons.person_outline,
//         farmerNameController,
//       ),
//       const SizedBox(height: 20),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Phone Number",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: phoneController,
//             keyboardType: TextInputType.phone,
//             maxLength: 10,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             decoration: InputDecoration(
//               hintText: "Enter phone number",
//               prefixIcon: const Icon(Icons.phone_outlined),
//               counterText: "",
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//         ],
//       ),
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
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Other WhatsApp Number",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: otherWhatsappController,
//             keyboardType: TextInputType.phone,
//             maxLength: 10,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             decoration: InputDecoration(
//               hintText: "Enter other WhatsApp number",
//               prefixIcon: const Icon(Icons.wechat),
//               counterText: "",
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 25),
//       _labelWithIcon("Literacy", Icons.menu_book_outlined),
//       _optionGroup(
//         ["High School", "Illiterate", "Literate", "Graduate"],
//         selectedLiteracy,
//         (val) => setState(() => selectedLiteracy = val),
//       ),
//       _labelWithIcon("Age Group", Icons.person_outlined),
//       _optionGroup(
//         ["Upto 30", "30-50", "50+"],
//         selectedAgeGroup,
//         (val) => setState(() => selectedAgeGroup = val),
//       ),
//       _labelWithIcon("Nature", Icons.accessibility_new_outlined),
//       _optionGroup(
//         ["Calm", "Polite", "Medium", "Rude"],
//         selectedNature,
//         (val) => setState(() => selectedNature = val),
//       ),
//       _labelWithIcon("Land Ownership", Icons.percent_outlined),
//       _optionGroup(
//         ["Own", "Joint", "Single"],
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
//           "None",
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
//         ["Easy Access", "No Path to Land"],
//         selectedPath,
//         (val) => setState(() => selectedPath = val),
//       ),
//     ],
//   );

//   Widget _buildLandDetailsSection() => _sectionContainer(
//     title: "Land Details",
//     children: [
//       Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Land Area (Acres)",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: landAreaController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
//                   ],
//                   decoration: InputDecoration(
//                     hintText: "e.g. 3.5",
//                     prefixIcon: const Icon(Icons.square_foot_outlined),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Guntas",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 8),
//                 DropdownButtonFormField<int>(
//                   isExpanded: true,
//                   value: selectedGuntas,
//                   decoration: InputDecoration(
//                     hintText: "Select",
//                     prefixIcon: const Icon(Icons.straighten_outlined),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   items: List.generate(
//                     39,
//                     (index) => DropdownMenuItem(
//                       value: index + 1,
//                       child: Text((index + 1).toString()),
//                     ),
//                   ),
//                   onChanged: (value) => setState(() => selectedGuntas = value),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Price per Acre (in Lakhs)",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: pricePerAcreController,
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             decoration: InputDecoration(
//               hintText: "e.g. 4500000",
//               prefixIcon: const Icon(Icons.currency_rupee_outlined),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 20),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Total Land Value",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: totalLandPriceController,
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             decoration: InputDecoration(
//               hintText: "Calculated Automatically",
//               prefixIcon: const Icon(Icons.calculate_outlined),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//         ],
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
//         ["agri", "Red", "Black", "Sandy"],
//         selectedLandType,
//         (val) => setState(() => selectedLandType = val),
//       ),
//       _labelWithIcon("Water Source ", Icons.water_drop_outlined),
//       _buildMultipleSelectionChips(
//         options: ["tubewell", "Canal", "Bores", "Cheruvu", "Rain Water"],
//         selectedOptions: selectedWaterSources,
//         onToggle: _toggleWaterSource,
//       ),
//       _labelWithIcon("Garden ", Icons.park_outlined),
//       _buildMultipleSelectionChips(
//         options: ["Mango", "Guava", "Coconut", "Sapota", "Other"],
//         selectedOptions: selectedGardens,
//         onToggle: _toggleGarden,
//       ),
//       _labelWithIcon("Shed Details ", Icons.agriculture_outlined),
//       _buildMultipleSelectionChips(
//         options: ["Poultry", "Cow Shed"],
//         selectedOptions: selectedSheds,
//         onToggle: _toggleShed,
//       ),
//       _labelWithIcon("Farm Pond ", Icons.water_outlined),
//       _buildMultipleSelectionChips(
//         options: ["Yes", "No"],
//         selectedOptions: selectedFarmPonds,
//         onToggle: _toggleFarmPond,
//       ),
//       _labelWithIcon("Residential", Icons.home_work_outlined),
//       _optionGroup(
//         ["Yes", "Farm House", "RCC Home", "Asbestos Shelter", "Hut"],
//         selectedResidential,
//         (val) => setState(() => selectedResidential = val),
//       ),
//       _labelWithIcon("Fencing", Icons.fence_outlined),
//       _optionGroup(
//         ["Complete", "With Gate", "All Sides", "Partially", "No"],
//         selectedFencing,
//         (val) => setState(() => selectedFencing = val),
//       ),
//     ],
//   );

//   Widget _buildMultipleSelectionChips({
//     required List<String> options,
//     required List<String> selectedOptions,
//     required Function(String) onToggle,
//   }) {
//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: options.map((option) {
//         final isSelected = selectedOptions.contains(option);
//         return ChoiceChip(
//           label: Text(option),
//           selected: isSelected,
//           onSelected: (selected) => onToggle(option),
//           selectedColor: Colors.green.shade100,
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//             side: BorderSide(
//               color: isSelected ? Colors.green : Colors.grey.shade300,
//               width: isSelected ? 2 : 1,
//             ),
//           ),
//           labelStyle: TextStyle(
//             color: isSelected ? Colors.green.shade800 : Colors.black87,
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildGpsSection() => _sectionContainer(
//     title: "GPS & Path Tracking",
//     children: [
//       _labelWithIcon("Path from Main Road", Icons.alt_route_outlined),
//       _optionGroup(
//         ["Attached to Road", "No Connectivity", "Easy Access"],
//         selectedPath,
//         (val) => setState(() => selectedPath = val),
//       ),
//       const SizedBox(height: 20),
//       _labelWithIcon(
//         "Land Entry Point (Coordinates)",
//         Icons.location_on_outlined,
//       ),
//       Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Latitude",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: latitudeController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
//                   ],
//                   decoration: InputDecoration(
//                     hintText: "e.g. 17.4502",
//                     prefixIcon: const Icon(Icons.gps_fixed),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Longitude",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: longitudeController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
//                   ],
//                   decoration: InputDecoration(
//                     hintText: "e.g. 78.3654",
//                     prefixIcon: const Icon(Icons.gps_fixed),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//               ],
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
//     ],
//   );

//   Widget _buildDocumentsSection() => _sectionContainer(
//     title: "Documents & Media",
//     children: [
//       _labelWithIcon("Land Photos", Icons.photo_camera_outlined),
//       ElevatedButton.icon(
//         onPressed: () async {
//           final picked = await _picker.pickMultiImage();
//           if (picked != null && picked.isNotEmpty) {
//             setState(() => mediaFiles.addAll(picked.map((e) => File(e.path))));
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
//       Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children: mediaFiles.map((f) {
//           final ext = f.path.split('.').last.toLowerCase();
//           if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
//             return Image.file(f, width: 90, height: 90, fit: BoxFit.cover);
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

//   Widget _buildSubmitButtons() => Column(
//     children: [
//       ElevatedButton.icon(
//         onPressed: () {
//           isDraft = false;
//           submitNewLand();
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
//           isDraft = true;
//           submitNewLand();
//         },
//         icon: const Icon(Icons.save_alt_outlined),
//         label: const Text("Save as Draft"),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.grey.shade600,
//           foregroundColor: Colors.white,
//           minimumSize: const Size.fromHeight(55),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     ],
//   );

//   // ====================== REUSABLE UI HELPERS ======================
//   Widget _sectionContainer({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
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
//         .map(
//           (text) => GestureDetector(
//             onTap: () => onSelect(text),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               decoration: BoxDecoration(
//                 color: selectedValue == text
//                     ? Colors.green.shade100
//                     : Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: selectedValue == text
//                       ? Colors.green
//                       : Colors.grey.shade300,
//                   width: selectedValue == text ? 2 : 1,
//                 ),
//               ),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   color: selectedValue == text
//                       ? Colors.green.shade800
//                       : Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         )
//         .toList(),
//   );

//   ButtonStyle _outlinedButtonStyle() => ElevatedButton.styleFrom(
//     backgroundColor: Colors.white,
//     foregroundColor: Colors.black87,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     side: BorderSide(color: Colors.grey.shade300),
//     minimumSize: const Size.fromHeight(50),
//   );
// }

// // ✅ DATUM MODEL CLASSES (EditLandScreen के लिए)
// class Datum {
//   int? id;
//   String? landId;
//   FarmerDetails farmerDetails;
//   LandLocation landLocation;
//   LandDetails landDetails;
//   DisputeDetails disputeDetails;
//   GpsTracking gpsTracking;
//   DocumentMedia documentMedia;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? status;

//   Datum({
//     this.id,
//     this.landId,
//     required this.farmerDetails,
//     required this.landLocation,
//     required this.landDetails,
//     required this.disputeDetails,
//     required this.gpsTracking,
//     required this.documentMedia,
//     this.createdAt,
//     this.updatedAt,
//     this.status,
//   });
// }

// class FarmerDetails {
//   String? name;
//   String? phone;
//   String? whatsappNumber;
//   String? literacy;
//   String? ageGroup;
//   String? nature;
//   String? landOwnership;
//   String? mortgage;

//   FarmerDetails({
//     this.name,
//     this.phone,
//     this.whatsappNumber,
//     this.literacy,
//     this.ageGroup,
//     this.nature,
//     this.landOwnership,
//     this.mortgage,
//   });
// }

// class LandLocation {
//   String? state;
//   String? district;
//   String? mandal;
//   String? village;
//   String? location;

//   LandLocation({
//     this.state,
//     this.district,
//     this.mandal,
//     this.village,
//     this.location,
//   });
// }

// class LandDetails {
//   String? surveyNumber;
//   String? landArea;
//   String? guntas;
//   double? pricePerAcre;
//   double? totalLandPrice;
//   String? landType;
//   String? waterSource;
//   String? garden;
//   String? shedDetails;
//   String? farmPond;
//   String? residental;
//   String? fencing;
//   String? shed;

//   LandDetails({
//     this.surveyNumber,
//     this.landArea,
//     this.guntas,
//     this.pricePerAcre,
//     this.totalLandPrice,
//     this.landType,
//     this.waterSource,
//     this.garden,
//     this.shedDetails,
//     this.farmPond,
//     this.residental,
//     this.fencing,
//     this.shed,
//   });
// }

// class DisputeDetails {
//   String? disputeType;
//   String? siblingsInvolveInDispute;
//   String? pathToLand;

//   DisputeDetails({
//     this.disputeType,
//     this.siblingsInvolveInDispute,
//     this.pathToLand,
//   });
// }

// class GpsTracking {
//   String? latitude;
//   String? longitude;
//   String? roadPath;

//   GpsTracking({this.latitude, this.longitude, this.roadPath});
// }

// class DocumentMedia {
//   String? passbookPhoto;
//   List<String>? landPhotos;
//   List<String>? landVideos;

//   DocumentMedia({this.passbookPhoto, this.landPhotos, this.landVideos});
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gadura_land/Screens/Regional/regionaldetails.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gadura_land/Screens/FieldExecutive/edit_land_details.dart';
import 'package:gadura_land/Screens/FieldExecutive/landmodel.dart';

class Regionalverification extends StatefulWidget {
  const Regionalverification({super.key});

  @override
  State<Regionalverification> createState() => _RegionalverificationState();
}

class _RegionalverificationState extends State<Regionalverification>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> unverifiedLands = [];
  bool isLoading = true;
  String? _apiToken;
  final String baseUrl = "http://72.61.169.226";
  late Timer _autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadToken();
    _fetchUnverifiedLands();
    // Auto refresh every 15 seconds
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (mounted && _tabController.index == 0 && !isLoading) {
        _fetchUnverifiedLands();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _autoRefreshTimer.cancel();
    super.dispose();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
  }

  // ========== FETCH UNVERIFIED LANDS FROM API ==========
  Future<void> _fetchUnverifiedLands() async {
    if (_apiToken == null) {
      await loadToken();
      if (_apiToken == null) return;
    }

    setState(() => isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/regional/land/unverified'),
        headers: {'Authorization': 'Bearer $_apiToken'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _processApiResponse(data);
      } else {
        print("Failed to fetch unverified lands: ${response.statusCode}");
        setState(() {
          unverifiedLands = [];
        });
      }
    } catch (e) {
      print("Error fetching unverified lands: $e");
      setState(() {
        unverifiedLands = [];
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _processApiResponse(dynamic data) {
    if (data is Map && data.containsKey('data')) {
      final apiData = data['data'];

      // Agar data Map hai (key-value pairs)
      if (apiData is Map) {
        List<dynamic> landList = [];
        apiData.forEach((key, value) {
          if (value is Map) {
            landList.add({'id': key.toString(), ...value});
          }
        });
        setState(() {
          unverifiedLands = landList;
        });
      }
      // Agar data List hai
      else if (apiData is List) {
        setState(() {
          unverifiedLands = apiData;
        });
      }
    }
    // Direct list response
    else if (data is List) {
      setState(() {
        unverifiedLands = data;
      });
    }
  }

  // ========== VERIFY LAND ==========
  Future<void> _verifyLand(String landId) async {
    try {
      // ✅ Create multipart request for PUT
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/regional/land/$landId'),
      );

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $_apiToken';

      // Add verification status
      request.fields['verification'] = 'verified';
      request.fields['status'] = 'true';

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Land $landId verified successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // IMMEDIATELY REMOVE FROM LOCAL LIST
        setState(() {
          unverifiedLands.removeWhere(
            (land) =>
                (land['id']?.toString() == landId) ||
                (land['land_id']?.toString() == landId),
          );
        });

        // THEN REFRESH FROM API
        await _fetchUnverifiedLands();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to verify land: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Verify Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // ========== REJECT LAND ==========
  Future<void> _rejectLand(String landId, String reason) async {
    try {
      // ✅ Create multipart request for PUT
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/regional/land/$landId'),
      );

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $_apiToken';

      // Add rejection details
      request.fields['verification'] = 'rejected';
      request.fields['status'] = 'true';
      request.fields['remarks'] = reason; // Rejection reason
      request.fields['unique_id'] = 'regional_incharge0';
      request.fields['latitude'] = '0.0';
      request.fields['longitude'] = '0.0';

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // ✅ Reject success - RegionalDetails (Review Again) पर navigate करें
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Land rejected. Moving to Review Again...'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );

        // IMMEDIATELY REMOVE FROM LOCAL LIST
        setState(() {
          unverifiedLands.removeWhere(
            (land) =>
                (land['id']?.toString() == landId) ||
                (land['land_id']?.toString() == landId),
          );
        });

        // थोड़ी देर wait करें और फिर navigate करें
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegionalDetails()),
          );
        }
      } else {
        print('Reject Error: ${response.statusCode} - ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to reject land: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Reject Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // ========== SHOW REJECT DIALOG ==========
  void _showRejectDialog(String landId, String farmerName) {
    TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reject Land $landId"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Farmer: $farmerName"),
              SizedBox(height: 12),
              Text(
                "⚠️ Note: After rejection, land will move to 'Review Again' section",
                style: TextStyle(
                  color: Colors.orange.shade800,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 16),
              Text("Please provide reason for rejection:"),
              SizedBox(height: 8),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  hintText:
                      "e.g., Documents incomplete, Location unclear, etc.",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
                maxLines: 4,
                minLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isNotEmpty) {
                Navigator.pop(context); // Dialog close करें
                _rejectLand(landId, reasonController.text.trim());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter rejection reason'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Reject & Go to Review'),
          ),
        ],
      ),
    );
  }

  // ========== SHOW LAND DETAILS ==========
  void _showLandDetails(Map<String, dynamic> land) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Land ID and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Land ID: ${land['id'] ?? land['land_id'] ?? 'N/A'}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Text(
                          "PENDING",
                          style: TextStyle(
                            color: Colors.orange.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Farmer Details
                  Text(
                    "👤 Farmer Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _detailRow(
                    "Name",
                    land['farmer_details']?['name']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "Phone",
                    land['farmer_details']?['phone']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "WhatsApp",
                    land['farmer_details']?['whatsapp_number']?.toString() ??
                        "N/A",
                  ),
                  _detailRow(
                    "Literacy",
                    land['farmer_details']?['literacy']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "Age Group",
                    land['farmer_details']?['age_group']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "Nature",
                    land['farmer_details']?['nature']?.toString() ?? "N/A",
                  ),

                  SizedBox(height: 20),

                  // Land Details
                  Text(
                    "📍 Land Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _detailRow(
                    "Village",
                    land['land_location']?['village']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "Mandal",
                    land['land_location']?['mandal']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "District",
                    land['land_location']?['district']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "State",
                    land['land_location']?['state']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "Survey No",
                    land['land_details']?['survey_number']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "Area",
                    "${land['land_details']?['land_area']?.toString() ?? "N/A"} Acres",
                  ),
                  _detailRow(
                    "Guntas",
                    land['land_details']?['guntas']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "Price per Acre",
                    "₹${land['land_details']?['price_per_acre']?.toString() ?? "N/A"}",
                  ),
                  _detailRow(
                    "Total Price",
                    "₹${land['land_details']?['total_land_price']?.toString() ?? "N/A"}",
                  ),
                  _detailRow(
                    "Land Type",
                    land['land_details']?['land_type']?.toString() ?? "N/A",
                  ),
                  _detailRow(
                    "Ownership",
                    land['farmer_details']?['land_ownership']?.toString() ??
                        "N/A",
                  ),

                  if (land['land_details']?['water_source'] != null)
                    _detailRow(
                      "Water Source",
                      land['land_details']?['water_source']?.toString() ??
                          "N/A",
                    ),

                  if (land['land_details']?['dispute_type'] != null)
                    _detailRow(
                      "Dispute Type",
                      land['land_details']?['dispute_type']?.toString() ??
                          "N/A",
                    ),

                  SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _navigateToEditLand(land);
                          },
                          icon: Icon(Icons.edit_outlined, size: 18),
                          label: Text("Edit"),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: Colors.blue),
                            foregroundColor: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _verifyLand(
                              land['id']?.toString() ??
                                  land['land_id']?.toString() ??
                                  "",
                            );
                          },
                          icon: Icon(Icons.check_circle_outline, size: 18),
                          label: Text("Verify"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _showRejectDialog(
                              land['id']?.toString() ??
                                  land['land_id']?.toString() ??
                                  "",
                              land['farmer_details']?['name']?.toString() ??
                                  "Unknown Farmer",
                            );
                          },
                          icon: Icon(Icons.close_outlined, size: 18),
                          label: Text("Reject"),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: Colors.red),
                            foregroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ✅ UPDATED EDIT NAVIGATION FUNCTION
  void _navigateToEditLand(Map<String, dynamic> land) {
    // पहले EditLandScreen के लिए Datum model create करें
    final Datum = _createDatumFromLandData(land);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditLandScreen(
    //       landData: Datum,
    //       landId: land['id']?.toString() ?? land['land_id']?.toString(),
    //     ),
    //   ),
    // );
  }

  // ✅ HELPER: Create Datum object from API land data
  Datum _createDatumFromLandData(Map<String, dynamic> land) {
    return Datum(
      id: int.tryParse(land['id']?.toString() ?? '0'),
      landId: land['land_id']?.toString() ?? land['id']?.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: land['status']?.toString(),

      // Farmer Details
      farmerDetails: FarmerDetails(
        name: land['farmer_details']?['name']?.toString(),
        phone: land['farmer_details']?['phone']?.toString(),
        whatsappNumber: land['farmer_details']?['whatsapp_number']?.toString(),
        literacy: land['farmer_details']?['literacy']?.toString(),
        ageGroup: land['farmer_details']?['age_group']?.toString(),
        nature: land['farmer_details']?['nature']?.toString(),
        landOwnership: land['farmer_details']?['land_ownership']?.toString(),
        mortgage: land['farmer_details']?['mortgage']?.toString(),
      ),

      // Land Location
      landLocation: LandLocation(
        state: land['land_location']?['state']?.toString(),
        district: land['land_location']?['district']?.toString(),
        mandal: land['land_location']?['mandal']?.toString(),
        village: land['land_location']?['village']?.toString(),
        location: land['land_location']?['location']?.toString(),
      ),

      // Land Details
      landDetails: LandDetails(
        surveyNumber: land['land_details']?['survey_number']?.toString(),
        landArea: land['land_details']?['land_area']?.toString(),
        guntas: land['land_details']?['guntas']?.toString(),
        pricePerAcre: double.tryParse(
          land['land_details']?['price_per_acre']?.toString() ?? '0',
        ),
        totalLandPrice: double.tryParse(
          land['land_details']?['total_land_price']?.toString() ?? '0',
        ),
        landType: land['land_details']?['land_type']?.toString(),
        waterSource: land['land_details']?['water_source']?.toString(),
        garden: land['land_details']?['garden']?.toString(),
        shedDetails: land['land_details']?['shed']?.toString(),
        farmPond: land['land_details']?['farm_pond']?.toString(),
        residental: land['land_details']?['residental']?.toString(),
        fencing: land['land_details']?['fencing']?.toString(),
        shed: land['land_details']?['shed']?.toString(),
      ),

      // Dispute Details
      disputeDetails: DisputeDetails(
        disputeType: land['land_details']?['dispute_type']?.toString(),
        siblingsInvolveInDispute:
            land['land_details']?['siblings_involve_in_dispute']?.toString(),
        pathToLand: land['land_details']?['path_to_land']?.toString(),
      ),

      // GPS Tracking
      gpsTracking: GpsTracking(
        latitude: land['land_details']?['latitude']?.toString(),
        longitude: land['land_details']?['longitude']?.toString(),
        roadPath: land['land_details']?['road_path']?.toString(),
      ),

      // Document Media
      documentMedia: DocumentMedia(
        passbookPhoto: land['document_media']?['passbook_photo']?.toString(),
        landPhotos: (land['document_media']?['land_photos'] as List<dynamic>?)
            ?.cast<String>(),
        landVideos: (land['document_media']?['land_videos'] as List<dynamic>?)
            ?.cast<String>(),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(child: Text(value, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Land Verification",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Regional Verifier",
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.assignment_outlined),
            tooltip: "Review Lands",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegionalDetails()),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
          tabs: const [
            Tab(text: "Unverified Lands"),
            Tab(text: "New Land"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: UNVERIFIED LANDS FROM API
          _buildUnverifiedLands(),

          // TAB 2: NEW LAND FORM
          NewLandForm(),
        ],
      ),
    );
  }

  // ========== TAB 1: UNVERIFIED LANDS ==========
  Widget _buildUnverifiedLands() {
    return Column(
      children: [
        // Auto refresh indicator
        if (isLoading)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: Colors.green.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh, size: 16, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  "Refreshing...",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

        Expanded(
          child: isLoading && unverifiedLands.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.green),
                      SizedBox(height: 16),
                      Text(
                        "Loading unverified lands...",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : unverifiedLands.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_turned_in_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No unverified lands found",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _fetchUnverifiedLands,
                        icon: Icon(Icons.refresh),
                        label: Text("Refresh"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchUnverifiedLands,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: unverifiedLands.length,
                    itemBuilder: (context, index) {
                      final land = unverifiedLands[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () => _showLandDetails(land),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Land ID and Status
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Land ID: ${land['id'] ?? land['land_id'] ?? "N/A"}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.shade50,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.orange.shade200,
                                        ),
                                      ),
                                      child: Text(
                                        "PENDING",
                                        style: TextStyle(
                                          color: Colors.orange.shade800,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 12),

                                // Farmer Name
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person_outline,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        (land['farmer_details']
                                                    as Map<
                                                      String,
                                                      dynamic
                                                    >)?['name']
                                                ?.toString() ??
                                            "Unknown Farmer",
                                        style: TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),

                                // Village
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        (land['land_location']
                                                    as Map<
                                                      String,
                                                      dynamic
                                                    >)?['village']
                                                ?.toString() ??
                                            "Unknown Village",
                                        style: TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),

                                // Land Area and Price
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.square_foot_outlined,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "${(land['land_details'] as Map<String, dynamic>)?['land_area']?.toString() ?? "0"} Acres",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        "₹${land['land_details']?['total_land_price']?.toString() ?? "0"}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),

                                // Action Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () => _showLandDetails(land),
                                        icon: Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 18,
                                        ),
                                        label: Text("View"),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.blue,
                                          side: BorderSide(color: Colors.blue),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () => _verifyLand(
                                          land['id']?.toString() ??
                                              land['land_id']?.toString() ??
                                              "",
                                        ),
                                        icon: Icon(
                                          Icons.check_circle_outline,
                                          size: 18,
                                        ),
                                        label: Text("Verify"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () => _showRejectDialog(
                                          land['id']?.toString() ??
                                              land['land_id']?.toString() ??
                                              "",
                                          land['farmer_details']?['name']
                                                  ?.toString() ??
                                              "Unknown Farmer",
                                        ),
                                        icon: Icon(
                                          Icons.close_outlined,
                                          size: 18,
                                        ),
                                        label: Text("Reject"),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.red,
                                          side: BorderSide(color: Colors.red),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

// ========== NEW LAND FORM ==========
class NewLandForm extends StatefulWidget {
  const NewLandForm({super.key});

  @override
  State<NewLandForm> createState() => _NewLandFormState();
}

class _NewLandFormState extends State<NewLandForm> {
  String? _apiToken;
  bool isDraft = false;
  int? selectedGuntas;

  @override
  void initState() {
    super.initState();
    loadToken();
    _fetchStates();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
  }

  // Basic state fields
  bool isWhatsApp = false;
  String? selectedState;
  String? selectedDistrict;
  String? selectedMandal;
  String? selectedVillage;
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

  // MULTIPLE SELECTION FIELDS
  List<String> selectedWaterSources = [];
  List<String> selectedGardens = [];
  List<String> selectedSheds = [];
  List<String> selectedFarmPonds = [];

  // API से लोड किए गए डेटा
  List<String> statesList = [];
  List<String> districtsList = [];
  List<String> mandalsList = [];
  List<String> villagesList = [];

  // Controllers
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
  final TextEditingController locationController = TextEditingController();
  final TextEditingController shedDetailsController = TextEditingController();

  // Media & others
  File? passbookImage;
  List<File> mediaFiles = [];

  bool loadingGPS = false;
  bool submitting = false;
  bool loadingStates = false;
  bool loadingDistricts = false;
  bool loadingMandals = false;
  bool loadingVillages = false;
  final ImagePicker _picker = ImagePicker();

  final String baseUrl = "http://72.61.169.226";

  @override
  void dispose() {
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

  // ====================== API CALLS ======================
  Future<void> _fetchStates() async {
    setState(() => loadingStates = true);
    try {
      final response = await http.get(Uri.parse('$baseUrl/location/states'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map && data.containsKey('data')) {
          final List<dynamic> stateData = data['data'];
          setState(() {
            statesList = stateData
                .map<String>((state) => state['name']?.toString() ?? '')
                .where((name) => name.isNotEmpty)
                .toList();
          });
        } else if (data is List) {
          setState(() {
            statesList = data
                .map<String>((state) => state['name']?.toString() ?? '')
                .where((name) => name.isNotEmpty)
                .toList();
          });
        }
      }
    } catch (e) {
      print("Error fetching states: $e");
    } finally {
      setState(() => loadingStates = false);
    }
  }

  Future<void> _fetchDistricts(String stateName) async {
    setState(() {
      loadingDistricts = true;
      districtsList.clear();
      selectedDistrict = null;
      mandalsList.clear();
      selectedMandal = null;
      villagesList.clear();
      selectedVillage = null;
    });

    try {
      final statesResponse = await http.get(
        Uri.parse('$baseUrl/location/states'),
      );
      if (statesResponse.statusCode == 200) {
        final statesData = jsonDecode(statesResponse.body);
        List<dynamic> statesListData = [];
        if (statesData is Map && statesData.containsKey('data')) {
          statesListData = statesData['data'];
        } else if (statesData is List) {
          statesListData = statesData;
        }

        final state = statesListData.firstWhere(
          (s) => s['name'] == stateName,
          orElse: () => {'id': 1},
        );

        final stateId = state['id'];
        final response = await http.get(
          Uri.parse('$baseUrl/location/states/$stateId/districts'),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data is Map && data.containsKey('data')) {
            final List<dynamic> districtData = data['data'];
            setState(() {
              districtsList = districtData
                  .map<String>((district) => district['name']?.toString() ?? '')
                  .where((name) => name.isNotEmpty)
                  .toList();
            });
          } else if (data is List) {
            setState(() {
              districtsList = data
                  .map<String>((district) => district['name']?.toString() ?? '')
                  .where((name) => name.isNotEmpty)
                  .toList();
            });
          }
        }
      }
    } catch (e) {
      print("Error fetching districts: $e");
    } finally {
      setState(() => loadingDistricts = false);
    }
  }

  Future<void> _fetchMandals(String districtName) async {
    setState(() {
      loadingMandals = true;
      mandalsList.clear();
      selectedMandal = null;
      villagesList.clear();
      selectedVillage = null;
    });

    try {
      if (selectedState == null) return;
      final statesResponse = await http.get(
        Uri.parse('$baseUrl/location/states'),
      );
      if (statesResponse.statusCode == 200) {
        final statesData = jsonDecode(statesResponse.body);
        List<dynamic> statesListData = [];
        if (statesData is Map && statesData.containsKey('data')) {
          statesListData = statesData['data'];
        } else if (statesData is List) {
          statesListData = statesData;
        }

        final state = statesListData.firstWhere(
          (s) => s['name'] == selectedState,
          orElse: () => {'id': 1},
        );

        final stateId = state['id'];
        final districtsResponse = await http.get(
          Uri.parse('$baseUrl/location/states/$stateId/districts'),
        );

        if (districtsResponse.statusCode == 200) {
          final districtsData = jsonDecode(districtsResponse.body);
          List<dynamic> districtsListData = [];
          if (districtsData is Map && districtsData.containsKey('data')) {
            districtsListData = districtsData['data'];
          } else if (districtsData is List) {
            districtsListData = districtsData;
          }

          final district = districtsListData.firstWhere(
            (d) => d['name'] == districtName,
            orElse: () => {'id': 1},
          );

          final districtId = district['id'];
          final response = await http.get(
            Uri.parse('$baseUrl/location/districts/$districtId/mandals'),
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            if (data is Map && data.containsKey('data')) {
              final List<dynamic> mandalData = data['data'];
              setState(() {
                mandalsList = mandalData
                    .map<String>((mandal) => mandal['name']?.toString() ?? '')
                    .where((name) => name.isNotEmpty)
                    .toList();
              });
            } else if (data is List) {
              setState(() {
                mandalsList = data
                    .map<String>((mandal) => mandal['name']?.toString() ?? '')
                    .where((name) => name.isNotEmpty)
                    .toList();
              });
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching mandals: $e");
    } finally {
      setState(() => loadingMandals = false);
    }
  }

  Future<void> _fetchVillages(String mandalName) async {
    setState(() {
      loadingVillages = true;
      villagesList.clear();
      selectedVillage = null;
    });

    try {
      if (selectedState == null || selectedDistrict == null) return;

      final statesResponse = await http.get(
        Uri.parse('$baseUrl/location/states'),
      );
      if (statesResponse.statusCode == 200) {
        final statesData = jsonDecode(statesResponse.body);
        List<dynamic> statesListData = [];
        if (statesData is Map && statesData.containsKey('data')) {
          statesListData = statesData['data'];
        } else if (statesData is List) {
          statesListData = statesData;
        }

        final state = statesListData.firstWhere(
          (s) => s['name'] == selectedState,
          orElse: () => {'id': 1},
        );

        final stateId = state['id'];
        final districtsResponse = await http.get(
          Uri.parse('$baseUrl/location/states/$stateId/districts'),
        );

        if (districtsResponse.statusCode == 200) {
          final districtsData = jsonDecode(districtsResponse.body);
          List<dynamic> districtsListData = [];
          if (districtsData is Map && districtsData.containsKey('data')) {
            districtsListData = districtsData['data'];
          } else if (districtsData is List) {
            districtsListData = districtsData;
          }

          final district = districtsListData.firstWhere(
            (d) => d['name'] == selectedDistrict,
            orElse: () => {'id': 1},
          );

          final districtId = district['id'];
          final mandalsResponse = await http.get(
            Uri.parse('$baseUrl/location/districts/$districtId/mandals'),
          );

          if (mandalsResponse.statusCode == 200) {
            final mandalsData = jsonDecode(mandalsResponse.body);
            List<dynamic> mandalsListData = [];
            if (mandalsData is Map && mandalsData.containsKey('data')) {
              mandalsListData = mandalsData['data'];
            } else if (mandalsData is List) {
              mandalsListData = mandalsData;
            }

            final mandal = mandalsListData.firstWhere(
              (m) => m['name'] == mandalName,
              orElse: () => {'id': 1},
            );

            final mandalId = mandal['id'];
            final response = await http.get(
              Uri.parse('$baseUrl/location/mandals/$mandalId/villages'),
            );

            if (response.statusCode == 200) {
              final data = jsonDecode(response.body);
              if (data is Map && data.containsKey('data')) {
                final List<dynamic> villageData = data['data'];
                setState(() {
                  villagesList = villageData
                      .map<String>(
                        (village) => village['name']?.toString() ?? '',
                      )
                      .where((name) => name.isNotEmpty)
                      .toList();
                });
              } else if (data is List) {
                setState(() {
                  villagesList = data
                      .map<String>(
                        (village) => village['name']?.toString() ?? '',
                      )
                      .where((name) => name.isNotEmpty)
                      .toList();
                });
              }
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching villages: $e");
    } finally {
      setState(() => loadingVillages = false);
    }
  }

  void _resetForm() {
    setState(() {
      isWhatsApp = false;
      selectedState = null;
      selectedDistrict = null;
      selectedMandal = null;
      selectedVillage = null;
      selectedLiteracy = null;
      selectedAgeGroup = null;
      selectedNature = null;
      selectedOwnership = null;
      selectedMortgage = null;
      selectedDisputeType = null;
      selectedSibling = null;
      selectedPath = null;
      selectedLandType = null;
      selectedResidential = null;
      selectedFencing = null;
      selectedWaterSources.clear();
      selectedGardens.clear();
      selectedSheds.clear();
      selectedFarmPonds.clear();
      villageController.clear();
      mandalController.clear();
      latitudeController.clear();
      longitudeController.clear();
      farmerNameController.clear();
      phoneController.clear();
      otherWhatsappController.clear();
      landAreaController.clear();
      guntasController.clear();
      pricePerAcreController.clear();
      totalLandPriceController.clear();
      locationController.clear();
      shedDetailsController.clear();
      passbookImage = null;
      mediaFiles.clear();
      isDraft = false;
      districtsList.clear();
      mandalsList.clear();
      villagesList.clear();
      submitting = false;
    });
  }

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
      selectedFarmPonds.clear();
      selectedFarmPonds.add(pond);
    });
  }

  // ========== FORM VALIDATION ==========
  bool _validateForm() {
    if (selectedState == null || selectedState!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select state')));
      return false;
    }

    if (selectedDistrict == null || selectedDistrict!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select district')));
      return false;
    }

    if (selectedMandal == null || selectedMandal!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select mandal')));
      return false;
    }

    if (selectedVillage == null || selectedVillage!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select village')));
      return false;
    }

    if (latitudeController.text.isEmpty || longitudeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please capture GPS location')));
      return false;
    }

    if (farmerNameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter farmer name')));
      return false;
    }

    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter phone number')));
      return false;
    }

    return true;
  }

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
          if (!mandalsList.contains(mandal)) {
            setState(() => mandalsList.add(mandal));
          }
          selectedMandal = mandal;
          mandalController.text = mandal;
        }

        final village =
            (p.subLocality?.trim().isNotEmpty == true ? p.subLocality : null) ??
            (p.locality?.trim().isNotEmpty == true ? p.locality : null) ??
            (p.name?.trim().isNotEmpty == true ? p.name : null);

        if (village != null) {
          if (!villagesList.contains(village)) {
            setState(() => villagesList.add(village));
          }
          selectedVillage = village;
          villageController.text = village;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('GPS captured — Mandal & Village filled'),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to capture location: $e')));
    }
  }

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
      builder: (_) => SafeArea(
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
      ),
    );

    if (picked != null) {
      setState(() => passbookImage = File(picked.path));
    }
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

  // ========== DRAFT SUBMIT ==========
  Future<void> submitDraft() async {
    if (!_validateForm()) return;

    setState(() => submitting = true);
    try {
      final uri = Uri.parse("$baseUrl/regional/land");
      final request = http.MultipartRequest('POST', uri);

      if (_apiToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Token not found. Please login again.")),
        );
        setState(() => submitting = false);
        return;
      }

      request.headers['Authorization'] = 'Bearer $_apiToken';

      // ✅ Draft के लिए status = false
      request.fields['status'] = 'false'; // Draft
      request.fields['verification'] = 'pending'; // Pending verification

      // Basic location fields
      request.fields['state'] = selectedState ?? '';
      request.fields['district'] = selectedDistrict ?? '';
      request.fields['mandal'] = selectedMandal ?? '';
      request.fields['village'] = selectedVillage ?? '';
      request.fields['location'] = locationController.text;

      // Farmer details
      request.fields['name'] = farmerNameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['whatsapp_number'] = otherWhatsappController.text;
      request.fields['literacy'] = selectedLiteracy ?? '';
      request.fields['age_group'] = selectedAgeGroup ?? '';
      request.fields['nature'] = selectedNature ?? '';
      request.fields['land_ownership'] = selectedOwnership ?? '';
      request.fields['mortgage'] = selectedMortgage ?? '';

      // Land details
      request.fields['land_area'] = landAreaController.text;
      request.fields['guntas'] = guntasController.text;
      request.fields['price_per_acre'] = pricePerAcreController.text;
      request.fields['total_land_price'] = totalLandPriceController.text;
      request.fields['land_type'] = selectedLandType ?? '';
      request.fields['water_source'] = selectedWaterSources.join(',');
      request.fields['garden'] = selectedGardens.join(',');
      request.fields['shed'] = selectedSheds.join(',');
      request.fields['farm_pond'] = selectedFarmPonds.join(',');
      request.fields['shed_details'] = shedDetailsController.text;
      request.fields['residental'] = selectedResidential ?? '';
      request.fields['fencing'] = selectedFencing ?? '';
      request.fields['road_path'] = selectedPath ?? '';

      // GPS coordinates
      request.fields['latitude'] = latitudeController.text;
      request.fields['longitude'] = longitudeController.text;
      request.fields['land_location_gps'] =
          "${latitudeController.text},${longitudeController.text}";

      // Dispute details
      request.fields['dispute_type'] = selectedDisputeType ?? '';
      request.fields['siblings_involve_in_dispute'] = selectedSibling ?? '';
      request.fields['path_to_land'] = selectedPath ?? '';

      // File uploads
      if (passbookImage != null && await passbookImage!.exists()) {
        final passbookStream = http.ByteStream(passbookImage!.openRead());
        final passbookLength = await passbookImage!.length();
        request.files.add(
          http.MultipartFile(
            'passbook_photo',
            passbookStream,
            passbookLength,
            filename: passbookImage!.path.split('/').last,
          ),
        );
      }

      // Land photos
      for (int i = 0; i < mediaFiles.length; i++) {
        final file = mediaFiles[i];
        final ext = file.path.split('.').last.toLowerCase();

        if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
          final stream = http.ByteStream(file.openRead());
          final length = await file.length();
          request.files.add(
            http.MultipartFile(
              'land_photo',
              stream,
              length,
              filename: file.path.split('/').last,
            ),
          );
        } else if (['mp4', 'avi', 'mov', 'mkv'].contains(ext)) {
          final stream = http.ByteStream(file.openRead());
          final length = await file.length();
          request.files.add(
            http.MultipartFile(
              'land_video',
              stream,
              length,
              filename: file.path.split('/').last,
            ),
          );
        }
      }

      final streamed = await request.send();
      final respStr = await streamed.stream.bytesToString();

      if (streamed.statusCode == 200 || streamed.statusCode == 201) {
        final responseData = jsonDecode(respStr);
        print('Draft Response: $responseData');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Land saved as draft successfully'),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'View Drafts',
              textColor: Colors.white,
              onPressed: () {
                // Navigate to RegionalDetails (Drafts tab)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegionalDetails()),
                );
              },
            ),
          ),
        );

        // Reset form
        _resetForm();

        // Auto-navigate after delay
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegionalDetails()),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Draft save failed: ${streamed.statusCode}\n$respStr',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Draft Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Draft error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => submitting = false);
    }
  }

  // ========== SUBMIT FOR VERIFICATION ==========
  Future<void> submitForVerification() async {
    if (!_validateForm()) return;

    setState(() => submitting = true);
    try {
      final uri = Uri.parse("$baseUrl/regional/land");
      final request = http.MultipartRequest('POST', uri);

      if (_apiToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Token not found. Please login again.")),
        );
        setState(() => submitting = false);
        return;
      }

      request.headers['Authorization'] = 'Bearer $_apiToken';

      // ✅ Submit for verification - status = true
      request.fields['status'] = 'true'; // Submitted for verification
      request.fields['verification'] = 'pending'; // Pending verification

      // Basic location fields
      request.fields['state'] = selectedState ?? '';
      request.fields['district'] = selectedDistrict ?? '';
      request.fields['mandal'] = selectedMandal ?? '';
      request.fields['village'] = selectedVillage ?? '';
      request.fields['location'] = locationController.text;

      // Farmer details
      request.fields['name'] = farmerNameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['whatsapp_number'] = otherWhatsappController.text;
      request.fields['literacy'] = selectedLiteracy ?? '';
      request.fields['age_group'] = selectedAgeGroup ?? '';
      request.fields['nature'] = selectedNature ?? '';
      request.fields['land_ownership'] = selectedOwnership ?? '';
      request.fields['mortgage'] = selectedMortgage ?? '';

      // Land details
      request.fields['land_area'] = landAreaController.text;
      request.fields['guntas'] = guntasController.text;
      request.fields['price_per_acre'] = pricePerAcreController.text;
      request.fields['total_land_price'] = totalLandPriceController.text;
      request.fields['land_type'] = selectedLandType ?? '';
      request.fields['water_source'] = selectedWaterSources.join(',');
      request.fields['garden'] = selectedGardens.join(',');
      request.fields['shed'] = selectedSheds.join(',');
      request.fields['farm_pond'] = selectedFarmPonds.join(',');
      request.fields['shed_details'] = shedDetailsController.text;
      request.fields['residental'] = selectedResidential ?? '';
      request.fields['fencing'] = selectedFencing ?? '';
      request.fields['road_path'] = selectedPath ?? '';

      // GPS coordinates
      request.fields['latitude'] = latitudeController.text;
      request.fields['longitude'] = longitudeController.text;
      request.fields['land_location_gps'] =
          "${latitudeController.text},${longitudeController.text}";

      // Dispute details
      request.fields['dispute_type'] = selectedDisputeType ?? '';
      request.fields['siblings_involve_in_dispute'] = selectedSibling ?? '';
      request.fields['path_to_land'] = selectedPath ?? '';

      // File uploads
      if (passbookImage != null && await passbookImage!.exists()) {
        final passbookStream = http.ByteStream(passbookImage!.openRead());
        final passbookLength = await passbookImage!.length();
        request.files.add(
          http.MultipartFile(
            'passbook_photo',
            passbookStream,
            passbookLength,
            filename: passbookImage!.path.split('/').last,
          ),
        );
      }

      // Land photos
      for (int i = 0; i < mediaFiles.length; i++) {
        final file = mediaFiles[i];
        final ext = file.path.split('.').last.toLowerCase();

        if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
          final stream = http.ByteStream(file.openRead());
          final length = await file.length();
          request.files.add(
            http.MultipartFile(
              'land_photo',
              stream,
              length,
              filename: file.path.split('/').last,
            ),
          );
        } else if (['mp4', 'avi', 'mov', 'mkv'].contains(ext)) {
          final stream = http.ByteStream(file.openRead());
          final length = await file.length();
          request.files.add(
            http.MultipartFile(
              'land_video',
              stream,
              length,
              filename: file.path.split('/').last,
            ),
          );
        }
      }

      final streamed = await request.send();
      final respStr = await streamed.stream.bytesToString();

      if (streamed.statusCode == 200 || streamed.statusCode == 201) {
        final responseData = jsonDecode(respStr);
        print('Submit Response: $responseData');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Land submitted for verification successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.white,
              onPressed: () {
                // Navigate to verification page
                Navigator.pop(context); // Close form
              },
            ),
          ),
        );

        // Reset form
        _resetForm();

        // Auto-navigate after delay
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            // Go back to verification screen
            Navigator.pop(context);
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Submission failed: ${streamed.statusCode}\n$respStr',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Submit Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Submission error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildAddressSection() => _sectionContainer(
    title: "Village Address",
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "State",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: selectedState,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text("Select State"),
                icon: loadingStates
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : const Icon(Icons.arrow_drop_down),
                items: statesList.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedState = newValue;
                      selectedDistrict = null;
                      selectedMandal = null;
                      selectedVillage = null;
                      districtsList.clear();
                      mandalsList.clear();
                      villagesList.clear();
                    });
                    _fetchDistricts(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "District",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: selectedDistrict,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text("Select District"),
                icon: loadingDistricts
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : const Icon(Icons.arrow_drop_down),
                items: districtsList.map((String district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedDistrict = newValue;
                      selectedMandal = null;
                      selectedVillage = null;
                      mandalsList.clear();
                      villagesList.clear();
                    });
                    _fetchMandals(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mandal",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: selectedMandal,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text("Select Mandal"),
                icon: loadingMandals
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : const Icon(Icons.arrow_drop_down),
                items: mandalsList.map((String mandal) {
                  return DropdownMenuItem<String>(
                    value: mandal,
                    child: Text(mandal),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedMandal = newValue;
                      selectedVillage = null;
                      villagesList.clear();
                    });
                    _fetchVillages(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Village",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: selectedVillage,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text("Select Village"),
                icon: loadingVillages
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : const Icon(Icons.arrow_drop_down),
                items: villagesList.map((String village) {
                  return DropdownMenuItem<String>(
                    value: village,
                    child: Text(village),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() => selectedVillage = newValue);
                },
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: loadingGPS ? null : fetchVillageGPSAndAddress,
          icon: const Icon(Icons.gps_fixed, color: Colors.black87),
          label: Text(loadingGPS ? 'Capturing...' : 'Capture GPS location'),
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Phone Number",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Other WhatsApp Number",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      const SizedBox(height: 25),
      _labelWithIcon("Literacy", Icons.menu_book_outlined),
      _optionGroup(
        ["High School", "Illiterate", "Literate", "Graduate"],
        selectedLiteracy,
        (val) => setState(() => selectedLiteracy = val),
      ),
      _labelWithIcon("Age Group", Icons.person_outlined),
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

  Widget _buildLandDetailsSection() => _sectionContainer(
    title: "Land Details",
    children: [
      Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Land Area (Acres)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Guntas",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  isExpanded: true,
                  value: selectedGuntas,
                  decoration: InputDecoration(
                    hintText: "Select",
                    prefixIcon: const Icon(Icons.straighten_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  items: List.generate(
                    39,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text((index + 1).toString()),
                    ),
                  ),
                  onChanged: (value) => setState(() => selectedGuntas = value),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Price per Acre (in Lakhs)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Land Value",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      _labelWithIcon("Water Source ", Icons.water_drop_outlined),
      _buildMultipleSelectionChips(
        options: ["tubewell", "Canal", "Bores", "Cheruvu", "Rain Water"],
        selectedOptions: selectedWaterSources,
        onToggle: _toggleWaterSource,
      ),
      _labelWithIcon("Garden ", Icons.park_outlined),
      _buildMultipleSelectionChips(
        options: ["Mango", "Guava", "Coconut", "Sapota", "Other"],
        selectedOptions: selectedGardens,
        onToggle: _toggleGarden,
      ),
      _labelWithIcon("Shed Details ", Icons.agriculture_outlined),
      _buildMultipleSelectionChips(
        options: ["Poultry", "Cow Shed"],
        selectedOptions: selectedSheds,
        onToggle: _toggleShed,
      ),
      _labelWithIcon("Farm Pond ", Icons.water_outlined),
      _buildMultipleSelectionChips(
        options: ["Yes", "No"],
        selectedOptions: selectedFarmPonds,
        onToggle: _toggleFarmPond,
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
          selectedColor: Colors.green.shade100,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isSelected ? Colors.green : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          labelStyle: TextStyle(
            color: isSelected ? Colors.green.shade800 : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        );
      }).toList(),
    );
  }

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
      _labelWithIcon(
        "Land Entry Point (Coordinates)",
        Icons.location_on_outlined,
      ),
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Latitude",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: latitudeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                  ],
                  decoration: InputDecoration(
                    hintText: "e.g. 17.4502",
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Longitude",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: longitudeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                  ],
                  decoration: InputDecoration(
                    hintText: "e.g. 78.3654",
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
        onPressed: getCurrentLatLong,
        icon: const Icon(Icons.my_location_outlined),
        label: const Text("Get Location"),
        style: _outlinedButtonStyle(),
      ),
    ],
  );

  Widget _buildDocumentsSection() => _sectionContainer(
    title: "Documents & Media",
    children: [
      _labelWithIcon("Land Photos", Icons.photo_camera_outlined),
      ElevatedButton.icon(
        onPressed: () async {
          final picked = await _picker.pickMultiImage();
          if (picked != null && picked.isNotEmpty) {
            setState(() => mediaFiles.addAll(picked.map((e) => File(e.path))));
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
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: mediaFiles.map((f) {
          final ext = f.path.split('.').last.toLowerCase();
          if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
            return Image.file(f, width: 90, height: 90, fit: BoxFit.cover);
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
      // ✅ SUBMIT FOR VERIFICATION BUTTON
      ElevatedButton.icon(
        onPressed: submitting ? null : submitForVerification,
        icon: submitting
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(Icons.cloud_upload_outlined),
        label: Text(submitting ? 'Submitting...' : 'Submit for Verification'),
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

      // ✅ SAVE AS DRAFT BUTTON
      ElevatedButton.icon(
        onPressed: submitting ? null : submitDraft,
        icon: submitting
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(Icons.save_alt_outlined),
        label: Text(submitting ? 'Saving...' : 'Save as Draft'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Add a cancel button
      const SizedBox(height: 15),
      OutlinedButton.icon(
        onPressed: () {
          _resetForm();
          Navigator.pop(context);
        },
        icon: Icon(Icons.cancel_outlined),
        label: Text('Cancel & Clear Form'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ],
  );

  // ====================== REUSABLE UI HELPERS ======================
  Widget _sectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
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
        .map(
          (text) => GestureDetector(
            onTap: () => onSelect(text),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: selectedValue == text
                    ? Colors.green.shade100
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedValue == text
                      ? Colors.green
                      : Colors.grey.shade300,
                  width: selectedValue == text ? 2 : 1,
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: selectedValue == text
                      ? Colors.green.shade800
                      : Colors.black,
                ),
              ),
            ),
          ),
        )
        .toList(),
  );

  ButtonStyle _outlinedButtonStyle() => ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    side: BorderSide(color: Colors.grey.shade300),
    minimumSize: const Size.fromHeight(50),
  );
}

// ✅ DATUM MODEL CLASSES (EditLandScreen के लिए)
class Datum {
  int? id;
  String? landId;
  FarmerDetails farmerDetails;
  LandLocation landLocation;
  LandDetails landDetails;
  DisputeDetails disputeDetails;
  GpsTracking gpsTracking;
  DocumentMedia documentMedia;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;

  Datum({
    this.id,
    this.landId,
    required this.farmerDetails,
    required this.landLocation,
    required this.landDetails,
    required this.disputeDetails,
    required this.gpsTracking,
    required this.documentMedia,
    this.createdAt,
    this.updatedAt,
    this.status,
  });
}

class FarmerDetails {
  String? name;
  String? phone;
  String? whatsappNumber;
  String? literacy;
  String? ageGroup;
  String? nature;
  String? landOwnership;
  String? mortgage;

  FarmerDetails({
    this.name,
    this.phone,
    this.whatsappNumber,
    this.literacy,
    this.ageGroup,
    this.nature,
    this.landOwnership,
    this.mortgage,
  });
}

class LandLocation {
  String? state;
  String? district;
  String? mandal;
  String? village;
  String? location;

  LandLocation({
    this.state,
    this.district,
    this.mandal,
    this.village,
    this.location,
  });
}

class LandDetails {
  String? surveyNumber;
  String? landArea;
  String? guntas;
  double? pricePerAcre;
  double? totalLandPrice;
  String? landType;
  String? waterSource;
  String? garden;
  String? shedDetails;
  String? farmPond;
  String? residental;
  String? fencing;
  String? shed;

  LandDetails({
    this.surveyNumber,
    this.landArea,
    this.guntas,
    this.pricePerAcre,
    this.totalLandPrice,
    this.landType,
    this.waterSource,
    this.garden,
    this.shedDetails,
    this.farmPond,
    this.residental,
    this.fencing,
    this.shed,
  });
}

class DisputeDetails {
  String? disputeType;
  String? siblingsInvolveInDispute;
  String? pathToLand;

  DisputeDetails({
    this.disputeType,
    this.siblingsInvolveInDispute,
    this.pathToLand,
  });
}

class GpsTracking {
  String? latitude;
  String? longitude;
  String? roadPath;

  GpsTracking({this.latitude, this.longitude, this.roadPath});
}

class DocumentMedia {
  String? passbookPhoto;
  List<String>? landPhotos;
  List<String>? landVideos;

  DocumentMedia({this.passbookPhoto, this.landPhotos, this.landVideos});
}
