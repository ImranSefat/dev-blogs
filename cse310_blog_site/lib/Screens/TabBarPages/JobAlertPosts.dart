import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse310_blog_site/Screens/ChatRoom.dart';
import 'package:cse310_blog_site/Screens/TestWidgets/CreatePost.dart';
import 'package:cse310_blog_site/Screens/TestWidgets/SampleViewPost.dart';
import 'package:cse310_blog_site/Service/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';
import 'package:provider/provider.dart';

class JobAllert extends StatefulWidget {
  @override
  _JobAllertState createState() => _JobAllertState();
}

class _JobAllertState extends State<JobAllert> {
  final ScrollController _scrollController = ScrollController();
  CollectionReference posts =
      FirebaseFirestore.instance.collection('postCollection');
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    bool isDark = theme.getTheme() == ThemeData.dark() ? true : false;
    return SmoothScrollWeb(
      controller: _scrollController,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        children: [
          CreatePost(
            category: "jobs",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(
                      category: 'jobs',
                    ),
                  ),
                );
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(isDark ? 0.1 : 0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(2, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chat Room',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: posts.where('category', isEqualTo: 'jobs').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              if (snapshot.data.size == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(isDark ? 0.1 : 0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(2, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "No post found",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return ListView(
                shrinkWrap: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return SampleViewPost(
                    title: document['title'],
                    description: document['description'],
                    createdAt: document['createdAt'],
                    authorEmail: document['email'],
                    loved: document['loved'],
                    category: document['category'],
                    document: document,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
