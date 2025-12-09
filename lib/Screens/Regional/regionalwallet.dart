import 'package:flutter/material.dart';

class Regionalwallet extends StatefulWidget {
  const Regionalwallet({super.key});

  @override
  State<Regionalwallet> createState() => _RegionalwalletState();
}

class _RegionalwalletState extends State<Regionalwallet> {
  // Sample data
  final List<Map<String, dynamic>> dueLedger = [
    {
      'date': '24 Jul',
      'landOwner': 'Mr. Mike Ross',
      'physicalVerification': 'Verified',
      'monthEndAmount': 'P125',
      'paidStatus': 'Paid',
    },
    {
      'date': '23 Jul',
      'landOwner': 'Ms. Rachel Zane',
      'physicalVerification': 'Verified',
      'monthEndAmount': 'P125',
      'paidStatus': 'Unpaid',
    },
  ];

  final List<Map<String, dynamic>> travelLedger = [
    {
      'date': '25 Jul',
      'totalDistance': '70 km',
      'travelAmount': 'P175',
      'paidStatus': 'Unpaid',
    },
    {
      'date': '24 Jul',
      'totalDistance': '45 km',
      'travelAmount': 'P113',
      'paidStatus': 'Paid',
    },
    {
      'date': '23 Jul',
      'totalDistance': '45 km',
      'travelAmount': 'P113',
      'paidStatus': 'Unpaid',
    },
  ];

  final List<Map<String, dynamic>> landEntryLedger = [
    {
      'date': '25 Jul',
      'landOwner': 'Mr. John Doe',
      'verification': 'Verified',
      'workAmount': 'P125',
      'paidStatus': 'Unpaid',
    },
    {
      'date': '25 Jul',
      'landOwner': 'Ms. Jane Smith',
      'verification': 'Verified',
      'workAmount': 'P125',
      'paidStatus': 'Unpaid',
    },
    {
      'date': '24 Jul',
      'landOwner': 'Mr. Mike Ross',
      'verification': 'Verified',
      'workAmount': 'P125',
      'paidStatus': 'Paid',
    },
    {
      'date': '24 Jul',
      'landOwner': 'Mr. Sam Wilson',
      'verification': 'Pending',
      'workAmount': 'P125',
      'paidStatus': 'Unpaid',
    },
    {
      'date': '23 Jul',
      'landOwner': 'Ms. Rachel Zane',
      'verification': 'Verified',
      'workAmount': 'P125',
      'paidStatus': 'Unpaid',
    },
  ];

  final List<Map<String, dynamic>> physicalVerificationLedger = [
    {
      'date': '24 Jul',
      'landOwner': 'Mr. Mike Ross',
      'amount': 'P25',
      'status': 'Verified',
      'paidStatus': 'Paid',
    },
    {
      'date': '23 Jul',
      'landOwner': 'Ms. Rachel Zane',
      'amount': 'P25',
      'status': 'Verified',
      'paidStatus': 'Unpaid',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regional Wallet'),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // My Earnings Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Earnings',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Review your daily work and earnings.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Due Amount',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'P38',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Paid Amount',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'P238',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 30-Day Due Ledger Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '30-Day Due Ledger',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // 30-Day Settlement
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '30-Day Settlement',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Total Month-End Amount',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'P250',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Table
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 20,
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) => Colors.blue[50],
                              ),
                          columns: const [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Land Owner')),
                            DataColumn(label: Text('Physical\nVerification')),
                            DataColumn(label: Text('Month End\nAmount')),
                            DataColumn(label: Text('Paid Status')),
                          ],
                          rows: dueLedger.map((entry) {
                            return DataRow(
                              cells: [
                                DataCell(Text(entry['date'])),
                                DataCell(Text(entry['landOwner'])),
                                DataCell(Text(entry['physicalVerification'])),
                                DataCell(Text(entry['monthEndAmount'])),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: entry['paidStatus'] == 'Paid'
                                          ? Colors.green[100]
                                          : Colors.orange[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      entry['paidStatus'],
                                      style: TextStyle(
                                        color: entry['paidStatus'] == 'Paid'
                                            ? Colors.green[800]
                                            : Colors.orange[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Travel Ledger Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Travel Ledger',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 20,
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) => Colors.green[50],
                              ),
                          columns: const [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Total Distance')),
                            DataColumn(label: Text('Travel Amount')),
                            DataColumn(label: Text('Paid Status')),
                          ],
                          rows: travelLedger.map((entry) {
                            return DataRow(
                              cells: [
                                DataCell(Text(entry['date'])),
                                DataCell(Text(entry['totalDistance'])),
                                DataCell(
                                  Text(
                                    entry['travelAmount'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: entry['paidStatus'] == 'Paid'
                                          ? Colors.green[100]
                                          : Colors.orange[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      entry['paidStatus'],
                                      style: TextStyle(
                                        color: entry['paidStatus'] == 'Paid'
                                            ? Colors.green[800]
                                            : Colors.orange[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Land Entry Ledger Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Land Entry Ledger',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 20,
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) =>
                                    Colors.purple[50],
                              ),
                          columns: const [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Land Owner')),
                            DataColumn(label: Text('Verification')),
                            DataColumn(label: Text('Work Amount')),
                            DataColumn(label: Text('Paid Status')),
                          ],
                          rows: landEntryLedger.map((entry) {
                            return DataRow(
                              cells: [
                                DataCell(Text(entry['date'])),
                                DataCell(Text(entry['landOwner'])),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: entry['verification'] == 'Verified'
                                          ? Colors.green[100]
                                          : Colors.yellow[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      entry['verification'],
                                      style: TextStyle(
                                        color:
                                            entry['verification'] == 'Verified'
                                            ? Colors.green[800]
                                            : Colors.orange[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(Text(entry['workAmount'])),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: entry['paidStatus'] == 'Paid'
                                          ? Colors.green[100]
                                          : Colors.orange[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      entry['paidStatus'],
                                      style: TextStyle(
                                        color: entry['paidStatus'] == 'Paid'
                                            ? Colors.green[800]
                                            : Colors.orange[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Physical Verification Ledger Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Physical Verification Ledger',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 20,
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) =>
                                    Colors.orange[50],
                              ),
                          columns: const [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Land Owner')),
                            DataColumn(label: Text('Amount')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Paid Status')),
                          ],
                          rows: physicalVerificationLedger.map((entry) {
                            return DataRow(
                              cells: [
                                DataCell(Text(entry['date'])),
                                DataCell(Text(entry['landOwner'])),
                                DataCell(
                                  Text(
                                    entry['amount'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: entry['status'] == 'Verified'
                                          ? Colors.green[100]
                                          : Colors.yellow[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      entry['status'],
                                      style: TextStyle(
                                        color: entry['status'] == 'Verified'
                                            ? Colors.green[800]
                                            : Colors.orange[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: entry['paidStatus'] == 'Paid'
                                          ? Colors.green[100]
                                          : Colors.orange[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      entry['paidStatus'],
                                      style: TextStyle(
                                        color: entry['paidStatus'] == 'Paid'
                                            ? Colors.green[800]
                                            : Colors.orange[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
