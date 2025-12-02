// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:gadura_land/Screens/Bottom navigation/newland.dart';
// // // import 'package:gadura_land/Screens/homepage.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';

// // // class ReviewPage extends StatefulWidget {
// // //   const ReviewPage({super.key});

// // //   @override
// // //   State<ReviewPage> createState() => _ReviewPageState();
// // // }

// // // class _ReviewPageState extends State<ReviewPage> {
// // //   int selectedIndex = 0;
// // //   bool isLoading = false;
// // //   List<dynamic> landData = [];

// // //   String? _apiToken;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     loadTokenAndFetch();
// // //   }

// // //   // Load token then call API
// // //   Future<void> loadTokenAndFetch() async {
// // //     SharedPreferences prefs = await SharedPreferences.getInstance();
// // //     _apiToken = prefs.getString("auth_token");

// // //     if (_apiToken != null) {
// // //       fetchLandData();
// // //     } else {
// // //       ScaffoldMessenger.of(
// // //         context,
// // //       ).showSnackBar(const SnackBar(content: Text("Token not found")));
// // //     }
// // //   }

// // //   Future<void> fetchLandData() async {
// // //     setState(() => isLoading = true);

// // //     try {
// // //       final response = await http.get(
// // //         Uri.parse("http://72.61.169.226/field-executive/land"),
// // //         headers: {"Authorization": "Bearer $_apiToken"},
// // //       );

// // //       if (response.statusCode == 200) {
// // //         final jsonResponse = jsonDecode(response.body);

// // //         landData = jsonResponse["data"] ?? [];
// // //       } else {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text("Error: ${response.statusCode}")),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(
// // //         context,
// // //       ).showSnackBar(SnackBar(content: Text("Something went wrong: $e")));
// // //     }

// // //     setState(() => isLoading = false);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return WillPopScope(
// // //       onWillPop: () async {
// // //         bool exitPopup = await showDialog(
// // //           context: context,
// // //           builder: (context) => AlertDialog(
// // //             title: const Text("Exit Review"),
// // //             content: const Text("Do you really want to exit the app?"),
// // //             actions: [
// // //               TextButton(
// // //                 onPressed: () => Navigator.pop(context, false),
// // //                 child: const Text("No"),
// // //               ),
// // //               ElevatedButton(
// // //                 onPressed: () => Navigator.pop(context, true),
// // //                 child: const Text("Yes"),
// // //               ),
// // //             ],
// // //           ),
// // //         );

// // //         return exitPopup;
// // //       },
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text("Review"),
// // //           leading: IconButton(
// // //             icon: const Icon(Icons.arrow_back),
// // //             onPressed: () {
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(builder: (_) => const Homepage()),
// // //               );
// // //             },
// // //           ),
// // //         ),

// // //         body: Padding(
// // //           padding: const EdgeInsets.all(20.0),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               const Text(
// // //                 "Land Data Management",
// // //                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 20),

// // //               Container(
// // //                 padding: const EdgeInsets.all(5),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey.shade300,
// // //                   borderRadius: BorderRadius.circular(30),
// // //                 ),
// // //                 child: Row(
// // //                   children: [
// // //                     _optionButton("Re-view", 0),
// // //                     _optionButton("Draft", 1),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 20),

// // //               Expanded(
// // //                 child: isLoading
// // //                     ? const Center(child: CircularProgressIndicator())
// // //                     : landData.isEmpty
// // //                     ? const Center(
// // //                         child: Text(
// // //                           "No Land Data Found",
// // //                           style: TextStyle(fontSize: 20),
// // //                         ),
// // //                       )
// // //                     : ListView.builder(
// // //                         itemCount: landData.length,
// // //                         itemBuilder: (context, index) {
// // //                           final land = landData[index];

// // //                           return Card(
// // //                             elevation: 3,
// // //                             margin: const EdgeInsets.symmetric(vertical: 10),
// // //                             child: ListTile(
// // //                               title: Text(
// // //                                 "${land['land_location']['village'] ?? 'N/A'}",
// // //                                 style: const TextStyle(
// // //                                   fontWeight: FontWeight.bold,
// // //                                 ),
// // //                               ),
// // //                               subtitle: Column(
// // //                                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                                 children: [
// // //                                   Text(
// // //                                     "${land['farmer_details']['name'] ?? 'N/A'}",
// // //                                   ),
// // //                                   Row(
// // //                                     mainAxisAlignment:
// // //                                         MainAxisAlignment.spaceBetween,
// // //                                     mainAxisSize: MainAxisSize.max,
// // //                                     children: [
// // //                                       Text(
// // //                                         "${land['land_details']['land_area'] ?? 'N/A'}, ${land['land_details']['guntas'] ?? 'N/A'} guntas",
// // //                                       ),
// // //                                       Spacer(),
// // //                                       Text(
// // //                                         "${land['land_details']['total_land_price'] ?? 'N/A'}",
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               trailing: IconButton(
// // //                                 icon: const Icon(Icons.edit),
// // //                                 onPressed: () {
// // //                                   Navigator.push(
// // //                                     context,
// // //                                     MaterialPageRoute(
// // //                                       builder: (_) => NewLandPage(
// // //                                         landData:
// // //                                             land, // 👈 full land object pass ho raha hai
// // //                                       ),
// // //                                     ),
// // //                                   );
// // //                                 },
// // //                               ),
// // //                             ),
// // //                           );
// // //                         },
// // //                       ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _optionButton(String title, int index) {
// // //     bool isSelected = selectedIndex == index;

// // //     return Expanded(
// // //       child: GestureDetector(
// // //         onTap: () {
// // //           setState(() => selectedIndex = index);
// // //         },
// // //         child: AnimatedContainer(
// // //           duration: const Duration(milliseconds: 250),
// // //           padding: const EdgeInsets.symmetric(vertical: 12),
// // //           decoration: BoxDecoration(
// // //             color: isSelected ? Colors.blue : Colors.transparent,
// // //             borderRadius: BorderRadius.circular(30),
// // //           ),
// // //           child: Center(
// // //             child: Text(
// // //               title,
// // //               style: TextStyle(
// // //                 fontSize: 16,
// // //                 color: isSelected ? Colors.white : Colors.black87,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:gadura_land/Screens/Bottom navigation/newland.dart';
// // import 'package:gadura_land/Screens/homepage.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class ReviewPage extends StatefulWidget {
// //   const ReviewPage({super.key});

// //   @override
// //   State<ReviewPage> createState() => _ReviewPageState();
// // }

// // class _ReviewPageState extends State<ReviewPage> {
// //   int selectedIndex = 0; // 0 = Review, 1 = Draft
// //   bool isLoading = false;

// //   List<dynamic> landData = [];
// //   String? _apiToken;

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadTokenAndFetch();
// //   }

// //   /// Load token then call API
// //   Future<void> loadTokenAndFetch() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     _apiToken = prefs.getString("auth_token");

// //     if (_apiToken != null) {
// //       fetchLandData();
// //     } else {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(const SnackBar(content: Text("Token not found")));
// //     }
// //   }

// //   /// Fetch land data from API
// //   Future<void> fetchLandData() async {
// //     setState(() => isLoading = true);

// //     try {
// //       final response = await http.get(
// //         Uri.parse("http://72.61.169.226/field-executive/land"),
// //         headers: {"Authorization": "Bearer $_apiToken"},
// //       );

// //       if (response.statusCode == 200) {
// //         final jsonResponse = jsonDecode(response.body);
// //         landData = jsonResponse["data"] ?? [];
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("API Error: ${response.statusCode}")),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text("Something went wrong: $e")));
// //     }

// //     setState(() => isLoading = false);
// //   }

// //   Future<void> fetchDraftData() async {
// //     if (_apiToken == null) return;
// //     setState(() => isLoading = true);

// //     try {
// //       final response = await http.get(
// //         Uri.parse("http://72.61.169.226/field-executive/land/draft"),
// //         headers: {"Authorization": "Bearer $_apiToken"},
// //       );

// //       if (response.statusCode == 200) {
// //         final jsonResponse = jsonDecode(response.body);
// //         landData = jsonResponse['data'] ?? [];
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Draft fetch error: ${response.statusCode}")),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text("Something went wrong: $e")));
// //     }

// //     setState(() => isLoading = false);
// //   }

// //   /// Filter Data — Review & Draft
// //   List<dynamic> get reviewList =>
// //       landData.where((item) => item['status'] != "draft").toList();

// //   List<dynamic> get draftList =>
// //       landData.where((item) => item['status'] == "draft").toList();

// //   @override
// //   Widget build(BuildContext context) {
// //     final showList = selectedIndex == 0 ? reviewList : draftList;

// //     return WillPopScope(
// //       onWillPop: () async {
// //         bool exitPopup = await showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //             title: const Text("Exit Review"),
// //             content: const Text("Do you really want to exit?"),
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
// //         return exitPopup;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Review"),
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back),
// //             onPressed: () {
// //               Navigator.pushReplacement(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const Homepage()),
// //               );
// //             },
// //           ),
// //         ),

// //         // ---------------------------------------------------------
// //         body: Padding(
// //           padding: const EdgeInsets.all(20),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 "Land Data Management",
// //                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 20),

// //               /// ------------------- TOP FILTER BUTTONS -------------------
// //               Container(
// //                 padding: const EdgeInsets.all(5),
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey.shade300,
// //                   borderRadius: BorderRadius.circular(30),
// //                 ),
// //                 child: Row(
// //                   children: [_tabButton("Re-view", 0), _tabButton("Draft", 1)],
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               /// ------------------- LIST VIEW -------------------
// //               Expanded(
// //                 child: isLoading
// //                     ? const Center(child: CircularProgressIndicator())
// //                     : showList.isEmpty
// //                     ? const Center(
// //                         child: Text(
// //                           "No data found",
// //                           style: TextStyle(fontSize: 20),
// //                         ),
// //                       )
// //                     : ListView.builder(
// //                         itemCount: showList.length,
// //                         itemBuilder: (context, index) {
// //                           final land = showList[index];

// //                           return Card(
// //                             elevation: 3,
// //                             margin: const EdgeInsets.symmetric(vertical: 10),
// //                             child: ListTile(
// //                               title: Text(
// //                                 land['land_location']['village'] ?? "N/A",
// //                                 style: const TextStyle(
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),

// //                               subtitle: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Text(land['farmer_details']['name'] ?? "N/A"),
// //                                   Row(
// //                                     children: [
// //                                       Text(
// //                                         "${land['land_details']['land_area'] ?? 'N/A'} acres, "
// //                                         "${land['land_details']['guntas'] ?? 'N/A'} guntas",
// //                                       ),
// //                                       const Spacer(),
// //                                       Text(
// //                                         "${land['land_details']['total_land_price'] ?? 'N/A'}",
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),

// //                               trailing: IconButton(
// //                                 icon: const Icon(Icons.edit),
// //                                 onPressed: () {
// //                                   Navigator.push(
// //                                     context,
// //                                     MaterialPageRoute(
// //                                       builder: (_) =>
// //                                           NewLandPage(landData: land),
// //                                     ),
// //                                   );
// //                                 },
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// ------------------- TAB BUTTON WIDGET -------------------
// //   Widget_tabButton(String title, int index) {
// //     bool active = selectedIndex == index;

// //     return Expanded(
// //       child: GestureDetector(
// //         onTap: () {
// //           setState(() => selectedIndex = index);
// //           if (index == 1)
// //             fetchDraftData(); // 👈 fetch drafts
// //           else
// //             fetchLandData(); // 👈 normal review
// //         },
// //         child: AnimatedContainer(
// //           duration: const Duration(milliseconds: 250),
// //           padding: const EdgeInsets.symmetric(vertical: 12),
// //           decoration: BoxDecoration(
// //             color: active ? Colors.blue : Colors.transparent,
// //             borderRadius: BorderRadius.circular(30),
// //           ),
// //           child: Center(
// //             child: Text(
// //               title,
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 color: active ? Colors.white : Colors.black,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:gadura_land/Screens/Bottom navigation/newland.dart';
// import 'package:gadura_land/Screens/homepage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ReviewPage extends StatefulWidget {
//   const ReviewPage({super.key});

//   @override
//   State<ReviewPage> createState() => _ReviewPageState();
// }

// class _ReviewPageState extends State<ReviewPage> {
//   int selectedIndex = 0; // 0 = Review, 1 = Draft
//   bool isLoading = false;

//   List<dynamic> landData = [];
//   String? _apiToken;

//   @override
//   void initState() {
//     super.initState();
//     loadTokenAndFetch();
//   }

//   /// Load token from SharedPreferences
//   Future<void> loadTokenAndFetch() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _apiToken = prefs.getString("auth_token");

//     if (_apiToken != null) {
//       fetchLandData(); // initially fetch all lands
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Token not found")));
//     }
//   }

//   /// Fetch all lands (non-draft)
//   Future<void> fetchLandData() async {
//     setState(() => isLoading = true);

//     try {
//       final response = await http.get(
//         Uri.parse("http://72.61.169.226/field-executive/land"),
//         headers: {"Authorization": "Bearer $_apiToken"},
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         landData = jsonResponse["data"] ?? [];
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("API Error: ${response.statusCode}")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Something went wrong: $e")));
//     }

//     setState(() => isLoading = false);
//   }

//   /// Fetch draft lands
//   Future<void> fetchDraftData() async {
//     if (_apiToken == null) return;
//     setState(() => isLoading = true);

//     try {
//       final response = await http.get(
//         Uri.parse("http://72.61.169.226/field-executive/land/draft"),
//         headers: {"Authorization": "Bearer $_apiToken"},
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         landData = jsonResponse['data'] ?? [];
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Draft fetch error: ${response.statusCode}")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Something went wrong: $e")));
//     }

//     setState(() => isLoading = false);
//   }

//   /// Filter data
//   List<dynamic> get reviewList =>
//       landData.where((item) => item['status'] != "draft").toList();

//   List<dynamic> get draftList =>
//       landData.where((item) => item['status'] == "draft").toList();

//   @override
//   Widget build(BuildContext context) {
//     final showList = selectedIndex == 0 ? reviewList : draftList;

//     return WillPopScope(
//       onWillPop: () async {
//         bool exitPopup = await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Exit Review"),
//             content: const Text("Do you really want to exit?"),
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
//         appBar: AppBar(
//           title: const Text("Review"),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const Homepage()),
//               );
//             },
//           ),
//         ),

//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Land Data Management",
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),

//               // ------------------- TAB BUTTONS -------------------
//               Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [_tabButton("Re-view", 0), _tabButton("Draft", 1)],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ------------------- LIST VIEW -------------------
//               Expanded(
//                 child: isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : showList.isEmpty
//                     ? const Center(
//                         child: Text(
//                           "No data found",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: showList.length,
//                         itemBuilder: (context, index) {
//                           final land = showList[index];

//                           return Card(
//                             elevation: 3,
//                             margin: const EdgeInsets.symmetric(vertical: 10),
//                             child: ListTile(
//                               title: Text(
//                                 land['land_location']['village'] ?? "N/A",
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(land['farmer_details']['name'] ?? "N/A"),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "${land['land_details']['land_area'] ?? 'N/A'} acres, "
//                                         "${land['land_details']['guntas'] ?? 'N/A'} guntas",
//                                       ),
//                                       const Spacer(),
//                                       Text(
//                                         "${land['land_details']['total_land_price'] ?? 'N/A'}",
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               trailing: IconButton(
//                                 icon: const Icon(Icons.edit),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) =>
//                                           NewLandPage(landData: land),
//                                     ),
//                                   ).then((result) {
//                                     if (result == "draft") {
//                                       // Draft save हुआ → Draft tab open + fetch draft
//                                       setState(() => selectedIndex = 1);
//                                       fetchDraftData();
//                                     } else if (result == "submitted") {
//                                       // Final submit → Review tab open + fetch lands
//                                       setState(() => selectedIndex = 0);
//                                       fetchLandData();
//                                     } else {
//                                       // सिर्फ edit करके आया → जिस tab पर है वही reload
//                                       selectedIndex == 0
//                                           ? fetchLandData()
//                                           : fetchDraftData();
//                                     }
//                                   });
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ------------------- TAB BUTTON WIDGET -------------------
//   Widget _tabButton(String title, int index) {
//     bool active = selectedIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() => selectedIndex = index);

//           if (index == 1)
//             fetchDraftData(); // fetch draft tab
//           else
//             fetchLandData(); // fetch review tab
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: active ? Colors.blue : Colors.transparent,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: active ? Colors.white : Colors.black,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gadura_land/Screens/Bottom navigation/newland.dart';
import 'package:gadura_land/Screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int selectedIndex = 0; // 0 = Review, 1 = Draft
  bool isLoading = false;

  List<dynamic> landData = [];
  String? token;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("auth_token");

    if (token != null) {
      fetchSubmitted();
    }
  }

  // ------------------------------------------------------------
  // FETCH SUBMITTED LAND
  // ------------------------------------------------------------
  Future<void> fetchSubmitted() async {
    setState(() => isLoading = true);

    try {
      final response = await http.get(
        Uri.parse("http://72.61.169.226/field-executive/land"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        landData = jsonBody["data"] ?? [];
      } else {
        showSnack("Error fetching submitted: ${response.statusCode}");
      }
    } catch (e) {
      showSnack("Error: $e");
    }

    setState(() => isLoading = false);
  }

  // ------------------------------------------------------------
  // FETCH DRAFT LAND
  // ------------------------------------------------------------
  Future<void> fetchDrafts() async {
    setState(() => isLoading = true);

    try {
      final response = await http.get(
        Uri.parse("http://72.61.169.226/field-executive/land/draft"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        landData = jsonBody["data"] ?? [];
      } else {
        showSnack("Error fetching drafts: ${response.statusCode}");
      }
    } catch (e) {
      showSnack("Error: $e");
    }

    setState(() => isLoading = false);
  }

  void showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Homepage()),
            );
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ---------------- Tab Buttons ----------------
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [tabButton("Review", 0), tabButton("Draft", 1)],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : landData.isEmpty
                  ? const Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: landData.length,
                      itemBuilder: (context, index) {
                        final land = landData[index];

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(
                              land['land_location']?['village'] ?? "N/A",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(land['farmer_details']?['name'] ?? "N/A"),
                                Row(
                                  children: [
                                    Text(
                                      "${land['land_details']?['land_area'] ?? 'N/A'} acres, "
                                      "${land['land_details']?['guntas'] ?? 'N/A'} guntas",
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${land['land_details']?['total_land_price'] ?? 'N/A'}",
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NewLandPage(landData: land),
                                  ),
                                ).then((value) {
                                  // value = "draft" OR "submitted"
                                  if (value == "draft") {
                                    setState(() => selectedIndex = 1);
                                    fetchDrafts();
                                  } else if (value == "submitted") {
                                    setState(() => selectedIndex = 0);
                                    fetchSubmitted();
                                  } else {
                                    selectedIndex == 0
                                        ? fetchSubmitted()
                                        : fetchDrafts();
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Tab Button Widget ----------------
  Widget tabButton(String title, int index) {
    bool active = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedIndex = index);

          if (index == 0) {
            fetchSubmitted();
          } else {
            fetchDrafts();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: active ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
