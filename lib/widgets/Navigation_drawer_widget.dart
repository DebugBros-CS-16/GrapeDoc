import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grapedoc_test/main.dart';
import 'package:grapedoc_test/screens/HomeScreen.dart';
// import 'package:grapedoc_test/screens/AddBlog.dart';
import 'package:grapedoc_test/screens/NavBar.dart';
import 'package:grapedoc_test/screens/SettingScreen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 15.0);

  final firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final name = firebaseUser != null
        ? firebaseUser?.displayName != null || firebaseUser!.displayName == '-'
        ? firebaseUser!.displayName.toString()
        : "Name Not Set": "Unknown Name";
    final email = firebaseUser != null
        ? firebaseUser!.email != null
        ? firebaseUser!.email.toString()
        : "Email Not Set"
        : "Email Not Found";
    final urlImage =
        firebaseUser != null
            ? firebaseUser!.photoURL != null
            ? firebaseUser!.photoURL.toString()
            : "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
            : "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";
    //final urlImage = 'https://www.whatsappimages.in/wp-content/uploads/2021/03/New-Top-Quality-Cute-Girl-Images-For-Whatsapp-Dp-Wallpaper-Download.jpg';

    return Drawer(
      child: Material(
        color: Colors.purple,
        child: ListView(
          //padding: padding,
          children: [
            //const SizedBox(height: 50.0),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.only(
                  top: 30.0, bottom: 40.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Container(
                //padding: const EdgeInsets.all(20.0),
                child: buildHeader(
                    urlImage: urlImage,
                    name: name.toString(),
                    email: email.toString(),
                    onClicked: () => selectedItem(context, 99)),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildMenuItem(
                text: 'Home',
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildMenuItem(
                text: 'Settings',
                icon: Icons.settings_sharp,
                onClicked: () => selectedItem(context, 2),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildMenuItem(
                text: 'About us',
                icon: Icons.info_sharp,
                onClicked: () => selectedItem(context, 3),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildMenuItem(
                text: 'Privacy Policy',
                icon: Icons.admin_panel_settings_sharp,
                onClicked: () => selectedItem(context, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(
          {required String urlImage,
          required String name,
          required String email,
          required VoidCallback onClicked}) =>
      InkWell(
        onTap: onClicked,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              height: 100.0,
              width: 100.0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        Image.asset("assets/images/grapedoclogo.png"),
                    imageUrl: urlImage,
                    //width: 100,
                    fit: BoxFit.cover,
                  )),
            ),
            // CircleAvatar(
            //   radius: 30.0,
            //   backgroundImage: NetworkImage(urlImage),
            // ),
            // SizedBox(width:10.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
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
      leading: Icon(
        icon,
        color: color,
      ),
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
