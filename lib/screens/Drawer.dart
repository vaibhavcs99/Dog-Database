import 'package:flutter/material.dart';

import 'DataList.dart';

class NewDrawer extends StatefulWidget {
  @override
  _NewDrawerState createState() => _NewDrawerState();
}

class _NewDrawerState extends State<NewDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("johndoe@gmail.com"),
            accountName: Text("John Doe"),
            currentAccountPicture: CircleAvatar(backgroundImage: getImage()),
            // decoration: ,
            onDetailsPressed: () => debugPrint("TOuched name"),
          ),
          ListTile(
            leading: Icon(Icons.add_alert),
            title: Text("Primary"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>DataList()));
              // Navigator.pushNamed(context, '/primary');
            },
          ),
        ],
      ),
    );
  }

  getImage() {
    return NetworkImage(
        'https://img1.looper.com/img/gallery/what-you-need-to-know-before-you-see-deadpool-2/intro-1525691373.jpg');
  }
}
