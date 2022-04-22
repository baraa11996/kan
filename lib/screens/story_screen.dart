import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kan/controller/fb_story_controller.dart';
import 'package:kan/prefs/shared_prefs.dart';

class StoryScreen extends StatefulWidget {
  final String docid;

  const StoryScreen({
    Key? key,
    required this.docid,
  }) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  CollectionReference storyref = FirebaseFirestore.instance.collection("story");
  CollectionReference userref = FirebaseFirestore.instance.collection("user");
  var documentFavorite = FirebaseFirestore.instance
      .collection('user')
      .doc(SharedPrefController().getId)
      .collection('favorite');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.redAccent,
        title: const Text('قصص الاطفال'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: storyref.doc(widget.docid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/back.jfif'),
                ),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(data['image']),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FBStoryController().story(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  var favorites = snapshot.data!.docs;
                                  return IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (favorites.indexWhere((element) =>
                                              element.id == data['id']) ==
                                          -1) {
                                        documentFavorite.doc(data['id']).set({
                                          'favName': data['nameStory'],
                                          'favBody': data['body'],
                                          'favImage': data['image'],
                                        });
                                      } else {
                                        documentFavorite
                                            .doc(data['id'])
                                            .delete();
                                      }
                                    },
                                    icon: Icon(
                                      favorites.indexWhere((element) =>
                                                  element.id == data['id']) !=
                                              -1
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.redAccent,
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              data['nameStory'],
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.multitrack_audio,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          data['body'],
                          style: TextStyle(fontSize: 16.sp),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
