import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grapedoc_test/main.dart';
import 'package:grapedoc_test/screens/HomeScreen.dart';
// import 'package:grapedoc_test/screens/AddBlog.dart';
import 'package:grapedoc_test/screens/NavBar.dart';
import 'package:grapedoc_test/screens/SettingScreen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 15.0);

  @override
  Widget build(BuildContext context) {
    final name = 'Your Name';
    final email = 'youremail@gmail.com';
    final urlImage = 'https://www.whatsappimages.in/wp-content/uploads/2021/03/New-Top-Quality-Cute-Girl-Images-For-Whatsapp-Dp-Wallpaper-Download.jpg';

    return Drawer(
      child: Material(
        color: Colors.purple,
        child: ListView(
          padding: padding,
          children: [
            const SizedBox(height: 50.0),
            Container(
              //padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                onClicked: () => selectedItem(context, 99)
              ),
            ),
            const SizedBox(height: 10.0),
            //const Divider(color: Colors.white70,),
            const SizedBox(height: 20.0),
            Container(
              //padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildMenuItem(
                text: 'Home',
                icon: Icons.home,
                onClicked: () => selectedItem(context,0),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              //padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildMenuItem(
                text: 'Profile',
                icon: Icons.account_circle_sharp,
                onClicked: () => selectedItem(context,1),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              //padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildMenuItem(
                text: 'Settings',
                icon: Icons.settings_sharp,
                onClicked: () => selectedItem(context,2),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              //padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildMenuItem(
                text: 'About us',
                icon: Icons.info_sharp,
                onClicked: () => selectedItem(context,3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked
  }) => InkWell(
      onTap: onClicked,
      child: Row(
        children: [
          Container(
            height: 100.0,
            width: 90.0,
            child: ClipRRect(
                borderRadius:
                BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      Image.asset("assets/images/grapedoclogo.png"),
                  imageUrl: urlImage,
                  width: 90,
                  fit: BoxFit.cover,
                )
            ),
          ),
          // CircleAvatar(
          //   radius: 30.0,
          //   backgroundImage: NetworkImage(urlImage),
          // ),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20, color:  Colors.white),
              ),
              const SizedBox(height: 4.0),
              Text(
                email,
                style: TextStyle(fontSize: 14, color:  Colors.white),
              ),
            ],
          )
        ],
      ),
  );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    Color color = Colors.white;
    Color hoverColor = Colors.white38;
    return ListTile(
      leading: Icon(icon, color: color,),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NavBar(1, streamController.stream),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyHomePage(title: "Profile"),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingScreen(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyHomePage(title: "AboutUs"),
        ));
        break;
      // case 99:
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => const AddBlog(
      //     //name: name,
      //     //urlImage: urlImage,
      //     )
      //   ));
      //   break;
    }
  }
}
