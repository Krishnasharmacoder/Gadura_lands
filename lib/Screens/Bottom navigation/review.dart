// import 'package:flutter/material.dart';
// import 'package:gadura_land/Screens/Bottom navigation/newland.dart';
// import 'package:gadura_land/Screens/homepage.dart';

// class ReviewPage extends StatefulWidget {
//   const ReviewPage({super.key});

//   @override
//   State<ReviewPage> createState() => _ReviewPageState();
// }

// class _ReviewPageState extends State<ReviewPage> {
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         bool exitPopup = await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Exit Review"),
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
//         appBar: AppBar(
//           title: const Text("Review"),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const Homepage(),
//                 ), // <-- Your homepage
//               );
//             },
//           ),
//         ),

//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Land Data Management",
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),

//               Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     _optionButton("Re-check", 0),
//                     _optionButton("Draft", 1),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 40),

//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const NewLandPage()),
//                     );
//                   },
//                   icon: const Icon(Icons.edit),
//                   label: const Text("Edit Form"),
//                 ),
//               ),

//               const SizedBox(height: 40),

//               Center(
//                 child: Text(
//                   selectedIndex == 0
//                       ? "Re-check Mode Enabled"
//                       : "Draft Mode Enabled",
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _optionButton(String title, int index) {
//     bool isSelected = selectedIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() => selectedIndex = index);
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.blue : Colors.transparent,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: isSelected ? Colors.white : Colors.black87,
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
  int selectedIndex = 0;
  bool isLoading = false;
  List<dynamic> landData = [];

  String? _apiToken;

  @override
  void initState() {
    super.initState();
    loadTokenAndFetch();
  }

  // Load token then call API
  Future<void> loadTokenAndFetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");

    if (_apiToken != null) {
      fetchLandData();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Token not found")));
    }
  }

  // 🔥 API CALL
  // Future<void> fetchLandData() async {
  //   setState(() => isLoading = true);

  //   try {
  //     final response = await http.get(
  //       Uri.parse("http://72.61.169.226/field-executive/land"),
  //       headers: {"Authorization": "Bearer $_apiToken"},
  //     );

  //     if (response.statusCode == 200) {
  //       landData = jsonDecode(response.body);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Error: ${response.statusCode}")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Error: $e")));
  //   }

  //   setState(() => isLoading = false);
  // }

  Future<void> fetchLandData() async {
    setState(() => isLoading = true);

    try {
      final response = await http.get(
        Uri.parse("http://72.61.169.226/field-executive/land"),
        headers: {"Authorization": "Bearer $_apiToken"},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        landData = jsonResponse["data"] ?? [];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong: $e")));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitPopup = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit Review"),
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
        appBar: AppBar(
          title: const Text("Review"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Homepage()),
              );
            },
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Land Data Management",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _optionButton("Re-check", 0),
                    _optionButton("Draft", 1),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : landData.isEmpty
                    ? const Center(
                        child: Text(
                          "No Land Data Found",
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
                                "${land['land_location']['village'] ?? 'N/A'}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${land['farmer_details']['name'] ?? 'N/A'}",
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "${land['land_details']['land_area'] ?? 'N/A'}, ${land['land_details']['guntas'] ?? 'N/A'} guntas",
                                      ),
                                      Spacer(),
                                      Text(
                                        "${land['land_details']['total_land_price'] ?? 'N/A'}",
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
                                      builder: (_) => const NewLandPage(),
                                    ),
                                  );
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
      ),
    );
  }

  Widget _optionButton(String title, int index) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedIndex = index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
