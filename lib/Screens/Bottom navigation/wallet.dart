// // // // // import 'package:flutter/material.dart';

// // // // // class WalletPage extends StatelessWidget {
// // // // //   const WalletPage({super.key});

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: const Text("Wallet"),
// // // // //         backgroundColor: Colors.white,
// // // // //         foregroundColor: Colors.black,
// // // // //         elevation: 0,
// // // // //       ),
// // // // //       body: SingleChildScrollView(
// // // // //         padding: const EdgeInsets.all(16),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             const Text(
// // // // //               "My Earnings",
// // // // //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // // // //             ),
// // // // //             const SizedBox(height: 4),
// // // // //             const Text(
// // // // //               "Review your daily work and earnings.",
// // // // //               style: TextStyle(color: Colors.grey),
// // // // //             ),
// // // // //             const SizedBox(height: 16),

// // // // //             // Total Due Card
// // // // //             Container(
// // // // //               padding: const EdgeInsets.all(18),
// // // // //               decoration: BoxDecoration(
// // // // //                 color: Colors.red.shade50,
// // // // //                 borderRadius: BorderRadius.circular(12),
// // // // //               ),
// // // // //               child: Row(
// // // // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                 children: const [
// // // // //                   Text(
// // // // //                     "Total Due Amount",
// // // // //                     style: TextStyle(fontSize: 18, color: Colors.red),
// // // // //                   ),
// // // // //                   Text(
// // // // //                     "₱38",
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 20,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                       color: Colors.red,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),

// // // // //             const SizedBox(height: 12),

// // // // //             // Total Paid Card
// // // // //             Container(
// // // // //               padding: const EdgeInsets.all(18),
// // // // //               decoration: BoxDecoration(
// // // // //                 color: Colors.green.shade50,
// // // // //                 borderRadius: BorderRadius.circular(12),
// // // // //               ),
// // // // //               child: Row(
// // // // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                 children: const [
// // // // //                   Text(
// // // // //                     "Total Paid Amount",
// // // // //                     style: TextStyle(fontSize: 18, color: Colors.green),
// // // // //                   ),
// // // // //                   Text(
// // // // //                     "₱238",
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 20,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                       color: Colors.green,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),

// // // // //             const SizedBox(height: 24),

// // // // //             const Text(
// // // // //               "🚴 Travel Ledger",
// // // // //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // // //             ),
// // // // //             const SizedBox(height: 16),

// // // // //             _ledgerItem("25 Jul", "70 km", "₱175", false),
// // // // //             _ledgerItem("24 Jul", "45 km", "₱113", true),
// // // // //             _ledgerItem("23 Jul", "45 km", "₱113", false),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _ledgerItem(String date, String distance, String amount, bool isPaid) {
// // // // //     return Container(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
// // // // //       margin: const EdgeInsets.only(bottom: 10),
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.white,
// // // // //         borderRadius: BorderRadius.circular(12),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //             color: Colors.grey.shade200,
// // // // //             spreadRadius: 2,
// // // // //             blurRadius: 5,
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       child: Row(
// // // // //         children: [
// // // // //           Expanded(
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Text(
// // // // //                   date,
// // // // //                   style: const TextStyle(
// // // // //                     fontSize: 16,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 4),
// // // // //                 Text(distance, style: const TextStyle(color: Colors.grey)),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //           Text(
// // // // //             amount,
// // // // //             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // // //           ),
// // // // //           const SizedBox(width: 12),
// // // // //           Container(
// // // // //             padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
// // // // //             decoration: BoxDecoration(
// // // // //               color: isPaid ? Colors.green.shade100 : Colors.orange.shade100,
// // // // //               borderRadius: BorderRadius.circular(20),
// // // // //             ),
// // // // //             child: Text(
// // // // //               isPaid ? "Paid" : "Unpaid",
// // // // //               style: TextStyle(
// // // // //                 color: isPaid ? Colors.green : Colors.orange,
// // // // //                 fontWeight: FontWeight.bold,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';

// // // // class WalletPage extends StatelessWidget {
// // // //   const WalletPage({super.key});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: const Text("Wallet"),
// // // //         backgroundColor: Colors.white,
// // // //         foregroundColor: Colors.black,
// // // //         elevation: 0,
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         padding: const EdgeInsets.all(16),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             const Text(
// // // //               "My Earnings",
// // // //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // // //             ),
// // // //             const SizedBox(height: 4),
// // // //             const Text(
// // // //               "Review your daily work and earnings.",
// // // //               style: TextStyle(color: Colors.grey),
// // // //             ),
// // // //             const SizedBox(height: 16),

// // // //             // Total Due Card
// // // //             Container(
// // // //               padding: const EdgeInsets.all(18),
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.red.shade50,
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //               ),
// // // //               child: Row(
// // // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                 children: const [
// // // //                   Text(
// // // //                     "Total Due Amount",
// // // //                     style: TextStyle(fontSize: 18, color: Colors.red),
// // // //                   ),
// // // //                   Text(
// // // //                     "₱38",
// // // //                     style: TextStyle(
// // // //                       fontSize: 20,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Colors.red,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),

// // // //             const SizedBox(height: 12),

// // // //             // Total Paid Card
// // // //             Container(
// // // //               padding: const EdgeInsets.all(18),
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.green.shade50,
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //               ),
// // // //               child: Row(
// // // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                 children: const [
// // // //                   Text(
// // // //                     "Total Paid Amount",
// // // //                     style: TextStyle(fontSize: 18, color: Colors.green),
// // // //                   ),
// // // //                   Text(
// // // //                     "₱238",
// // // //                     style: TextStyle(
// // // //                       fontSize: 20,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Colors.green,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),

// // // //             const SizedBox(height: 24),

// // // //             const Text(
// // // //               "🚴 Travel Ledger",
// // // //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // //             ),
// // // //             const SizedBox(height: 16),

// // // //             _ledgerItem("25 Jul", "70 km", "₱175", false),
// // // //             _ledgerItem("24 Jul", "45 km", "₱113", true),
// // // //             _ledgerItem("23 Jul", "45 km", "₱113", false),

// // // //             const SizedBox(height: 24),

// // // //             // Land Entry Ledger
// // // //             const Text(
// // // //               "📋 Land Entry Ledger",
// // // //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // //             ),
// // // //             SizedBox(height: 16),

// // // //              _landEntryLedgerItem("25 Jul", "Venkatesh Rao", true, "₱125"),
// // // //              _landEntryLedgerItem("25 Jul", "Lakshmi Devi", true, "₱125"),
// // // //             _landEntryLedgerItem("24 Jul", "Anand Reddy", true, "₱125"),
// // // //             const SizedBox(height: 24),

// // // //             // 30-Day Due Ledger
// // // //             const Text(
// // // //               "🗓️ 30-Day Due Ledger",
// // // //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // //             ),
// // // //             SizedBox(height: 16),

// // // //             // _dueLedgerItem("24 Jul", "Anand Reddy", true, "₱125"),
// // // //             // _dueLedgerItem("23 Jul", "Sarala", true, "₱125"),
// // // //             const SizedBox(height: 24),

// // // //             // 30-Day Settlement
// // // //             const Text(
// // // //               "🗓️ 30-Day Settlement",
// // // //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // // //             ),
// // // //             SizedBox(height: 16),
// // // //             Container(
// // // //               padding: const EdgeInsets.all(18),
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.blue.shade50,
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //               ),
// // // //               child: Row(
// // // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                 children: const [
// // // //                   Text(
// // // //                     "Total Month-End Amount",
// // // //                     style: TextStyle(fontSize: 18, color: Colors.blue),
// // // //                   ),
// // // //                   Text(
// // // //                     "₱250",
// // // //                     style: TextStyle(
// // // //                       fontSize: 20,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Colors.blue,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _ledgerItem(String date, String distance, String amount, bool isPaid) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
// // // //       margin: const EdgeInsets.only(bottom: 10),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.white,
// // // //         borderRadius: BorderRadius.circular(12),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //             color: Colors.grey.shade200,
// // // //             spreadRadius: 2,
// // // //             blurRadius: 5,
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       child: Row(
// // // //         children: [
// // // //           Expanded(
// // // //             child: Column(
// // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // //               children: [
// // // //                 Text(
// // // //                   date,
// // // //                   style: const TextStyle(
// // // //                     fontSize: 16,
// // // //                     fontWeight: FontWeight.bold,
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(height: 4),
// // // //                 Text(distance, style: const TextStyle(color: Colors.grey)),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           Text(
// // // //             amount,
// // // //             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // //           ),
// // // //           const SizedBox(width: 12),
// // // //           Container(
// // // //             padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
// // // //             decoration: BoxDecoration(
// // // //               color: isPaid ? Colors.green.shade100 : Colors.orange.shade100,
// // // //               borderRadius: BorderRadius.circular(20),
// // // //             ),
// // // //             child: Text(
// // // //               isPaid ? "Paid" : "Unpaid",
// // // //               style: TextStyle(
// // // //                 color: isPaid ? Colors.green : Colors.orange,
// // // //                 fontWeight: FontWeight.bold,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //     // --- Added New Sections Below ---

// // // //     Future<Widget> _landEntryLedgerItem(
// // // //       String date,
// // // //       String owner,
// // // //       bool verified,
// // // //       String amount,
// // // //     ) async {
// // // //       return Container(
// // // //         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
// // // //         margin: const EdgeInsets.only(bottom: 10),
// // // //         decoration: BoxDecoration(
// // // //           color: Colors.white,
// // // //           borderRadius: BorderRadius.circular(12),
// // // //           boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
// // // //         ),
// // // //         child: Row(
// // // //           children: [
// // // //             Expanded(
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text(
// // // //                     date,
// // // //                     style: const TextStyle(fontWeight: FontWeight.bold),
// // // //                   ),
// // // //                   Text(owner, style: const TextStyle(color: Colors.black87)),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //             Container(
// // // //               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.green.shade100,
// // // //                 borderRadius: BorderRadius.circular(20),
// // // //               ),
// // // //               child: const Text(
// // // //                 "Verified",
// // // //                 style: TextStyle(
// // // //                   color: Colors.green,
// // // //                   fontWeight: FontWeight.bold,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             const SizedBox(width: 10),
// // // //             Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
// // // //           ],
// // // //         ),
// // // //       );
// // // //     }

// // // //     Widget _dueLedgerItem(
// // // //       String date,
// // // //       String owner,
// // // //       bool verified,
// // // //       String amount,
// // // //     ) {
// // // //       return Container(
// // // //         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
// // // //         margin: const EdgeInsets.only(bottom: 10),
// // // //         decoration: BoxDecoration(
// // // //           color: Colors.white,
// // // //           borderRadius: BorderRadius.circular(12),
// // // //           boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
// // // //         ),
// // // //         child: Row(
// // // //           children: [
// // // //             Expanded(
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text(
// // // //                     date,
// // // //                     style: const TextStyle(fontWeight: FontWeight.bold),
// // // //                   ),
// // // //                   Text(owner, style: const TextStyle(color: Colors.black87)),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //             Container(
// // // //               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.green.shade100,
// // // //                 borderRadius: BorderRadius.circular(20),
// // // //               ),
// // // //               child: const Text(
// // // //                 "Verified",
// // // //                 style: TextStyle(
// // // //                   color: Colors.green,
// // // //                   fontWeight: FontWeight.bold,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             const SizedBox(width: 10),
// // // //             Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
// // // //           ],
// // // //         ),
// // // //       );
// // // //     }
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:gadura_land/Screens/homepage.dart';

// // // class WalletPage extends StatelessWidget {
// // //   const WalletPage({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return WillPopScope(
// // //       onWillPop: () async {
// // //         bool exitPopup = await showDialog(
// // //           context: context,
// // //           builder: (context) => AlertDialog(
// // //             title: const Text("Exit Wallet"),
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

// // //         return exitPopup; // true = exit, false = stay
// // //       },
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text("Wallet"),
// // //           leading: IconButton(
// // //             icon: const Icon(Icons.arrow_back),
// // //             onPressed: () {
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(
// // //                   builder: (_) => const Homepage(),
// // //                 ), // <-- Your homepage
// // //               );
// // //             },
// // //           ),
// // //           backgroundColor: Colors.white,
// // //           foregroundColor: Colors.black,
// // //           elevation: 0,
// // //         ),
// // //         body: SingleChildScrollView(
// // //           padding: const EdgeInsets.all(16),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               const Text(
// // //                 "My Earnings",
// // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 4),
// // //               const Text(
// // //                 "Review your daily work and earnings.",
// // //                 style: TextStyle(color: Colors.grey),
// // //               ),
// // //               const SizedBox(height: 16),

// // //               _summaryCard("Total Due Amount", "₱38", Colors.red),
// // //               const SizedBox(height: 12),
// // //               _summaryCard("Total Paid Amount", "₱238", Colors.green),

// // //               const SizedBox(height: 24),
// // //               const Text(
// // //                 "🚴 Travel Ledger",
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 16),

// // //               _ledgerItem("25 Jul", "70 km", "₱175", false),
// // //               _ledgerItem("24 Jul", "45 km", "₱113", true),
// // //               _ledgerItem("23 Jul", "45 km", "₱113", false),

// // //               const SizedBox(height: 24),
// // //               const Text(
// // //                 "📋 Land Entry Ledger",
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               SizedBox(height: 16),

// // //               _landEntryLedgerItem("25 Jul", "Venkatesh Rao", "₱125"),
// // //               _landEntryLedgerItem("25 Jul", "Lakshmi Devi", "₱125"),
// // //               _landEntryLedgerItem("24 Jul", "Anand Reddy", "₱125"),

// // //               const SizedBox(height: 24),
// // //               const Text(
// // //                 "🗓️ 30-Day Due Ledger",
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               SizedBox(height: 16),

// // //               _dueLedgerItem("24 Jul", "Anand Reddy", "₱125"),
// // //               _dueLedgerItem("23 Jul", "Sarala", "₱125"),

// // //               const SizedBox(height: 24),
// // //               const Text(
// // //                 "🗓️ 30-Day Settlement",
// // //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //               ),
// // //               SizedBox(height: 16),

// // //               Container(
// // //                 padding: const EdgeInsets.all(18),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.blue.shade50,
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: const [
// // //                     Text(
// // //                       "Total Month-End Amount",
// // //                       style: TextStyle(fontSize: 18, color: Colors.blue),
// // //                     ),
// // //                     Text(
// // //                       "₱250",
// // //                       style: TextStyle(
// // //                         fontSize: 20,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Colors.blue,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // Summary Card
// // //   Widget _summaryCard(String title, String amount, Color color) {
// // //     return Container(
// // //       padding: const EdgeInsets.all(18),
// // //       decoration: BoxDecoration(
// // //         color: color.withOpacity(0.1),
// // //         borderRadius: BorderRadius.circular(12),
// // //       ),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         children: [
// // //           Text(title, style: TextStyle(fontSize: 18, color: color)),
// // //           Text(
// // //             amount,
// // //             style: TextStyle(
// // //               fontSize: 20,
// // //               fontWeight: FontWeight.bold,
// // //               color: color,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Travel Ledger Item
// // //   Widget _ledgerItem(String date, String distance, String amount, bool isPaid) {
// // //     return _container(
// // //       Row(
// // //         children: [
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(date, style: bold()),
// // //                 SizedBox(height: 4),
// // //                 Text(distance, style: grey()),
// // //               ],
// // //             ),
// // //           ),
// // //           Text(amount, style: bold()),
// // //           const SizedBox(width: 12),
// // //           _statusChip(
// // //             isPaid ? "Paid" : "Unpaid",
// // //             isPaid ? Colors.green : Colors.orange,
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Land Entry Ledger Item
// // //   Widget _landEntryLedgerItem(String date, String owner, String amount) {
// // //     return _container(
// // //       Row(
// // //         children: [
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(date, style: bold()),
// // //                 Text(owner),
// // //               ],
// // //             ),
// // //           ),
// // //           _statusChip("Verified", Colors.green),
// // //           SizedBox(width: 10),
// // //           Text(amount, style: bold()),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Due Ledger Item
// // //   Widget _dueLedgerItem(String date, String owner, String amount) {
// // //     return _container(
// // //       Row(
// // //         children: [
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(date, style: bold()),
// // //                 Text(owner),
// // //               ],
// // //             ),
// // //           ),
// // //           _statusChip("Verified", Colors.green),
// // //           SizedBox(width: 10),
// // //           Text(amount, style: bold()),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Generic Container
// // //   Widget _container(Widget child) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
// // //       margin: const EdgeInsets.only(bottom: 10),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.grey.shade200,
// // //             spreadRadius: 2,
// // //             blurRadius: 5,
// // //           ),
// // //         ],
// // //       ),
// // //       child: child,
// // //     );
// // //   }

// // //   // Status Chip
// // //   Widget _statusChip(String text, Color color) {
// // //     return Container(
// // //       padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
// // //       decoration: BoxDecoration(
// // //         color: color.withOpacity(0.2),
// // //         borderRadius: BorderRadius.circular(20),
// // //       ),
// // //       child: Text(
// // //         text,
// // //         style: TextStyle(color: color, fontWeight: FontWeight.bold),
// // //       ),
// // //     );
// // //   }

// // //   TextStyle bold() =>
// // //       const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
// // //   TextStyle grey() => const TextStyle(color: Colors.grey);
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:gadura_land/Screens/homepage.dart';

// // class WalletPage extends StatelessWidget {
// //   const WalletPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         bool exitPopup = await showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //             title: const Text("Exit Wallet"),
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
// //         return exitPopup;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Wallet"),
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back),
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const Homepage()),
// //               );
// //             },
// //           ),
// //           backgroundColor: Colors.white,
// //           foregroundColor: Colors.black,
// //           elevation: 0,
// //         ),
// //         backgroundColor: const Color(0xfff7f8fc),
// //         body: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // TITLE
// //               const Text(
// //                 "My Earnings",
// //                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
// //               ),
// //               const SizedBox(height: 4),
// //               const Text(
// //                 "Review your daily work and earnings.",
// //                 style: TextStyle(color: Colors.black54, fontSize: 16),
// //               ),
// //               const SizedBox(height: 20),

// //               // ==========================
// //               // TOTAL DUE CARD
// //               // ==========================
// //               _summaryCard(
// //                 title: "Total Due Amount",
// //                 amount: "₱38",
// //                 color: Colors.red.shade400,
// //                 bgColor: Colors.red.shade50,
// //                 icon: Icons.arrow_downward_rounded,
// //               ),
// //               const SizedBox(height: 20),

// //               // TOTAL PAID CARD
// //               _summaryCard(
// //                 title: "Total Paid Amount",
// //                 amount: "₱238",
// //                 color: Colors.green.shade600,
// //                 bgColor: Colors.green.shade50,
// //                 icon: Icons.arrow_upward_rounded,
// //               ),

// //               const SizedBox(height: 30),

// //               // ==========================
// //               // TRAVEL LEDGER
// //               // ==========================
// //               _sectionTitle(
// //                 "Travel Ledger",
// //                 Icons.directions_bike,
// //                 Colors.green,
// //               ),
// //               _travelLedgerTable(),

// //               const SizedBox(height: 30),

// //               // ==========================
// //               // LAND ENTRY LEDGER
// //               // ==========================
// //               _sectionTitle("Land Entry Ledger", Icons.check_box, Colors.green),
// //               _landEntryLedgerTable(),

// //               const SizedBox(height: 30),

// //               // ==========================
// //               // 30 DAY DUE LEDGER
// //               // ==========================
// //               _sectionTitle(
// //                 "30-Day Due Ledger",
// //                 Icons.calendar_today,
// //                 Colors.green,
// //               ),
// //               _dueLedgerTable(),

// //               const SizedBox(height: 30),

// //               // ==========================
// //               // 30 DAY SETTLEMENT
// //               // ==========================
// //               _sectionTitle(
// //                 "30-Day Settlement",
// //                 Icons.calendar_month,
// //                 Colors.blue,
// //               ),
// //               _settlementCard(),

// //               const SizedBox(height: 40),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // ----------------------------------------------------------
// //   // SUMMARY CARD
// //   // ----------------------------------------------------------
// //   Widget _summaryCard({
// //     required String title,
// //     required String amount,
// //     required Color color,
// //     required Color bgColor,
// //     required IconData icon,
// //   }) {
// //     return Container(
// //       padding: const EdgeInsets.all(18),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
// //         ],
// //       ),
// //       child: Container(
// //         padding: const EdgeInsets.all(22),
// //         decoration: BoxDecoration(
// //           color: bgColor,
// //           borderRadius: BorderRadius.circular(20),
// //           border: Border.all(color: color, width: 2),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Row(
// //               children: [
// //                 Icon(icon, color: color, size: 26),
// //                 const SizedBox(width: 10),
// //                 Text(
// //                   title,
// //                   style: TextStyle(
// //                     color: color,
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 18,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Text(
// //               amount,
// //               style: TextStyle(
// //                 color: color,
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 22,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ----------------------------------------------------------
// //   // SECTION TITLE
// //   // ----------------------------------------------------------
// //   Widget _sectionTitle(String title, IconData icon, Color color) {
// //     return Row(
// //       children: [
// //         Icon(icon, color: color, size: 22),
// //         const SizedBox(width: 8),
// //         Text(
// //           title,
// //           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// //         ),
// //       ],
// //     );
// //   }

// //   // ----------------------------------------------------------
// //   // TRAVEL LEDGER TABLE
// //   // ----------------------------------------------------------
// //   Widget _travelLedgerTable() {
// //     return _tableContainer(
// //       children: [
// //         _tableHeader([
// //           "Date",
// //           "Total Distance",
// //           "Travel Amount",
// //           "Paid Status",
// //         ]),
// //         _tableDivider(),
// //         _travelRow("25 Jul", "70 km", "₱175", "Unpaid"),
// //         _travelRow("24 Jul", "45 km", "₱113", "Paid"),
// //         _travelRow("23 Jul", "45 km", "₱113", "Unpaid"),
// //       ],
// //     );
// //   }

// //   // ROW
// //   Widget _travelRow(
// //     String date,
// //     String distance,
// //     String amount,
// //     String status,
// //   ) {
// //     return _tableRow([
// //       date,
// //       distance,
// //       amount,
// //       _statusChip(
// //         status,
// //         status == "Paid" ? Colors.green : Colors.amber.shade700,
// //       ),
// //     ]);
// //   }

// //   // ----------------------------------------------------------
// //   // LAND ENTRY LEDGER TABLE
// //   // ----------------------------------------------------------
// //   Widget _landEntryLedgerTable() {
// //     return _tableContainer(
// //       children: [
// //         _tableHeader([
// //           "Date",
// //           "Land Owner",
// //           "Verification",
// //           "Work Amount",
// //           "Paid Status",
// //         ]),
// //         _tableDivider(),
// //         _landRow("25 Jul", "Venkatesh Rao", "Verified", "₱125", "Unpaid"),
// //         _landRow("25 Jul", "Lakshmi Devi", "Verified", "₱125", "Unpaid"),
// //         _landRow("24 Jul", "Anand Reddy", "Verified", "₱125", "Paid"),
// //         _landRow("24 Jul", "Krishna Murthy", "Pending", "---", "---"),
// //         _landRow("23 Jul", "Sarala", "Verified", "₱125", "Unpaid"),
// //       ],
// //     );
// //   }

// //   Widget _landRow(date, owner, verify, amount, status) {
// //     return _tableRow([
// //       date,
// //       owner,
// //       _statusChip(verify, verify == "Verified" ? Colors.green : Colors.orange),
// //       amount,
// //       status == "---"
// //           ? Text("---")
// //           : _statusChip(
// //               status,
// //               status == "Paid" ? Colors.green : Colors.grey.shade600,
// //             ),
// //     ]);
// //   }

// //   // ----------------------------------------------------------
// //   // DUE LEDGER TABLE
// //   // ----------------------------------------------------------
// //   Widget _dueLedgerTable() {
// //     return _tableContainer(
// //       children: [
// //         _tableHeader([
// //           "Date",
// //           "Land Owner",
// //           "Physical Verification",
// //           "Month End Amount",
// //           "Paid Status",
// //         ]),
// //         _tableDivider(),
// //         _dueRow("24 Jul", "Anand Reddy", "₱125", "Paid"),
// //         _dueRow("23 Jul", "Sarala", "₱125", "Unpaid"),
// //       ],
// //     );
// //   }

// //   Widget _dueRow(String date, String owner, String amount, String status) {
// //     return _tableRow([
// //       date,
// //       owner,
// //       _statusChip("Verified", Colors.green),
// //       amount,
// //       _statusChip(
// //         status,
// //         status == "Paid" ? Colors.green : Colors.amber.shade700,
// //       ),
// //     ]);
// //   }

// //   // ----------------------------------------------------------
// //   // 30 DAY SETTLEMENT CARD
// //   // ----------------------------------------------------------
// //   Widget _settlementCard() {
// //     return Container(
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
// //         ],
// //       ),
// //       child: Container(
// //         padding: const EdgeInsets.all(22),
// //         decoration: BoxDecoration(
// //           color: Colors.blue.shade50,
// //           borderRadius: BorderRadius.circular(20),
// //           border: Border.all(color: Colors.blue, width: 2),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: const [
// //             Text(
// //               "Total Month-End Amount",
// //               style: TextStyle(fontSize: 18, color: Colors.blue),
// //             ),
// //             Text(
// //               "₱250",
// //               style: TextStyle(
// //                 fontSize: 22,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.blue,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ----------------------------------------------------------
// //   // TABLE UTILITY WIDGETS
// //   // ----------------------------------------------------------
// //   Widget _tableContainer({required List<Widget> children}) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
// //         ],
// //       ),
// //       child: Column(children: children),
// //     );
// //   }

// //   Widget _tableHeader(List<String> headers) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: headers
// //           .map(
// //             (h) => Expanded(
// //               child: Text(
// //                 h,
// //                 style: const TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 15,
// //                 ),
// //               ),
// //             ),
// //           )
// //           .toList(),
// //     );
// //   }

// //   Widget _tableDivider() => const Padding(
// //     padding: EdgeInsets.symmetric(vertical: 10),
// //     child: Divider(),
// //   );

// //   Widget _tableRow(List<dynamic> values) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 12),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: values
// //             .map(
// //               (v) => Expanded(
// //                 child: v is Widget
// //                     ? v
// //                     : Text(v.toString(), style: const TextStyle(fontSize: 15)),
// //               ),
// //             )
// //             .toList(),
// //       ),
// //     );
// //   }

// //   Widget _statusChip(String text, Color color) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
// //       decoration: BoxDecoration(
// //         color: color.withOpacity(0.15),
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Text(
// //         text,
// //         style: TextStyle(
// //           color: color,
// //           fontWeight: FontWeight.bold,
// //           fontSize: 13,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:gadura_land/Screens/homepage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class WalletPage extends StatefulWidget {
//   const WalletPage({super.key});

//   @override
//   State<WalletPage> createState() => _WalletPageState();
// }

// class _WalletPageState extends State<WalletPage> {
//   // API URLs
//   final String baseUrl = "http://72.61.169.226";
//   String? _apiToken;

//   // State variables
//   Map<String, dynamic>? travelWalletData;
//   Map<String, dynamic>? landWalletData;
//   Map<String, dynamic>? landMonthWalletData;
//   bool isLoading = true;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchWalletData();
//     loadToken();
//   }

//   Future<void> loadToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _apiToken = prefs.getString("auth_token");
//   }

//   Future<void> fetchWalletData() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     try {
//       // Fetch all data in parallel
//       final responses = await Future.wait([
//         fetchTravelWallet(),
//         fetchLandWallet(),
//         fetchLandMonthWallet(),
//       ]);

//       setState(() {
//         travelWalletData = responses[0];
//         landWalletData = responses[1];
//         landMonthWalletData = responses[2];
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to load wallet data: $e';
//         isLoading = false;
//       });
//     }
//   }

//   Future<Map<String, dynamic>> fetchTravelWallet() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/field-executive/travel-wallet'),
//       headers: {'Authorization': 'Bearer $_apiToken'},
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load travel wallet data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchLandWallet() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/field-executive/land-wallet'),
//       headers: {'Authorization': 'Bearer $_apiToken'},
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load land wallet data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchLandMonthWallet() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/field-executive/land-month-wallet'),
//       headers: {'Authorization': 'Bearer $_apiToken'},
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load land month wallet data');
//     }
//   }

//   double getTotalDueAmount() {
//     double total = 0;

//     // Travel wallet due amount
//     if (travelWalletData != null && travelWalletData!['total_amount'] != null) {
//       total +=
//           double.tryParse(travelWalletData!['total_amount'].toString()) ?? 0;
//     }

//     // Land wallet due amount
//     if (landWalletData != null && landWalletData!['total_amount'] != null) {
//       total += double.tryParse(landWalletData!['total_amount'].toString()) ?? 0;
//     }

//     return total;
//   }

//   double getTotalPaidAmount() {
//     double total = 0;

//     // Add logic here based on your API response structure
//     // For example, if your APIs have 'paid_amount' field
//     if (travelWalletData != null && travelWalletData!['paid_amount'] != null) {
//       total +=
//           double.tryParse(travelWalletData!['paid_amount'].toString()) ?? 0;
//     }

//     if (landWalletData != null && landWalletData!['paid_amount'] != null) {
//       total += double.tryParse(landWalletData!['paid_amount'].toString()) ?? 0;
//     }

//     return total;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         bool exitPopup = await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Exit Wallet"),
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
//         appBar: AppBar(
//           title: const Text("Wallet"),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const Homepage()),
//               );
//             },
//           ),
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 0,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.refresh),
//               onPressed: fetchWalletData,
//               tooltip: 'Refresh',
//             ),
//           ],
//         ),
//         backgroundColor: const Color(0xfff7f8fc),
//         body: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : errorMessage.isNotEmpty
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       errorMessage,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: fetchWalletData,
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               )
//             : SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // TITLE
//                     const Text(
//                       "My Earnings",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     const Text(
//                       "Review your daily work and earnings.",
//                       style: TextStyle(color: Colors.black54, fontSize: 16),
//                     ),
//                     const SizedBox(height: 20),

//                     // ==========================
//                     // TOTAL DUE CARD
//                     // ==========================
//                     _summaryCard(
//                       title: "Total Due Amount",
//                       amount: "₱${getTotalDueAmount().toInt()}",
//                       color: Colors.red.shade400,
//                       bgColor: Colors.red.shade50,
//                       icon: Icons.arrow_downward_rounded,
//                     ),
//                     const SizedBox(height: 20),

//                     // TOTAL PAID CARD
//                     _summaryCard(
//                       title: "Total Paid Amount",
//                       amount: "₱${getTotalPaidAmount().toInt()}",
//                       color: Colors.green.shade600,
//                       bgColor: Colors.green.shade50,
//                       icon: Icons.arrow_upward_rounded,
//                     ),

//                     const SizedBox(height: 30),

//                     // ==========================
//                     // TRAVEL LEDGER
//                     // ==========================
//                     if (travelWalletData != null)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _sectionTitle(
//                             "Travel Ledger",
//                             Icons.directions_bike,
//                             Colors.green,
//                           ),
//                           _travelLedgerTable(travelWalletData!),
//                           const SizedBox(height: 30),
//                         ],
//                       ),

//                     // ==========================
//                     // LAND ENTRY LEDGER
//                     // ==========================
//                     if (landWalletData != null)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _sectionTitle(
//                             "Land Entry Ledger",
//                             Icons.check_box,
//                             Colors.green,
//                           ),
//                           _landEntryLedgerTable(landWalletData!),
//                           const SizedBox(height: 30),
//                         ],
//                       ),

//                     // ==========================
//                     // 30 DAY DUE LEDGER
//                     // ==========================
//                     if (landMonthWalletData != null)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _sectionTitle(
//                             "30-Day Due Ledger",
//                             Icons.calendar_today,
//                             Colors.green,
//                           ),
//                           _dueLedgerTable(landMonthWalletData!),
//                           const SizedBox(height: 30),
//                         ],
//                       ),

//                     // ==========================
//                     // 30 DAY SETTLEMENT
//                     // ==========================
//                     _sectionTitle(
//                       "30-Day Settlement",
//                       Icons.calendar_month,
//                       Colors.blue,
//                     ),
//                     _settlementCard(),

//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }

//   // ----------------------------------------------------------
//   // SUMMARY CARD
//   // ----------------------------------------------------------
//   Widget _summaryCard({
//     required String title,
//     required String amount,
//     required Color color,
//     required Color bgColor,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
//         ],
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(22),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: color, width: 2),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, color: color, size: 26),
//                 const SizedBox(width: 10),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: color,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                   ),
//                 ),
//               ],
//             ),
//             Text(
//               amount,
//               style: TextStyle(
//                 color: color,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ----------------------------------------------------------
//   // SECTION TITLE
//   // ----------------------------------------------------------
//   Widget _sectionTitle(String title, IconData icon, Color color) {
//     return Row(
//       children: [
//         Icon(icon, color: color, size: 22),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   // ----------------------------------------------------------
//   // TRAVEL LEDGER TABLE
//   // ----------------------------------------------------------
//   Widget _travelLedgerTable(Map<String, dynamic> data) {
//     // Adjust this based on your actual API response structure
//     List<dynamic> travelRecords = data['records'] ?? [];

//     return _tableContainer(
//       children: [
//         _tableHeader([
//           "Date",
//           "Total Distance",
//           "Travel Amount",
//           "Paid Status",
//         ]),
//         _tableDivider(),
//         if (travelRecords.isEmpty)
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Center(child: Text("No travel records found")),
//           )
//         else
//           ...travelRecords.map((record) {
//             return _travelRow(
//               record['date']?.toString() ?? 'N/A',
//               '${record['distance']?.toString() ?? '0'} km',
//               '₱${record['amount']?.toString() ?? '0'}',
//               record['status']?.toString() ?? 'Pending',
//             );
//           }).toList(),
//       ],
//     );
//   }

//   // ROW
//   Widget _travelRow(
//     String date,
//     String distance,
//     String amount,
//     String status,
//   ) {
//     return _tableRow([
//       date,
//       distance,
//       amount,
//       _statusChip(
//         status,
//         status.toLowerCase() == "paid" ? Colors.green : Colors.amber.shade700,
//       ),
//     ]);
//   }

//   // ----------------------------------------------------------
//   // LAND ENTRY LEDGER TABLE
//   // ----------------------------------------------------------
//   Widget _landEntryLedgerTable(Map<String, dynamic> data) {
//     // Adjust this based on your actual API response structure
//     List<dynamic> landRecords = data['records'] ?? [];

//     return _tableContainer(
//       children: [
//         _tableHeader([
//           "Date",
//           "Land Owner",
//           "Verification",
//           "Work Amount",
//           "Paid Status",
//         ]),
//         _tableDivider(),
//         if (landRecords.isEmpty)
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Center(child: Text("No land entry records found")),
//           )
//         else
//           ...landRecords.map((record) {
//             return _landRow(
//               record['date']?.toString() ?? 'N/A',
//               record['owner_name']?.toString() ?? 'Unknown',
//               record['verification_status']?.toString() ?? 'Pending',
//               '₱${record['amount']?.toString() ?? '0'}',
//               record['payment_status']?.toString() ?? 'Pending',
//             );
//           }).toList(),
//       ],
//     );
//   }

//   Widget _landRow(date, owner, verify, amount, status) {
//     return _tableRow([
//       date,
//       owner,
//       _statusChip(
//         verify,
//         verify.toLowerCase() == "verified" ? Colors.green : Colors.orange,
//       ),
//       amount,
//       status == "---"
//           ? const Text("---")
//           : _statusChip(
//               status,
//               status.toLowerCase() == "paid"
//                   ? Colors.green
//                   : Colors.grey.shade600,
//             ),
//     ]);
//   }

//   // ----------------------------------------------------------
//   // DUE LEDGER TABLE
//   // ----------------------------------------------------------
//   Widget _dueLedgerTable(Map<String, dynamic> data) {
//     // Adjust this based on your actual API response structure
//     List<dynamic> dueRecords = data['records'] ?? [];

//     return _tableContainer(
//       children: [
//         _tableHeader([
//           "Date",
//           "Land Owner",
//           "Physical Verification",
//           "Month End Amount",
//           "Paid Status",
//         ]),
//         _tableDivider(),
//         if (dueRecords.isEmpty)
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Center(child: Text("No due records found")),
//           )
//         else
//           ...dueRecords.map((record) {
//             return _dueRow(
//               record['date']?.toString() ?? 'N/A',
//               record['owner_name']?.toString() ?? 'Unknown',
//               '₱${record['amount']?.toString() ?? '0'}',
//               record['payment_status']?.toString() ?? 'Pending',
//             );
//           }).toList(),
//       ],
//     );
//   }

//   Widget _dueRow(String date, String owner, String amount, String status) {
//     return _tableRow([
//       date,
//       owner,
//       _statusChip("Verified", Colors.green),
//       amount,
//       _statusChip(
//         status,
//         status.toLowerCase() == "paid" ? Colors.green : Colors.amber.shade700,
//       ),
//     ]);
//   }

//   // ----------------------------------------------------------
//   // 30 DAY SETTLEMENT CARD
//   // ----------------------------------------------------------
//   Widget _settlementCard() {
//     double totalMonthEnd = 0;

//     // Calculate total month end amount from land month wallet
//     if (landMonthWalletData != null &&
//         landMonthWalletData!['total_amount'] != null) {
//       totalMonthEnd =
//           double.tryParse(landMonthWalletData!['total_amount'].toString()) ?? 0;
//     }

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
//         ],
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(22),
//         decoration: BoxDecoration(
//           color: Colors.blue.shade50,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.blue, width: 2),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "Total Month-End Amount",
//               style: TextStyle(fontSize: 18, color: Colors.blue),
//             ),
//             Text(
//               "₱${totalMonthEnd.toInt()}",
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ----------------------------------------------------------
//   // TABLE UTILITY WIDGETS
//   // ----------------------------------------------------------
//   Widget _tableContainer({required List<Widget> children}) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
//         ],
//       ),
//       child: Column(children: children),
//     );
//   }

//   Widget _tableHeader(List<String> headers) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: headers
//           .map(
//             (h) => Expanded(
//               child: Text(
//                 h,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }

//   Widget _tableDivider() => const Padding(
//     padding: EdgeInsets.symmetric(vertical: 10),
//     child: Divider(),
//   );

//   Widget _tableRow(List<dynamic> values) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: values
//             .map(
//               (v) => Expanded(
//                 child: v is Widget
//                     ? Center(child: v)
//                     : Text(
//                         v.toString(),
//                         style: const TextStyle(fontSize: 15),
//                         textAlign: TextAlign.center,
//                       ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }

//   Widget _statusChip(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           fontSize: 13,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  // API URLs
  final String baseUrl = "http://72.61.169.226";
  String? _apiToken;
  bool _isTokenLoaded = false;

  // State variables
  Map<String, dynamic>? travelWalletData;
  Map<String, dynamic>? landWalletData;
  Map<String, dynamic>? landMonthWalletData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      // First load the token
      await loadToken();

      // Then fetch wallet data
      await fetchWalletData();
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to initialize: $e';
        isLoading = false;
      });
    }
  }

  Future<void> loadToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _apiToken = prefs.getString("auth_token");

      if (_apiToken == null || _apiToken!.isEmpty) {
        throw Exception('No authentication token found');
      }

      setState(() {
        _isTokenLoaded = true;
      });
    } catch (e) {
      throw Exception('Failed to load token: $e');
    }
  }

  Future<void> fetchWalletData() async {
    if (!_isTokenLoaded || _apiToken == null) {
      setState(() {
        errorMessage = 'Authentication token not available';
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Fetch all data in parallel
      final responses = await Future.wait([
        fetchTravelWallet(),
        fetchLandWallet(),
        fetchLandMonthWallet(),
      ]);

      setState(() {
        travelWalletData = responses[0];
        landWalletData = responses[1];
        landMonthWalletData = responses[2];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load wallet data: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>> fetchTravelWallet() async {
    final response = await http.get(
      Uri.parse('$baseUrl/field-executive/travel-wallet'),
      headers: {'Authorization': 'Bearer $_apiToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Travel Wallet Response: $data'); // Debug log
      return data;
    } else {
      print(
        'Travel Wallet Error: ${response.statusCode} - ${response.body}',
      ); // Debug log
      throw Exception(
        'Failed to load travel wallet data: ${response.statusCode}',
      );
    }
  }

  Future<Map<String, dynamic>> fetchLandWallet() async {
    final response = await http.get(
      Uri.parse('$baseUrl/field-executive/land-wallet'),
      headers: {'Authorization': 'Bearer $_apiToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Land Wallet Response: $data'); // Debug log
      return data;
    } else {
      print(
        'Land Wallet Error: ${response.statusCode} - ${response.body}',
      ); // Debug log
      throw Exception(
        'Failed to load land wallet data: ${response.statusCode}',
      );
    }
  }

  Future<Map<String, dynamic>> fetchLandMonthWallet() async {
    final response = await http.get(
      Uri.parse('$baseUrl/field-executive/land-month-wallet'),
      headers: {'Authorization': 'Bearer $_apiToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Land Month Wallet Response: $data'); // Debug log
      return data;
    } else {
      print(
        'Land Month Wallet Error: ${response.statusCode} - ${response.body}',
      ); // Debug log
      throw Exception(
        'Failed to load land month wallet data: ${response.statusCode}',
      );
    }
  }

  double getTotalDueAmount() {
    double total = 0;

    // Travel wallet due amount
    if (travelWalletData != null && travelWalletData!['total_amount'] != null) {
      total +=
          double.tryParse(travelWalletData!['total_amount'].toString()) ?? 0;
    }

    // Land wallet due amount
    if (landWalletData != null && landWalletData!['total_amount'] != null) {
      total += double.tryParse(landWalletData!['total_amount'].toString()) ?? 0;
    }

    return total;
  }

  double getTotalPaidAmount() {
    double total = 0;

    // Travel wallet paid amount
    if (travelWalletData != null && travelWalletData!['paid_amount'] != null) {
      total +=
          double.tryParse(travelWalletData!['paid_amount'].toString()) ?? 0;
    }

    // Land wallet paid amount
    if (landWalletData != null && landWalletData!['paid_amount'] != null) {
      total += double.tryParse(landWalletData!['paid_amount'].toString()) ?? 0;
    }

    // If no paid_amount field, check for settled_amount or similar
    if (total == 0) {
      // Alternative: check for settled transactions
      // This depends on your API response structure
      if (travelWalletData != null &&
          travelWalletData!['settled_amount'] != null) {
        total +=
            double.tryParse(travelWalletData!['settled_amount'].toString()) ??
            0;
      }
      if (landWalletData != null && landWalletData!['settled_amount'] != null) {
        total +=
            double.tryParse(landWalletData!['settled_amount'].toString()) ?? 0;
      }
    }

    return total;
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading wallet data...'),
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: fetchWalletData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Back press → homepage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Homepage()),
        );
        return false; // prevent default back
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Wallet"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Homepage()),
              );
            },
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: fetchWalletData,
              tooltip: 'Refresh',
            ),
          ],
        ),
        backgroundColor: const Color(0xfff7f8fc),
        body: isLoading
            ? _buildLoadingScreen()
            : errorMessage.isNotEmpty
            ? _buildErrorScreen()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    const Text(
                      "My Earnings",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Review your daily work and earnings.",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    // ==========================
                    // TOTAL DUE CARD
                    // ==========================
                    _summaryCard(
                      title: "Total Due Amount",
                      amount: "₱${getTotalDueAmount().toInt()}",
                      color: Colors.red.shade400,
                      bgColor: Colors.red.shade50,
                      icon: Icons.arrow_downward_rounded,
                    ),
                    const SizedBox(height: 20),

                    // TOTAL PAID CARD
                    _summaryCard(
                      title: "Total Paid Amount",
                      amount: "₱${getTotalPaidAmount().toInt()}",
                      color: Colors.green.shade600,
                      bgColor: Colors.green.shade50,
                      icon: Icons.arrow_upward_rounded,
                    ),

                    const SizedBox(height: 30),

                    // ==========================
                    // TRAVEL LEDGER
                    // ==========================
                    if (travelWalletData != null &&
                        (travelWalletData!['records'] != null ||
                            travelWalletData!['data'] != null))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(
                            "Travel Ledger",
                            Icons.directions_bike,
                            Colors.green,
                          ),
                          const SizedBox(height: 12),
                          _travelLedgerTable(travelWalletData!),
                          const SizedBox(height: 30),
                        ],
                      ),

                    // ==========================
                    // LAND ENTRY LEDGER
                    // ==========================
                    if (landWalletData != null &&
                        (landWalletData!['records'] != null ||
                            landWalletData!['data'] != null))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(
                            "Land Entry Ledger",
                            Icons.check_box,
                            Colors.green,
                          ),
                          const SizedBox(height: 12),
                          _landEntryLedgerTable(landWalletData!),
                          const SizedBox(height: 30),
                        ],
                      ),

                    // ==========================
                    // 30 DAY DUE LEDGER
                    // ==========================
                    if (landMonthWalletData != null &&
                        (landMonthWalletData!['records'] != null ||
                            landMonthWalletData!['data'] != null))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(
                            "30-Day Due Ledger",
                            Icons.calendar_today,
                            Colors.green,
                          ),
                          const SizedBox(height: 12),
                          _dueLedgerTable(landMonthWalletData!),
                          const SizedBox(height: 30),
                        ],
                      ),

                    // ==========================
                    // 30 DAY SETTLEMENT
                    // ==========================
                    _sectionTitle(
                      "30-Day Settlement",
                      Icons.calendar_month,
                      Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _settlementCard(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }

  // ----------------------------------------------------------
  // SUMMARY CARD
  // ----------------------------------------------------------
  Widget _summaryCard({
    required String title,
    required String amount,
    required Color color,
    required Color bgColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 26),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Text(
              amount,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // SECTION TITLE
  // ----------------------------------------------------------
  Widget _sectionTitle(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // TRAVEL LEDGER TABLE
  // ----------------------------------------------------------
  Widget _travelLedgerTable(Map<String, dynamic> data) {
    // Try multiple possible keys for records
    List<dynamic> travelRecords =
        data['records'] ?? data['data'] ?? data['travel_records'] ?? [];

    // If no records found, check for direct data
    if (travelRecords.isEmpty && data.isNotEmpty) {
      // Check if data itself is a list
      if (data['success'] != null && data['data'] is List) {
        travelRecords = data['data'];
      }
    }

    return _tableContainer(
      children: [
        _tableHeader([
          "Date",
          "Total Distance",
          "Travel Amount",
          "Paid Status",
        ]),
        _tableDivider(),
        if (travelRecords.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Text("No travel records found")),
          )
        else
          ...travelRecords.take(10).map((record) {
            return _travelRow(
              record['date']?.toString().substring(0, 10) ?? 'N/A',
              '${record['total_km']?.toString() ?? '0'} km',
              '₱${record['amount']?.toString() ?? '0'}',
              record['status']?.toString() ??
                  record['payment_status']?.toString() ??
                  'Pending',
            );
          }).toList(),
      ],
    );
  }

  // ROW
  Widget _travelRow(
    String date,
    String distance,
    String amount,
    String status,
  ) {
    return _tableRow([
      Text(date, style: const TextStyle(fontSize: 14)),
      Text(distance, style: const TextStyle(fontSize: 14)),
      Text(
        amount,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      _statusChip(
        status,
        status.toLowerCase().contains("paid")
            ? Colors.green
            : Colors.amber.shade700,
      ),
    ]);
  }

  // ----------------------------------------------------------
  // LAND ENTRY LEDGER TABLE
  // ----------------------------------------------------------
  Widget _landEntryLedgerTable(Map<String, dynamic> data) {
    // Try multiple possible keys for records
    List<dynamic> landRecords =
        data['records'] ?? data['data'] ?? data['land_records'] ?? [];

    // If no records found, check for direct data
    if (landRecords.isEmpty && data.isNotEmpty) {
      // Check if data itself is a list
      if (data['success'] != null && data['data'] is List) {
        landRecords = data['data'];
      }
    }

    return _tableContainer(
      children: [
        _tableHeader([
          "Date",
          "Land Owner",
          "Verification",
          "Work Amount",
          "Paid Status",
        ]),
        _tableDivider(),
        if (landRecords.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Text("No land entry records found")),
          )
        else
          ...landRecords.take(10).map((record) {
            return _landRow(
              record['date']?.toString().substring(0, 10) ??
                  record['created_at']?.toString().substring(0, 10) ??
                  'N/A',
              record['farmer_name']?.toString() ??
                  record['land_owner']?.toString() ??
                  'Unknown',
              record['verification_status']?.toString() ??
                  record['status']?.toString() ??
                  'Pending',
              '₱${record['amount']?.toString() ?? record['work_amount']?.toString() ?? '0'}',
              record['payment_status']?.toString() ??
                  record['status']?.toString() ??
                  'Pending',
            );
          }).toList(),
      ],
    );
  }

  Widget _landRow(date, owner, verify, amount, status) {
    return _tableRow([
      Text(date, style: const TextStyle(fontSize: 14)),
      Text(owner, style: const TextStyle(fontSize: 14)),
      _statusChip(
        verify,
        verify.toLowerCase().contains("verified")
            ? Colors.green
            : Colors.orange,
      ),
      Text(
        amount,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      status == "---" || status == null
          ? const Text("---", style: TextStyle(fontSize: 14))
          : _statusChip(
              status,
              status.toLowerCase().contains("paid")
                  ? Colors.green
                  : Colors.grey.shade600,
            ),
    ]);
  }

  // ----------------------------------------------------------
  // DUE LEDGER TABLE
  // ----------------------------------------------------------
  Widget _dueLedgerTable(Map<String, dynamic> data) {
    // Try multiple possible keys for records
    List<dynamic> dueRecords =
        data['records'] ?? data['data'] ?? data['due_records'] ?? [];

    // If no records found, check for direct data
    if (dueRecords.isEmpty && data.isNotEmpty) {
      // Check if data itself is a list
      if (data['success'] != null && data['data'] is List) {
        dueRecords = data['data'];
      }
    }

    return _tableContainer(
      children: [
        _tableHeader([
          "Date",
          "Land Owner",
          "Physical Verification",
          "Month End Amount",
          "Paid Status",
        ]),
        _tableDivider(),
        if (dueRecords.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Text("No due records found")),
          )
        else
          ...dueRecords.take(10).map((record) {
            return _dueRow(
              record['date']?.toString().substring(0, 10) ??
                  record['due_date']?.toString().substring(0, 10) ??
                  'N/A',
              record['farmer_name']?.toString() ??
                  record['land_owner']?.toString() ??
                  'Unknown',
              '₱${record['amount']?.toString() ?? record['due_amount']?.toString() ?? '0'}',
              record['payment_status']?.toString() ??
                  record['status']?.toString() ??
                  'Pending',
            );
          }).toList(),
      ],
    );
  }

  Widget _dueRow(String date, String owner, String amount, String status) {
    return _tableRow([
      Text(date, style: const TextStyle(fontSize: 14)),
      Text(owner, style: const TextStyle(fontSize: 14)),
      _statusChip("Verified", Colors.green),
      Text(
        amount,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      _statusChip(
        status,
        status.toLowerCase().contains("paid")
            ? Colors.green
            : Colors.amber.shade700,
      ),
    ]);
  }

  // ----------------------------------------------------------
  // 30 DAY SETTLEMENT CARD
  // ----------------------------------------------------------
  Widget _settlementCard() {
    double totalMonthEnd = 0;

    // Calculate total month end amount from land month wallet
    if (landMonthWalletData != null) {
      totalMonthEnd =
          double.tryParse(
            landMonthWalletData!['total_amount']?.toString() ?? '0',
          ) ??
          0;

      // Try alternative keys
      if (totalMonthEnd == 0) {
        totalMonthEnd =
            double.tryParse(
              landMonthWalletData!['month_end_total']?.toString() ?? '0',
            ) ??
            0;
      }
      if (totalMonthEnd == 0) {
        totalMonthEnd =
            double.tryParse(
              landMonthWalletData!['settlement_amount']?.toString() ?? '0',
            ) ??
            0;
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Month-End Amount",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            Text(
              "₱${totalMonthEnd.toInt()}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // TABLE UTILITY WIDGETS
  // ----------------------------------------------------------
  Widget _tableContainer({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _tableHeader(List<String> headers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: headers
          .map(
            (h) => Expanded(
              child: Text(
                h,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _tableDivider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Divider(),
  );

  Widget _tableRow(List<Widget> values) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: values
            .asMap()
            .entries
            .map(
              (entry) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: entry.key == values.length - 1 ? 0 : 8,
                  ),
                  child: entry.value,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _statusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
