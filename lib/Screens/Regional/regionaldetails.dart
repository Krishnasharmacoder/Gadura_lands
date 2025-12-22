// // import 'package:flutter/material.dart';
// // import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';

// // class RegionalDetails extends StatefulWidget {
// //   const RegionalDetails({super.key});

// //   @override
// //   State<RegionalDetails> createState() => _RegionalDetailsState();
// // }

// // class _RegionalDetailsState extends State<RegionalDetails>
// //     with SingleTickerProviderStateMixin {
// //   late TabController _tabController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 2, vsync: this);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         // Back press → homepage
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => Regionalhomepage()),
// //         );
// //         return false; // prevent default back
// //       },
// //       child: Scaffold(
// //         backgroundColor: const Color(0xFFF5F8FC),
// //         appBar: AppBar(
// //           backgroundColor: Colors.transparent,
// //           elevation: 0,
// //           title: const Text(
// //             "Land Entry Management",
// //             style: TextStyle(
// //               color: Colors.black,
// //               fontSize: 22,
// //               fontWeight: FontWeight.w700,
// //             ),
// //           ),
// //         ),
// //         body: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 "Continue your saved drafts or correct returned entries.",
// //                 style: TextStyle(fontSize: 14, color: Colors.black54),
// //               ),

// //               const SizedBox(height: 20),

// //               _buildTabBar(),

// //               const SizedBox(height: 20),

// //               Expanded(
// //                 child: TabBarView(
// //                   controller: _tabController,
// //                   children: [_buildDraftList(), _buildReviewAgainList()],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // -------------------------------------------------------------
// //   // TAB BAR
// //   // -------------------------------------------------------------
// //   Widget _buildTabBar() {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: const Color(0xFFE9EFF6),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: TabBar(
// //         controller: _tabController,
// //         indicator: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         labelColor: Colors.black,
// //         unselectedLabelColor: Colors.black54,
// //         tabs: const [
// //           Tab(text: "Drafts (6)"),
// //           Tab(text: "Review Again (5)"),
// //         ],
// //       ),
// //     );
// //   }

// //   // -------------------------------------------------------------
// //   // DRAFTS LIST
// //   // -------------------------------------------------------------
// //   Widget _buildDraftList() {
// //     return ListView(
// //       children: [
// //         _entryCard(
// //           title: "Land Submission - Survey #123",
// //           date: "28 Jul 2024, 05:30 AM",
// //         ),
// //         _entryCard(
// //           title: "Land Submission - Plot #789",
// //           date: "27 Jul 2024, 05:30 AM",
// //         ),
// //         _entryCard(
// //           title: "Land Submission - Farm #55",
// //           date: "26 Jul 2024, 05:30 AM",
// //         ),
// //       ],
// //     );
// //   }

// //   // -------------------------------------------------------------
// //   // REVIEW AGAIN LIST
// //   // -------------------------------------------------------------
// //   Widget _buildReviewAgainList() {
// //     return ListView(
// //       children: [
// //         _entryCard(title: "Returned Entry - Survey #451", date: "25 Jul 2024"),
// //       ],
// //     );
// //   }

// //   // -------------------------------------------------------------
// //   // CARD WIDGET
// //   // -------------------------------------------------------------
// //   Widget _entryCard({required String title, required String date}) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       padding: const EdgeInsets.all(18),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12.withOpacity(0.05),
// //             blurRadius: 6,
// //             offset: const Offset(0, 3),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           // LEFT COLUMN
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 title,
// //                 style: const TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //               const SizedBox(height: 6),
// //               Text(
// //                 "Last saved: $date",
// //                 style: const TextStyle(fontSize: 13, color: Colors.black54),
// //               ),
// //             ],
// //           ),

// //           // ICON RIGHT
// //           const Icon(Icons.open_in_new, color: Colors.black54),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';

// class RegionalDetails extends StatefulWidget {
//   const RegionalDetails({super.key});

//   @override
//   State<RegionalDetails> createState() => _RegionalDetailsState();
// }

// class _RegionalDetailsState extends State<RegionalDetails>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final String baseUrl = "http://72.61.169.226";
//   String? _apiToken;

//   // States for API data
//   List<dynamic> rejectedLands = [];
//   bool isLoadingRejected = false;
//   bool hasError = false;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     loadToken();
//   }

//   Future<void> loadToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _apiToken = prefs.getString("auth_token");
//   }

//   // ========== FETCH REJECTED LANDS API ==========
//   Future<void> _fetchRejectedLands() async {
//     if (_apiToken == null) {
//       await loadToken();
//       if (_apiToken == null) {
//         setState(() {
//           hasError = true;
//           errorMessage = 'Authentication token not found';
//         });
//         return;
//       }
//     }

//     setState(() {
//       isLoadingRejected = true;
//       hasError = false;
//       errorMessage = '';
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/regional/land/rejected'),
//         headers: {'Authorization': 'Bearer $_apiToken'},
//       );

//       print('API Response Status: ${response.statusCode}');
//       print('API Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _processApiResponse(data);
//       } else {
//         setState(() {
//           hasError = true;
//           errorMessage =
//               'Failed to fetch rejected lands: ${response.statusCode}';
//           rejectedLands = [];
//         });
//       }
//     } catch (e) {
//       print('Error fetching rejected lands: $e');
//       setState(() {
//         hasError = true;
//         errorMessage = 'Error: $e';
//         rejectedLands = [];
//       });
//     } finally {
//       setState(() => isLoadingRejected = false);
//     }
//   }

//   void _processApiResponse(dynamic data) {
//     print('Processing API data type: ${data.runtimeType}');

//     // Case 1: Direct list
//     if (data is List) {
//       print('Direct list response with ${data.length} items');
//       setState(() {
//         rejectedLands = data;
//       });
//       return;
//     }

//     // Case 2: Map with 'data' key
//     if (data is Map && data.containsKey('data')) {
//       final apiData = data['data'];
//       print('Map response with data key, type: ${apiData.runtimeType}');

//       if (apiData is List) {
//         setState(() {
//           rejectedLands = apiData;
//         });
//       }
//       // Case 3: Map inside Map (key-value pairs)
//       else if (apiData is Map) {
//         List<dynamic> landList = [];
//         apiData.forEach((key, value) {
//           if (value is Map) {
//             landList.add({'id': key.toString(), ...value});
//           }
//         });
//         setState(() {
//           rejectedLands = landList;
//         });
//       }
//       return;
//     }

//     // Case 4: Empty or unexpected format
//     print('Unexpected API format');
//     setState(() {
//       rejectedLands = [];
//     });
//   }

//   // ========== FORMAT DATE STRING ==========
//   String _formatDate(String? dateString) {
//     if (dateString == null || dateString.isEmpty) return 'Date not available';

//     try {
//       // Try to parse ISO format
//       DateTime date = DateTime.parse(dateString);
//       return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
//     } catch (e) {
//       // Return as is if parsing fails
//       return dateString;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => Regionalhomepage()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F8FC),
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: const Text(
//             "Land Entry Management",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Continue your saved drafts or correct returned entries.",
//                 style: TextStyle(fontSize: 14, color: Colors.black54),
//               ),

//               const SizedBox(height: 20),

//               _buildTabBar(),

//               const SizedBox(height: 20),

//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [_buildDraftList(), _buildReviewAgainList()],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // -------------------------------------------------------------
//   // TAB BAR
//   // -------------------------------------------------------------
//   Widget _buildTabBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFE9EFF6),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TabBar(
//         controller: _tabController,
//         indicator: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         labelColor: Colors.black,
//         unselectedLabelColor: Colors.black54,
//         onTap: (index) {
//           // When Review Again tab is selected, fetch data
//           if (index == 1 && rejectedLands.isEmpty && !isLoadingRejected) {
//             _fetchRejectedLands();
//           }
//         },
//         tabs: [
//           Tab(
//             text: "Drafts (${rejectedLands.length})",
//           ), // You can update this too
//           Tab(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Review Again"),
//                 SizedBox(width: 6),
//                 if (isLoadingRejected)
//                   SizedBox(
//                     width: 12,
//                     height: 12,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       color: Colors.black54,
//                     ),
//                   )
//                 else
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade100,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       rejectedLands.length.toString(),
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------------------------------------------------
//   // DRAFTS LIST (Keep as before)
//   // -------------------------------------------------------------
//   Widget _buildDraftList() {
//     return ListView(
//       children: [
//         _entryCard(
//           title: "Land Submission - Survey #123",
//           date: "28 Jul 2024, 05:30 AM",
//         ),
//         _entryCard(
//           title: "Land Submission - Plot #789",
//           date: "27 Jul 2024, 05:30 AM",
//         ),
//         _entryCard(
//           title: "Land Submission - Farm #55",
//           date: "26 Jul 2024, 05:30 AM",
//         ),
//       ],
//     );
//   }

//   // -------------------------------------------------------------
//   // REVIEW AGAIN LIST (Updated with API data)
//   // -------------------------------------------------------------
//   Widget _buildReviewAgainList() {
//     // Show loading
//     if (isLoadingRejected) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: Colors.red),
//             SizedBox(height: 16),
//             Text(
//               "Loading rejected lands...",
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       );
//     }

//     // Show error
//     if (hasError) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 64, color: Colors.red),
//             SizedBox(height: 16),
//             Text(
//               "Error loading data",
//               style: TextStyle(fontSize: 18, color: Colors.red),
//             ),
//             SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 errorMessage,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: _fetchRejectedLands,
//               icon: Icon(Icons.refresh),
//               label: Text("Retry"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     // Show empty state
//     if (rejectedLands.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.assignment_returned_outlined,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             Text(
//               "No rejected lands found",
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             SizedBox(height: 8),
//             ElevatedButton.icon(
//               onPressed: _fetchRejectedLands,
//               icon: Icon(Icons.refresh),
//               label: Text("Load Rejected Lands"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     // Show list of rejected lands
//     return RefreshIndicator(
//       onRefresh: () async {
//         await _fetchRejectedLands();
//       },
//       child: ListView.builder(
//         padding: const EdgeInsets.only(bottom: 16),
//         itemCount: rejectedLands.length,
//         itemBuilder: (context, index) {
//           final land = rejectedLands[index];
//           return _rejectedLandCard(land);
//         },
//       ),
//     );
//   }

//   // -------------------------------------------------------------
//   // REJECTED LAND CARD (New widget for rejected lands)
//   // -------------------------------------------------------------
//   Widget _rejectedLandCard(Map<String, dynamic> land) {
//     // Extract data from API response
//     final landId =
//         land['id']?.toString() ?? land['land_id']?.toString() ?? 'N/A';
//     final farmerName =
//         land['farmer_details']?['name']?.toString() ?? 'Unknown Farmer';
//     final village =
//         land['land_location']?['village']?.toString() ?? 'Unknown Village';
//     final remarks = land['remarks']?.toString() ?? 'No remarks provided';
//     final date =
//         land['updated_at']?.toString() ?? land['created_at']?.toString() ?? '';

//     // Get rejection status
//     final verification = land['verification']?.toString() ?? 'rejected';
//     final isRejected = verification == 'rejected';

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.red.shade100, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header with ID and status
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   "Land ID: $landId",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red.shade800,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade50,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.red.shade200),
//                 ),
//                 child: Text(
//                   isRejected ? "REJECTED" : "PENDING REVIEW",
//                   style: TextStyle(
//                     color: Colors.red.shade800,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 12),

//           // Farmer Details
//           Row(
//             children: [
//               Icon(Icons.person_outline, size: 16, color: Colors.grey),
//               SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   "Farmer: $farmerName",
//                   style: TextStyle(fontSize: 14),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 8),

//           // Village
//           Row(
//             children: [
//               Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
//               SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   "Village: $village",
//                   style: TextStyle(fontSize: 14),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 8),

//           // Rejection Remarks
//           if (remarks.isNotEmpty && remarks != 'No remarks provided')
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.comment_outlined,
//                       size: 16,
//                       color: Colors.orange,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       "Remarks:",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.orange.shade800,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 4),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 24),
//                   child: Text(
//                     remarks,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey.shade700,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//           SizedBox(height: 12),

//           // Footer with date and action
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Rejected on: ${_formatDate(date)}",
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Add functionality to view/edit rejected land
//                   print('View details for land: $landId');
//                 },
//                 icon: Icon(Icons.visibility_outlined, color: Colors.red),
//                 tooltip: "View Details",
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------------------------------------------------
//   // DRAFT CARD (Keep existing)
//   // -------------------------------------------------------------
//   Widget _entryCard({required String title, required String date}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 6),
//               Text(
//                 "Last saved: $date",
//                 style: TextStyle(fontSize: 13, color: Colors.black54),
//               ),
//             ],
//           ),
//           Icon(Icons.open_in_new, color: Colors.black54),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';

class RegionalDetails extends StatefulWidget {
  const RegionalDetails({super.key});

  @override
  State<RegionalDetails> createState() => _RegionalDetailsState();
}

class _RegionalDetailsState extends State<RegionalDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String baseUrl = "http://72.61.169.226";
  String? _apiToken;

  // States for API data
  List<dynamic> draftLands = [];
  List<dynamic> rejectedLands = [];

  bool isLoadingDrafts = false;
  bool isLoadingRejected = false;

  bool hasErrorDrafts = false;
  bool hasErrorRejected = false;

  String errorMessageDrafts = '';
  String errorMessageRejected = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadToken();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
  }

  // ========== FETCH DRAFT LANDS API ==========
  Future<void> _fetchDraftLands() async {
    if (_apiToken == null) {
      await loadToken();
      if (_apiToken == null) {
        setState(() {
          hasErrorDrafts = true;
          errorMessageDrafts = 'Authentication token not found';
        });
        return;
      }
    }

    setState(() {
      isLoadingDrafts = true;
      hasErrorDrafts = false;
      errorMessageDrafts = '';
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/regional/land/draft'),
        headers: {'Authorization': 'Bearer $_apiToken'},
      );

      print('Draft API Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _processDraftApiResponse(data);
      } else {
        setState(() {
          hasErrorDrafts = true;
          errorMessageDrafts = 'Failed to fetch drafts: ${response.statusCode}';
          draftLands = [];
        });
      }
    } catch (e) {
      print('Error fetching drafts: $e');
      setState(() {
        hasErrorDrafts = true;
        errorMessageDrafts = 'Error: $e';
        draftLands = [];
      });
    } finally {
      setState(() => isLoadingDrafts = false);
    }
  }

  void _processDraftApiResponse(dynamic data) {
    print('Draft API data type: ${data.runtimeType}');

    // Case 1: Direct list
    if (data is List) {
      print('Found ${data.length} draft lands');
      setState(() {
        draftLands = data;
      });
      return;
    }

    // Case 2: Map with 'data' key
    if (data is Map && data.containsKey('data')) {
      final apiData = data['data'];
      print('Draft data key type: ${apiData.runtimeType}');

      if (apiData is List) {
        setState(() {
          draftLands = apiData;
        });
      }
      // Case 3: Map inside Map (key-value pairs)
      else if (apiData is Map) {
        List<dynamic> landList = [];
        apiData.forEach((key, value) {
          if (value is Map) {
            landList.add({'id': key.toString(), ...value});
          }
        });
        print('Processed ${landList.length} draft lands from map');
        setState(() {
          draftLands = landList;
        });
      }
      return;
    }

    // Case 4: Empty or unexpected format
    print('Unexpected draft API format');
    setState(() {
      draftLands = [];
    });
  }

  // ========== FETCH REJECTED LANDS API ==========
  Future<void> _fetchRejectedLands() async {
    if (_apiToken == null) {
      await loadToken();
      if (_apiToken == null) {
        setState(() {
          hasErrorRejected = true;
          errorMessageRejected = 'Authentication token not found';
        });
        return;
      }
    }

    setState(() {
      isLoadingRejected = true;
      hasErrorRejected = false;
      errorMessageRejected = '';
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/regional/land/rejected'),
        headers: {'Authorization': 'Bearer $_apiToken'},
      );

      print('Rejected API Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _processRejectedApiResponse(data);
      } else {
        setState(() {
          hasErrorRejected = true;
          errorMessageRejected =
              'Failed to fetch rejected lands: ${response.statusCode}';
          rejectedLands = [];
        });
      }
    } catch (e) {
      print('Error fetching rejected lands: $e');
      setState(() {
        hasErrorRejected = true;
        errorMessageRejected = 'Error: $e';
        rejectedLands = [];
      });
    } finally {
      setState(() => isLoadingRejected = false);
    }
  }

  void _processRejectedApiResponse(dynamic data) {
    print('Rejected API data type: ${data.runtimeType}');

    // Case 1: Direct list
    if (data is List) {
      print('Found ${data.length} rejected lands');
      setState(() {
        rejectedLands = data;
      });
      return;
    }

    // Case 2: Map with 'data' key
    if (data is Map && data.containsKey('data')) {
      final apiData = data['data'];
      print('Rejected data key type: ${apiData.runtimeType}');

      if (apiData is List) {
        setState(() {
          rejectedLands = apiData;
        });
      }
      // Case 3: Map inside Map (key-value pairs)
      else if (apiData is Map) {
        List<dynamic> landList = [];
        apiData.forEach((key, value) {
          if (value is Map) {
            landList.add({'id': key.toString(), ...value});
          }
        });
        print('Processed ${landList.length} rejected lands from map');
        setState(() {
          rejectedLands = landList;
        });
      }
      return;
    }

    // Case 4: Empty or unexpected format
    print('Unexpected rejected API format');
    setState(() {
      rejectedLands = [];
    });
  }

  // ========== FORMAT DATE STRING ==========
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Date not available';

    try {
      DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  // ========== EXTRACT LAND TITLE ==========
  String _getLandTitle(Map<String, dynamic> land) {
    final landId =
        land['id']?.toString() ?? land['land_id']?.toString() ?? 'N/A';
    final surveyNo = land['land_details']?['survey_number']?.toString();

    if (surveyNo != null && surveyNo.isNotEmpty) {
      return "Land Submission - Survey #$surveyNo";
    }
    return "Land Submission - ID: $landId";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Regionalhomepage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F8FC),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Land Entry Management",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.black),
              tooltip: "Refresh All",
              onPressed: () {
                if (_tabController.index == 0) {
                  _fetchDraftLands();
                } else {
                  _fetchRejectedLands();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Continue your saved drafts or correct returned entries.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 20),

              _buildTabBar(),

              const SizedBox(height: 20),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildDraftList(), _buildReviewAgainList()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // TAB BAR
  // -------------------------------------------------------------
  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE9EFF6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        onTap: (index) {
          if (index == 0 && draftLands.isEmpty && !isLoadingDrafts) {
            _fetchDraftLands();
          } else if (index == 1 &&
              rejectedLands.isEmpty &&
              !isLoadingRejected) {
            _fetchRejectedLands();
          }
        },
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Drafts"),
                SizedBox(width: 6),
                if (isLoadingDrafts)
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.blue,
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      draftLands.length.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Review Again"),
                SizedBox(width: 6),
                if (isLoadingRejected)
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.red,
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      rejectedLands.length.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // DRAFTS LIST (Updated with API data)
  // -------------------------------------------------------------
  Widget _buildDraftList() {
    // Show loading
    if (isLoadingDrafts) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 16),
            Text(
              "Loading draft lands...",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Show error
    if (hasErrorDrafts) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              "Error loading drafts",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                errorMessageDrafts,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _fetchDraftLands,
              icon: Icon(Icons.refresh),
              label: Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    // Show empty state
    if (draftLands.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.drafts_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No draft lands found",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _fetchDraftLands,
              icon: Icon(Icons.refresh),
              label: Text("Load Drafts"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    // Show list of draft lands
    return RefreshIndicator(
      onRefresh: () async {
        await _fetchDraftLands();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: draftLands.length,
        itemBuilder: (context, index) {
          final land = draftLands[index];
          return _draftLandCard(land);
        },
      ),
    );
  }

  // -------------------------------------------------------------
  // DRAFT LAND CARD
  // -------------------------------------------------------------
  Widget _draftLandCard(Map<String, dynamic> land) {
    final landId =
        land['id']?.toString() ?? land['land_id']?.toString() ?? 'N/A';
    final farmerName =
        land['farmer_details']?['name']?.toString() ?? 'Unknown Farmer';
    final village =
        land['land_location']?['village']?.toString() ?? 'Unknown Village';
    final date =
        land['updated_at']?.toString() ?? land['created_at']?.toString() ?? '';
    final surveyNo = land['land_details']?['survey_number']?.toString() ?? '';
    final status = land['status']?.toString() ?? 'draft';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with ID and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  surveyNo.isNotEmpty
                      ? "Survey #$surveyNo"
                      : "Land ID: $landId",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Farmer Details
          Row(
            children: [
              Icon(Icons.person_outline, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Farmer: $farmerName",
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Village
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Village: $village",
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Land Details
          Row(
            children: [
              Icon(Icons.square_foot_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Area: ${land['land_details']?['land_area']?.toString() ?? '0'} Acres",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "₹${land['land_details']?['total_land_price']?.toString() ?? '0'}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Footer with date and action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last saved: ${_formatDate(date)}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              IconButton(
                onPressed: () {
                  // Add functionality to edit draft land
                  print('Edit draft for land: $landId');
                },
                icon: Icon(Icons.edit_outlined, color: Colors.blue),
                tooltip: "Edit Draft",
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // REVIEW AGAIN LIST (Updated with API data)
  // -------------------------------------------------------------
  Widget _buildReviewAgainList() {
    // Show loading
    if (isLoadingRejected) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 16),
            Text(
              "Loading rejected lands...",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Show error
    if (hasErrorRejected) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              "Error loading rejected lands",
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                errorMessageRejected,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _fetchRejectedLands,
              icon: Icon(Icons.refresh),
              label: Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    // Show empty state
    if (rejectedLands.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_returned_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              "No rejected lands found",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _fetchRejectedLands,
              icon: Icon(Icons.refresh),
              label: Text("Load Rejected Lands"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    // Show list of rejected lands
    return RefreshIndicator(
      onRefresh: () async {
        await _fetchRejectedLands();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: rejectedLands.length,
        itemBuilder: (context, index) {
          final land = rejectedLands[index];
          return _rejectedLandCard(land);
        },
      ),
    );
  }

  // -------------------------------------------------------------
  // REJECTED LAND CARD
  // -------------------------------------------------------------
  Widget _rejectedLandCard(Map<String, dynamic> land) {
    final landId =
        land['id']?.toString() ?? land['land_id']?.toString() ?? 'N/A';
    final farmerName =
        land['farmer_details']?['name']?.toString() ?? 'Unknown Farmer';
    final village =
        land['land_location']?['village']?.toString() ?? 'Unknown Village';
    final remarks =
        land['remarks']?.toString() ??
        land['rejection_reason']?.toString() ??
        'No remarks provided';
    final date =
        land['updated_at']?.toString() ?? land['created_at']?.toString() ?? '';
    final surveyNo = land['land_details']?['survey_number']?.toString() ?? '';

    final verification = land['verification']?.toString() ?? 'rejected';
    final isRejected = verification == 'rejected';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with ID and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  surveyNo.isNotEmpty
                      ? "Survey #$surveyNo"
                      : "Land ID: $landId",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Text(
                  isRejected ? "REJECTED" : "PENDING REVIEW",
                  style: TextStyle(
                    color: Colors.red.shade800,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Farmer Details
          Row(
            children: [
              Icon(Icons.person_outline, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Farmer: $farmerName",
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Village
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Village: $village",
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Land Details
          Row(
            children: [
              Icon(Icons.square_foot_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Area: ${land['land_details']?['land_area']?.toString() ?? '0'} Acres",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "₹${land['land_details']?['total_land_price']?.toString() ?? '0'}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Rejection Remarks
          if (remarks.isNotEmpty && remarks != 'No remarks provided')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: 16,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Remarks:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    remarks,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),

          SizedBox(height: 12),

          // Footer with date and action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rejected on: ${_formatDate(date)}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // View details
                      print('View details for land: $landId');
                    },
                    icon: Icon(Icons.visibility_outlined, color: Colors.red),
                    tooltip: "View Details",
                  ),
                  IconButton(
                    onPressed: () {
                      // Edit rejected land
                      print('Edit rejected land: $landId');
                    },
                    icon: Icon(Icons.edit_outlined, color: Colors.blue),
                    tooltip: "Edit",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
