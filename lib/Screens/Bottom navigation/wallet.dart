// // import 'package:flutter/material.dart';

// // class WalletPage extends StatelessWidget {
// //   const WalletPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Wallet"),
// //         backgroundColor: Colors.white,
// //         foregroundColor: Colors.black,
// //         elevation: 0,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               "My Earnings",
// //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 4),
// //             const Text(
// //               "Review your daily work and earnings.",
// //               style: TextStyle(color: Colors.grey),
// //             ),
// //             const SizedBox(height: 16),

// //             // Total Due Card
// //             Container(
// //               padding: const EdgeInsets.all(18),
// //               decoration: BoxDecoration(
// //                 color: Colors.red.shade50,
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: const [
// //                   Text(
// //                     "Total Due Amount",
// //                     style: TextStyle(fontSize: 18, color: Colors.red),
// //                   ),
// //                   Text(
// //                     "₱38",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.red,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 12),

// //             // Total Paid Card
// //             Container(
// //               padding: const EdgeInsets.all(18),
// //               decoration: BoxDecoration(
// //                 color: Colors.green.shade50,
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: const [
// //                   Text(
// //                     "Total Paid Amount",
// //                     style: TextStyle(fontSize: 18, color: Colors.green),
// //                   ),
// //                   Text(
// //                     "₱238",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.green,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 24),

// //             const Text(
// //               "🚴 Travel Ledger",
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 16),

// //             _ledgerItem("25 Jul", "70 km", "₱175", false),
// //             _ledgerItem("24 Jul", "45 km", "₱113", true),
// //             _ledgerItem("23 Jul", "45 km", "₱113", false),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _ledgerItem(String date, String distance, String amount, bool isPaid) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
// //       margin: const EdgeInsets.only(bottom: 10),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.shade200,
// //             spreadRadius: 2,
// //             blurRadius: 5,
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   date,
// //                   style: const TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 Text(distance, style: const TextStyle(color: Colors.grey)),
// //               ],
// //             ),
// //           ),
// //           Text(
// //             amount,
// //             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(width: 12),
// //           Container(
// //             padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
// //             decoration: BoxDecoration(
// //               color: isPaid ? Colors.green.shade100 : Colors.orange.shade100,
// //               borderRadius: BorderRadius.circular(20),
// //             ),
// //             child: Text(
// //               isPaid ? "Paid" : "Unpaid",
// //               style: TextStyle(
// //                 color: isPaid ? Colors.green : Colors.orange,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class WalletPage extends StatelessWidget {
//   const WalletPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Wallet"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "My Earnings",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               "Review your daily work and earnings.",
//               style: TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 16),

//             // Total Due Card
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade50,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     "Total Due Amount",
//                     style: TextStyle(fontSize: 18, color: Colors.red),
//                   ),
//                   Text(
//                     "₱38",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Total Paid Card
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade50,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     "Total Paid Amount",
//                     style: TextStyle(fontSize: 18, color: Colors.green),
//                   ),
//                   Text(
//                     "₱238",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             const Text(
//               "🚴 Travel Ledger",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),

//             _ledgerItem("25 Jul", "70 km", "₱175", false),
//             _ledgerItem("24 Jul", "45 km", "₱113", true),
//             _ledgerItem("23 Jul", "45 km", "₱113", false),

//             const SizedBox(height: 24),

//             // Land Entry Ledger
//             const Text(
//               "📋 Land Entry Ledger",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),

//              _landEntryLedgerItem("25 Jul", "Venkatesh Rao", true, "₱125"),
//              _landEntryLedgerItem("25 Jul", "Lakshmi Devi", true, "₱125"),
//             _landEntryLedgerItem("24 Jul", "Anand Reddy", true, "₱125"),
//             const SizedBox(height: 24),

//             // 30-Day Due Ledger
//             const Text(
//               "🗓️ 30-Day Due Ledger",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),

//             // _dueLedgerItem("24 Jul", "Anand Reddy", true, "₱125"),
//             // _dueLedgerItem("23 Jul", "Sarala", true, "₱125"),
//             const SizedBox(height: 24),

//             // 30-Day Settlement
//             const Text(
//               "🗓️ 30-Day Settlement",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     "Total Month-End Amount",
//                     style: TextStyle(fontSize: 18, color: Colors.blue),
//                   ),
//                   Text(
//                     "₱250",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _ledgerItem(String date, String distance, String amount, bool isPaid) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             spreadRadius: 2,
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   date,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(distance, style: const TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),
//           Text(
//             amount,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(width: 12),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//             decoration: BoxDecoration(
//               color: isPaid ? Colors.green.shade100 : Colors.orange.shade100,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               isPaid ? "Paid" : "Unpaid",
//               style: TextStyle(
//                 color: isPaid ? Colors.green : Colors.orange,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//     // --- Added New Sections Below ---

//     Future<Widget> _landEntryLedgerItem(
//       String date,
//       String owner,
//       bool verified,
//       String amount,
//     ) async {
//       return Container(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//         margin: const EdgeInsets.only(bottom: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     date,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Text(owner, style: const TextStyle(color: Colors.black87)),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade100,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Text(
//                 "Verified",
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//       );
//     }

//     Widget _dueLedgerItem(
//       String date,
//       String owner,
//       bool verified,
//       String amount,
//     ) {
//       return Container(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//         margin: const EdgeInsets.only(bottom: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     date,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Text(owner, style: const TextStyle(color: Colors.black87)),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade100,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Text(
//                 "Verified",
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Earnings",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Review your daily work and earnings.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            _summaryCard("Total Due Amount", "₱38", Colors.red),
            const SizedBox(height: 12),
            _summaryCard("Total Paid Amount", "₱238", Colors.green),

            const SizedBox(height: 24),
            const Text(
              "🚴 Travel Ledger",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            _ledgerItem("25 Jul", "70 km", "₱175", false),
            _ledgerItem("24 Jul", "45 km", "₱113", true),
            _ledgerItem("23 Jul", "45 km", "₱113", false),

            const SizedBox(height: 24),
            const Text(
              "📋 Land Entry Ledger",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            _landEntryLedgerItem("25 Jul", "Venkatesh Rao", "₱125"),
            _landEntryLedgerItem("25 Jul", "Lakshmi Devi", "₱125"),
            _landEntryLedgerItem("24 Jul", "Anand Reddy", "₱125"),

            const SizedBox(height: 24),
            const Text(
              "🗓️ 30-Day Due Ledger",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            _dueLedgerItem("24 Jul", "Anand Reddy", "₱125"),
            _dueLedgerItem("23 Jul", "Sarala", "₱125"),

            const SizedBox(height: 24),
            const Text(
              "🗓️ 30-Day Settlement",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Total Month-End Amount",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  Text(
                    "₱250",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Summary Card
  Widget _summaryCard(String title, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, color: color)),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Travel Ledger Item
  Widget _ledgerItem(String date, String distance, String amount, bool isPaid) {
    return _container(
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: bold()),
                SizedBox(height: 4),
                Text(distance, style: grey()),
              ],
            ),
          ),
          Text(amount, style: bold()),
          const SizedBox(width: 12),
          _statusChip(
            isPaid ? "Paid" : "Unpaid",
            isPaid ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }

  // Land Entry Ledger Item
  Widget _landEntryLedgerItem(String date, String owner, String amount) {
    return _container(
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: bold()),
                Text(owner),
              ],
            ),
          ),
          _statusChip("Verified", Colors.green),
          SizedBox(width: 10),
          Text(amount, style: bold()),
        ],
      ),
    );
  }

  // Due Ledger Item
  Widget _dueLedgerItem(String date, String owner, String amount) {
    return _container(
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: bold()),
                Text(owner),
              ],
            ),
          ),
          _statusChip("Verified", Colors.green),
          SizedBox(width: 10),
          Text(amount, style: bold()),
        ],
      ),
    );
  }

  // Generic Container
  Widget _container(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }

  // Status Chip
  Widget _statusChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  TextStyle bold() =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle grey() => const TextStyle(color: Colors.grey);
}
