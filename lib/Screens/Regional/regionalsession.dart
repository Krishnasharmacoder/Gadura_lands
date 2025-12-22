import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class Regionalsession extends StatefulWidget {
  const Regionalsession({super.key});

  @override
  State<Regionalsession> createState() => _SessionPageState();
}

class _SessionPageState extends State<Regionalsession> {
  final TextEditingController startingKm = TextEditingController();
  final TextEditingController endKmController = TextEditingController();
  final TextEditingController transportController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  XFile? odometerImage;
  XFile? endOdometerImage;
  List<XFile> ticketImages = [];

  String? _apiToken;
  int? _currentSessionId;
  bool _sessionStarted = false;
  bool _isLoading = false;

  List<dynamic> sessionHistory = [];
  List<Map<String, dynamic>> weeklyStats = [];

  // API base URL
  static const String _baseUrl = "http://72.61.169.226";

  @override
  void initState() {
    super.initState();
    loadTokenAndSession();
    _initializeWeeklyStats(); // Initialize graph data
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

  // Initialize weekly stats with dummy data
  void _initializeWeeklyStats() {
    setState(() {
      weeklyStats = [
        {"week": "Week 1", "sessions": 8, "landEntries": 12},
        {"week": "Week 2", "sessions": 6, "landEntries": 9},
        {"week": "Week 3", "sessions": 10, "landEntries": 12},
        {"week": "Week 4", "sessions": 4, "landEntries": 6},
        {"week": "Week 5", "sessions": 9, "landEntries": 13},
        {"week": "Week 6", "sessions": 7, "landEntries": 10},
        {"week": "Week 7", "sessions": 11, "landEntries": 16},
        {"week": "Week 8", "sessions": 5, "landEntries": 8},
      ];
    });
  }

  // Fetch current session data API
  Future<void> fetchSessionData() async {
    if (_apiToken == null || _apiToken!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication token not found")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse("$_baseUrl/regional/session");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_apiToken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body);

        // Check if there's an active session
        if (decode["data"] != null && decode["data"] is Map) {
          final sessionData = decode["data"];
          if (sessionData["id"] != null) {
            int sessionId = sessionData["id"];

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt("current_session_id", sessionId);

            setState(() {
              _currentSessionId = sessionId;
              _sessionStarted = true;

              // Pre-fill data if available
              if (sessionData["starting_km"] != null) {
                startingKm.text = sessionData["starting_km"].toString();
              }
            });
          }
        }
      } else {
        print("Session data fetch failed: ${response.statusCode}");
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching session: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // PICK IMAGE - WITH PERMISSION HANDLING
  Future<void> pickOdometerImage() async {
    try {
      final isCameraAvailable = await _checkCameraAvailability();
      if (!isCameraAvailable) {
        _showCameraErrorDialog();
        return;
      }

      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileSize = await file.length();
        final fileSizeInMB = fileSize / (1024 * 1024);

        if (fileSizeInMB > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image size too large (max 10MB)")),
          );
          return;
        }

        setState(() {
          odometerImage = pickedFile;
        });
      }
    } catch (e) {
      _handleImagePickerError(e);
    }
  }

  Future<void> pickEndOdometer() async {
    try {
      final isCameraAvailable = await _checkCameraAvailability();
      if (!isCameraAvailable) {
        _showCameraErrorDialog();
        return;
      }

      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileSize = await file.length();
        final fileSizeInMB = fileSize / (1024 * 1024);

        if (fileSizeInMB > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image size too large (max 10MB)")),
          );
          return;
        }

        setState(() {
          endOdometerImage = pickedFile;
        });
      }
    } catch (e) {
      _handleImagePickerError(e);
    }
  }

  Future<void> pickBusTickets() async {
    try {
      final isCameraAvailable = await _checkCameraAvailability();
      if (!isCameraAvailable) {
        _showCameraErrorDialog();
        return;
      }

      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileSize = await file.length();
        final fileSizeInMB = fileSize / (1024 * 1024);

        if (fileSizeInMB > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image size too large (max 10MB)")),
          );
          return;
        }

        setState(() {
          ticketImages.add(pickedFile);
        });
      }
    } catch (e) {
      _handleImagePickerError(e);
    }
  }

  Future<bool> _checkCameraAvailability() async {
    try {
      final camerasAvailable = await _imagePicker
          .pickImage(source: ImageSource.camera)
          .then((_) => true)
          .catchError((_) => false);
      return camerasAvailable;
    } catch (e) {
      return false;
    }
  }

  void _showCameraErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Camera Not Available"),
        content: const Text("Please check camera permissions or try again."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _handleImagePickerError(dynamic error) {
    String errorMessage = "Failed to pick image";

    if (error is PlatformException) {
      switch (error.code) {
        case 'camera_access_denied':
          errorMessage =
              "Camera access denied. Please enable camera permissions in settings.";
          break;
        case 'camera_access_restricted':
          errorMessage = "Camera access is restricted on this device.";
          break;
        case 'no_camera_available':
          errorMessage = "No camera available on this device.";
          break;
        default:
          errorMessage = "Camera error: ${error.message}";
      }
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  // START SESSION API
  Future<void> startSessionApi() async {
    if (_apiToken == null || _apiToken!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication token not found")),
      );
      return;
    }

    // Validation
    if (startingKm.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter starting kilometer")),
      );
      return;
    }

    if (odometerImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload odometer photo")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse("$_baseUrl/regional/session");

    var request = http.MultipartRequest("POST", url);
    request.headers["Authorization"] = 'Bearer $_apiToken';

    request.fields["starting_km"] = startingKm.text.trim();

    if (odometerImage != null) {
      try {
        request.files.add(
          await http.MultipartFile.fromPath(
            'starting_image',
            odometerImage!.path,
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

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Session Started!")));

        // Refresh session history
        fetchSessionHistory();
      } else {
        final errorMsg = jsonDecode(responseBody)["message"] ?? "Unknown error";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to start session: $errorMsg")),
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

    // Validation
    if (endKmController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter ending kilometer")),
      );
      return;
    }

    if (endOdometerImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload ending odometer photo")),
      );
      return;
    }

    if (ticketImages.isEmpty && transportController.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload bus tickets for transport charges"),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse(
      "$_baseUrl/regional/update/session/$_currentSessionId",
    );

    var request = http.MultipartRequest("PUT", url);
    request.headers["Authorization"] = "Bearer $_apiToken";

    request.fields["end_km"] = endKmController.text.trim();

    if (transportController.text.trim().isNotEmpty) {
      request.fields["transport_charges"] = transportController.text.trim();
    }

    if (endOdometerImage != null) {
      try {
        request.files.add(
          await http.MultipartFile.fromPath(
            'end_image',
            endOdometerImage!.path,
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

    // Handle multiple ticket images
    for (var ticket in ticketImages) {
      try {
        request.files.add(
          await http.MultipartFile.fromPath("ticket_image", ticket.path),
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
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("current_session_id");

        setState(() {
          _currentSessionId = null;
          _sessionStarted = false;
          startingKm.clear();
          odometerImage = null;
          endKmController.clear();
          transportController.clear();
          endOdometerImage = null;
          ticketImages.clear();
        });

        fetchSessionHistory();
        _showSuccessPopup();
      } else {
        final errorMsg = jsonDecode(responseBody)["message"] ?? "Unknown error";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to end session: $errorMsg")),
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
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // FETCH SESSION HISTORY API
  Future<void> fetchSessionHistory() async {
    if (_apiToken == null) return;

    final url = Uri.parse("$_baseUrl/regional/session");

    try {
      final res = await http.get(
        url,
        headers: {"Authorization": "Bearer $_apiToken"},
      );

      if (res.statusCode == 200) {
        final decode = jsonDecode(res.body);

        if (decode.containsKey("data")) {
          final data = decode["data"];

          List<Map<String, dynamic>> formattedHistory = [];

          if (data is Map) {
            data.forEach((id, session) {
              if (session is Map) {
                formattedHistory.add({"id": id, ...session});
              }
            });
          } else if (data is List) {
            formattedHistory = List<Map<String, dynamic>>.from(data);
          }

          // Group by date
          Map<String, List<Map<String, dynamic>>> grouped = {};

          for (var session in formattedHistory) {
            String date = session["date"] ?? "Unknown Date";
            if (!grouped.containsKey(date)) {
              grouped[date] = [];
            }
            grouped[date]!.add(session);
          }

          List<Map<String, dynamic>> groupedList = grouped.entries.map((entry) {
            return {"date": entry.key, "sessions": entry.value};
          }).toList();

          setState(() {
            sessionHistory = groupedList;
          });
        }
      } else {
        print("Failed to fetch history: ${res.statusCode}");
      }
    } catch (e) {
      print("History Fetch Error: $e");
    }
  }

  Future<void> _stopSession() async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Stop Session"),
        content: const Text("Are you sure you want to stop this session?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Stop", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("current_session_id");

      setState(() {
        _currentSessionId = null;
        _sessionStarted = false;
        startingKm.clear();
        odometerImage = null;
        endKmController.clear();
        transportController.clear();
        endOdometerImage = null;
        ticketImages.clear();
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Session stopped")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Regionalhomepage()),
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
                MaterialPageRoute(builder: (_) => const Regionalhomepage()),
              );
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                fetchSessionHistory();
                fetchSessionData();
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_sessionStarted) _sessionCard(),

                  if (_sessionStarted) ...[
                    _endSessionCard(),
                    const SizedBox(height: 25),
                    _stopSessionButton(),
                  ],

                  const SizedBox(height: 25),

                  // Graph Card - FIXED
                  _weeklyStatsCard(),

                  const SizedBox(height: 25),

                  _historyCard(),
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

  // FIXED GRAPH CARD
  Widget _weeklyStatsCard() {
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

          // Graph Container with fixed height
          SizedBox(height: 250, child: _buildGraph()),

          const SizedBox(height: 20),

          // Stats Summary
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
                _statItem2(
                  "Total Weeks",
                  "${weeklyStats.length}",
                  Icons.calendar_today,
                ),
                _statItem2(
                  "Avg Sessions",
                  "${_calculateAverageSessions().toStringAsFixed(1)}",
                  Icons.bar_chart,
                ),
                _statItem2(
                  "Total Entries",
                  "${_calculateTotalEntries()}",
                  Icons.landscape,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to calculate average sessions
  double _calculateAverageSessions() {
    if (weeklyStats.isEmpty) return 0.0;
    double total = 0;
    for (var week in weeklyStats) {
      total += (week["sessions"] as num).toDouble();
    }
    return total / weeklyStats.length;
  }

  // Helper method to calculate total entries
  int _calculateTotalEntries() {
    if (weeklyStats.isEmpty) return 0;
    int total = 0;
    for (var week in weeklyStats) {
      total += week["landEntries"] as int;
    }
    return total;
  }

  // BUILD GRAPH WIDGET
  Widget _buildGraph() {
    if (weeklyStats.isEmpty) {
      return const Center(
        child: Text("No data available", style: TextStyle(color: Colors.grey)),
      );
    }

    // Find max value for scaling
    double maxValue = 0;
    for (var week in weeklyStats) {
      if ((week["landEntries"] as num).toDouble() > maxValue) {
        maxValue = (week["landEntries"] as num).toDouble();
      }
    }

    return Column(
      children: [
        // Bars Container
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weeklyStats.map((weekData) {
                double value = (weekData["landEntries"] as num).toDouble();
                double heightFactor = maxValue > 0 ? value / maxValue : 0;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Value label
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // Bar
                    Container(
                      width: 28,
                      height: 150 * heightFactor,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF4CAF50).withOpacity(0.9),
                            const Color(0xFF2E7D32).withOpacity(0.9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),

                    // Week label
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 40,
                      child: Text(
                        weekData["week"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),

        // X-axis line
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 1,
          color: Colors.grey.shade300,
        ),

        // Scale labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0",
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
              Text(
                "${(maxValue * 0.25).toInt()}",
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
              Text(
                "${(maxValue * 0.5).toInt()}",
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
              Text(
                "${(maxValue * 0.75).toInt()}",
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
              Text(
                "${maxValue.toInt()}",
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statItem2(String label, String value, IconData icon) {
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

  Widget _sessionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
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

          TextField(
            controller: startingKm,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: _inputDecoration("e.g., 12345 km"),
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

          if (odometerImage != null) ...[
            const SizedBox(height: 15),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(odometerImage!.path),
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

  Widget _endSessionCard() {
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
          Text(
            "End Session #$_currentSessionId",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Log final readings and expenses for this session",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 25),

          const Text(
            "🚍 Transport Charges ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: transportController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: _inputDecoration2("Enter amount in ₱ "),
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: pickBusTickets,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Upload Bus Tickets "),
            style: _uploadButtonStyle(),
          ),

          if (ticketImages.isNotEmpty)
            Column(
              children: ticketImages.asMap().entries.map((entry) {
                int index = entry.key;
                XFile img = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(img.path),
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
                                ticketImages.removeAt(index);
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

          const Text(
            "🚲 End Odometer Reading ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: endKmController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: _inputDecoration2("Enter final kilometers "),
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: pickEndOdometer,
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text("Upload Odometer Photo "),
            style: _uploadButtonStyle(),
          ),

          if (endOdometerImage != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(endOdometerImage!.path),
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
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 30),

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

  Widget _historyCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
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
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("No session history found"),
              ),
            ),

          if (sessionHistory.isNotEmpty)
            ...sessionHistory.map((sessionGroup) {
              String date = sessionGroup["date"];
              List<dynamic> sessions = sessionGroup["sessions"];

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
                              Text(
                                "Session ID: ${s["id"] ?? "N/A"}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Starting KM: ${s["starting_km"] ?? "N/A"} | End KM: ${s["end_km"] ?? "N/A"}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "Transport Charges: ₱${s["transport_charges"] ?? "0"}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
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

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: Colors.grey.shade300),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: const Color(0xFFF1F1F1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );

  InputDecoration _inputDecoration2(String hint) {
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
