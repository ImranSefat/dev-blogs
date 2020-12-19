import 'package:flutter/material.dart';

class SampleViewPost extends StatefulWidget {
  @override
  _SampleViewPostState createState() => _SampleViewPostState();
}

class _SampleViewPostState extends State<SampleViewPost> {
  String desc =
      "This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string ";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Flutter Development',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                      letterSpacing: 1.3,
                    ),
                  ),
                  Text(
                    '01:12 PM, 16th December, 2020',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SelectableText("Written by Imran Sefat"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text("Categories: "),
                    FlatButton(
                      onPressed: () {},
                      child: Text("Flutter"),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text("App Development"),
                    ),
                  ],
                ),
              ),
              Text(desc)
            ],
          ),
        ),
      ),
    );
  }
}
