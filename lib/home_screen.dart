import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:camera/camera.dart';
//import 'package:geolocator/geolocator.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.place,
          color: Colors.white,
          size: 30,
        ),
        onPressed: null,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.info,
            color: Colors.white,
            size: 30,
          ),
          onPressed: null,
        ),
      ],
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF454545),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),

      body: SafeArea(
      child: Stack(

        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ClipRRect(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                // ICI une image mais il faut y mettre le camera preview
                child: Image.asset(
                  "assets/welcome_background.png",
                  fit: BoxFit.fill,
                ),

              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                child: Image.asset(
                  "assets/bt_photo_icon.png",
                  fit: BoxFit.cover,
                  width: 60,
                ),

                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  side: BorderSide(
                      color: Color(0x34f5c7c9),
                      width: 5.0
                  ),
                  padding: EdgeInsets.symmetric( vertical:50, horizontal:20 ),
                  primary: Color(0xffe95e5d),
                  elevation: 5
                ),
              ),

          )
        ],
      ),
      ),
    );
  }
}
