// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:matrimony/info/DBHelper.dart';
// import 'package:matrimony/info/details.dart';
// import 'package:matrimony/landpage.dart';
// import 'package:matrimony/try/simple.dart';
// import 'package:path/path.dart';
// import 'add_user.dart';
// import 'dart:math';
//
// class user_list extends StatefulWidget {
//   const user_list({super.key});
//
//   @override
//   State<user_list> createState() => _user_listState();
// }
//
// class _user_listState extends State<user_list> {
//   var search_data = TextEditingController();
//
//   DBHelper db = DBHelper();
//   List<P_Details> users = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchdata();
//   }
//
//   Future<void> fetchdata() async {
//     users = await db.getAllUser();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           appBar: AppBar(
//             title: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 0),
//                   child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context) => MyApp()));
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: Icon(
//                           Icons.arrow_back,
//                           color: Colors.black,
//                           size: 30,
//                         ),
//                       )),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     "User List",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             backgroundColor: Color(0xFF800020),
//           ),
//           body: Container(
//             color: Color(0xFFFFF8F0),
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Color(0xFF800020),
//                               width: 3,
//                             )),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                               color: Color(0xFF800020),
//                               width: 3,
//                             )),
//                         hintText: "Search Name..",
//                         fillColor: Colors.white,
//                         filled: true,
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 15, horizontal: 20),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Colors.black,
//                           size: 30,
//                         )),
//                     controller: search_data,
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Expanded(
//                     flex: 9,
//                     child: ListView.separated(
//                         itemBuilder: (context, index) {
//                           return Card(
//                             elevation: 10,
//                             color: Colors.white,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text("Image : "),
//                                       CircleAvatar(
//                                         radius: 30,
//                                         backgroundImage: MemoryImage(
//                                           base64Decode(users[index].ImagePath),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text("Name : "),
//                                       Text("${users[index].Name}"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text("Email : "),
//                                       Text("${users[index].Email}"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text("Mobile : "),
//                                       Text("${users[index].Phone}"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text("Birth Date : "),
//                                       Text("${users[index].Date_Birth}"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text("City : "),
//                                       Text("${users[index].City}"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text("Gender : "),
//                                       Text("${users[index].Gender}"),
//                                     ],
//                                   ),
//                                   // Row(
//                                   //   children: [
//                                   //     Text("Hobbies: "),
//                                   //     Text("${(jsonEncode(users[index].Hobbies) as List<dynamic>).join(", ")}"),
//                                   //   ],
//                                   // ),
//                                   Row(
//                                     children: [
//                                       Text("Hobbies: "),
//                                       // Simply join the list items into a single string.
//                                       Text(jsonEncode(users[index].Hobbies).splitMapJoin(", ")),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text("Password: "),
//                                       Text("${users[index].Password}"),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text("isFavourite: "),
//                                       Text("${users[index].isFavourite}"),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) {
//                           return Divider(
//                             // height: 4,
//                             thickness: 3,
//                           );
//                         },
//                         itemCount: users.length),
//                   )
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
// //  search bar , name phone number ,@email ,filter age , sort


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:matrimony/info/DBHelper.dart';
import 'package:matrimony/info/details.dart';
import 'package:path/path.dart';

// ENUM to define the available sort options for type-safety and readability.
enum SortOption { none, byName, byAge }

class user_list extends StatefulWidget {
  const user_list({super.key});

  @override
  State<user_list> createState() => _user_listState();
}

class _user_listState extends State<user_list> {
  final search_data = TextEditingController();
  final db = DBHelper();

  // State variables for managing the list, filters, and sorting
  List<P_Details> masterUserList = []; // The original, unmodified list from the database
  List<P_Details> displayedUsers = []; // The list that gets filtered/sorted and shown in the UI

  // State for sorting
  SortOption _currentSortOption = SortOption.none;

  // State for age filtering
  // We assume a reasonable age range for a matrimony app, e.g., 18 to 60.
  RangeValues _ageRangeValues = const RangeValues(18, 60);

  @override
  void initState() {
    super.initState();
    fetchdata();
    // Add a listener to the search controller to automatically filter as the user types.
    search_data.addListener(applyFiltersAndSort);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    search_data.dispose();
    super.dispose();
  }

  Future<void> fetchdata() async {
    // Fetch the data and populate both the master list and the initial displayed list.
    masterUserList = await db.getAllUser();
    setState(() {
      displayedUsers = masterUserList;
    });
  }

  /// Calculates age from a date of birth string.
  /// Assumes the date format is 'dd/MM/yyyy'.
  int _calculateAge(String birthDateString) {
    try {
      final birthDate = DateFormat('dd/MM/yyyy').parse(birthDateString);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      // Return 0 if the date format is invalid, preventing crashes.
      return 0;
    }
  }

  /// The main function to apply all active filters and sorting rules.
  void applyFiltersAndSort() {
    List<P_Details> filteredList = List.from(masterUserList);
    String query = search_data.text.toLowerCase();

    // 1. Apply Search Query Filter
    if (query.isNotEmpty) {
      filteredList = filteredList.where((user) {
        final nameMatches = user.Name.toLowerCase().contains(query);
        final emailMatches = user.Email.toLowerCase().contains(query);
        final phoneMatches = user.Phone.contains(query);
        return nameMatches || emailMatches || phoneMatches;
      }).toList();
    }

    // 2. Apply Age Range Filter
    filteredList = filteredList.where((user) {
      final age = _calculateAge(user.Date_Birth);
      return age >= _ageRangeValues.start && age <= _ageRangeValues.end;
    }).toList();

    // 3. Apply Sorting
    switch (_currentSortOption) {
      case SortOption.byName:
        filteredList.sort((a, b) => a.Name.compareTo(b.Name));
        break;
      case SortOption.byAge:
        filteredList.sort((a, b) =>
            _calculateAge(a.Date_Birth).compareTo(_calculateAge(b.Date_Birth)));
        break;
      case SortOption.none:
      // Do nothing, maintain default order (usually by ID)
        break;
    }

    // 4. Update the UI with the final list
    setState(() {
      displayedUsers = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "User List",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF800020),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: const Color(0xFFFFF8F0),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Search Bar
                TextFormField(
                  controller: search_data,
                  decoration: InputDecoration(
                    hintText: "Search by Name, Email, or Phone..",
                    prefixIcon: const Icon(Icons.search, color: Colors.black, size: 30),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF800020), width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF800020), width: 3),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Filters and Sorting in a collapsible tile
                ExpansionTile(
                  title: const Text("Filters and Sorting"),
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Age Filter
                          Text(
                              "Filter by Age: ${_ageRangeValues.start.round()} - ${_ageRangeValues.end.round()}",
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          RangeSlider(
                            values: _ageRangeValues,
                            min: 18,
                            max: 60,
                            divisions: 42, // 60 - 18
                            labels: RangeLabels(
                              _ageRangeValues.start.round().toString(),
                              _ageRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _ageRangeValues = values;
                              });
                              // Apply filters when the user releases the slider
                              applyFiltersAndSort();
                            },
                          ),
                          const Divider(),
                          // Sorting
                          const Text("Sort by", style: TextStyle(fontWeight: FontWeight.bold)),
                          RadioListTile<SortOption>(
                            title: const Text("Default"),
                            value: SortOption.none,
                            groupValue: _currentSortOption,
                            onChanged: (SortOption? value) {
                              setState(() {
                                _currentSortOption = value!;
                              });
                              applyFiltersAndSort();
                            },
                          ),
                          RadioListTile<SortOption>(
                            title: const Text("Name (A-Z)"),
                            value: SortOption.byName,
                            groupValue: _currentSortOption,
                            onChanged: (SortOption? value) {
                              setState(() {
                                _currentSortOption = value!;
                              });
                              applyFiltersAndSort();
                            },
                          ),
                          RadioListTile<SortOption>(
                            title: const Text("Age (Youngest First)"),
                            value: SortOption.byAge,
                            groupValue: _currentSortOption,
                            onChanged: (SortOption? value) {
                              setState(() {
                                _currentSortOption = value!;
                              });
                              applyFiltersAndSort();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // User List
                Expanded(
                  child: ListView.separated(
                    itemCount: displayedUsers.length,
                    itemBuilder: (context, index) {
                      final user = displayedUsers[index];
                      return Card(
                        elevation: 10,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(children: [
                                const Text("Image : "),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: MemoryImage(base64Decode(user.ImagePath)),
                                ),
                              ]),
                              Row(children: [const Text("Name : "), Text(user.Name)]),
                              Row(children: [const Text("Email : "), Text(user.Email)]),
                              Row(children: [const Text("Mobile : "), Text(user.Phone)]),
                              Row(children: [
                                const Text("Birth Date : "),
                                Text("${user.Date_Birth} (Age: ${_calculateAge(user.Date_Birth)})")
                              ]),
                              Row(children: [const Text("City : "), Text(user.City)]),
                              Row(children: [const Text("Gender : "), Text(user.Gender)]),
                              Row(children: [
                                const Text("Hobbies: "),
                                // Make sure your P_Details model is fixed to handle Hobbies as a List<String>
                                // Expanded(child: Text(user.Hobbies.join(", "), overflow: TextOverflow.ellipsis)),
                              ]),
                              Row(children: [const Text("Password: "), Text(user.Password)]),
                              Row(children: [
                                const Text("isFavourite: "),
                                Text(user.isFavourite.toString())
                              ]),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 3);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}