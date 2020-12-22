// import 'dart:html';
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse310_blog_site/Service/ThemeChanger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  final String category;
  CreatePost({this.category});
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String title, description;
  Timestamp createdAt;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerTitle =
      TextEditingController();
  final TextEditingController _textEditingControllerDescription =
      TextEditingController();
  // String selectedCategory;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    bool isDark = theme.getTheme() == ThemeData.dark() ? true : false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
        child: !loading
            ? Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 20, 20, 40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(vertical: 8.0),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         "Select Category",
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 22,
                            //           letterSpacing: 1.3,
                            //         ),
                            //       ),
                            //       SizedBox(width: 30),
                            //       selectedCategory != null
                            //           ? Text(
                            //               selectedCategory.toUpperCase(),
                            //               style: TextStyle(
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 22,
                            //                 letterSpacing: 1.3,
                            //               ),
                            //             )
                            //           : Container(),
                            //       SizedBox(width: 30),
                            //       RaisedButton(
                            //         color: Colors.blue,
                            //         onPressed: () {
                            //           _popUpCategorySelect();
                            //         },
                            //         child: Text(
                            //           selectedCategory == null
                            //               ? "Select"
                            //               : "Change",
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Center(
                              child: Text(
                                "Add a post to this category",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 32,
                                  letterSpacing: 1.3,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _textEditingControllerTitle,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter title of your post";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                title = value;
                              },
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    // color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 8,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.heading,
                                    // color: Colors.white,
                                  ),
                                ),
                                labelText: "Title",
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 32,
                                letterSpacing: 1.3,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _textEditingControllerDescription,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter post details";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                description = value;
                              },
                              minLines: 3,
                              maxLines: 50,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    // color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12.0,
                                    top: 8,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.info,
                                    // color: Colors.white,
                                  ),
                                ),
                                labelText: "Description",
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: RaisedButton.icon(
                                    icon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.solidPaperPlane,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    label: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "Add Post",
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        addApost();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Flexible(
                  //     flex: 1,
                  //     child: Center(
                  //       child: FlatButton.icon(
                  //         icon: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: FaIcon(
                  //             FontAwesomeIcons.images,
                  //             color: Colors.greenAccent,
                  //             size: 32,
                  //           ),
                  //         ),
                  //         label: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Text("Add Picture")),
                  //         onPressed: () {},
                  //       ),
                  //     )

                  //     // : ClipRRect(
                  //     //     borderRadius: BorderRadius.only(
                  //     //       topRight: Radius.circular(8),
                  //     //       bottomRight: Radius.circular(8),
                  //     //       // bottomRight: Radius.circular(8),
                  //     //     ),
                  //     //     child: Image(
                  //     //       fit: BoxFit.cover,
                  //     //       image: NetworkImage(
                  //     //         _pickedImage.path,
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     )
                ],
              )
            : Container(
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Please Wait",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> addApost() async {
    CollectionReference postCollection = FirebaseFirestore.instance
        // .collection('posts')
        // .doc(selectedCategory)
        .collection('postCollection');
    // .doc(FirebaseAuth.instance.currentUser.uid)
    // .collection('postCollection');
    return postCollection.add({
      'title': title,
      'description': description,
      'createdAt': Timestamp.now(),
      'email': FirebaseAuth.instance.currentUser.email,
      'category': widget.category,
      'uid': FirebaseAuth.instance.currentUser.uid,
      'loved': 0,
    }).then((value) {
      setState(() {
        loading = false;
        _textEditingControllerTitle.clear();
        _textEditingControllerDescription.clear();
      });
      _showMaterialDialog("Your post has been added");
    });
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

  // _popUpCategorySelect() {
  //   showDialog(
  //     context: context,
  //     builder: (_) => new AlertDialog(
  //       title: new Text("Select Category"),
  //       content: Container(
  //         height: MediaQuery.of(context).size.height / 2,
  //         width: MediaQuery.of(context).size.width / 2,
  //         child: GridView.count(
  //           childAspectRatio: 1.8,
  //           crossAxisCount: 2,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedCategory = "flutter";
  //                   });
  //                   Navigator.pop(_);
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text(
  //                         "Flutter",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 22,
  //                           color: Colors.white,
  //                           letterSpacing: 1.3,
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Container(
  //                         height: 200,
  //                         child: Image(
  //                           fit: BoxFit.fill,
  //                           image: AssetImage('images/flutter.jng'),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedCategory = "reactJs";
  //                   });
  //                   Navigator.pop(_);
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text(
  //                         "React JS",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 22,
  //                           color: Colors.white,
  //                           letterSpacing: 1.3,
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Container(
  //                         height: 200,
  //                         child: Image(
  //                           fit: BoxFit.fill,
  //                           image: AssetImage('images/reactJs.png'),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedCategory = "development";
  //                   });
  //                   Navigator.pop(_);
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text(
  //                         "Software Development",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 22,
  //                           color: Colors.white,
  //                           letterSpacing: 1.3,
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Container(
  //                         height: 200,
  //                         child: Image(
  //                           fit: BoxFit.fill,
  //                           image: AssetImage('images/landing2.png'),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedCategory = "seekHelp";
  //                   });
  //                   Navigator.pop(_);
  //                 },
  //                 child: Container(
  //                   // height: 250,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text(
  //                         "Seek Help",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 22,
  //                           color: Colors.white,
  //                           letterSpacing: 1.3,
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Container(
  //                         height: 200,
  //                         child: Image(
  //                           fit: BoxFit.fill,
  //                           image: AssetImage('images/seekHelp.png'),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedCategory = "tips";
  //                   });
  //                   Navigator.pop(_);
  //                 },
  //                 child: Container(
  //                   // height: 250,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text(
  //                         "Tips",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 22,
  //                           color: Colors.white,
  //                           letterSpacing: 1.3,
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Container(
  //                         height: 200,
  //                         child: Image(
  //                           fit: BoxFit.fill,
  //                           image: AssetImage('images/tips.png'),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedCategory = "jobs";
  //                   });
  //                   Navigator.pop(_);
  //                 },
  //                 child: Container(
  //                   // height: 250,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text(
  //                         "Jobs",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 22,
  //                           color: Colors.white,
  //                           letterSpacing: 1.3,
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Container(
  //                         height: 200,
  //                         child: Image(
  //                           fit: BoxFit.fill,
  //                           image: AssetImage('images/job.png'),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
