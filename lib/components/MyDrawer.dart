import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    String name = user.displayName;
    String email = user.email;
    String imageURL = user.photoURL;
    return Drawer(
      elevation: 10.0,
      child: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(name),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(imageURL),
                    backgroundColor: Colors.transparent,
                  ),
                  // decoration: BoxDecoration(
                  //   color: Color(0xFF8D90F3),
                  // ),
                ),
                ListTile(
                  leading: Icon(Icons.notifications_active),
                  title: Text("Subscriptions"),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Subscriptions()),
                    // );
                  },
                ),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About"),
                ),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
                    print('Settings');
                  },
                ),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text("Change Password"),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AcceptedOrder()),
                    // );
                  },
                ),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text("Report Bug"),
                  onTap: () {
                    print('Leaderboard');
                  },
                ),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.inventory),
                  title: Text("Lost and Found"),
                  onTap: () {
                    print('Loast and Found');
                  },
                ),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Logout"),
                  onTap: () {
                    // print('Logout');
                    // AuthService().logout();
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => LoginPage()));
                  },
                ),
                Divider(
                  height: 2.0,
                ),
              ],
            ),
          ),
          Container(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      //Divider(),
                      ListTile(
                          // leading: Image.asset(
                          //   "assets/images/cnc_logo.png",
                          // ),
                          title: Text(
                        'V 0.0.1',
                      ))
                    ],
                  ))),
        ],
      )),
    );
  }
}
