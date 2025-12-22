import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final TextEditingController startingKm = TextEditingController();
  final TextEditingController endKmController = TextEditingController();
  final TextEditingController transportController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  // Variables for API (XFile)
  XFile? odometerImage;
  XFile? endOdometerImage;
  List<XFile> ticketImages = [];

  // Variables for display (Uint8List)
  Uint8List? odometerImageBytes;
  Uint8List? endOdometerImageBytes;
  List<Uint8List> ticketImagesBytes = [];

  String? _apiToken;
  int? _currentSessionId;
  bool _sessionStarted = false;
  bool _isLoading = false;

  List<dynamic> sessionHistory = [];
  List<Map<String, dynamic>> weeklyStats = [];

  // Helper function to get mime type
  String getMimeType(String filePath) {
    final ext = filePath.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'heic':
        return 'image/heic';
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'avi':
        return 'video/x-msvideo';
      case 'mkv':
        return 'video/x-matroska';
      case 'wmv':
        return 'video/x-ms-wmv';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      default:
        return 'application/octet-stream';
    }
  }

  @override
  void initState() {
    super.initState();
    loadTokenAndSession();
  }

  Future<void> loadTokenAndSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiToken = prefs.getString("auth_token");
    _currentSessionId = prefs.getInt("current_session_id");

    if (_currentSessionId != null) {
      _sessionStarted = true;
    }

    fetchSessionHistory();
  }

  // PICK IMAGE METHODS
  Future<void> pickOdometerImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile != null) {
        // Check file size
        final bytes = await pickedFile.readAsBytes();
        final fileSizeInMB = bytes.length / (1024 * 1024);

        if (fileSizeInMB > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image size too large (max 10MB)")),
          );
          return;
        }

        setState(() {
          odometerImage = pickedFile;
          odometerImageBytes = bytes;
        });
      }
    } catch (e) {
      print("Image pick error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to take picture")));
    }
  }

  Future<void> pickEndOdometer() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final fileSizeInMB = bytes.length / (1024 * 1024);

        if (fileSizeInMB > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image size too large (max 10MB)")),
          );
          return;
        }

        setState(() {
          endOdometerImage = pickedFile;
          endOdometerImageBytes = bytes;
        });
      }
    } catch (e) {
      print("Image pick error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to take picture")));
    }
  }

  Future<void> pickBusTickets() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final fileSizeInMB = bytes.length / (1024 * 1024);

        if (fileSizeInMB > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image size too large (max 10MB)")),
          );
          return;
        }

        setState(() {
          ticketImages.add(pickedFile);
          ticketImagesBytes.add(bytes);
        });
      }
    } catch (e) {
      print("Image pick error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to take picture")));
    }
  }

  // START SESSION API
  Future<void> startSessionApi() async {
    if (_apiToken == null || _apiToken!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication token not found")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse("http://72.61.169.226/field-executive/session");

    var request = http.MultipartRequest("POST", url);
    request.headers["Authorization"] = 'Bearer $_apiToken';

    // Send starting_km only if it's not empty
    if (startingKm.text.trim().isNotEmpty) {
      request.fields["starting_km"] = startingKm.text.trim();
    }

    if (odometerImage != null) {
      try {
        final file = File(odometerImage!.path);
        final mimeType = getMimeType(odometerImage!.path);
        final filename = odometerImage!.path.split('/').last;

        request.files.add(
          http.MultipartFile(
            'starting_image',
            http.ByteStream(file.openRead()),
            await file.length(),
            filename: filename,
            contentType: http.MediaType.parse(mimeType),
          ),
        );
        debugPrint(
          'Starting odometer image added: $filename, mimeType: $mimeType',
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error uploading image: $e")));
        setState(() => _isLoading = false);
        return;
      }
    }

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(responseBody);
        int sessionId = decode["data"]["id"];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("current_session_id", sessionId);

        setState(() {
          _currentSessionId = sessionId;
          _sessionStarted = true;
        });

        // ScaffoldMessenger.of(
        //   context,
        // ).showSnackBar(const SnackBar(content: Text("Session Started!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed: ${response.statusCode} - $responseBody"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // END SESSION API
  Future<void> endSessionApi() async {
    if (_currentSessionId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No active session found")));
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse(
      "http://72.61.169.226/field-executive/update/session/$_currentSessionId",
    );

    var request = http.MultipartRequest("PUT", url);
    request.headers["Authorization"] = "Bearer $_apiToken";

    // Send only if fields are not empty
    if (endKmController.text.trim().isNotEmpty) {
      request.fields["end_km"] = endKmController.text.trim();
    }

    if (transportController.text.trim().isNotEmpty) {
      request.fields["transport_charges"] = transportController.text.trim();
    }

    // Upload end odometer image
    if (endOdometerImage != null) {
      try {
        final file = File(endOdometerImage!.path);
        final mimeType = getMimeType(endOdometerImage!.path);
        final filename = endOdometerImage!.path.split('/').last;

        request.files.add(
          http.MultipartFile(
            'end_image',
            http.ByteStream(file.openRead()),
            await file.length(),
            filename: filename,
            contentType: http.MediaType.parse(mimeType),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error uploading image: $e")));
        setState(() => _isLoading = false);
        return;
      }
    }

    // Upload bus ticket images
    for (var ticket in ticketImages) {
      try {
        final file = File(ticket.path);
        final mimeType = getMimeType(ticket.path);
        final filename = ticket.path.split('/').last;

        request.files.add(
          http.MultipartFile(
            'ticket_image',
            http.ByteStream(file.openRead()),
            await file.length(),
            filename: filename,
            contentType: http.MediaType.parse(mimeType),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading ticket image: $e")),
        );
        setState(() => _isLoading = false);
        return;
      }
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Clear session data
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("current_session_id");

        // Reset state
        setState(() {
          _currentSessionId = null;
          _sessionStarted = false;
          startingKm.clear();

          // Clear XFile variables
          odometerImage = null;
          endOdometerImage = null;
          ticketImages.clear();

          // Clear display bytes
          odometerImageBytes = null;
          endOdometerImageBytes = null;
          ticketImagesBytes.clear();

          endKmController.clear();
          transportController.clear();
        });

        // Refresh history
        fetchSessionHistory();

        // Show snackbar instead of popup
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Session ended successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        var responseBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed: ${response.statusCode} - $responseBody"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> fetchSessionHistory() async {
    if (_apiToken == null) return;

    final url = Uri.parse("http://72.61.169.226/field-executive/session");

    try {
      final res = await http.get(
        url,
        headers: {"Authorization": "Bearer $_apiToken"},
      );

      if (res.statusCode == 200) {
        final decode = jsonDecode(res.body);
        final data = decode["data"];

        // Group sessions by date
        Map<String, List<dynamic>> grouped = {};

        data.forEach((id, session) {
          String date = session["date"];

          if (!grouped.containsKey(date)) {
            grouped[date] = [];
          }

          grouped[date]!.add(session);
        });

        // Calculate weekly stats
        _calculateWeeklyStats(data);

        // Convert to list for UI
        List<Map<String, dynamic>> formattedList = grouped.entries.map((e) {
          return {"date": e.key, "sessions": e.value};
        }).toList();

        setState(() {
          sessionHistory = formattedList;
        });
      }
    } catch (e) {
      print("History Fetch Error: $e");
    }
  }

  // Calculate weekly statistics
  void _calculateWeeklyStats(Map<String, dynamic> data) {
    List<Map<String, dynamic>> weeklyData = [
      {"week": "Week 1", "sessions": 8, "landEntries": 12},
      {"week": "Week 2", "sessions": 6, "landEntries": 9},
      {"week": "Week 3", "sessions": 10, "landEntries": 12},
      {"week": "Week 4", "sessions": 4, "landEntries": 6},
      {"week": "Week 5", "sessions": 9, "landEntries": 13},
      {"week": "Week 6", "sessions": 7, "landEntries": 10},
      {"week": "Week 7", "sessions": 11, "landEntries": 16},
      {"week": "Week 8", "sessions": 5, "landEntries": 8},
    ];

    setState(() {
      weeklyStats = weeklyData;
    });
  }

  // STOP SESSION WITHOUT SUBMITTING
  Future<void> _stopSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("current_session_id");

    setState(() {
      _currentSessionId = null;
      _sessionStarted = false;
      startingKm.clear();

      // Clear XFile variables
      odometerImage = null;
      endOdometerImage = null;
      ticketImages.clear();

      // Clear display bytes
      odometerImageBytes = null;
      endOdometerImageBytes = null;
      ticketImagesBytes.clear();

      endKmController.clear();
      transportController.clear();
    });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text("Session stopped"),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Homepage()),
        );
        return false;
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
                MaterialPageRoute(builder: (_) => const Homepage()),
              );
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SHOW START SESSION CARD IF NO ACTIVE SESSION
                  if (!_sessionStarted) _buildStartSessionCard(),

                  // SHOW END SESSION CARD IF ACTIVE SESSION EXISTS
                  if (_sessionStarted) ...[
                    _buildEndSessionCard(),
                    const SizedBox(height: 25),
                    _buildStopSessionButton(),
                  ],

                  const SizedBox(height: 25),

                  // WEEKLY STATS CARD
                  _buildWeeklyStatsCard(),

                  const SizedBox(height: 25),

                  _buildHistoryCard(),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  // START SESSION CARD
  Widget _buildStartSessionCard() {
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
            "Enter Starting Odometer ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),

          const SizedBox(height: 5),

          TextField(
            controller: startingKm,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

          ElevatedButton.icon(
            onPressed: pickOdometerImage,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Upload Odometer Photo "),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBDECC6),
              foregroundColor: Colors.black87,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          if (odometerImageBytes != null) ...[
            const SizedBox(height: 15),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    odometerImageBytes!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          odometerImage = null;
                          odometerImageBytes = null;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: startSessionApi,
            icon: const Icon(Icons.play_arrow),
            label: const Text("Start Session"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A86B),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  // END SESSION CARD
  Widget _buildEndSessionCard() {
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
            "Log Expenses & Readings ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),

          const SizedBox(height: 25),

          // TRANSPORT CHARGES
          const Text(
            "🚍 Transport Charges ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: transportController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: "Enter amount in ₱ ",
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
            onPressed: pickBusTickets,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Upload Bus Tickets "),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBDECC6),
              foregroundColor: Colors.black87,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          if (ticketImagesBytes.isNotEmpty)
            Column(
              children: ticketImagesBytes.asMap().entries.map((entry) {
                int index = entry.key;
                Uint8List imgBytes = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          imgBytes,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if (index < ticketImages.length) {
                                  ticketImages.removeAt(index);
                                }
                                ticketImagesBytes.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

          const SizedBox(height: 25),

          // END ODOMETER
          const Text(
            "🚲 End Odometer Reading ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: endKmController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: "Enter final kilometers ",
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
            onPressed: pickEndOdometer,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Upload Odometer Photo "),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBDECC6),
              foregroundColor: Colors.black87,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          if (endOdometerImageBytes != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      endOdometerImageBytes!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            endOdometerImage = null;
                            endOdometerImageBytes = null;
                          });
                        },
                      ),
                    ),
                  ),
                ],
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
              "Submit Final Readings ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // STOP SESSION BUTTON
  Widget _buildStopSessionButton() {
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
          onTap: _stopSession,
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

  Widget _buildWeeklyStatsCard() {
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
            "Weekly Session Summary",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "A summary of your sessions over the last 8 weeks",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),

          // BAR GRAPH CONTAINER
          Container(
            height: 220,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                // BARS
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: weeklyStats.map((weekData) {
                      double heightFactor = weekData["landEntries"] / 20.0;
                      return Column(
                        children: [
                          // VALUE ON TOP
                          Text(
                            "${weekData["landEntries"]}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // BAR
                          Container(
                            width: 25,
                            height: 120 * heightFactor,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50),
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF4CAF50).withOpacity(0.9),
                                  const Color(0xFF4CAF50).withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // WEEK LABEL
                          Text(
                            weekData["week"],
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                // X-AXIS SCALE
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "0",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "5",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "10",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "15",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "20",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                // X-AXIS LINE
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // STATS SUMMARY
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(
                  "Total Weeks",
                  "${weeklyStats.length}",
                  Icons.calendar_today,
                ),
                _buildStatItem("Avg Sessions", "7.5", Icons.bar_chart),
                _buildStatItem("Total Entries", "89", Icons.landscape),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, color: const Color(0xFF4CAF50), size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildHistoryCard() {
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

          if (sessionHistory.isEmpty)
            const Center(child: Text("No session history found")),

          ...sessionHistory.map((sessionGroup) {
            String date = sessionGroup["date"];
            List sessions = sessionGroup["sessions"];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    ...sessions.map((s) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TITLE (e.g., Medak)
                            Text(
                              s["farmer_name"] ?? "Unknown Location",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // SUBTEXT
                            Text(
                              "${s["land"] ?? 1} land completed",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 10),

                            // STATUS BADGE
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Completed",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),

                const Divider(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
