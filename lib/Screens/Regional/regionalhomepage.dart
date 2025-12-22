import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Regional/regionaldetails.dart';
import 'package:gadura_land/Screens/Regional/regionalprofile.dart';
import 'package:gadura_land/Screens/Regional/regionalsession.dart';
import 'package:gadura_land/Screens/Regional/regionalverification.dart';
import 'package:gadura_land/Screens/Regional/regionalwallet.dart';

class Regionalhomepage extends StatefulWidget {
  const Regionalhomepage({super.key});

  @override
  State<Regionalhomepage> createState() => _RegionalhomepageState();
}

class _RegionalhomepageState extends State<Regionalhomepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Regionalverification(),
    RegionalDetails(),
    Regionalsession(),
    Regionalwallet(),
    Regionalprofile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[600],

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_rounded),
            activeIcon: Icon(Icons.work, color: Colors.green),
            label: "Verification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "Details",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Session",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
