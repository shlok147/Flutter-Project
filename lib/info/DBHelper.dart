import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'details.dart';

class DBHelper {
  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "matrimony.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute("""
                CREATE TABLE Users 
                (
                  UserID INTEGER PRIMARY KEY AUTOINCREMENT, 
                  Name VARCHAR(200),
                  Email VARCHAR(200),
                  Phone VARCHAR(255),
                  Date_Birth VARCHAR(100),
                  City VARCHAR(100),
                  Gender VARCHAR(200),
                  Hobbies VARCHAR(200),
                  Password VARCHAR(200),
                  isFavourite BOOLEAN,
                  ImagePath VARCHAR(255)
                )
              """);
      },
    );
  }

  Future<int> insertUser(P_Details user) async {
    Database db = await initDatabase();
    return db.insert("Users", user.toMap());
  }

  Future<List<P_Details>> getAllUser() async {
    List<P_Details> userList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> usersMap = await db.query("Users");
    usersMap.forEach((element) {
      P_Details user = P_Details();
      user.UserID = int.parse(element["UserID"].toString());
      user.Name = element["Name"].toString();
      user.Email = element["Email"].toString();
      user.Phone = element["Phone"].toString();
      user.Date_Birth = element["Date_Birth"].toString();
      user.City = element["City"].toString();
      user.Gender = element["Gender"].toString();
      user.Hobbies = element["Hobbies"].toString();
      user.Password = element["Password"].toString();
      user.isFavourite = element["isFavourite"] == 1 ? true : false;
      user.ImagePath = element["ImagePath"].toString();
      userList.add(user);
    });
    return userList;
  }

  Future<void> setFavourite(int? Userid, bool isFavourite) async {
    Database db = await initDatabase();
    db.execute("""
        UPDATE Users set isFavourite=? where UserID=?
    """, [isFavourite, Userid]);
  }

  Future<List<P_Details>> getFavourite() async {
    List<P_Details> userList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> usersMap =
        await db.query("Users", where: "isFavourite=1");
    usersMap.forEach((element) {
      P_Details user = P_Details();
      user.UserID = int.parse(element["UserID"].toString());
      user.Name = element["Name"].toString();
      user.Email = element["Email"].toString();
      user.Phone = element["Phone"].toString();
      user.Date_Birth = element["Date_Birth"].toString();
      user.City = element["City"].toString();
      user.Gender = element["Gender"].toString();
      user.Hobbies = element["Hobbies"].toString();
      user.Password = element["Password"].toString();
      user.isFavourite = element["isFavourite"] == 1 ? true : false;
      user.ImagePath = element["ImagePath"].toString();
      userList.add(user);
    });
    return userList;
  }

  Future<void> deleteUser(int UserID) async {
    Database db = await initDatabase();
    db.execute("DELETE FROM Users WHERE UserID=?",[UserID]);
  }

  Future<void> updateUser(P_Details user) async {
    Database db = await initDatabase();
    db.update("Users", user.toMap(), where: "UserID=?", whereArgs: [user.UserID]);
  }

  // Future<P_Details> getUser(int UserID) async {
  //   Database db = await initDatabase();
  //   P_Details user= P_Details();
  //   List<Map<String, Object?>> usersMap = await db.query("Users", where: "UserID=?", whereArgs: [UserID]);
  //   // user.UserID = int.parse(usersMap..toString());
  //   // user.Name = usersMap[0]..toString();
  //   // user.Email = usersMap[0]["Email"].toString();
  //   // user.Phone = usersMap[0]["Phone"].toString();
  //   // user.Date_Birth = usersMap[0]["Date_Birth"].toString();
  //   // user.City = usersMap[0]["City"].toString();
  //   // user.Gender = usersMap[0]["Gender"].toString();
  //   // user.Hobbies = usersMap[0]["Hobbies"].toString();
  //   // user.Password = usersMap[0]["Password"].toString();
  //   // user.ImagePath = usersMap[0]["ImagePath"].toString();
  //   // user.isFavourite = usersMap[0]["isFavourite"];
  //   return user;
  // }

  Future<P_Details> getUser(int userID) async {
    Database db = await initDatabase();

    List<Map<String, dynamic>> usersMap = await db.query(
      "Users",
      where: "UserID = ?",
      whereArgs: [userID],
    );

    return P_Details.fromMap(usersMap.first);

  }

}
