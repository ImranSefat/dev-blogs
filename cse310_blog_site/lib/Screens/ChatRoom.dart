import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cse310_blog_site/Screens/TestWidgets/SampleViewPost.dart';
import 'package:cse310_blog_site/Service/ThemeChanger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  final String category;
  ChatRoom({
    this.category,
  });
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeChanger>(context);
    // bool isDark = theme.getTheme() == ThemeData.dark() ? true : false;
    CollectionReference messages = FirebaseFirestore.instance
        .collection('messages')
        .doc(widget.category)
        .collection('messageList');
    String message;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Room of ${widget.category.toUpperCase()}"),
        // actions: [
        //   Row(
        //     children: [
        //       Text("Dark Mode"),
        //       Switch(
        //         activeColor: Colors.blue,
        //         onChanged: (bool value) {
        //           if (value) {
        //             theme.setTheme(ThemeData.dark());
        //           } else {
        //             theme.setTheme(ThemeData.light());
        //           }
        //         },
        //         value: theme.getTheme() == ThemeData.dark() ? true : false,
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.2,
            child: Align(
              alignment: Alignment.topCenter,
              child: StreamBuilder<QuerySnapshot>(
                stream: messages.orderBy('time').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(2, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "No Chat found",
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
                    // reverse: true,
                    shrinkWrap: true,
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      String uid = FirebaseAuth.instance.currentUser.uid;
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: uid == document['uid']
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  color: uid == document['uid']
                                      ? Colors.blue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          2, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: uid == document['uid']
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        document['message'],
                                        style: TextStyle(
                                          color: uid == document['uid']
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 20,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  controller: textController,
                  onChanged: (value) {
                    message = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Send Message",
                    suffix: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        if (message != null) {
                          CollectionReference messages = FirebaseFirestore
                              .instance
                              .collection('messages')
                              .doc('flutter')
                              .collection('messageList');

                          messages.add({
                            'time': Timestamp.now(),
                            'message': message,
                            'uid': FirebaseAuth.instance.currentUser.uid,
                            'email': FirebaseAuth.instance.currentUser.email,
                            'category': 'flutter'
                          });
                          textController.clear();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
