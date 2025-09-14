import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrimony/landpage.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? selectedCity;
  String? selectedGender;
  List<String> selectedHobbies = [];
  List<String> cities = ["Morbi","Rajkot","Ahemdabad"];
  List<String> hobbies = ['Reading', 'Traveling', 'Gaming', 'Cooking'];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF8F0),
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: InkWell(
                    onTap: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => landpage()))
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xFFFFF8F0),
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.only(right: 65),
                  child: Center(
                    child: Container(
                      child: Text(
                        "Registration",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Color(0xFFFFF8F0)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF800020),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0xFFFFE5DC),
                Color(0xFFFFF0E5),
              ]),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Color(0xFF800020),
                width: 1.5
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF800020).withOpacity(0.3),
                  blurRadius: 50,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
              margin: EdgeInsets.zero,
              child: SingleChildScrollView(

                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextField("Your Name", Icons.account_box, _nameController),
                        const SizedBox(height: 5),
                        buildTextField("Email", Icons.email, _emailController, keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 5),
                        buildTextField("Mobile Number", Icons.phone, _phoneController, keyboardType: TextInputType.phone),
                        const SizedBox(height: 15),
                        // Date of Birth
                        TextFormField(
                          controller: _dobController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: inputDecoration("Date of Birth", Icons.calendar_today),
                        ),

                        const SizedBox(height: 20),

                        // City Dropdown
                        DropdownButtonFormField<String>(
                          value: selectedCity,
                          items: cities
                              .map((city) => DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedCity = value),
                          decoration:
                          inputDecoration("City", Icons.location_city),
                        ),

                        const SizedBox(height: 20),

                        // Gender (Radio)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                            ,color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text("Gender",
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: 'Male',
                                            groupValue: selectedGender,
                                            visualDensity: VisualDensity.compact,
                                            activeColor: Color(0xFF800020),
                                            onChanged: (value) => setState(() => selectedGender = value),
                                          ),
                                          const Flexible(
                                            child: Text('Male', style: TextStyle(fontSize: 14)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: 'Female',
                                            groupValue: selectedGender,
                                            visualDensity: VisualDensity.compact,
                                            activeColor: Color(0xFF800020),
                                            onChanged: (value) => setState(() => selectedGender = value),
                                          ),
                                          const Flexible(
                                            child: Text('Female', style: TextStyle(fontSize: 14)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Hobbies (Checkboxes)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text("Hobbies",
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              ...hobbies.map((hobby) {
                                return CheckboxListTile(
                                  value: selectedHobbies.contains(hobby),
                                  title: Text(hobby),
                                  activeColor: Color(0xFF800020),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedHobbies.add(hobby);
                                      } else {
                                        selectedHobbies.remove(hobby);
                                      }
                                    });
                                  },
                                );
                              }),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        buildTextField("Password", Icons.lock, _passwordController, obscureText: true),

                        buildTextField("Confirm Password", Icons.lock_outline, _confirmPasswordController, obscureText: true),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFF8F0),
                                ),
                                onPressed: () {
                                  _formKey.currentState?.reset();
                                  _dobController.clear();
                                  setState(() {
                                    selectedCity = null;
                                    selectedGender = null;
                                    selectedHobbies.clear();
                                  });
                                },
                                child: const Text(
                                  "Reset",
                                  style: TextStyle(
                                      color: Color(0xff333333), fontSize: 15),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF800020),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Save logic here
                                  }
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint, IconData icon, TextEditingController controller, {TextInputType keyboardType = TextInputType.text, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: inputDecoration(hint, icon),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.black),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 15.0),
      border: OutlineInputBorder(

        borderSide: BorderSide(
          color: Color(0xFF800020),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}