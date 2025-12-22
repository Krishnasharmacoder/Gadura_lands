// import 'package:flutter/material.dart';
// import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';

// class Regionalwallet extends StatefulWidget {
//   const Regionalwallet({super.key});

//   @override
//   State<Regionalwallet> createState() => _RegionalwalletState();
// }

// class _RegionalwalletState extends State<Regionalwallet> {
//   // Sample data
//   final List<Map<String, dynamic>> dueLedger = [
//     {
//       'date': '24 Jul',
//       'landOwner': 'Mr. Mike Ross',
//       'physicalVerification': 'Verified',
//       'monthEndAmount': '¥125',
//       'paidStatus': 'Paid',
//     },
//     {
//       'date': '23 Jul',
//       'landOwner': 'Ms. Rachel Zane',
//       'physicalVerification': 'Verified',
//       'monthEndAmount': '¥125',
//       'paidStatus': 'Unpaid',
//     },
//   ];

//   final List<Map<String, dynamic>> travelLedger = [
//     {
//       'date': '25 Jul',
//       'totalDistance': '70 km',
//       'travelAmount': 'P175',
//       'paidStatus': 'Unpaid',
//     },
//     {
//       'date': '24 Jul',
//       'totalDistance': '45 km',
//       'travelAmount': 'P113',
//       'paidStatus': 'Paid',
//     },
//     {
//       'date': '23 Jul',
//       'totalDistance': '45 km',
//       'travelAmount': 'P113',
//       'paidStatus': 'Unpaid',
//     },
//   ];

//   final List<Map<String, dynamic>> landEntryLedger = [
//     {
//       'date': '25 Jul',
//       'landOwner': 'Mr. John Doe',
//       'verification': 'Verified',
//       'workAmount': 'P125',
//       'paidStatus': 'Unpaid',
//     },
//     {
//       'date': '25 Jul',
//       'landOwner': 'Ms. Jane Smith',
//       'verification': 'Verified',
//       'workAmount': 'P125',
//       'paidStatus': 'Unpaid',
//     },
//     {
//       'date': '24 Jul',
//       'landOwner': 'Mr. Mike Ross',
//       'verification': 'Verified',
//       'workAmount': 'P125',
//       'paidStatus': 'Paid',
//     },
//     {
//       'date': '24 Jul',
//       'landOwner': 'Mr. Sam Wilson',
//       'verification': 'Pending',
//       'workAmount': 'P125',
//       'paidStatus': 'Unpaid',
//     },
//     {
//       'date': '23 Jul',
//       'landOwner': 'Ms. Rachel Zane',
//       'verification': 'Verified',
//       'workAmount': 'P125',
//       'paidStatus': 'Unpaid',
//     },
//   ];

//   final List<Map<String, dynamic>> physicalVerificationLedger = [
//     {
//       'date': '24 Jul',
//       'landOwner': 'Mr. Mike Ross',
//       'amount': 'P25',
//       'status': 'Verified',
//       'paidStatus': 'Paid',
//     },
//     {
//       'date': '23 Jul',
//       'landOwner': 'Ms. Rachel Zane',
//       'amount': 'P25',
//       'status': 'Verified',
//       'paidStatus': 'Unpaid',
//     },
//   ];

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
//         appBar: AppBar(
//           title: const Text('Wallet'),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => Regionalhomepage()),
//               );
//             },
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // My Earnings Section
//               Container(
//                 margin: const EdgeInsets.all(16),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'My Earnings',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       'Review your daily work and earnings.',
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.orange[50],
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Total Due Amount',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   'P38',
//                                   style: TextStyle(
//                                     fontSize: 28,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.orange[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.green[50],
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Total Paid Amount',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   'P238',
//                                   style: TextStyle(
//                                     fontSize: 28,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.green[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               // Physical Verification Ledger
//               _buildLedgerCard(
//                 title: 'Physical Verification Ledger',
//                 child: Column(
//                   children: [
//                     _buildTableHeader(
//                       headers: [
//                         'Date',
//                         'Land Owner',
//                         'Amount',
//                         'Status',
//                         'Paid Status',
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     ...physicalVerificationLedger
//                         .map(
//                           (entry) => _buildTableRow(
//                             date: entry['date'],
//                             landOwner: entry['landOwner'],
//                             amount: entry['amount'],
//                             status: entry['status'],
//                             paidStatus: entry['paidStatus'],
//                           ),
//                         )
//                         .toList(),
//                   ],
//                 ),
//               ),

//               // Land Entry Ledger
//               _buildLedgerCard(
//                 title: 'Land Entry Ledger',
//                 child: Column(
//                   children: [
//                     _buildTableHeader(
//                       headers: [
//                         'Date',
//                         'Land Owner',
//                         'Verification',
//                         'Work Amount',
//                         'Paid Status',
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     ...landEntryLedger
//                         .map(
//                           (entry) => _buildTableRow(
//                             date: entry['date'],
//                             landOwner: entry['landOwner'],
//                             amount: entry['workAmount'],
//                             status: entry['verification'],
//                             paidStatus: entry['paidStatus'],
//                           ),
//                         )
//                         .toList(),
//                   ],
//                 ),
//               ),

//               // Travel Ledger
//               _buildLedgerCard(
//                 title: 'Travel Ledger',
//                 child: Column(
//                   children: [
//                     _buildTableHeader(
//                       headers: [
//                         'Date',
//                         'Total Distance',
//                         'Travel Amount',
//                         'Paid Status',
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     ...travelLedger
//                         .map(
//                           (entry) => Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                             child: Row(
//                               children: [
//                                 Expanded(child: Text(entry['date'])),
//                                 Expanded(child: Text(entry['totalDistance'])),
//                                 Expanded(
//                                   child: Text(
//                                     entry['travelAmount'],
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: _buildStatusBadge(
//                                     entry['paidStatus'],
//                                     isPaid: entry['paidStatus'] == 'Paid',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ],
//                 ),
//               ),

//               // 30-Day Due Ledger
//               _buildLedgerCard(
//                 title: '30-Day Due Ledger',
//                 child: Column(
//                   children: [
//                     _buildTableHeader(
//                       headers: [
//                         'Date',
//                         'Land Owner',
//                         'Physical Verification',
//                         'Month End Amount',
//                         'Paid Status',
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     ...dueLedger
//                         .map(
//                           (entry) => _buildTableRow(
//                             date: entry['date'],
//                             landOwner: entry['landOwner'],
//                             amount: entry['monthEndAmount'],
//                             status: entry['physicalVerification'],
//                             paidStatus: entry['paidStatus'],
//                           ),
//                         )
//                         .toList(),
//                   ],
//                 ),
//               ),

//               // 30-Day Settlement (सबसे नीचे)
//               Container(
//                 margin: const EdgeInsets.all(16),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '30-Day Settlement',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total Month-End Amount',
//                           style: TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const SizedBox(width: 1),
//                         Text(
//                           'P250',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue[800],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLedgerCard({required String title, required Widget child}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 12),
//             child,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTableHeader({required List<String> headers}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: headers
//             .map(
//               (header) => Expanded(
//                 child: Text(
//                   header,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[700],
//                     fontSize: 13,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildTableRow({
//     required String date,
//     required String landOwner,
//     required String amount,
//     required String status,
//     required String paidStatus,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           Expanded(child: Text(date, textAlign: TextAlign.center)),
//           Expanded(child: Text(landOwner, textAlign: TextAlign.center)),
//           Expanded(
//             child: Text(
//               amount,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: _buildStatusBadge(status, isPaid: status == 'Verified'),
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: _buildStatusBadge(
//                 paidStatus,
//                 isPaid: paidStatus == 'Paid',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusBadge(String status, {required bool isPaid}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: isPaid ? Colors.green[50] : Colors.orange[50],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         status,
//         style: TextStyle(
//           color: isPaid ? Colors.green[800] : Colors.orange[800],
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Regionalwallet extends StatefulWidget {
  const Regionalwallet({super.key});

  @override
  State<Regionalwallet> createState() => _RegionalwalletState();
}

class _RegionalwalletState extends State<Regionalwallet> {
  final String baseUrl = "http://72.61.169.226";

  bool isLoading = true;
  String error = "";
  String? api_token;

  List<dynamic> travelLedger = [];
  List<dynamic> landLedger = [];
  List<dynamic> physicalLedger = [];
  List<dynamic> monthLedger = [];

  double totalDue = 0;
  double totalPaid = 0;
  double totalMonthEnd = 0;

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  // ================= INIT =================

  Future<void> loadAll() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      api_token = prefs.getString("auth_token");

      if (api_token == null) throw Exception("Token not found");

      await Future.wait([
        fetchTravel(),
        fetchLand(),
        fetchPhysical(),
        fetchMonth(),
      ]);

      calculateTotals();

      setState(() => isLoading = false);
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  // ================= APIs =================

  Future<void> fetchTravel() async {
    final res = await http.get(
      Uri.parse("$baseUrl/regional/travel-wallet"),
      headers: {"Authorization": "Bearer $api_token"},
    );
    final data = jsonDecode(res.body);
    travelLedger = data['data'] ?? [];
  }

  Future<void> fetchLand() async {
    final res = await http.get(
      Uri.parse("$baseUrl/regional/land-wallet"),
      headers: {"Authorization": "Bearer $api_token"},
    );
    final data = jsonDecode(res.body);
    landLedger = data['data'] ?? [];
  }

  Future<void> fetchPhysical() async {
    final res = await http.get(
      Uri.parse("$baseUrl/regional/physical/wallet"),
      headers: {"Authorization": "Bearer $api_token"},
    );
    final data = jsonDecode(res.body);
    physicalLedger = data['data'] ?? [];
  }

  Future<void> fetchMonth() async {
    final res = await http.get(
      Uri.parse("$baseUrl/regional/land-month-wallet"),
      headers: {"Authorization": "Bearer $api_token"},
    );
    final data = jsonDecode(res.body);
    monthLedger = data['data'] ?? [];

    totalMonthEnd =
        double.tryParse(data['total_amount']?.toString() ?? "0") ?? 0;
  }

  // ================= CALC =================

  void calculateTotals() {
    double due = 0;
    double paid = 0;

    void calc(List list) {
      for (var e in list) {
        final amount = double.tryParse(e['amount']?.toString() ?? "0") ?? 0;
        final status = (e['payment_status'] ?? e['paid_status'] ?? "")
            .toString();

        if (status.toLowerCase().contains("paid")) {
          paid += amount;
        } else {
          due += amount;
        }
      }
    }

    calc(travelLedger);
    calc(landLedger);
    calc(physicalLedger);
    calc(monthLedger);

    totalDue = due;
    totalPaid = paid;
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Regionalhomepage()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Wallet"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: const Color(0xfff7f8fc),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error.isNotEmpty
            ? Center(child: Text(error))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _topSummary(),
                    _ledger("Physical Verification Ledger", [
                      "Date",
                      "Land Owner",
                      "Amount",
                      "Status",
                      "Paid",
                    ], physicalLedger),
                    _ledger("Land Entry Ledger", [
                      "Date",
                      "Land Owner",
                      "Verify",
                      "Amount",
                      "Paid",
                    ], landLedger),
                    _ledger("Travel Ledger", [
                      "Date",
                      "Distance",
                      "Amount",
                      "Paid",
                    ], travelLedger),
                    _ledger("30-Day Due Ledger", [
                      "Date",
                      "Land Owner",
                      "Amount",
                      "Paid",
                    ], monthLedger),
                    _bottomSettlement(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }

  // ================= WIDGETS =================

  Widget _topSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Earnings",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _amountBox("Total Due Amount", totalDue, Colors.orange),
              const SizedBox(width: 16),
              _amountBox("Total Paid Amount", totalPaid, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _amountBox(String title, double value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              "P${value.toInt()}",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ledger(String title, List<String> headers, List data) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: headers
                .map(
                  (h) => Expanded(
                    child: Text(
                      h,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const Divider(),
          ...data.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(child: Text("${e['date'] ?? '-'}")),
                  Expanded(child: Text("${e['land_owner'] ?? '-'}")),
                  Expanded(child: Text("P${e['amount'] ?? 0}")),
                  Expanded(child: _chip(e['payment_status'] ?? "Unpaid")),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    final paid = text.toLowerCase().contains("paid");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: paid ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: paid ? Colors.green : Colors.orange,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _bottomSettlement() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "30-Day Settlement",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            "P${totalMonthEnd.toInt()}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
        ],
      ),
    );
  }
}
