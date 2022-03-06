import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grape_doc/screens/AddBlog.dart';
import 'package:grape_doc/screens/NavBar.dart';
import 'package:grape_doc/screens/SettingScreen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20.0);

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
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => selectedItem(context, 99)
            ),
            const SizedBox(height: 24.0),
            const Divider(color: Colors.white70,),
            const SizedBox(height: 24.0),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => selectedItem(context,0),
            ),
            const SizedBox(height: 16.0),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.account_circle_sharp,
              onClicked: () => selectedItem(context,1),
            ),
            const SizedBox(height: 16.0),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings_sharp,
              onClicked: () => selectedItem(context,2),
            ),
            const SizedBox(height: 16.0),
            buildMenuItem(
              text: 'About us',
              icon: Icons.info_sharp,
              onClicked: () => selectedItem(context,3),
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
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(urlImage),
          ),
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
          builder: (context) => NavBar(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddBlog(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingScreen(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddBlog(),
        ));
        break;
      case 99:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddBlog(
          //name: name,
          //urlImage: urlImage,
          )
        ));
        break;
    }
  }
}
