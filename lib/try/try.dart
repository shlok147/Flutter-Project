import 'package:flutter/material.dart';

class LockTextFieldScreen extends StatefulWidget {
  const LockTextFieldScreen({super.key});

  @override
  State<LockTextFieldScreen> createState() => _LockTextFieldScreenState();
}

class _LockTextFieldScreenState extends State<LockTextFieldScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _changeObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: LockbuildTextField(
            "Password",
            Icons.lock,
            _passwordController,
            obscureText: _obscureText,
            onToggleVisibility: _changeObscureText,
          ),
        ),
      ),
    );
  }
}

// ✅ Updated builder function
Widget LockbuildTextField(
    String hint,
    IconData icon,
    TextEditingController controller, {
      TextInputType keyboardType = TextInputType.text,
      bool obscureText = false,
      required VoidCallback onToggleVisibility,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration:
      LockinputDecoration(hint, icon, obscureText, onToggleVisibility),
    ),
  );
}

// ✅ Updated decoration function
InputDecoration LockinputDecoration(
    String hint,
    IconData icon,
    bool obscureText,
    VoidCallback onToggleVisibility,
    ) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Colors.black),
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF800020)),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF800020)),
      borderRadius: BorderRadius.circular(12),
    ),
    suffixIcon: IconButton(
      onPressed: onToggleVisibility,
      icon: Icon(
        obscureText ? Icons.visibility_off : Icons.visibility,
        size: 20,
      ),
    ),
  );
}
