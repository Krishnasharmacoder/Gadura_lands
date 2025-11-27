// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:gadura_land/Screens/Bottom%20navigation/session.dart';
// // import 'package:image_picker/image_picker.dart';

// // class LogExpensesPage extends StatefulWidget {
// //   const LogExpensesPage({super.key});

// //   @override
// //   State<LogExpensesPage> createState() => _LogExpensesPageState();
// // }

// // class _LogExpensesPageState extends State<LogExpensesPage> {
// //   final ImagePicker picker = ImagePicker();

// //   File? busTicketImage;
// //   File? odometerImage;

// //   // ---------------------- Pick Bus Ticket ----------------------
// //   Future<void> pickBusTicket() async {
// //     final XFile? img = await picker.pickImage(source: ImageSource.camera);
// //     if (img != null) {
// //       setState(() => busTicketImage = File(img.path));
// //     }
// //   }

// //   // ---------------------- Pick Odometer ----------------------
// //   Future<void> pickOdometer() async {
// //     final XFile? img = await picker.pickImage(source: ImageSource.camera);
// //     if (img != null) {
// //       setState(() => odometerImage = File(img.path));
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F6FA),

// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         foregroundColor: Colors.black,
// //         title: const Text("Log Expenses & Readings"),
// //       ),

// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),

// //         child: Column(
// //           children: [
// //             // ===============================================================
// //             // MAIN LOG EXPENSES CONTAINER
// //             // ===============================================================
// //             Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.05),
// //                     blurRadius: 8,
// //                   ),
// //                 ],
// //               ),

// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Text(
// //                     "Log Expenses & Readings",
// //                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                   ),

// //                   const SizedBox(height: 5),
// //                   const Text(
// //                     "Add your expenses and final odometer reading.",
// //                     style: TextStyle(color: Colors.grey),
// //                   ),

// //                   const SizedBox(height: 20),

// //                   // ---------------- Bus Expenses -----------------
// //                   const Text(
// //                     "🚍  Bus/Transport Charges",
// //                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //                   ),
// //                   const SizedBox(height: 8),

// //                   TextField(
// //                     keyboardType: TextInputType.number,
// //                     decoration: InputDecoration(
// //                       hintText: "Enter amount in ₱",
// //                       filled: true,
// //                       fillColor: const Color(0xFFF5F5F5),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                     ),
// //                   ),

// //                   const SizedBox(height: 12),

// //                   ElevatedButton.icon(
// //                     onPressed: pickBusTicket,
// //                     icon: const Icon(Icons.camera_alt_outlined),
// //                     label: const Text("Upload Bus Tickets"),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFFBDECC6),
// //                       foregroundColor: Colors.black87,
// //                       minimumSize: const Size(double.infinity, 48),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                     ),
// //                   ),

// //                   if (busTicketImage != null) ...[
// //                     const SizedBox(height: 10),
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(12),
// //                       child: Image.file(
// //                         busTicketImage!,
// //                         height: 150,
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                   ],

// //                   const SizedBox(height: 25),

// //                   // ---------------- End Odometer -----------------
// //                   const Text(
// //                     "🚲  End Odometer Reading",
// //                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //                   ),
// //                   const SizedBox(height: 8),

// //                   TextField(
// //                     keyboardType: TextInputType.number,
// //                     decoration: InputDecoration(
// //                       hintText: "Enter final kilometers",
// //                       filled: true,
// //                       fillColor: const Color(0xFFF5F5F5),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                     ),
// //                   ),

// //                   const SizedBox(height: 12),

// //                   ElevatedButton.icon(
// //                     onPressed: pickOdometer,
// //                     icon: const Icon(Icons.camera_alt_outlined),
// //                     label: const Text("Upload Odometer Photo"),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFFBDECC6),
// //                       foregroundColor: Colors.black87,
// //                       minimumSize: const Size(double.infinity, 48),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                     ),
// //                   ),

// //                   if (odometerImage != null) ...[
// //                     const SizedBox(height: 10),
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(12),
// //                       child: Image.file(
// //                         odometerImage!,
// //                         height: 150,
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                   ],

// //                   const SizedBox(height: 30),

// //                   // ---------------- Submit Button -----------------
// //                   ElevatedButton(
// //                     onPressed: () {
// //                       // Submit logic
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFF00A86B),
// //                       foregroundColor: Colors.white,
// //                       minimumSize: const Size(double.infinity, 55),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                     ),
// //                     child: const Text(
// //                       "Submit Final Readings",
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             // ===============================================================
// //             // STOP SESSION — SEPARATE CONTAINER OUTSIDE MAIN BOX
// //             // ===============================================================
// //             const SizedBox(height: 60),

// //             Container(
// //               padding: const EdgeInsets.all(18),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.05),
// //                     blurRadius: 8,
// //                   ),
// //                 ],
// //               ),
// //               child: Container(
// //                 height: 55,
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFFE45858),
// //                   borderRadius: BorderRadius.circular(14),
// //                 ),
// //                 child: InkWell(
// //                   onTap: () {
// //                     print("its working");
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => SessionPage()),
// //                     );
// //                   },
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: const [
// //                       Icon(Icons.stop_circle_outlined, color: Colors.white),
// //                       SizedBox(width: 8),
// //                       Text(
// //                         "Stop Session",
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 17,
// //                           fontWeight: FontWeight.w700,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:gadura_land/Screens/Bottom%20navigation/session.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LogExpensesPage extends StatefulWidget {
//   final int sessionId;

//   const LogExpensesPage({super.key, required this.sessionId});

//   @override
//   State<LogExpensesPage> createState() => _LogExpensesPageState();
// }

// class _LogExpensesPageState extends State<LogExpensesPage> {
//   final ImagePicker picker = ImagePicker();

//   File? endOdometerImage;
//   List<File> ticketImages = [];

//   TextEditingController endKmController = TextEditingController();
//   TextEditingController transportController = TextEditingController();

//   // =================== PICK END ODOMETER IMAGE ===================
//   Future<void> pickEndOdometer() async {
//     final XFile? img = await picker.pickImage(source: ImageSource.camera);
//     if (img != null) {
//       setState(() => endOdometerImage = File(img.path));
//     }
//   }

//   // =================== PICK MULTIPLE TICKET IMAGES ===================
//   Future<void> pickBusTickets() async {
//     final XFile? img = await picker.pickImage(source: ImageSource.camera);
//     if (img != null) {
//       setState(() => ticketImages.add(File(img.path)));
//     }
//   }

//   // =================== END SESSION API ===================
//   Future<void> endSessionApi() async {
//     if (endOdometerImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please upload ending odometer image")),
//       );
//       return;
//     }

//     final url = Uri.parse(
//       "http://72.61.169.226/agent/update/session/${widget.sessionId}",
//     );

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("auth_token");

//     var request = http.MultipartRequest("PUT", url);
//     request.headers["Authorization"] = "Bearer $token";

//     // TEXT FIELDS
//     //request.fields["end_time"] = "05:00 PM"; // static for now
//     request.fields["end_km"] = endKmController.text.trim();
//     request.fields["transport_charges"] = transportController.text.trim();

//     // END ODOMETER IMAGE
//     request.files.add(
//       await http.MultipartFile.fromPath('end_image', endOdometerImage!.path),
//     );

//     // MULTIPLE TICKET IMAGES
//     for (var file in ticketImages) {
//       request.files.add(
//         await http.MultipartFile.fromPath("ticket_image", file.path),
//       );
//     }

//     var response = await request.send();

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Session Ended Successfully!")),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const SessionPage()),
//       );
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Failed: ${response.statusCode}")));
//     }
//   }

//   // =================== UI ===================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         title: const Text("Log Expenses & Readings"),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // MAIN CARD
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),

//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Log Expenses & Readings",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 30),

//                   // TRANSPORT CHARGES
//                   const Text(
//                     "🚍 Transport Charges",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 8),
//                   TextField(
//                     controller: transportController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       hintText: "Enter amount in ₱",
//                       filled: true,
//                       fillColor: const Color(0xFFF5F5F5),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   ElevatedButton.icon(
//                     onPressed: pickBusTickets,
//                     icon: const Icon(Icons.camera_alt_outlined),
//                     label: const Text("Upload Bus Tickets"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFBDECC6),
//                       foregroundColor: Colors.black87,
//                       minimumSize: const Size(double.infinity, 48),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),

//                   // TICKET IMAGES PREVIEW
//                   if (ticketImages.isNotEmpty)
//                     Column(
//                       children: ticketImages.map((img) {
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 10),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.file(
//                               img,
//                               height: 150,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),

//                   const SizedBox(height: 25),

//                   // END ODOMETER
//                   const Text(
//                     "🚲 End Odometer Reading",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 8),

//                   TextField(
//                     controller: endKmController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       hintText: "Enter final kilometers",
//                       filled: true,
//                       fillColor: const Color(0xFFF5F5F5),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   ElevatedButton.icon(
//                     onPressed: pickEndOdometer,
//                     icon: const Icon(Icons.camera_alt_outlined),
//                     label: const Text("Upload Odometer Photo"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFBDECC6),
//                       foregroundColor: Colors.black87,
//                       minimumSize: const Size(double.infinity, 48),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),

//                   if (endOdometerImage != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(
//                           endOdometerImage!,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),

//                   const SizedBox(height: 30),

//                   // SUBMIT BUTTON
//                   ElevatedButton(
//                     onPressed: () {
//                       endSessionApi();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF00A86B),
//                       foregroundColor: Colors.white,
//                       minimumSize: const Size(double.infinity, 55),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Submit Final Readings",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 60),

//             // STOP SESSION BOTTOM
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: Container(
//                 height: 55,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE45858),
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (_) => const SessionPage()),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.stop_circle_outlined, color: Colors.white),
//                       SizedBox(width: 8),
//                       Text(
//                         "Stop Session",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/session.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogExpensesPage extends StatefulWidget {
  final int sessionId;

  const LogExpensesPage({super.key, required this.sessionId});

  @override
  State<LogExpensesPage> createState() => _LogExpensesPageState();
}

class _LogExpensesPageState extends State<LogExpensesPage> {
  final ImagePicker picker = ImagePicker();

  File? endOdometerImage;
  List<File> ticketImages = [];

  TextEditingController endKmController = TextEditingController();
  TextEditingController transportController = TextEditingController();

  bool isLoading = false;

  // =================== PICK END ODOMETER IMAGE ===================
  Future<void> pickEndOdometer() async {
    final XFile? img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() => endOdometerImage = File(img.path));
    }
  }

  // =================== PICK MULTIPLE TICKET IMAGES ===================
  Future<void> pickBusTickets() async {
    final XFile? img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() => ticketImages.add(File(img.path)));
    }
  }

  // =================== END SESSION API ===================
  Future<void> endSessionApi() async {
    if (endKmController.text.trim().isEmpty ||
        transportController.text.trim().isEmpty ||
        endOdometerImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    final url = Uri.parse(
      "http://72.61.169.226/agent/update/session/${widget.sessionId}",
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");

    var request = http.MultipartRequest("PUT", url);
    request.headers["Authorization"] = "Bearer $token";

    request.fields["end_km"] = endKmController.text.trim();
    request.fields["transport_charges"] = transportController.text.trim();

    // END ODOMETER IMAGE
    request.files.add(
      await http.MultipartFile.fromPath('end_image', endOdometerImage!.path),
    );

    // MULTIPLE TICKET IMAGES
    for (var file in ticketImages) {
      request.files.add(
        await http.MultipartFile.fromPath("ticket_image", file.path),
      );
    }

    var response = await request.send();

    setState(() => isLoading = false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      _showSuccessPopup();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed: ${response.statusCode}")));
    }
  }

  // =================== SUCCESS POPUP ===================
  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Success"),
        content: const Text("Session ended successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SessionPage()),
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // =================== UI ===================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Log Expenses & Readings"),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _expenseCard(),
                const SizedBox(height: 60),
                _stopSessionButton(),
              ],
            ),
          ),

          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  // =================== MAIN EXPENSE CARD ===================
  Widget _expenseCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Log Expenses & Readings",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          // TRANSPORT CHARGES
          const Text(
            "🚍 Transport Charges",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: transportController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration("Enter amount in ₱"),
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: pickBusTickets,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Upload Bus Tickets"),
            style: _uploadButtonStyle(),
          ),

          // TICKET IMAGES PREVIEW
          if (ticketImages.isNotEmpty)
            Column(
              children: ticketImages.map((img) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(img, height: 150, fit: BoxFit.cover),
                  ),
                );
              }).toList(),
            ),

          const SizedBox(height: 25),

          // END ODOMETER
          const Text(
            "🚲 End Odometer Reading",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: endKmController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration("Enter final kilometers"),
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: pickEndOdometer,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Upload Odometer Photo"),
            style: _uploadButtonStyle(),
          ),

          if (endOdometerImage != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  endOdometerImage!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          const SizedBox(height: 30),

          // SUBMIT BUTTON
          ElevatedButton(
            onPressed: endSessionApi,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A86B),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Submit Final Readings",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // =================== STOP SESSION BUTTON ===================
  Widget _stopSessionButton() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFE45858),
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SessionPage()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.stop_circle_outlined, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Stop Session",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =================== REUSABLE DECORATIONS ===================
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  ButtonStyle _uploadButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFBDECC6),
      foregroundColor: Colors.black87,
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
