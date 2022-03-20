import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListStory extends StatelessWidget {

  CollectionReference storyref = FirebaseFirestore.instance.collection("story");

  final story;
  final docid;

  ListStory({this.story, this.docid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return ViewNote(notes: notes);
        // },),);
      },
      child: Card(
        child: Row(
          children: [
            ListTile(
              title: Text("${story['nameStory']}"),
            )
          ],
        ),
      ),
    );
  }
  }