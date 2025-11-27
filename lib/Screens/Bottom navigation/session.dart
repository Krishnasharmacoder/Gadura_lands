import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:gadura_land/Screens/Bottom%20navigation/newland.dart';
import 'package:gadura_land/Screens/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'start session/longexpenses.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final TextEditingController startingKm = TextEditingController();

  XFile? odometerImage;
  String? _apiToken;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
  }

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

  Future<void> startSessionApi() async {
    if (odometerImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload odometer image")),
      );
      return;
    }

    final url = Uri.parse("http://72.61.169.226/agent/session");

    var request = http.MultipartRequest("POST", url);
    request.headers["Authorization"] = 'Bearer $_apiToken';
    request.fields["starting_km"] = startingKm.text.trim();

    request.files.add(
      await http.MultipartFile.fromPath('starting_image', odometerImage!.path),
    );

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print("API Response: $responseBody");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decode = jsonDecode(responseBody);

      // Extract real session id from data.id
      int sessionId = decode["data"]["id"];

      // Save for later use
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("current_session_id", sessionId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Session Started! ID: $sessionId")),
      );

      // Navigate to next page & pass ID
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LogExpensesPage(sessionId: sessionId),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed: ${response.statusCode}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitPopup = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit Session"),
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

        return exitPopup; // true = exit, false = stay
      },
      child: Scaffold(
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
            controller: startingKm,
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
              startSessionApi();
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
