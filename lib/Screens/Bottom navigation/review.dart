import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/newland.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int selectedIndex = 0; // 0 = Re-check, 1 = Draft

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Review")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔵 Heading
            const Text(
              "Land Data Management",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// 🔵 Slider Button (Re-check / Draft)
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _optionButton("Re-check", 0),
                  _optionButton("Draft", 1),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// 🔵 Edit Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // 👉 Navigate to edit form page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NewLandPage()),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Form"),
              ),
            ),

            const SizedBox(height: 40),

            /// 🔵 Content / Body
            Center(
              child: Text(
                selectedIndex == 0
                    ? "Re-check Mode Enabled"
                    : "Draft Mode Enabled",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom slider option widget
  Widget _optionButton(String title, int index) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
