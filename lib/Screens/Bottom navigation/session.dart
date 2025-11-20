// import 'package:flutter/material.dart';

// import 'start session/longexpenses.dart';
// //import 'package:charts_flutter/flutter.dart' as charts;

// class SessionPage extends StatelessWidget {
//   const SessionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//       appBar: AppBar(
//         title: const Text("Sessions"),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ---------------------- Start New Session ----------------------
//             _sessionCard(context),

//             const SizedBox(height: 25),

//             // ---------------------- Weekly Chart ----------------------
//             // _weeklyChartCard(),
//             const SizedBox(height: 25),

//             // ---------------------- Session History ----------------------
//             _historyCard(),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // ----------------------------------------------------------
//   // Start Session Card
//   // ----------------------------------------------------------
//   Widget _sessionCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Start a New Session",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),

//           const SizedBox(height: 5),
//           const Text(
//             "Select your work type(s) and start the timer.",
//             style: TextStyle(color: Colors.grey),
//           ),

//           const SizedBox(height: 20),

//           const Text(
//             "2. Enter Starting Odometer",
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//           ),

//           const SizedBox(height: 10),

//           // Input box
//           TextField(
//             decoration: InputDecoration(
//               hintText: "e.g., 12345 km",
//               filled: true,
//               fillColor: const Color(0xFFF1F1F1),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),

//           const SizedBox(height: 15),

//           // Upload Button
//           OutlinedButton.icon(
//             onPressed: () {},
//             icon: const Icon(Icons.camera_alt_outlined),
//             label: const Text("Upload Odometer Photo"),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: Colors.black,
//               side: BorderSide(color: Colors.grey.shade300),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Start Session Button
//           // ElevatedButton.icon(
//           //   onPressed: () {},
//           //   icon: const Icon(Icons.play_arrow),
//           //   label: const Text("Start Session"),
//           //   style: ElevatedButton.styleFrom(
//           //     backgroundColor: const Color(0xFF00A86B),
//           //     foregroundColor: Colors.white,
//           //     minimumSize: const Size(double.infinity, 50),
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.circular(12),
//           //     ),
//           //   ),
//           // ),

//           // Start Session Button
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const LogExpensesPage(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.play_arrow),
//             label: const Text("Start Session"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF00A86B),
//               foregroundColor: Colors.white,
//               minimumSize: const Size(double.infinity, 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ----------------------------------------------------------
//   // Weekly Chart Card
//   // ----------------------------------------------------------
//   // Widget _weeklyChartCard() {
//   //   final data = [
//   //     WeeklyData("Week 1", 5),
//   //     WeeklyData("Week 2", 3),
//   //     WeeklyData("Week 3", 7),
//   //     WeeklyData("Week 4", 4),
//   //     WeeklyData("Week 5", 6),
//   //     WeeklyData("Week 6", 8),
//   //   ];

//   //   final series = [
//   //     charts.Series<WeeklyData, String>(
//   //       id: 'Lands',
//   //       domainFn: (WeeklyData data, _) => data.week,
//   //       measureFn: (WeeklyData data, _) => data.count,
//   //       data: data,
//   //       colorFn: (_, __) =>
//   //           charts.ColorUtil.fromDartColor(const Color(0xFF00A86B)),
//   //     ),
//   //   ];

//   //   return Container(
//   //     padding: const EdgeInsets.all(20),
//   //     decoration: BoxDecoration(
//   //       color: Colors.white,
//   //       borderRadius: BorderRadius.circular(18),
//   //       border: Border.all(color: Colors.grey.shade300),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Row(
//   //           children: const [
//   //             Icon(Icons.trending_up, color: Colors.green),
//   //             SizedBox(width: 6),
//   //             Text(
//   //               "Weekly New Land Entries",
//   //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //             ),
//   //           ],
//   //         ),

//   //         const SizedBox(height: 5),
//   //         const Text(
//   //           "A summary of new land entries over the last 8 weeks.",
//   //           style: TextStyle(color: Colors.grey),
//   //         ),

//   //         const SizedBox(height: 20),

//   //         SizedBox(height: 200, child: charts.BarChart(series, animate: true)),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // ----------------------------------------------------------
//   // Session History Card
//   // ----------------------------------------------------------
//   Widget _historyCard() {
//     List<String> dates = [
//       "15 July 2024",
//       "14 July 2024",
//       "13 July 2024",
//       "12 July 2024",
//       "11 July 2024",
//     ];

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: const [
//               Icon(Icons.check_circle, color: Colors.green),
//               SizedBox(width: 6),
//               Text(
//                 "Session & Work History",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),

//           const SizedBox(height: 5),
//           const Text(
//             "Your past work sessions and completed tasks.",
//             style: TextStyle(color: Colors.grey),
//           ),

//           const SizedBox(height: 20),

//           ...dates.map((d) => _dateItem(d)).toList(),
//         ],
//       ),
//     );
//   }

//   Widget _dateItem(String date) {
//     return Column(
//       children: [
//         ExpansionTile(
//           tilePadding: EdgeInsets.zero,
//           title: Row(
//             children: [
//               const Icon(Icons.calendar_today_outlined, size: 18),
//               const SizedBox(width: 10),
//               Text(date, style: const TextStyle(fontSize: 16)),
//             ],
//           ),
//           children: const [
//             ListTile(title: Text("• Work session details go here")),
//           ],
//         ),
//         const Divider(),
//       ],
//     );
//   }
// }

// class WeeklyData {
//   final String week;
//   final int count;
//   WeeklyData(this.week, this.count);
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/newland.dart';
import 'package:gadura_land/Screens/homepage.dart';
import 'package:image_picker/image_picker.dart';

import 'start session/longexpenses.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  XFile? odometerImage;
  final ImagePicker _picker = ImagePicker();

  // Pick Odometer Photo
  Future<void> pickOdometerImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        odometerImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Sessions"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const Homepage(),
              ), // <-- Your homepage
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sessionCard(context),
            const SizedBox(height: 25),
            _historyCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // Start Session Card
  // ----------------------------------------------------------
  Widget _sessionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Start a New Session",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),
          const Text(
            "Select your work type(s) and start the timer.",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          const Text(
            "2. Enter Starting Odometer",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          TextField(
            decoration: InputDecoration(
              hintText: "e.g., 12345 km",
              filled: true,
              fillColor: const Color(0xFFF1F1F1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Upload Button
          OutlinedButton.icon(
            onPressed: pickOdometerImage,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Upload Odometer Photo"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // Photo Preview
          if (odometerImage != null) ...[
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(odometerImage!.path),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Start Session Button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogExpensesPage(),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text("Start Session"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A86B),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // Session History Card
  // ----------------------------------------------------------
  Widget _historyCard() {
    List<String> dates = [
      "15 July 2024",
      "14 July 2024",
      "13 July 2024",
      "12 July 2024",
      "11 July 2024",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 6),
              Text(
                "Session & Work History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 5),
          const Text(
            "Your past work sessions and completed tasks.",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          ...dates.map((d) => _dateItem(d)).toList(),
        ],
      ),
    );
  }

  Widget _dateItem(String date) {
    return Column(
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 18),
              const SizedBox(width: 10),
              Text(date, style: const TextStyle(fontSize: 16)),
            ],
          ),
          children: const [
            ListTile(title: Text("• Work session details go here")),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class WeeklyData {
  final String week;
  final int count;
  WeeklyData(this.week, this.count);
}
