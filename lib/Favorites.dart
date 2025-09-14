import 'package:flutter/material.dart';
import 'package:matrimony/info/DBHelper.dart';
import 'package:matrimony/info/details.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}


class _FavoritesState extends State<Favorites> {
  DBHelper db = DBHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavourites();
  }

  Future<void> getFavourites()  async {
    List<P_Details> favourites = await db.getFavourite();
    print(favourites);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFFF8F0),
        appBar: AppBar(
          title: Text(
            'Favorites',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff333333),fontSize: 25),
            //bright  oxfffff700
            //Color(0xffFFFF33) gold neon
          ),
          backgroundColor: Color(0xFF800020),
        ),
        body: Container(
          height: 700,
          width: 500,
          color: Colors.white70,
        ),
      ),
    );
  }
}
