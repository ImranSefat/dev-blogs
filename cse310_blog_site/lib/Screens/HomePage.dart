import 'package:cse310_blog_site/Screens/TabBarPages/FlutterPosts.dart';
import 'package:cse310_blog_site/Screens/TabBarPages/JobAlertPosts.dart';
import 'package:cse310_blog_site/Screens/TabBarPages/ReactJSPosts.dart';
import 'package:cse310_blog_site/Screens/TabBarPages/SoftwareDevelopmentPosts.dart';
import 'package:cse310_blog_site/Service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Developer Blogs Home",
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.black87,
          drawer: Container(
            height: size.height,
            width: size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: Colors.white,
            ),
          ),
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.view_sidebar),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: Text(
              "Developer Blogs",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 1.3,
              ),
            ),
            centerTitle: true,
            actions: [
              FlatButton.icon(
                label: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
              )
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Text("Flutter"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("React JS"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Software Development"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Job Alert"),
                ),
              ],
            ),
          ),
          body: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 3,
                child: TabBarView(
                  children: [
                    FlutterPosts(),
                    ReactJSPosts(),
                    SoftwareDevelopmentPosts(),
                    JobAllert(),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showMaterialDialog(String data) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Alert"),
        content: new Text(data),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
