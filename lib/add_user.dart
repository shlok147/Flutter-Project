// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:matrimony/info/details.dart';
// import 'package:matrimony/landpage.dart';
// import 'package:intl/intl.dart';
// import 'package:matrimony/user_list.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'display_user.dart';
// import 'info/DBHelper.dart';
//
// class AddUser extends StatefulWidget {
//   const AddUser({super.key});
//
//   @override
//   State<AddUser> createState() => _AddUserState();
// }
//
// class _AddUserState extends State<AddUser> {
//   final _formKey = GlobalKey<FormState>();
//
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _dobController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   RegExp regex_name = RegExp(r"^[a-zA-Z\s'_\\-]{3,50}$");
//   RegExp regex_email =
//       RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
//   RegExp regex_phone_no = RegExp(r"^\+?[0-9]{10}$");
//
//   bool obt1 = true;
//   bool obt2 = true;
//   String? selectedCity;
//   String? selectedGender = 'Male';
//   List<String> selectedHobbies = [];
//   List<String> cities = ["Morbi", "Rajkot", "Ahemdabad"];
//   List<String> hobbies = ['Reading', 'Traveling', 'Gaming', 'Cooking'];
//   File? _imageFile;
//
//   Future<void> selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     selectedGender = 'Male';
//   }
//
//   void changeObscureText1() {
//     return setState(() {
//       obt1 = !obt1;
//     });
//   }
//
//   void changeObscureText2() {
//     return setState(() {
//       obt2 = !obt2;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: const Color(0xFFFFF8F0),
//         appBar: AppBar(
//           title: Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 30),
//                   child: InkWell(
//                     onTap: () => {
//                       Navigator.of(context).pop(),
//                       Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => MyApp()))
//                     },
//                     child: Icon(
//                       Icons.arrow_back,
//                       color: Color(0xFFFFF8F0),
//                       size: 30,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 9,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 65),
//                   child: Center(
//                     child: Container(
//                       child: Text(
//                         "Registration",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFFFFF8F0)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           backgroundColor: Color(0xFF800020),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 15,
//                   left: 14,
//                 ),
//                 child: Card(
//                   color: Colors.transparent,
//                   elevation: 0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                           width: 1,
//                           color: Colors.black,
//                         ),
//                         color: Color(0xFF800020),
//                         borderRadius: BorderRadius.all(Radius.circular(30))),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(colors: [
//                       Color(0xFFFFE5DC),
//                       Color(0xFFFFF0E5),
//                     ]),
//                     borderRadius: BorderRadius.circular(30),
//                     border: Border.all(color: Color(0xFF800020), width: 1.5),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF800020).withOpacity(0.3),
//                         blurRadius: 50,
//                         spreadRadius: 2,
//                       )
//                     ],
//                   ),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     elevation: 5,
//                     margin: EdgeInsets.zero,
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             children: [
//                               FormField<File>(
//                                 validator: (value) {
//                                   if (_imageFile == null) {
//                                     return 'Please select an image.';
//                                   }
//                                   return null;
//                                 },
//                                 builder: (FormFieldState<File> state) {
//                                   return Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           _showImagePickerOptions(context);
//                                         },
//                                         child: CircleAvatar(
//                                           radius: 65,
//                                           backgroundColor: state.hasError
//                                               ? Colors.red
//                                               : Colors.transparent,
//                                           child: CircleAvatar(
//                                             radius: 60,
//                                             backgroundColor: Colors.black26,
//                                             backgroundImage: _imageFile != null
//                                                 ? FileImage(_imageFile!)
//                                                     as ImageProvider
//                                                 : const AssetImage(
//                                                     "assets/Image/photo.gif"),
//                                             child: _imageFile == null
//                                                 ? const Icon(
//                                                     Icons.camera_alt,
//                                                     color: Colors.white70,
//                                                     size: 30,
//                                                   )
//                                                 : null,
//                                           ),
//                                         ),
//                                       ),
//                                       // Display the error message below the avatar if validation fails
//                                       if (state.hasError)
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 8.0),
//                                           child: Text(
//                                             state.errorText!,
//                                             style: const TextStyle(
//                                               color: Colors.red,
//                                               fontSize: 12,
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               buildTextField("Your Name", Icons.account_box,
//                                   _nameController, regex_name),
//                               const SizedBox(height: 5),
//                               buildTextField("Email", Icons.email,
//                                   _emailController, regex_email,
//                                   keyboardType: TextInputType.emailAddress),
//                               const SizedBox(height: 5),
//
//                               buildTextField("Mobile Number", Icons.phone,
//                                   _phoneController, regex_phone_no,
//                                   keyboardType: TextInputType.phone,
//                                   max_length: 10),
//                               const SizedBox(height: 15),
//                               // Date of Birth
//                               TextFormField(
//                                 controller: _dobController,
//                                 readOnly: true,
//                                 onTap: () => selectDate(context),
//                                 decoration: inputDecoration(
//                                     "Date of Birth", Icons.calendar_today),
//                                 validator: (value) {
//                                   if (value == null || value.trim().isEmpty) {
//                                     return 'Select Date';
//                                   }
//
//                                   try {
//                                     final inputDate = DateFormat('dd/MM/yyyy')
//                                         .parse(value.trim());
//                                     final today = DateTime.now();
//                                     final age = today.year -
//                                         inputDate.year -
//                                         ((today.month < inputDate.month ||
//                                                 (today.month ==
//                                                         inputDate.month &&
//                                                     today.day < inputDate.day))
//                                             ? 1
//                                             : 0);
//
//                                     if (age < 18) {
//                                       return 'You must be at least 18 years old';
//                                     } else if (age > 60) {
//                                       return 'No more then 60 years people allowed';
//                                     }
//                                   } catch (_) {
//                                     return 'Invalid date format';
//                                   }
//
//                                   return null;
//                                 },
//                               ),
//
//                               const SizedBox(height: 20),
//
//                               // City Dropdown
//                               DropdownButtonFormField<String>(
//                                 value: selectedCity,
//                                 items: cities
//                                     .map((city) => DropdownMenuItem(
//                                           value: city,
//                                           child: Text(city),
//                                         ))
//                                     .toList(),
//                                 onChanged: (value) =>
//                                     setState(() => selectedCity = value),
//                                 validator: (value) {
//                                   if (value == null ||
//                                       value.trim().length == 0) {
//                                     return 'Select Your City';
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                                 decoration: inputDecoration(
//                                     "City", Icons.location_city),
//                               ),
//
//                               const SizedBox(height: 20),
//
//                               // Gender (Radio)
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.black,
//                                       width: 1,
//                                     ),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(15)),
//                                     color: Colors.white),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Column(
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.bottomCenter,
//                                         child: Text("Gender",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Expanded(
//                                             child: Row(
//                                               children: [
//                                                 Radio<String>(
//                                                   value: 'Male',
//                                                   groupValue: selectedGender,
//                                                   visualDensity:
//                                                       VisualDensity.compact,
//                                                   activeColor:
//                                                       Color(0xFF800020),
//                                                   onChanged: (value) =>
//                                                       setState(
//                                                     () =>
//                                                         selectedGender = value,
//                                                   ),
//                                                 ),
//                                                 Flexible(
//                                                   child: Text('Male',
//                                                       style: TextStyle(
//                                                           fontSize: 14)),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Row(
//                                               children: [
//                                                 Radio<String>(
//                                                   value: 'Female',
//                                                   groupValue: selectedGender,
//                                                   visualDensity:
//                                                       VisualDensity.compact,
//                                                   activeColor:
//                                                       Color(0xFF800020),
//                                                   onChanged: (value) =>
//                                                       setState(
//                                                     () =>
//                                                         selectedGender = value,
//                                                   ),
//                                                 ),
//                                                 Flexible(
//                                                   child: Text('Female',
//                                                       style: TextStyle(
//                                                         fontSize: 14,
//                                                       )),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//
//                               // Hobbies (Checkboxes)
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                       width: 1,
//                                       color: Colors.black,
//                                     ),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(15))),
//                                 child: Column(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.bottomCenter,
//                                       child: Text("Hobbies",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 14)),
//                                     ),
//                                     ...hobbies.map((hobby) {
//                                       return CheckboxListTile(
//                                         value: selectedHobbies.contains(hobby),
//                                         title: Text(hobby),
//                                         activeColor: Color(0xFF800020),
//                                         onChanged: (bool? value) {
//                                           setState(() {
//                                             if (value == true) {
//                                               selectedHobbies.add(hobby);
//                                             } else {
//                                               selectedHobbies.remove(hobby);
//                                             }
//                                           });
//                                         },
//                                       );
//                                     }),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(height: 10),
//
//                               LockbuildTextField("Password", Icons.lock,
//                                   _passwordController, changeObscureText1,
//                                   obscureText: obt1),
//
//                               LockbuildTextField(
//                                   "Confirm Password",
//                                   Icons.lock_outline,
//                                   _confirmPasswordController,
//                                   changeObscureText2,
//                                   obscureText: obt2),
//
//                               const SizedBox(height: 20),
//
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Color(0xFFFFF8F0),
//                                       ),
//                                       onPressed: () {
//                                         print("Clicked");
//                                         clear();
//                                         setState(() {
//
//                                         });
//                                       },
//                                       child: const Text(
//                                         "Reset",
//                                         style: TextStyle(
//                                             color: Color(0xff333333),
//                                             fontSize: 15),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Color(0xFF800020),
//                                       ),
//                                       onPressed: () async {
//                                         if (_formKey.currentState!.validate() &&
//                                             (_imageFile != null &&
//                                                 _imageFile != "")) {
//                                           // Save  here
//                                           insertUser().then((value) {
//                                             setState(() {
//                                               Navigator.pop(context);
//                                               Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         Display_User()),
//                                               );
//                                             });
//                                           },);
//
//                                         }
//                                       },
//                                       child: const Text(
//                                         "Save",
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 15),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextField(
//       String hint, IconData icon, TextEditingController controller, RegExp exp,
//       {TextInputType keyboardType = TextInputType.text,
//       bool obscureText = false,
//       int max_length = 0}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         decoration: inputDecoration(hint, icon),
//         maxLength: max_length != 0 ? max_length : null,
//         validator: (value) {
//           final pattern = exp;
//           if (value == null || value.trim().isEmpty) {
//             return "Empty is not valid!!";
//           } else if (!pattern.hasMatch(value.trim())) {
//             return 'Enter ${hint} Proper';
//           } else {
//             return null;
//           }
//         },
//       ),
//     );
//   }
//
//   Widget LockbuildTextField(String hint, IconData icon,
//       TextEditingController controller, VoidCallback cobt,
//       {TextInputType keyboardType = TextInputType.visiblePassword,
//       bool obscureText = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextFormField(
//           obscuringCharacter: "_",
//           controller: controller,
//           obscureText: obscureText,
//           keyboardType: keyboardType,
//           decoration: LockinputDecoration(hint, icon, cobt, obscureText),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Enter Password';
//             }
//             List<String> errors = [];
//             if (value.length < 8) {
//               errors.add('at least 8 characters');
//             }
//             if (!RegExp(r'[A-Z]').hasMatch(value)) {
//               errors.add('one uppercase letter');
//             }
//             if (!RegExp(r'[a-z]').hasMatch(value)) {
//               errors.add('one lowercase letter');
//             }
//             if (!RegExp(r'\d').hasMatch(value)) {
//               errors.add('one digit');
//             }
//             if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
//               errors.add('one special character (@\$!%*?&)');
//             }
//             if (_passwordController.value != _confirmPasswordController.value) {
//               return 'Password and Confirmpassword Did not match';
//             }
//             if (errors.isNotEmpty) {
//               return 'Password must contain:\n- ${errors.join('\n- ')}';
//             }
//             return null; // Valid password
//           }),
//     );
//   }
//
//   InputDecoration LockinputDecoration(
//       String hint, IconData icon, VoidCallback cobt,
//       [bool obscureText = false]) {
//     return InputDecoration(
//       prefixIcon: Icon(icon, color: Colors.black),
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//       border: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Color(0xFF800020),
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Color(0xFF800020)),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       suffixIcon: IconButton(
//           onPressed: cobt,
//           icon: Icon(
//             obscureText ? Icons.visibility : Icons.visibility_off,
//             size: 20,
//           )),
//     );
//   }
//
//   InputDecoration inputDecoration(String hint, IconData icon) {
//     return InputDecoration(
//       prefixIcon: Icon(icon, color: Colors.black),
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//       border: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Color(0xFF800020),
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Color(0xFF800020)),
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
//
//   Widget _buildPickerOption({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 40),
//           const SizedBox(height: 8),
//           Text(label),
//         ],
//       ),
//     );
//   }
//
//   void _showImagePickerOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (builder) {
//         return Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 6,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildPickerOption(
//                   icon: Icons.image,
//                   label: "Gallery",
//                   onTap: () {
//                     _pickImage(ImageSource.gallery);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 _buildPickerOption(
//                   icon: Icons.camera_alt,
//                   label: "Camera",
//                   onTap: () {
//                     _pickImage(ImageSource.camera);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   Future<void> insertUser() async {
//     DBHelper db = DBHelper();
//
//     P_Details temp = P_Details();
//     temp.Name =
//         _nameController.text.toString();
//     temp.Email =
//         _emailController.text.toString();
//     temp.Phone =
//         _phoneController.text.toString();
//     temp.Date_Birth =
//         _dobController.text.toString();
//     temp.City = selectedCity!.toString();
//     temp.Gender =
//         selectedGender!.toString();
//     temp.Hobbies =
//         jsonEncode(selectedHobbies);
//     temp.Password = _passwordController
//         .text
//         .toString();
//     if (_imageFile != null) {
//       final bytes =
//       await _imageFile!.readAsBytes();
//       temp.ImagePath =
//           base64Encode(bytes);
//     }
//
//     int value = await db.insertUser(temp);
//     if (value != 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Data added successfully!!!")),
//       );
//       clear();
//       setState(() {
//         _imageFile = null;
//       });
//     }
//   }
//
//   void clear() {
//     _formKey.currentState?.reset();
//     _nameController.clear();
//     _emailController.clear();
//     _dobController.clear();
//     _passwordController.clear();
//     _confirmPasswordController.clear();
//     selectedCity = null;
//     selectedGender = "Male";
//     selectedHobbies.clear();
//     _imageFile = null;
//   }
// }

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:matrimony/info/details.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'info/DBHelper.dart';

class AddUser extends StatefulWidget {
   P_Details? user;
   AddUser({super.key, this.user});

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
  RegExp regex_name = RegExp(r"^[a-zA-Z\s'_\\-]{3,50}$");
  RegExp regex_email = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  RegExp regex_phone_no = RegExp(r"^\+?[0-9]{10}$");

  bool obt1 = true;
  bool obt2 = true;
  String? selectedCity;
  String? selectedGender = 'Male';
  List<String> selectedHobbies = [];
  List<String> cities = ["Morbi", "Rajkot", "Ahemdabad"];
  List<String> hobbies = ['Reading', 'Traveling', 'Gaming', 'Cooking'];
  File? _imageFile;

  // ✨ NEW: Helper function to save the image and return its path
  Future<String> _saveImageToAppDirectory(File image) async {
    // Get the directory where the app can store files
    final directory = await getApplicationDocumentsDirectory();
    // Create a unique filename to avoid conflicts
    final fileName = '${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}';
    // Create the full path for the new file
    final newPath = p.join(directory.path, fileName);
    // Copy the picked image file to the new path
    final savedImage = await image.copy(newPath);
    // Return the path of the saved image
    return savedImage.path;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      final user = widget.user!;
      _nameController.text = user.Name;
      _emailController.text = user.Email;
      _phoneController.text = user.Phone;
      _dobController.text = user.Date_Birth;
      _passwordController.text = user.Password;
      _confirmPasswordController.text = user.Password;
      selectedCity = user.City;
      selectedGender = user.Gender;
      selectedHobbies = List<String>.from(jsonDecode(user.Hobbies));
      if (user.ImagePath.isNotEmpty) {
        _imageFile = File(user.ImagePath);
      }
    } else {
      selectedGender = 'Male';
    }
  }

  void changeObscureText1() {
    setState(() {
      obt1 = !obt1;
    });
  }

  void changeObscureText2() {
    setState(() {
      obt2 = !obt2;
    });
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
                    onTap: () {
                      Navigator.of(context).pop();
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
                    child: Text(
                      widget.user == null ? "Registration" : "Update Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFF8F0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF800020),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 14,
                ),
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                        color: Color(0xFF800020),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xFFFFE5DC),
                      Color(0xFFFFF0E5),
                    ]),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xFF800020), width: 1.5),
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
                              // ... (Keep all your existing FormFields like Name, Email, etc.)
                              FormField<File>(
                                validator: (value) {
                                  if (_imageFile == null) {
                                    return 'Please select an image.';
                                  }
                                  return null;
                                },
                                builder: (FormFieldState<File> state) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showImagePickerOptions(context);
                                        },
                                        child: CircleAvatar(
                                          radius: 65,
                                          backgroundColor: state.hasError
                                              ? Colors.red
                                              : Colors.transparent,
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundColor: Colors.black26,
                                            backgroundImage: _imageFile != null
                                                ? FileImage(_imageFile!)
                                            as ImageProvider
                                                : const AssetImage(
                                                "assets/Image/photo.gif"),
                                            child: _imageFile == null
                                                ? const Icon(
                                              Icons.camera_alt,
                                              color: Colors.white70,
                                              size: 30,
                                            )
                                                : null,
                                          ),
                                        ),
                                      ),
                                      // Display the error message below the avatar if validation fails
                                      if (state.hasError)
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              buildTextField("Your Name", Icons.account_box,
                                  _nameController, regex_name),
                              const SizedBox(height: 5),
                              buildTextField("Email", Icons.email,
                                  _emailController, regex_email,
                                  keyboardType: TextInputType.emailAddress),
                              const SizedBox(height: 5),

                              buildTextField("Mobile Number", Icons.phone,
                                  _phoneController, regex_phone_no,
                                  keyboardType: TextInputType.phone,
                                  max_length: 10),
                              const SizedBox(height: 15),
                              // Date of Birth
                              TextFormField(
                                controller: _dobController,
                                readOnly: true,
                                onTap: () => selectDate(context),
                                decoration: inputDecoration(
                                    "Date of Birth", Icons.calendar_today),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Select Date';
                                  }

                                  try {
                                    final inputDate = DateFormat('dd/MM/yyyy')
                                        .parse(value.trim());
                                    final today = DateTime.now();
                                    final age = today.year -
                                        inputDate.year -
                                        ((today.month < inputDate.month ||
                                            (today.month ==
                                                inputDate.month &&
                                                today.day < inputDate.day))
                                            ? 1
                                            : 0);

                                    if (age < 18) {
                                      return 'You must be at least 18 years old';
                                    } else if (age > 60) {
                                      return 'No more then 60 years people allowed';
                                    }
                                  } catch (_) {
                                    return 'Invalid date format';
                                  }

                                  return null;
                                },
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
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length == 0) {
                                    return 'Select Your City';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: inputDecoration(
                                    "City", Icons.location_city),
                              ),

                              const SizedBox(height: 20),

                              // Gender (Radio)
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text("Gender",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Radio<String>(
                                                  value: 'Male',
                                                  groupValue: selectedGender,
                                                  visualDensity:
                                                  VisualDensity.compact,
                                                  activeColor:
                                                  Color(0xFF800020),
                                                  onChanged: (value) =>
                                                      setState(
                                                            () =>
                                                        selectedGender = value,
                                                      ),
                                                ),
                                                Flexible(
                                                  child: Text('Male',
                                                      style: TextStyle(
                                                          fontSize: 14)),
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
                                                  visualDensity:
                                                  VisualDensity.compact,
                                                  activeColor:
                                                  Color(0xFF800020),
                                                  onChanged: (value) =>
                                                      setState(
                                                            () =>
                                                        selectedGender = value,
                                                      ),
                                                ),
                                                Flexible(
                                                  child: Text('Female',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      )),
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
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text("Hobbies",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
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

                              LockbuildTextField("Password", Icons.lock,
                                  _passwordController, changeObscureText1,
                                  obscureText: obt1),

                              LockbuildTextField(
                                  "Confirm Password",
                                  Icons.lock_outline,
                                  _confirmPasswordController,
                                  changeObscureText2,
                                  obscureText: obt2),

                              const SizedBox(height: 20),

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFFF8F0),
                                      ),
                                      onPressed: () {
                                        clear();
                                      },
                                      child: const Text(
                                        "Reset",
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF800020),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (widget.user == null) {
                                            await insertUser();
                                          } else {
                                            await updateUser();
                                          }
                                          if (mounted) {
                                            Navigator.of(context).pop();
                                          }
                                        }
                                      },
                                      child: Text(
                                        widget.user == null ? "Save" : "Update",
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String hint, IconData icon, TextEditingController controller, RegExp exp,
      {TextInputType keyboardType = TextInputType.text,
        bool obscureText = false,
        int max_length = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: inputDecoration(hint, icon),
        maxLength: max_length != 0 ? max_length : null,
        buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
        validator: (value) {
          final pattern = exp;
          if (value == null || value.trim().isEmpty) {
            return "Empty is not valid!!";
          } else if (!pattern.hasMatch(value.trim())) {
            return 'Enter ${hint} Proper';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget LockbuildTextField(String hint, IconData icon,
      TextEditingController controller, VoidCallback cobt,
      {TextInputType keyboardType = TextInputType.visiblePassword,
        bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
          obscuringCharacter: "_",
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: LockinputDecoration(hint, icon, cobt, obscureText),
          validator: (value) {
            // Added check for edit mode, where password can be unchanged
            if (widget.user != null && value!.isEmpty) {
              return null;
            }

            if (value == null || value.isEmpty) {
              return 'Enter Password';
            }
            List<String> errors = [];
            if (value.length < 8) {
              errors.add('at least 8 characters');
            }
            if (!RegExp(r'[A-Z]').hasMatch(value)) {
              errors.add('one uppercase letter');
            }
            if (!RegExp(r'[a-z]').hasMatch(value)) {
              errors.add('one lowercase letter');
            }
            if (!RegExp(r'\d').hasMatch(value)) {
              errors.add('one digit');
            }
            if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
              errors.add('one special character (@\$!%*?&)');
            }
            if (_passwordController.text != _confirmPasswordController.text) {
              return 'Passwords do not match';
            }
            if (errors.isNotEmpty) {
              return 'Password must contain:\n- ${errors.join('\n- ')}';
            }
            return null;
          }),
    );
  }

  InputDecoration LockinputDecoration(
      String hint, IconData icon, VoidCallback cobt,
      [bool obscureText = false]) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.black),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF800020),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF800020)),
        borderRadius: BorderRadius.circular(12),
      ),
      suffixIcon: IconButton(
          onPressed: cobt,
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            size: 20,
          )),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.black),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF800020),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF800020)),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPickerOption(
                  icon: Icons.image,
                  label: "Gallery",
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                _buildPickerOption(
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<P_Details> _mapControllersToUser() async {
    P_Details temp = P_Details();
    if (widget.user != null) {
      temp = widget.user!;
    }
    temp.Name = _nameController.text;
    temp.Email = _emailController.text;
    temp.Phone = _phoneController.text;
    temp.Date_Birth = _dobController.text;
    temp.City = selectedCity!;
    temp.Gender = selectedGender!;
    temp.Hobbies = jsonEncode(selectedHobbies);
    temp.Password = _passwordController.text;

    if (_imageFile != null) {
      if (widget.user == null || _imageFile!.path != widget.user!.ImagePath) {
        temp.ImagePath = await _saveImageToAppDirectory(_imageFile!);
      }
    }
    return temp;
  }

  Future<void> insertUser() async {
    final db = DBHelper();
    final user = await _mapControllersToUser();

    await db.insertUser(user);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User registered successfully!")),
      );
    }
  }

  Future<void> updateUser() async {
    final db = DBHelper();
    final user = await _mapControllersToUser();

    await db.updateUser(user);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully!")),
      );
    }
  }

  void clear() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _dobController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    setState(() {
      selectedCity = null;
      selectedGender = "Male";
      selectedHobbies.clear();
      _imageFile = null;
    });
  }
}