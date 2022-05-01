import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grapedoc_test/screens/LoginScreen.dart';
import 'package:grapedoc_test/services/t_key.dart';
import 'package:provider/provider.dart';
import 'package:grapedoc_test/providers/SignInProvider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title:  Text(
            TKeys.settings.translate(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_sharp)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            // const Text(
            //   "Settings",
            //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            // ),
            Container(
              //margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children:  [
                      Icon(
                        Icons.person,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        TKeys.account.translate(context),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 15,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  buildAccountOptionRow(context, TKeys.language.translate(context), 'BETA','English','සිංහල','தமிழ்'),
                  buildAccountOptionRow(context, TKeys.privacy.translate(context), '','Option 1','Option 2','Option 3'),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              //margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children:  [
                      Icon(
                        Icons.volume_up_outlined,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        TKeys.notifications.translate(context),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 15,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildNotificationOptionRow(TKeys.newforu.translate(context), true),
                  buildNotificationOptionRow(TKeys.accountability.translate(context), true),
                  buildNotificationOptionRow(TKeys.opportunity.translate(context), false),
                ],
              ),
            ),
            SizedBox(height: 50.0,),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(150.0, 50.0),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: Colors.red,
                  side: BorderSide(width: 2, color: Colors.red),
                ),
                onPressed: () {
                  final provider =
                  Provider.of<SignInProvider>(context, listen: false);
                  provider.logout();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen()));

                },
                child: const Text(
                    "SIGN OUT",
                    style: TextStyle(
                        fontSize: 16,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.purple,
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title, String subtitle, String op1, String op2, String op3) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Text(op1),
                    SizedBox(height: 10.0,),
                    Text(op2),
                    SizedBox(height: 10.0,),
                    Text(op3),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 10.0,),
                subtitle != '' ?
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    //color: Colors.white70.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.purple)
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 8.0,
                    ),
                  ),
                ) : Container(),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
