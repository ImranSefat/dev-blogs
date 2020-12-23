import 'package:cse310_blog_site/Screens/TabBarPages/FlutterPosts.dart';
import 'package:cse310_blog_site/Screens/TabBarPages/JobAlertPosts.dart';
import 'package:cse310_blog_site/Screens/TabBarPages/LandingPage.dart';
import 'package:cse310_blog_site/Screens/TabBarPages/ReactJSPosts.dart';
import 'package:cse310_blog_site/Screens/TabBarPages/SoftwareDevelopmentPosts.dart';
import 'package:cse310_blog_site/Screens/TabBarPages/Tips&Tricks.dart';
import 'package:cse310_blog_site/Service/ThemeChanger.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeChanger(ThemeData.light()),
        )
      ],
      child: HomePageWithThemeData(size: size),
    );
  }
}

class HomePageWithThemeData extends StatefulWidget {
  const HomePageWithThemeData({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _HomePageWithThemeDataState createState() => _HomePageWithThemeDataState();
}

class _HomePageWithThemeDataState extends State<HomePageWithThemeData> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Developer Blogs Home",
      theme: theme.getTheme(),
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          // backgroundColor: Colors.black87,
          // drawer: Container(
          //   height: widget.size.height,
          //   width: widget.size.width / 3,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(8),
          //       bottomRight: Radius.circular(8),
          //     ),
          //     color: Colors.white,
          //   ),
          // ),
          appBar: AppBar(
            // leading: Builder(
            //   builder: (BuildContext context) {
            //     return IconButton(
            //       icon: const Icon(Icons.view_sidebar),
            //       onPressed: () {
            //         Scaffold.of(context).openDrawer();
            //       },
            //       tooltip:
            //           MaterialLocalizations.of(context).openAppDrawerTooltip,
            //     );
            //   },
            // ),
            title: Text(
              "Developer Blogs",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 1.3,
              ),
            ),
            centerTitle: true,
            actions: [
              Row(
                children: [
                  Text("Dark Mode"),
                  Switch(
                    activeColor: Colors.blue,
                    onChanged: (bool value) {
                      if (value) {
                        theme.setTheme(ThemeData.dark());
                      } else {
                        theme.setTheme(ThemeData.light());
                      }
                    },
                    value: theme.getTheme() == ThemeData.dark() ? true : false,
                  ),
                ],
              ),
              SizedBox(width: 5),
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
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Home"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Flutter"),
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
                  child: Text("Tips & Tricks"),
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
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    LandingPage(),
                    FlutterPosts(),
                    ReactJSPosts(),
                    SoftwareDevelopmentPosts(),
                    TipsAndTricks(),
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
}
