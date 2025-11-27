import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isEmail = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  final String adminEmail = "admin@example.com";
  final String adminPhone = "+911234567890";

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final value = _inputController.text.trim();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Reset request sent to $value")));
  }

  Future<void> _contactAdmin() async {
    final mailUri = Uri(
      scheme: "mailto",
      path: adminEmail,
      query:
          "subject=Password Reset Help&body=Hi Admin, I need help resetting my password.",
    );
    final telUri = Uri(scheme: "tel", path: adminPhone);

    // if (await canLaunchUrl(mailUri)) {
    //   await launchUrl(mailUri);
    // } else {
    //   await launchUrl(telUri);
    // }
  }

  String? _validateInput(String? val) {
    if (val == null || val.trim().isEmpty) return "Field cannot be empty";

    if (isEmail) {
      final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
      if (!emailRegex.hasMatch(val)) return "Enter valid email";
    } else {
      final phoneRegex = RegExp(r"^\+?\d{7,15}$");
      if (!phoneRegex.hasMatch(val)) return "Enter valid phone number";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// Title Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B7CFA), Color(0xFF7E57F2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Enter your email or phone number to reset your password.",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// Toggle Email / Phone
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isEmail = true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isEmail ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.email_outlined, size: 18),
                                SizedBox(width: 6),
                                Text("Email"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isEmail = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isEmail ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.phone_outlined, size: 18),
                                SizedBox(width: 6),
                                Text("Phone"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// Form Field
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _inputController,
                  keyboardType: isEmail
                      ? TextInputType.emailAddress
                      : TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: isEmail ? "Email" : "Phone Number",
                    hintText: isEmail ? "example@gmail.com" : "+91 9876543210",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(isEmail ? Icons.email : Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: _validateInput,
                ),
              ),

              const SizedBox(height: 25),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: InkWell(
                  onTap: _submit,
                  borderRadius: BorderRadius.circular(14),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        "Send Reset Link",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// Contact Admin
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Need help? "),
                  InkWell(
                    onTap: _contactAdmin,
                    child: const Text(
                      "Contact Administrator",
                      style: TextStyle(
                        color: Colors.indigo,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
