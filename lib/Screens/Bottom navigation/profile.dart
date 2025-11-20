import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/Bottom%20navigation/wallet.dart';
import 'package:gadura_land/Screens/homepage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ---------- Controllers ----------
  final TextEditingController nameController = TextEditingController(
    text: "Suresh Kumar",
  );

  final TextEditingController emailController = TextEditingController(
    text: "suresh@rolesync.app",
  );

  final TextEditingController roleController = TextEditingController(
    text: "Field Executive",
  );

  // ---------- Images ----------
  File? profileImage;
  File? idCardImage;

  final ImagePicker picker = ImagePicker();

  // Pick Image
  Future<void> pickImage(bool isProfile) async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (file != null) {
      setState(() {
        if (isProfile) {
          profileImage = File(file.path);
        } else {
          idCardImage = File(file.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Profile", style: TextStyle(color: Colors.black)),
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ---------------- PROFILE PHOTO ----------------
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: profileImage != null
                      ? FileImage(profileImage!)
                      : null,
                  child: profileImage == null
                      ? const Icon(Icons.person, size: 60, color: Colors.white)
                      : null,
                ),
                GestureDetector(
                  onTap: () => pickImage(true),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ---------------- Edit Button ----------------
            ElevatedButton.icon(
              onPressed: () => openEditDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A86B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

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

                  // ---------------- ID CARD PHOTO ----------------
                  const Text(
                    "ID Card Photo:",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 10),

                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                            image: idCardImage != null
                                ? DecorationImage(
                                    image: FileImage(idCardImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: idCardImage == null
                              ? const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                        const SizedBox(height: 10),
                        TextButton.icon(
                          onPressed: () => pickImage(false),
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Upload"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  _label("Full Name:"),
                  _infoBox(nameController.text),

                  const SizedBox(height: 15),

                  _label("Role:"),
                  _infoBox(roleController.text),

                  const SizedBox(height: 15),

                  _label("Email Address:"),
                  _infoBox(emailController.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String text) {
    return Container(
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  // ---------------------- EDIT POPUP -----------------------
  void openEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: "Role"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
