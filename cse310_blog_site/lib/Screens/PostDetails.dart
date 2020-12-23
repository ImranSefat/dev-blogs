import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cse310_blog_site/Service/ThemeChanger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PostDetils extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  PostDetils({
    this.documentSnapshot,
  });
  @override
  _PostDetilsState createState() => _PostDetilsState();
}

class _PostDetilsState extends State<PostDetils> {
  String newComment;
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    bool isDark = theme.getTheme() == ThemeData.dark() ? true : false;
    Stream documentStream = FirebaseFirestore.instance
        .collection('postCollection')
        .doc(widget.documentSnapshot.id)
        .snapshots();
    CollectionReference comments = FirebaseFirestore.instance
        .collection('postCollection')
        .doc(widget.documentSnapshot.id)
        .collection('comments');
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: documentStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              if (!snapshot.data.exists) {
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 20, 20, 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 32,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          CollectionReference posts =
                                              FirebaseFirestore.instance
                                                  .collection('postCollection');
                                          posts
                                              .doc(widget.documentSnapshot.id)
                                              .update({
                                            'loved': snapshot.data['loved'] + 1,
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Loved ${snapshot.data['loved']} times",
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onDoubleTap: () {
                                FlutterClipboard.copy(
                                  snapshot.data['description'],
                                );
                                _showMaterialDialog(
                                    "Description has been copied to clipboard");
                              },
                              child: Text(
                                snapshot.data['description'],
                                // desc.substring(0, 480) + "...",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
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
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Comments",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 32,
                                      letterSpacing: 1.3,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: comments.snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      }
                                      if (snapshot.data.size == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 200,
                                            // decoration: BoxDecoration(
                                            //   color: isDark
                                            //       ? Colors.black
                                            //       : Colors.white,
                                            //   borderRadius:
                                            //       BorderRadius.circular(8),
                                            //   boxShadow: [
                                            //     BoxShadow(
                                            //       color: Colors.grey
                                            //           .withOpacity(
                                            //               isDark ? 0.1 : 0.5),
                                            //       spreadRadius: 2,
                                            //       blurRadius: 5,
                                            //       offset: Offset(2,
                                            //           3), // changes position of shadow
                                            //     ),
                                            //   ],
                                            // ),
                                            child: Center(
                                              child: Text(
                                                "No comments found till now",
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
                                        children: snapshot.data.docs
                                            .map((DocumentSnapshot document) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  document['email'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 32,
                                                    letterSpacing: 1.2,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(document['comment']),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextField(
                        onChanged: (value) {
                          newComment = value;
                        },
                        controller: _textController,
                        decoration: InputDecoration(
                          labelText: "Add a comment",
                          suffix: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              if (newComment != null) {
                                comments.add({
                                  'time': Timestamp.now(),
                                  'comment': newComment,
                                  'uid': FirebaseAuth.instance.currentUser.uid,
                                  'email':
                                      FirebaseAuth.instance.currentUser.email,
                                });
                                _textController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _showMaterialDialog(String data) {
    showDialog(
      context: context,
      builder: (_context) => new AlertDialog(
        title: new Text("Alert"),
        content: new Text(data),
        actions: <Widget>[
          FlatButton(
            child: Text('Close '),
            onPressed: () {
              Navigator.of(_context).pop();
            },
          )
        ],
      ),
    );
  }
}
