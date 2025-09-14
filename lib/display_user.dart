// //  search bar , name phone number ,@email ,filter age , sort
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:matrimony/UserProfilePage.dart';
import 'package:matrimony/info/DBHelper.dart';
import 'package:matrimony/info/details.dart';
import 'add_user.dart';
import 'landpage.dart';

class Display_User extends StatefulWidget {
  bool isFavourite;

  Display_User({super.key, required this.isFavourite});

  @override
  State<Display_User> createState() => _Display_UserState();
}

class _Display_UserState extends State<Display_User> {
  // var search_data = TextEditingController();

  DBHelper db = DBHelper();
  List<P_Details> users = [];
  List<P_Details> filteredUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.isFavourite) {
      getFavourites();
    } else {
      fetchdata();
    }
  }

  Future<void> fetchdata() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    users = await db.getAllUser();
    filteredUsers = List.from(users);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getFavourites() async {
    if (mounted) {
      setState(() {
        this.users = users;
      });
    }
    users = await db.getFavourite();
    filteredUsers = List.from(users);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController searchController = TextEditingController();
  late String title = (widget.isFavourite) ? "Favorites" : "User List";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => landpage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF800020),
        ),
        backgroundColor: Color(0xFFFFF8F0),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : users.isEmpty
                ? const Center(child: Text("No users found."))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          onChanged: (value) {

                            filteredUsers.clear();
                            if (searchController.text.isNotEmpty) {
                              final query = searchController.text.toLowerCase();

                              filteredUsers = users.where((user) {
                                return user.Name.toLowerCase().contains(query) ||
                                    user.City.toLowerCase().contains(query) ||
                                    user.Phone.toLowerCase().contains(query) ||
                                    user.Email.toLowerCase().contains(query);
                              }).toList();
                            } else {
                              filteredUsers = List.from(users);
                            }
                            setState(() {

                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: filteredUsers.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              final user = filteredUsers[index];
                              return UserProfileCard(user);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
          heroTag: "AddNew",
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xFFFFF8F0), width: 2),
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddUser()),
            );
            fetchdata();
          },
          backgroundColor: const Color(0xFF800020),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget UserProfileCard(P_Details user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UserProfilePage(userID: user.UserID as int,),)
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: Color(0xFF800020),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Expanded(
                  flex: 12,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Background container
                          Container(
                            color: Colors.grey.shade300,
                            child: user.ImagePath.isNotEmpty
                                ? Image.file(File(user.ImagePath),
                                    fit: BoxFit.cover)
                                : Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF800020)
                                        .withOpacity(0.2)
                                        .withOpacity(0.99),
                                    Color(0xFF800020)
                                        .withOpacity(0.2)
                                        .withOpacity(0.85),
                                    Colors.black.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // User information text
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user.Name}, ${user.Date_Birth}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  user.Phone,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Center(
                          child: icons_Action(
                              Color(0xff54d6d4), Color(0xFF39a8a7), Colors.white,
                              () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddUser(user: user)));
                          }, "assets/icons/edit.gif"),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: icons_Action(
                            // Color(0xffad21a2),
                            Colors.pink.shade500,
                            (user.isFavourite)
                                ? Colors.pinkAccent
                                : Color(0xffdb35cd),
                            (user.isFavourite) ? Colors.redAccent : Colors.white,
                            () async {
                              await db.setFavourite(
                                  user.UserID, !user.isFavourite);
                              if (widget.isFavourite) {
                                getFavourites();
                              } else {
                                fetchdata();
                              }
                            },
                            (user.isFavourite)
                                ? "assets/icons/like_s.gif"
                                : "assets/icons/like_f.gif",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: icons_Action(
                            Colors.redAccent.shade700,
                            Colors.red,
                            Colors.white,
                            () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    elevation: 0.0,
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF8F0),
                                        borderRadius: BorderRadius.circular(16.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 10.0),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            color: Colors.transparent,
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                                "assets/icons/dumpster1.gif"),
                                          ),
                                          SizedBox(height: 16.0),
                                          Text(
                                            'DELETE USER ? ',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            'Are you sure to delete "${user.Name}" user?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          SizedBox(height: 15.0),
                                          Container(
                                              height: 75,
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                              width: 2,
                                                              color: Colors.black,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                      20),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      20),
                                                            )),
                                                        child: Center(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              // color: Colors.black,
                                                              color: Color(
                                                                  0xFF800020),
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        db.deleteUser(
                                                            user.UserID as int);
                                                        Navigator.of(context)
                                                            .pop();
                                                        if (widget.isFavourite) {
                                                          getFavourites();
                                                        } else {
                                                          fetchdata();
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color(0xFF800020),
                                                            border: Border(
                                                              right: BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 2),
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 2),
                                                              top: BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 2),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.only(
                                                              topRight:
                                                                  Radius.circular(
                                                                      20),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      20),
                                                            )),
                                                        child: Center(
                                                          child: Text(
                                                            "Delete it!",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Color(
                                                                  0xFFFFF8F0),
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            "assets/icons/delete.gif",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget icons_Action(
    Color background_color,
    Color S_background_color,
    Color colors_i,
    VoidCallback f,
    String image,
  ) {
    return GestureDetector(
      onTap: f,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundColor: background_color,
            radius: 40,
          ),
          CircleAvatar(
            backgroundColor: S_background_color,
            radius: 25,
            backgroundImage: AssetImage(image),
          ),
        ],
      ),
    );
  }
}
