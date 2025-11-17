import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ---------------- PROFILE PHOTO ----------------
            const SizedBox(height: 30),

            const CircleAvatar(
              radius: 50,
              // backgroundImage: AssetImage("assets/profile.jpg"), // your image
            ),
            const SizedBox(height: 12),

            // ---------------- NAME & EMAIL ----------------
            const Text(
              "Suresh Kumar",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "suresh@rolesync.app",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 15),

            // ---------------- EDIT BUTTON ----------------
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A86B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- PERSONAL INFO CARD ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: const [
                      Icon(Icons.person_outline, color: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ID Photo
                  const Text(
                    "ID Card Photo:",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // image: const DecorationImage(
                            //   image: AssetImage("assets/idphoto.jpg"),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton.icon(
                          onPressed: () {
                            print("its working");
                          },
                          icon: const Icon(Icons.upload_file_outlined),
                          label: const Text("Upload"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Full Name
                  const Text(
                    "Full Name:",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  _infoBox("Suresh Kumar"),

                  const SizedBox(height: 20),

                  // Role
                  const Text(
                    "Role:",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  _infoBox("Field Executive"),

                  const SizedBox(height: 20),

                  // Email Address
                  const Text(
                    "Email Address:",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  _infoBox("suresh@rolesync.app"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Helper Box ----------------
  Widget _infoBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: const TextStyle(fontSize: 15)),
    );
  }
}
