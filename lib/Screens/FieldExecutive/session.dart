// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:gadura_land/Screens/homepage.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:flutter/services.dart';

// // class SessionPage extends StatefulWidget {
// //   const SessionPage({super.key});

// //   @override
// //   State<SessionPage> createState() => _SessionPageState();
// // }

// // class _SessionPageState extends State<SessionPage> {
// //   final TextEditingController startingKm = TextEditingController();
// //   final TextEditingController endKmController = TextEditingController();
// //   final TextEditingController transportController = TextEditingController();
// //   final ImagePicker _imagePicker = ImagePicker(); // Renamed for clarity

// //   XFile? odometerImage;
// //   XFile? endOdometerImage;
// //   List<XFile> ticketImages = [];

// //   String? _apiToken;
// //   int? _currentSessionId;
// //   bool _sessionStarted = false;
// //   bool _isLoading = false;

// //   List<dynamic> sessionHistory = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadTokenAndSession();
// //   }

// //   Future<void> loadTokenAndSession() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     _apiToken = prefs.getString("auth_token");
// //     _currentSessionId = prefs.getInt("current_session_id");

// //     if (_currentSessionId != null) {
// //       _sessionStarted = true;
// //     }

// //     fetchSessionHistory();
// //   }

// //   // PICK IMAGE - WITH PERMISSION HANDLING
// //   Future<void> pickOdometerImage() async {
// //     try {
// //       // Check if camera is available
// //       final isCameraAvailable = await _checkCameraAvailability();
// //       if (!isCameraAvailable) {
// //         _showCameraErrorDialog();
// //         return;
// //       }

// //       final pickedFile = await _imagePicker.pickImage(
// //         source: ImageSource.camera,
// //         imageQuality: 60,
// //         maxWidth: 800,
// //         maxHeight: 800,
// //       );

// //       if (pickedFile != null) {
// //         // Check file size
// //         final file = File(pickedFile.path);
// //         final fileSize = await file.length();
// //         final fileSizeInMB = fileSize / (1024 * 1024);

// //         if (fileSizeInMB > 10) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text("Image size too large (max 10MB)")),
// //           );
// //           return;
// //         }

// //         setState(() {
// //           odometerImage = pickedFile;
// //         });
// //       }
// //     } catch (e) {
// //       _handleImagePickerError(e);
// //     }
// //   }

// //   Future<void> pickEndOdometer() async {
// //     try {
// //       // Check if camera is available
// //       final isCameraAvailable = await _checkCameraAvailability();
// //       if (!isCameraAvailable) {
// //         _showCameraErrorDialog();
// //         return;
// //       }

// //       final pickedFile = await _imagePicker.pickImage(
// //         source: ImageSource.camera,
// //         imageQuality: 60,
// //         maxWidth: 800,
// //         maxHeight: 800,
// //       );

// //       if (pickedFile != null) {
// //         // Check file size
// //         final file = File(pickedFile.path);
// //         final fileSize = await file.length();
// //         final fileSizeInMB = fileSize / (1024 * 1024);

// //         if (fileSizeInMB > 10) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text("Image size too large (max 10MB)")),
// //           );
// //           return;
// //         }

// //         setState(() {
// //           endOdometerImage = pickedFile;
// //         });
// //       }
// //     } catch (e) {
// //       _handleImagePickerError(e);
// //     }
// //   }

// //   Future<void> pickBusTickets() async {
// //     try {
// //       // Check if camera is available
// //       final isCameraAvailable = await _checkCameraAvailability();
// //       if (!isCameraAvailable) {
// //         _showCameraErrorDialog();
// //         return;
// //       }

// //       final pickedFile = await _imagePicker.pickImage(
// //         source: ImageSource.camera,
// //         imageQuality: 60,
// //         maxWidth: 800,
// //         maxHeight: 800,
// //       );

// //       if (pickedFile != null) {
// //         // Check file size
// //         final file = File(pickedFile.path);
// //         final fileSize = await file.length();
// //         final fileSizeInMB = fileSize / (1024 * 1024);

// //         if (fileSizeInMB > 10) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text("Image size too large (max 10MB)")),
// //           );
// //           return;
// //         }

// //         setState(() {
// //           ticketImages.add(pickedFile);
// //         });
// //       }
// //     } catch (e) {
// //       _handleImagePickerError(e);
// //     }
// //   }

// //   // Check camera availability
// //   Future<bool> _checkCameraAvailability() async {
// //     try {
// //       // Check if camera is available
// //       final camerasAvailable = await _imagePicker
// //           .pickImage(source: ImageSource.camera)
// //           .then((_) => true)
// //           .catchError((_) => false);

// //       return camerasAvailable;
// //     } catch (e) {
// //       return false;
// //     }
// //   }

// //   // Show camera error dialog
// //   void _showCameraErrorDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: const Text("Camera Not Available"),
// //         content: const Text("Please check camera permissions or try again."),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text("OK"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // Handle image picker errors
// //   void _handleImagePickerError(dynamic error) {
// //     String errorMessage = "Failed to pick image";

// //     if (error is PlatformException) {
// //       switch (error.code) {
// //         case 'camera_access_denied':
// //           errorMessage =
// //               "Camera access denied. Please enable camera permissions in settings.";
// //           break;
// //         case 'camera_access_restricted':
// //           errorMessage = "Camera access is restricted on this device.";
// //           break;
// //         case 'no_camera_available':
// //           errorMessage = "No camera available on this device.";
// //           break;
// //         default:
// //           errorMessage = "Camera error: ${error.message}";
// //       }
// //     }

// //     ScaffoldMessenger.of(
// //       context,
// //     ).showSnackBar(SnackBar(content: Text(errorMessage)));
// //   }

// //   // START SESSION API - Starting KM is OPTIONAL
// //   Future<void> startSessionApi() async {
// //     // Check if token is available
// //     if (_apiToken == null || _apiToken!.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Authentication token not found")),
// //       );
// //       return;
// //     }

// //     setState(() => _isLoading = true);

// //     final url = Uri.parse("http://72.61.169.226/field-executive/session");

// //     var request = http.MultipartRequest("POST", url);
// //     request.headers["Authorization"] = 'Bearer $_apiToken';

// //     // Send starting_km only if it's not empty
// //     if (startingKm.text.trim().isNotEmpty) {
// //       request.fields["starting_km"] = startingKm.text.trim();
// //     }

// //     if (odometerImage != null) {
// //       try {
// //         request.files.add(
// //           await http.MultipartFile.fromPath(
// //             'starting_image',
// //             odometerImage!.path,
// //           ),
// //         );
// //       } catch (e) {
// //         ScaffoldMessenger.of(
// //           context,
// //         ).showSnackBar(SnackBar(content: Text("Error uploading image: $e")));
// //         setState(() => _isLoading = false);
// //         return;
// //       }
// //     }

// //     try {
// //       var response = await request.send();
// //       var responseBody = await response.stream.bytesToString();

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final decode = jsonDecode(responseBody);
// //         int sessionId = decode["data"]["id"];

// //         SharedPreferences prefs = await SharedPreferences.getInstance();
// //         await prefs.setInt("current_session_id", sessionId);

// //         setState(() {
// //           _currentSessionId = sessionId;
// //           _sessionStarted = true;
// //         });

// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Session Started! ID: $sessionId")),
// //         );
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text("Failed: ${response.statusCode} - $responseBody"),
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text("Error: $e")));
// //     } finally {
// //       setState(() => _isLoading = false);
// //     }
// //   }

// //   // END SESSION API - All fields are OPTIONAL
// //   Future<void> endSessionApi() async {
// //     if (_currentSessionId == null) {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(const SnackBar(content: Text("No active session found")));
// //       return;
// //     }

// //     // Check if any data is entered
// //     if (endKmController.text.trim().isEmpty &&
// //         transportController.text.trim().isEmpty &&
// //         endOdometerImage == null &&
// //         ticketImages.isEmpty) {
// //       // Ask for confirmation if no data is entered
// //       final confirmed = await showDialog(
// //         context: context,
// //         builder: (context) => AlertDialog(
// //           title: const Text("End Session"),
// //           content: const Text(
// //             "No data entered. End session without any information?",
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context, false),
// //               child: const Text("Cancel"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () => Navigator.pop(context, true),
// //               child: const Text("End Session"),
// //             ),
// //           ],
// //         ),
// //       );

// //       if (confirmed != true) {
// //         return;
// //       }
// //     }

// //     setState(() => _isLoading = true);

// //     final url = Uri.parse(
// //       "http://72.61.169.226/field-executive/update/session/$_currentSessionId",
// //     );

// //     var request = http.MultipartRequest("PUT", url);
// //     request.headers["Authorization"] = "Bearer $_apiToken";

// //     // Send only if fields are not empty
// //     if (endKmController.text.trim().isNotEmpty) {
// //       request.fields["end_km"] = endKmController.text.trim();
// //     }

// //     if (transportController.text.trim().isNotEmpty) {
// //       request.fields["transport_charges"] = transportController.text.trim();
// //     }

// //     if (endOdometerImage != null) {
// //       try {
// //         request.files.add(
// //           await http.MultipartFile.fromPath(
// //             'end_image',
// //             endOdometerImage!.path,
// //           ),
// //         );
// //       } catch (e) {
// //         ScaffoldMessenger.of(
// //           context,
// //         ).showSnackBar(SnackBar(content: Text("Error uploading image: $e")));
// //         setState(() => _isLoading = false);
// //         return;
// //       }
// //     }

// //     for (var ticket in ticketImages) {
// //       try {
// //         request.files.add(
// //           await http.MultipartFile.fromPath("ticket_image", ticket.path),
// //         );
// //       } catch (e) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Error uploading ticket image: $e")),
// //         );
// //         setState(() => _isLoading = false);
// //         return;
// //       }
// //     }

// //     try {
// //       var response = await request.send();

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         // Clear session data
// //         SharedPreferences prefs = await SharedPreferences.getInstance();
// //         await prefs.remove("current_session_id");

// //         // Reset state
// //         setState(() {
// //           _currentSessionId = null;
// //           _sessionStarted = false;
// //           startingKm.clear();
// //           odometerImage = null;
// //           endKmController.clear();
// //           transportController.clear();
// //           endOdometerImage = null;
// //           ticketImages.clear();
// //         });

// //         // Refresh history
// //         fetchSessionHistory();

// //         _showSuccessPopup();
// //       } else {
// //         var responseBody = await response.stream.bytesToString();
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text("Failed: ${response.statusCode} - $responseBody"),
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text("Error: $e")));
// //     } finally {
// //       setState(() => _isLoading = false);
// //     }
// //   }

// //   void _showSuccessPopup() {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// //         title: const Text("Success"),
// //         content: const Text("Session ended successfully."),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.pop(context);
// //             },
// //             child: const Text("OK"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<void> fetchSessionHistory() async {
// //     if (_apiToken == null) return;

// //     final url = Uri.parse("http://72.61.169.226/field-executive/session");

// //     try {
// //       final res = await http.get(
// //         url,
// //         headers: {"Authorization": "Bearer $_apiToken"},
// //       );

// //       if (res.statusCode == 200) {
// //         final decode = jsonDecode(res.body);
// //         final data = decode["data"];

// //         // Group sessions by date
// //         Map<String, List<dynamic>> grouped = {};

// //         data.forEach((id, session) {
// //           String date = session["date"];

// //           if (!grouped.containsKey(date)) {
// //             grouped[date] = [];
// //           }

// //           grouped[date]!.add(session);
// //         });

// //         // Convert to list for UI
// //         List<Map<String, dynamic>> formattedList = grouped.entries.map((e) {
// //           return {"date": e.key, "sessions": e.value};
// //         }).toList();

// //         setState(() {
// //           sessionHistory = formattedList;
// //         });
// //       }
// //     } catch (e) {
// //       print("History Fetch Error: $e");
// //     }
// //   }

// //   // STOP SESSION WITHOUT SUBMITTING
// //   Future<void> _stopSession() async {
// //     final confirmed = await showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: const Text("Stop Session"),
// //         content: const Text(
// //           "Are you sure you want to stop this session without submitting?",
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context, false),
// //             child: const Text("No"),
// //           ),
// //           ElevatedButton(
// //             onPressed: () => Navigator.pop(context, true),
// //             child: const Text("Yes"),
// //           ),
// //         ],
// //       ),
// //     );

// //     if (confirmed == true) {
// //       SharedPreferences prefs = await SharedPreferences.getInstance();
// //       await prefs.remove("current_session_id");

// //       setState(() {
// //         _currentSessionId = null;
// //         _sessionStarted = false;
// //         startingKm.clear();
// //         odometerImage = null;
// //         endKmController.clear();
// //         transportController.clear();
// //         endOdometerImage = null;
// //         ticketImages.clear();
// //       });

// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(const SnackBar(content: Text("Session stopped")));
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         return await showDialog(
// //               context: context,
// //               builder: (context) => AlertDialog(
// //                 title: const Text("Exit Session"),
// //                 content: const Text("Do you really want to exit the app?"),
// //                 actions: [
// //                   TextButton(
// //                     onPressed: () => Navigator.pop(context, false),
// //                     child: const Text("No"),
// //                   ),
// //                   ElevatedButton(
// //                     onPressed: () => Navigator.pop(context, true),
// //                     child: const Text("Yes"),
// //                   ),
// //                 ],
// //               ),
// //             ) ??
// //             false;
// //       },
// //       child: Scaffold(
// //         backgroundColor: const Color(0xFFF5F6FA),
// //         appBar: AppBar(
// //           title: const Text("Sessions"),
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back),
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const Homepage()),
// //               );
// //             },
// //           ),
// //           elevation: 0,
// //           backgroundColor: Colors.white,
// //           foregroundColor: Colors.black,
// //         ),
// //         body: Stack(
// //           children: [
// //             SingleChildScrollView(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // SHOW START SESSION CARD IF NO ACTIVE SESSION
// //                   if (!_sessionStarted) _sessionCard(),

// //                   // SHOW END SESSION CARD IF ACTIVE SESSION EXISTS
// //                   if (_sessionStarted) ...[
// //                     _endSessionCard(),
// //                     const SizedBox(height: 25),
// //                     _stopSessionButton(),
// //                   ],

// //                   const SizedBox(height: 25),
// //                   _historyCard(),
// //                 ],
// //               ),
// //             ),
// //             if (_isLoading)
// //               Container(
// //                 color: Colors.black.withOpacity(0.3),
// //                 child: const Center(child: CircularProgressIndicator()),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // START SESSION CARD - Updated to show optional
// //   Widget _sessionCard() {
// //     return Container(
// //       padding: const EdgeInsets.all(20),
// //       decoration: _boxDecoration(),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Start a New Session",
// //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 5),
// //           const Text(
// //             "Select your work type(s) and start the timer.",
// //             style: TextStyle(color: Colors.grey),
// //           ),
// //           const SizedBox(height: 20),
// //           const Text(
// //             "Enter Starting Odometer ",
// //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //           ),
// //           const SizedBox(height: 5),

// //           const SizedBox(height: 5),

// //           TextField(
// //             controller: startingKm,
// //             keyboardType: TextInputType.number,
// //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //             decoration: _inputDecoration("e.g., 12345 km"),
// //           ),

// //           const SizedBox(height: 15),

// //           ElevatedButton.icon(
// //             onPressed: pickOdometerImage,
// //             icon: const Icon(Icons.camera_alt_outlined),
// //             label: const Text("Upload Odometer Photo "),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color(0xFFBDECC6),
// //               foregroundColor: Colors.black87,
// //               minimumSize: const Size(double.infinity, 48),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //           ),

// //           if (odometerImage != null) ...[
// //             const SizedBox(height: 15),
// //             Stack(
// //               children: [
// //                 ClipRRect(
// //                   borderRadius: BorderRadius.circular(12),
// //                   child: Image.file(
// //                     File(odometerImage!.path),
// //                     height: 180,
// //                     width: double.infinity,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //                 Positioned(
// //                   top: 8,
// //                   right: 8,
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       color: Colors.black54,
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: IconButton(
// //                       icon: const Icon(
// //                         Icons.close,
// //                         color: Colors.white,
// //                         size: 20,
// //                       ),
// //                       onPressed: () {
// //                         setState(() {
// //                           odometerImage = null;
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],

// //           const SizedBox(height: 20),

// //           ElevatedButton.icon(
// //             onPressed: startSessionApi,
// //             icon: const Icon(Icons.play_arrow),
// //             label: const Text("Start Session"),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color(0xFF00A86B),
// //               foregroundColor: Colors.white,
// //               minimumSize: const Size(double.infinity, 50),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // END SESSION CARD - All fields optional
// //   Widget _endSessionCard() {
// //     return Container(
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             "Log Expenses & Readings ",
// //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 5),

// //           const SizedBox(height: 25),

// //           // TRANSPORT CHARGES (Optional)
// //           const Text(
// //             "🚍 Transport Charges ",
// //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //           ),
// //           const SizedBox(height: 8),
// //           TextField(
// //             controller: transportController,
// //             keyboardType: TextInputType.number,
// //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //             decoration: _inputDecoration2("Enter amount in ₱ "),
// //           ),

// //           const SizedBox(height: 12),

// //           ElevatedButton.icon(
// //             onPressed: pickBusTickets,
// //             icon: const Icon(Icons.camera_alt_outlined),
// //             label: const Text("Upload Bus Tickets "),
// //             style: _uploadButtonStyle(),
// //           ),

// //           if (ticketImages.isNotEmpty)
// //             Column(
// //               children: ticketImages.asMap().entries.map((entry) {
// //                 int index = entry.key;
// //                 XFile img = entry.value;
// //                 return Padding(
// //                   padding: const EdgeInsets.only(top: 10),
// //                   child: Stack(
// //                     children: [
// //                       ClipRRect(
// //                         borderRadius: BorderRadius.circular(12),
// //                         child: Image.file(
// //                           File(img.path),
// //                           height: 150,
// //                           width: double.infinity,
// //                           fit: BoxFit.cover,
// //                         ),
// //                       ),
// //                       Positioned(
// //                         top: 8,
// //                         right: 8,
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             color: Colors.black54,
// //                             borderRadius: BorderRadius.circular(20),
// //                           ),
// //                           child: IconButton(
// //                             icon: const Icon(
// //                               Icons.close,
// //                               color: Colors.white,
// //                               size: 20,
// //                             ),
// //                             onPressed: () {
// //                               setState(() {
// //                                 ticketImages.removeAt(index);
// //                               });
// //                             },
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               }).toList(),
// //             ),

// //           const SizedBox(height: 25),

// //           // END ODOMETER (Optional)
// //           const Text(
// //             "🚲 End Odometer Reading ",
// //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //           ),
// //           const SizedBox(height: 8),
// //           TextField(
// //             controller: endKmController,
// //             keyboardType: TextInputType.number,
// //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //             decoration: _inputDecoration2("Enter final kilometers "),
// //           ),

// //           const SizedBox(height: 12),

// //           ElevatedButton.icon(
// //             onPressed: pickEndOdometer,
// //             icon: const Icon(Icons.camera_alt_outlined),
// //             label: const Text("Upload Odometer Photo "),
// //             style: _uploadButtonStyle(),
// //           ),

// //           if (endOdometerImage != null)
// //             Padding(
// //               padding: const EdgeInsets.only(top: 10),
// //               child: Stack(
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(12),
// //                     child: Image.file(
// //                       File(endOdometerImage!.path),
// //                       height: 150,
// //                       width: double.infinity,
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                   Positioned(
// //                     top: 8,
// //                     right: 8,
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         color: Colors.black54,
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                       child: IconButton(
// //                         icon: const Icon(
// //                           Icons.close,
// //                           color: Colors.white,
// //                           size: 20,
// //                         ),
// //                         onPressed: () {
// //                           setState(() {
// //                             endOdometerImage = null;
// //                           });
// //                         },
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //           const SizedBox(height: 30),

// //           // SUBMIT BUTTON
// //           ElevatedButton(
// //             onPressed: endSessionApi,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color(0xFF00A86B),
// //               foregroundColor: Colors.white,
// //               minimumSize: const Size(double.infinity, 55),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //             child: const Text(
// //               "Submit Final Readings ",
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // STOP SESSION BUTTON
// //   Widget _stopSessionButton() {
// //     return Container(
// //       padding: const EdgeInsets.all(18),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
// //         ],
// //       ),
// //       child: Container(
// //         height: 55,
// //         decoration: BoxDecoration(
// //           color: const Color(0xFFE45858),
// //           borderRadius: BorderRadius.circular(14),
// //         ),
// //         child: InkWell(
// //           onTap: _stopSession,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: const [
// //               Icon(Icons.stop_circle_outlined, color: Colors.white),
// //               SizedBox(width: 8),
// //               Text(
// //                 "Stop Session",
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 17,
// //                   fontWeight: FontWeight.w700,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _historyCard() {
// //     return Container(
// //       padding: const EdgeInsets.all(20),
// //       decoration: _boxDecoration(),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: const [
// //               Icon(Icons.check_circle, color: Colors.green),
// //               SizedBox(width: 6),
// //               Text(
// //                 "Session & Work History",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 5),
// //           const Text(
// //             "Your past work sessions and completed tasks.",
// //             style: TextStyle(color: Colors.grey),
// //           ),
// //           const SizedBox(height: 20),

// //           if (sessionHistory.isEmpty)
// //             const Center(child: Text("No session history found")),

// //           ...sessionHistory.map((sessionGroup) {
// //             String date = sessionGroup["date"];
// //             List sessions = sessionGroup["sessions"];

// //             return Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 ExpansionTile(
// //                   tilePadding: EdgeInsets.zero,
// //                   title: Row(
// //                     children: [
// //                       const Icon(Icons.calendar_today_outlined, size: 18),
// //                       const SizedBox(width: 10),
// //                       Text(
// //                         date,
// //                         style: const TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   children: [
// //                     ...sessions.map((s) {
// //                       return Container(
// //                         margin: const EdgeInsets.symmetric(
// //                           vertical: 8,
// //                           horizontal: 10,
// //                         ),
// //                         padding: const EdgeInsets.all(16),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(15),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: Colors.grey.shade300,
// //                               blurRadius: 6,
// //                               offset: const Offset(0, 3),
// //                             ),
// //                           ],
// //                         ),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             // TITLE (e.g., Medak)
// //                             Text(
// //                               s["farmer_name"] ?? "Unknown Location",
// //                               style: const TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 6),

// //                             // SUBTEXT
// //                             Text(
// //                               "${s["land"] ?? 1} land completed",
// //                               style: const TextStyle(color: Colors.grey),
// //                             ),
// //                             const SizedBox(height: 10),

// //                             // STATUS BADGE
// //                             Align(
// //                               alignment: Alignment.centerRight,
// //                               child: Container(
// //                                 padding: const EdgeInsets.symmetric(
// //                                   horizontal: 12,
// //                                   vertical: 6,
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.green,
// //                                   borderRadius: BorderRadius.circular(20),
// //                                 ),
// //                                 child: const Text(
// //                                   "Completed",
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontWeight: FontWeight.bold,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ],
// //                 ),

// //                 const Divider(),
// //               ],
// //             );
// //           }).toList(),
// //         ],
// //       ),
// //     );
// //   }

// //   // HELPERS
// //   BoxDecoration _boxDecoration() => BoxDecoration(
// //     color: Colors.white,
// //     borderRadius: BorderRadius.circular(18),
// //     border: Border.all(color: Colors.grey.shade300),
// //   );

// //   InputDecoration _inputDecoration(String hint) => InputDecoration(
// //     hintText: hint,
// //     filled: true,
// //     fillColor: const Color(0xFFF1F1F1),
// //     border: OutlineInputBorder(
// //       borderRadius: BorderRadius.circular(12),
// //       borderSide: BorderSide.none,
// //     ),
// //   );

// //   InputDecoration _inputDecoration2(String hint) {
// //     return InputDecoration(
// //       hintText: hint,
// //       filled: true,
// //       fillColor: const Color(0xFFF5F5F5),
// //       border: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(12),
// //         borderSide: BorderSide.none,
// //       ),
// //     );
// //   }

// //   ButtonStyle _uploadButtonStyle() {
// //     return ElevatedButton.styleFrom(
// //       backgroundColor: const Color(0xFFBDECC6),
// //       foregroundColor: Colors.black87,
// //       minimumSize: const Size(double.infinity, 48),
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:gadura_land/Screens/homepage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart';

// class SessionPage extends StatefulWidget {
//   const SessionPage({super.key});

//   @override
//   State<SessionPage> createState() => _SessionPageState();
// }

// class _SessionPageState extends State<SessionPage> {
//   final TextEditingController startingKm = TextEditingController();
//   final TextEditingController endKmController = TextEditingController();
//   final TextEditingController transportController = TextEditingController();
//   final ImagePicker _imagePicker = ImagePicker(); // Renamed for clarity

//   XFile? odometerImage;
//   XFile? endOdometerImage;
//   List<XFile> ticketImages = [];

//   String? _apiToken;
//   int? _currentSessionId;
//   bool _sessionStarted = false;
//   bool _isLoading = false;

//   List<dynamic> sessionHistory = [];
//   Map<String, int> sessionStats = {}; // For bar graph data

//   @override
//   void initState() {
//     super.initState();
//     loadTokenAndSession();
//   }

//   Future<void> loadTokenAndSession() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _apiToken = prefs.getString("auth_token");
//     _currentSessionId = prefs.getInt("current_session_id");

//     if (_currentSessionId != null) {
//       _sessionStarted = true;
//     }

//     fetchSessionHistory();
//   }

//   // PICK IMAGE - WITH PERMISSION HANDLING
//   Future<void> pickOdometerImage() async {
//     try {
//       // Check if camera is available
//       final isCameraAvailable = await _checkCameraAvailability();
//       if (!isCameraAvailable) {
//         _showCameraErrorDialog();
//         return;
//       }

//       final pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 60,
//         maxWidth: 800,
//         maxHeight: 800,
//       );

//       if (pickedFile != null) {
//         // Check file size
//         final file = File(pickedFile.path);
//         final fileSize = await file.length();
//         final fileSizeInMB = fileSize / (1024 * 1024);

//         if (fileSizeInMB > 10) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Image size too large (max 10MB)")),
//           );
//           return;
//         }

//         setState(() {
//           odometerImage = pickedFile;
//         });
//       }
//     } catch (e) {
//       _handleImagePickerError(e);
//     }
//   }

//   Future<void> pickEndOdometer() async {
//     try {
//       // Check if camera is available
//       final isCameraAvailable = await _checkCameraAvailability();
//       if (!isCameraAvailable) {
//         _showCameraErrorDialog();
//         return;
//       }

//       final pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 60,
//         maxWidth: 800,
//         maxHeight: 800,
//       );

//       if (pickedFile != null) {
//         // Check file size
//         final file = File(pickedFile.path);
//         final fileSize = await file.length();
//         final fileSizeInMB = fileSize / (1024 * 1024);

//         if (fileSizeInMB > 10) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Image size too large (max 10MB)")),
//           );
//           return;
//         }

//         setState(() {
//           endOdometerImage = pickedFile;
//         });
//       }
//     } catch (e) {
//       _handleImagePickerError(e);
//     }
//   }

//   Future<void> pickBusTickets() async {
//     try {
//       // Check if camera is available
//       final isCameraAvailable = await _checkCameraAvailability();
//       if (!isCameraAvailable) {
//         _showCameraErrorDialog();
//         return;
//       }

//       final pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 60,
//         maxWidth: 800,
//         maxHeight: 800,
//       );

//       if (pickedFile != null) {
//         // Check file size
//         final file = File(pickedFile.path);
//         final fileSize = await file.length();
//         final fileSizeInMB = fileSize / (1024 * 1024);

//         if (fileSizeInMB > 10) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Image size too large (max 10MB)")),
//           );
//           return;
//         }

//         setState(() {
//           ticketImages.add(pickedFile);
//         });
//       }
//     } catch (e) {
//       _handleImagePickerError(e);
//     }
//   }

//   // Check camera availability
//   Future<bool> _checkCameraAvailability() async {
//     try {
//       // Check if camera is available
//       final camerasAvailable = await _imagePicker
//           .pickImage(source: ImageSource.camera)
//           .then((_) => true)
//           .catchError((_) => false);

//       return camerasAvailable;
//     } catch (e) {
//       return false;
//     }
//   }

//   // Show camera error dialog
//   void _showCameraErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Camera Not Available"),
//         content: const Text("Please check camera permissions or try again."),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   // Handle image picker errors
//   void _handleImagePickerError(dynamic error) {
//     String errorMessage = "Failed to pick image";

//     if (error is PlatformException) {
//       switch (error.code) {
//         case 'camera_access_denied':
//           errorMessage =
//               "Camera access denied. Please enable camera permissions in settings.";
//           break;
//         case 'camera_access_restricted':
//           errorMessage = "Camera access is restricted on this device.";
//           break;
//         case 'no_camera_available':
//           errorMessage = "No camera available on this device.";
//           break;
//         default:
//           errorMessage = "Camera error: ${error.message}";
//       }
//     }

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(errorMessage)));
//   }

//   // START SESSION API - Starting KM is OPTIONAL
//   Future<void> startSessionApi() async {
//     // Check if token is available
//     if (_apiToken == null || _apiToken!.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Authentication token not found")),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     final url = Uri.parse("http://72.61.169.226/field-executive/session");

//     var request = http.MultipartRequest("POST", url);
//     request.headers["Authorization"] = 'Bearer $_apiToken';

//     // Send starting_km only if it's not empty
//     if (startingKm.text.trim().isNotEmpty) {
//       request.fields["starting_km"] = startingKm.text.trim();
//     }

//     if (odometerImage != null) {
//       try {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'starting_image',
//             odometerImage!.path,
//           ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Error uploading image: $e")));
//         setState(() => _isLoading = false);
//         return;
//       }
//     }

//     try {
//       var response = await request.send();
//       var responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final decode = jsonDecode(responseBody);
//         int sessionId = decode["data"]["id"];

//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setInt("current_session_id", sessionId);

//         setState(() {
//           _currentSessionId = sessionId;
//           _sessionStarted = true;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Session Started! ID: $sessionId")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Failed: ${response.statusCode} - $responseBody"),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: $e")));
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   // END SESSION API - All fields are OPTIONAL
//   Future<void> endSessionApi() async {
//     if (_currentSessionId == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("No active session found")));
//       return;
//     }

//     // Check if any data is entered
//     if (endKmController.text.trim().isEmpty &&
//         transportController.text.trim().isEmpty &&
//         endOdometerImage == null &&
//         ticketImages.isEmpty) {
//       // Ask for confirmation if no data is entered
//       final confirmed = await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("End Session"),
//           content: const Text(
//             "No data entered. End session without any information?",
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: const Text("End Session"),
//             ),
//           ],
//         ),
//       );

//       if (confirmed != true) {
//         return;
//       }
//     }

//     setState(() => _isLoading = true);

//     final url = Uri.parse(
//       "http://72.61.169.226/field-executive/update/session/$_currentSessionId",
//     );

//     var request = http.MultipartRequest("PUT", url);
//     request.headers["Authorization"] = "Bearer $_apiToken";

//     // Send only if fields are not empty
//     if (endKmController.text.trim().isNotEmpty) {
//       request.fields["end_km"] = endKmController.text.trim();
//     }

//     if (transportController.text.trim().isNotEmpty) {
//       request.fields["transport_charges"] = transportController.text.trim();
//     }

//     if (endOdometerImage != null) {
//       try {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'end_image',
//             endOdometerImage!.path,
//           ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Error uploading image: $e")));
//         setState(() => _isLoading = false);
//         return;
//       }
//     }

//     for (var ticket in ticketImages) {
//       try {
//         request.files.add(
//           await http.MultipartFile.fromPath("ticket_image", ticket.path),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error uploading ticket image: $e")),
//         );
//         setState(() => _isLoading = false);
//         return;
//       }
//     }

//     try {
//       var response = await request.send();

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Clear session data
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.remove("current_session_id");

//         // Reset state
//         setState(() {
//           _currentSessionId = null;
//           _sessionStarted = false;
//           startingKm.clear();
//           odometerImage = null;
//           endKmController.clear();
//           transportController.clear();
//           endOdometerImage = null;
//           ticketImages.clear();
//         });

//         // Refresh history
//         fetchSessionHistory();

//         _showSuccessPopup();
//       } else {
//         var responseBody = await response.stream.bytesToString();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Failed: ${response.statusCode} - $responseBody"),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: $e")));
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _showSuccessPopup() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         title: const Text("Success"),
//         content: const Text("Session ended successfully."),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> fetchSessionHistory() async {
//     if (_apiToken == null) return;

//     final url = Uri.parse("http://72.61.169.226/field-executive/session");

//     try {
//       final res = await http.get(
//         url,
//         headers: {"Authorization": "Bearer $_apiToken"},
//       );

//       if (res.statusCode == 200) {
//         final decode = jsonDecode(res.body);
//         final data = decode["data"];

//         // Group sessions by date
//         Map<String, List<dynamic>> grouped = {};

//         data.forEach((id, session) {
//           String date = session["date"];

//           if (!grouped.containsKey(date)) {
//             grouped[date] = [];
//           }

//           grouped[date]!.add(session);
//         });

//         // Calculate statistics for bar graph
//         _calculateSessionStats(data);

//         // Convert to list for UI
//         List<Map<String, dynamic>> formattedList = grouped.entries.map((e) {
//           return {"date": e.key, "sessions": e.value};
//         }).toList();

//         setState(() {
//           sessionHistory = formattedList;
//         });
//       }
//     } catch (e) {
//       print("History Fetch Error: $e");
//     }
//   }

//   // Calculate session statistics for bar graph
//   void _calculateSessionStats(Map<String, dynamic> data) {
//     Map<String, int> stats = {};

//     // Process each session to count by date
//     data.forEach((id, session) {
//       String date = session["date"];
//       stats[date] = (stats[date] ?? 0) + 1;
//     });

//     // Sort dates (most recent first)
//     List<String> sortedDates = stats.keys.toList()
//       ..sort((a, b) => b.compareTo(a));

//     // Take only last 7 days or available days
//     int daysToShow = sortedDates.length > 7 ? 7 : sortedDates.length;
//     Map<String, int> limitedStats = {};

//     for (int i = 0; i < daysToShow; i++) {
//       limitedStats[sortedDates[i]] = stats[sortedDates[i]]!;
//     }

//     setState(() {
//       sessionStats = limitedStats;
//     });
//   }

//   // STOP SESSION WITHOUT SUBMITTING
//   Future<void> _stopSession() async {
//     final confirmed = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Stop Session"),
//         content: const Text(
//           "Are you sure you want to stop this session without submitting?",
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text("No"),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text("Yes"),
//           ),
//         ],
//       ),
//     );

//     if (confirmed == true) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.remove("current_session_id");

//       setState(() {
//         _currentSessionId = null;
//         _sessionStarted = false;
//         startingKm.clear();
//         odometerImage = null;
//         endKmController.clear();
//         transportController.clear();
//         endOdometerImage = null;
//         ticketImages.clear();
//       });

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Session stopped")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return await showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: const Text("Exit Session"),
//                 content: const Text("Do you really want to exit the app?"),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, false),
//                     child: const Text("No"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(context, true),
//                     child: const Text("Yes"),
//                   ),
//                 ],
//               ),
//             ) ??
//             false;
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F6FA),
//         appBar: AppBar(
//           title: const Text("Sessions"),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const Homepage()),
//               );
//             },
//           ),
//           elevation: 0,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//         ),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // SHOW START SESSION CARD IF NO ACTIVE SESSION
//                   if (!_sessionStarted) _sessionCard(),

//                   // SHOW END SESSION CARD IF ACTIVE SESSION EXISTS
//                   if (_sessionStarted) ...[
//                     _endSessionCard(),
//                     const SizedBox(height: 25),
//                     _stopSessionButton(),
//                   ],

//                   const SizedBox(height: 25),

//                   // BAR GRAPH CARD - ADDED BEFORE HISTORY
//                   if (sessionStats.isNotEmpty) _barGraphCard(),

//                   const SizedBox(height: 25),

//                   _historyCard(),
//                 ],
//               ),
//             ),
//             if (_isLoading)
//               Container(
//                 color: Colors.black.withOpacity(0.3),
//                 child: const Center(child: CircularProgressIndicator()),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // BAR GRAPH WIDGET
//   Widget _barGraphCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: const [
//               Icon(Icons.bar_chart, color: Color(0xFF00A86B)),
//               SizedBox(width: 8),
//               Text(
//                 "Session Statistics",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 5),
//           const Text(
//             "Your session activity over the past days",
//             style: TextStyle(color: Colors.grey, fontSize: 14),
//           ),
//           const SizedBox(height: 20),

//           // Bar Graph Container
//           Container(
//             height: 200,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF9F9F9),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: _buildBars(),
//             ),
//           ),

//           const SizedBox(height: 15),

//           // Stats Summary
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _statItem(
//                 Icons.timer,
//                 "Total Sessions",
//                 _getTotalSessions().toString(),
//               ),
//               _statItem(
//                 Icons.calendar_today,
//                 "Days Active",
//                 sessionStats.length.toString(),
//               ),
//               _statItem(
//                 Icons.insights,
//                 "Avg/Day",
//                 _getAverageSessions().toStringAsFixed(1),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Build individual bars for the graph
//   List<Widget> _buildBars() {
//     if (sessionStats.isEmpty) {
//       return [
//         const Center(
//           child: Text(
//             "No session data available",
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ];
//     }

//     List<MapEntry<String, int>> entries = sessionStats.entries.toList();
//     int maxSessions = entries.fold(
//       0,
//       (max, entry) => entry.value > max ? entry.value : max,
//     );

//     return entries.map((entry) {
//       String date = entry.key;
//       int sessions = entry.value;
//       double heightFactor = maxSessions > 0 ? sessions / maxSessions : 0;

//       // Format date to show day/month
//       List<String> dateParts = date.split('-');
//       String displayDate = dateParts.length >= 3
//           ? "${dateParts[2]}/${dateParts[1]}"
//           : date;

//       return Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           // Bar
//           Container(
//             width: 30,
//             height: 120 * heightFactor,
//             decoration: BoxDecoration(
//               color: const Color(0xFF00A86B),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(8),
//                 topRight: Radius.circular(8),
//               ),
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   const Color(0xFF00A86B).withOpacity(0.8),
//                   const Color(0xFF00A86B),
//                 ],
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 sessions.toString(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),

//           // Date label
//           Text(
//             displayDate,
//             style: const TextStyle(fontSize: 12, color: Colors.grey),
//           ),
//         ],
//       );
//     }).toList();
//   }

//   // Stat item widget
//   Widget _statItem(IconData icon, String label, String value) {
//     return Column(
//       children: [
//         Icon(icon, color: const Color(0xFF00A86B), size: 24),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//       ],
//     );
//   }

//   // Helper methods for statistics
//   int _getTotalSessions() {
//     return sessionStats.values.fold(0, (sum, value) => sum + value);
//   }

//   double _getAverageSessions() {
//     if (sessionStats.isEmpty) return 0;
//     return _getTotalSessions() / sessionStats.length;
//   }

//   // START SESSION CARD - Updated to show optional
//   Widget _sessionCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: _boxDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Start a New Session",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 5),
//           const Text(
//             "Select your work type(s) and start the timer.",
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Enter Starting Odometer ",
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 5),

//           const SizedBox(height: 5),

//           TextField(
//             controller: startingKm,
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             decoration: _inputDecoration("e.g., 12345 km"),
//           ),

//           const SizedBox(height: 15),

//           ElevatedButton.icon(
//             onPressed: pickOdometerImage,
//             icon: const Icon(Icons.camera_alt_outlined),
//             label: const Text("Upload Odometer Photo "),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFBDECC6),
//               foregroundColor: Colors.black87,
//               minimumSize: const Size(double.infinity, 48),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),

//           if (odometerImage != null) ...[
//             const SizedBox(height: 15),
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.file(
//                     File(odometerImage!.path),
//                     height: 180,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.black54,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.close,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           odometerImage = null;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],

//           const SizedBox(height: 20),

//           ElevatedButton.icon(
//             onPressed: startSessionApi,
//             icon: const Icon(Icons.play_arrow),
//             label: const Text("Start Session"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF00A86B),
//               foregroundColor: Colors.white,
//               minimumSize: const Size(double.infinity, 50),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // END SESSION CARD - All fields optional
//   Widget _endSessionCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Log Expenses & Readings ",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 5),

//           const SizedBox(height: 25),

//           // TRANSPORT CHARGES (Optional)
//           const Text(
//             "🚍 Transport Charges ",
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: transportController,
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             decoration: _inputDecoration2("Enter amount in ₱ "),
//           ),

//           const SizedBox(height: 12),

//           ElevatedButton.icon(
//             onPressed: pickBusTickets,
//             icon: const Icon(Icons.camera_alt_outlined),
//             label: const Text("Upload Bus Tickets "),
//             style: _uploadButtonStyle(),
//           ),

//           if (ticketImages.isNotEmpty)
//             Column(
//               children: ticketImages.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 XFile img = entry.value;
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(
//                           File(img.path),
//                           height: 150,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black54,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: IconButton(
//                             icon: const Icon(
//                               Icons.close,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 ticketImages.removeAt(index);
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),

//           const SizedBox(height: 25),

//           // END ODOMETER (Optional)
//           const Text(
//             "🚲 End Odometer Reading ",
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: endKmController,
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             decoration: _inputDecoration2("Enter final kilometers "),
//           ),

//           const SizedBox(height: 12),

//           ElevatedButton.icon(
//             onPressed: pickEndOdometer,
//             icon: const Icon(Icons.camera_alt_outlined),
//             label: const Text("Upload Odometer Photo "),
//             style: _uploadButtonStyle(),
//           ),

//           if (endOdometerImage != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.file(
//                       File(endOdometerImage!.path),
//                       height: 150,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black54,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.close,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             endOdometerImage = null;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//           const SizedBox(height: 30),

//           // SUBMIT BUTTON
//           ElevatedButton(
//             onPressed: endSessionApi,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF00A86B),
//               foregroundColor: Colors.white,
//               minimumSize: const Size(double.infinity, 55),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               "Submit Final Readings ",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // STOP SESSION BUTTON
//   Widget _stopSessionButton() {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
//         ],
//       ),
//       child: Container(
//         height: 55,
//         decoration: BoxDecoration(
//           color: const Color(0xFFE45858),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: InkWell(
//           onTap: _stopSession,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(Icons.stop_circle_outlined, color: Colors.white),
//               SizedBox(width: 8),
//               Text(
//                 "Stop Session",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _historyCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: _boxDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: const [
//               Icon(Icons.check_circle, color: Colors.green),
//               SizedBox(width: 6),
//               Text(
//                 "Session & Work History",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 5),
//           const Text(
//             "Your past work sessions and completed tasks.",
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(height: 20),

//           if (sessionHistory.isEmpty)
//             const Center(child: Text("No session history found")),

//           ...sessionHistory.map((sessionGroup) {
//             String date = sessionGroup["date"];
//             List sessions = sessionGroup["sessions"];

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ExpansionTile(
//                   tilePadding: EdgeInsets.zero,
//                   title: Row(
//                     children: [
//                       const Icon(Icons.calendar_today_outlined, size: 18),
//                       const SizedBox(width: 10),
//                       Text(
//                         date,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   children: [
//                     ...sessions.map((s) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 10,
//                         ),
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.shade300,
//                               blurRadius: 6,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // TITLE (e.g., Medak)
//                             Text(
//                               s["farmer_name"] ?? "Unknown Location",
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 6),

//                             // SUBTEXT
//                             Text(
//                               "${s["land"] ?? 1} land completed",
//                               style: const TextStyle(color: Colors.grey),
//                             ),
//                             const SizedBox(height: 10),

//                             // STATUS BADGE
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: const Text(
//                                   "Completed",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ],
//                 ),

//                 const Divider(),
//               ],
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }

//   // HELPERS
//   BoxDecoration _boxDecoration() => BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(18),
//     border: Border.all(color: Colors.grey.shade300),
//   );

//   InputDecoration _inputDecoration(String hint) => InputDecoration(
//     hintText: hint,
//     filled: true,
//     fillColor: const Color(0xFFF1F1F1),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide.none,
//     ),
//   );

//   InputDecoration _inputDecoration2(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: const Color(0xFFF5F5F5),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   ButtonStyle _uploadButtonStyle() {
//     return ElevatedButton.styleFrom(
//       backgroundColor: const Color(0xFFBDECC6),
//       foregroundColor: Colors.black87,
//       minimumSize: const Size(double.infinity, 48),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
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
  final ImagePicker _imagePicker = ImagePicker(); // Renamed for clarity

  XFile? odometerImage;
  XFile? endOdometerImage;
  List<XFile> ticketImages = [];

  String? _apiToken;
  int? _currentSessionId;
  bool _sessionStarted = false;
  bool _isLoading = false;

  List<dynamic> sessionHistory = [];
  List<Map<String, dynamic>> weeklyStats = [];

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

  // PICK IMAGE - WITH PERMISSION HANDLING
  Future<void> pickOdometerImage() async {
    try {
      // Check if camera is available
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
        // Check file size
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
      // Check if camera is available
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
        // Check file size
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
      // Check if camera is available
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
        // Check file size
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

  // Check camera availability
  Future<bool> _checkCameraAvailability() async {
    try {
      // Check if camera is available
      final camerasAvailable = await _imagePicker
          .pickImage(source: ImageSource.camera)
          .then((_) => true)
          .catchError((_) => false);

      return camerasAvailable;
    } catch (e) {
      return false;
    }
  }

  // Show camera error dialog
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

  // Handle image picker errors
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

  // START SESSION API - Starting KM is OPTIONAL
  Future<void> startSessionApi() async {
    // Check if token is available
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

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Session Started! ID: $sessionId")),
        // );
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

  // END SESSION API - All fields are OPTIONAL
  Future<void> endSessionApi() async {
    if (_currentSessionId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No active session found")));
      return;
    }

    // Check if any data is entered
    if (endKmController.text.trim().isEmpty &&
        transportController.text.trim().isEmpty &&
        endOdometerImage == null &&
        ticketImages.isEmpty) {
      // Ask for confirmation if no data is entered
      final confirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("End Session"),
          content: const Text(
            "No data entered. End session without any information?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("End Session"),
            ),
          ],
        ),
      );

      if (confirmed != true) {
        return;
      }
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Clear session data
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("current_session_id");

        // Reset state
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

        // Refresh history
        fetchSessionHistory();

        _showSuccessPopup();
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

        // Calculate weekly stats (like your screenshot)
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

  // Calculate weekly statistics (like your screenshot)
  void _calculateWeeklyStats(Map<String, dynamic> data) {
    // Create dummy data similar to your screenshot
    // In real app, you would calculate from actual data
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
  // Future<void> _stopSession() async {
  //   final confirmed = await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text("Stop Session"),
  //       content: const Text(
  //         "Are you sure you want to stop this session without submitting?",
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, false),
  //           child: const Text("No"),
  //         ),
  //         ElevatedButton(
  //           onPressed: () => Navigator.pop(context, true),
  //           child: const Text("Yes"),
  //         ),
  //       ],
  //     ),
  //   );

  //   if (confirmed == true) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.remove("current_session_id");

  //     setState(() {
  //       _currentSessionId = null;
  //       _sessionStarted = false;
  //       startingKm.clear();
  //       odometerImage = null;
  //       endKmController.clear();
  //       transportController.clear();
  //       endOdometerImage = null;
  //       ticketImages.clear();
  //     });

  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text("Session stopped")));
  //   }
  // }

  Future<void> _stopSession() async {
    final confirmed = true;

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
    }
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
                  if (!_sessionStarted) _sessionCard(),

                  // SHOW END SESSION CARD IF ACTIVE SESSION EXISTS
                  if (_sessionStarted) ...[
                    _endSessionCard(),
                    const SizedBox(height: 25),
                    _stopSessionButton(),
                  ],

                  const SizedBox(height: 25),

                  // WEEKLY STATS CARD (LIKE YOUR SCREENSHOT)
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

  // WEEKLY STATS CARD (LIKE YOUR SCREENSHOT)
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
                _statItem2(
                  "Total Weeks",
                  "${weeklyStats.length}",
                  Icons.calendar_today,
                ),
                _statItem2("Avg Sessions", "7.5", Icons.bar_chart),
                _statItem2("Total Entries", "89", Icons.landscape),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Stat item for weekly stats
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

  // START SESSION CARD - Updated to show optional
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

  // END SESSION CARD - All fields optional
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
          const Text(
            "Log Expenses & Readings ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),

          const SizedBox(height: 25),

          // TRANSPORT CHARGES (Optional)
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

          // END ODOMETER (Optional)
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

  // HELPERS
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
