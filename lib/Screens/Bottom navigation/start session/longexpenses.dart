// import 'package:flutter/material.dart';
// class LogExpensesPage extends StatelessWidget {
//   const LogExpensesPage({super.key});

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
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Log Expenses & Readings",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),

//               const SizedBox(height: 5),
//               const Text(
//                 "Add your expenses and final odometer reading.",
//                 style: TextStyle(color: Colors.grey),
//               ),

//               const SizedBox(height: 20),

//               // ---------------- Bus Charges ----------------
//               const Text(
//                 "🚍  Bus/Transport Charges",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 8),

//               TextField(
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: "Enter amount in ₱",
//                   filled: true,
//                   fillColor: const Color(0xFFF5F5F5),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.camera_alt_outlined),
//                 label: const Text("Upload Bus Tickets"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFBDECC6),
//                   foregroundColor: Colors.black87,
//                   minimumSize: const Size(double.infinity, 48),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // ---------------- Odometer Reading ----------------
//               const Text(
//                 "🚲  End Odometer Reading",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 8),

//               TextField(
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: "Enter final kilometers",
//                   filled: true,
//                   fillColor: const Color(0xFFF5F5F5),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.camera_alt_outlined),
//                 label: const Text("Upload Odometer Photo"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFBDECC6),
//                   foregroundColor: Colors.black87,
//                   minimumSize: const Size(double.infinity, 48),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // ---------------- Submit Button ----------------
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00A86B),
//                   foregroundColor: Colors.white,
//                   minimumSize: const Size(double.infinity, 55),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Submit Final Readings",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LogExpensesPage extends StatefulWidget {
  const LogExpensesPage({super.key});

  @override
  State<LogExpensesPage> createState() => _LogExpensesPageState();
}

class _LogExpensesPageState extends State<LogExpensesPage> {
  final ImagePicker picker = ImagePicker();

  File? busTicketImage;
  File? odometerImage;

  // ---------------------- Pick Bus Ticket ----------------------
  Future<void> pickBusTicket() async {
    final XFile? img = await picker.pickImage(source: ImageSource.camera);

    if (img != null) {
      setState(() {
        busTicketImage = File(img.path);
      });
    }
  }

  // ---------------------- Pick Odometer ----------------------
  Future<void> pickOdometer() async {
    final XFile? img = await picker.pickImage(source: ImageSource.camera);

    if (img != null) {
      setState(() {
        odometerImage = File(img.path);
      });
    }
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
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

              const SizedBox(height: 5),
              const Text(
                "Add your expenses and final odometer reading.",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // ===============================================================
              // BUS EXPENSES
              // ===============================================================
              const Text(
                "🚍  Bus/Transport Charges",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount in ₱",
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: pickBusTicket,
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text("Upload Bus Tickets"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBDECC6),
                  foregroundColor: Colors.black87,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              if (busTicketImage != null) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    busTicketImage!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],

              const SizedBox(height: 25),

              // ===============================================================
              // ODOMETER READING
              // ===============================================================
              const Text(
                "🚲  End Odometer Reading",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter final kilometers",
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: pickOdometer,
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text("Upload Odometer Photo"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBDECC6),
                  foregroundColor: Colors.black87,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              if (odometerImage != null) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    odometerImage!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],

              const SizedBox(height: 30),

              // ===============================================================
              // SUBMIT BUTTON
              // ===============================================================
              ElevatedButton(
                onPressed: () {},
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
        ),
      ),
    );
  }
}
