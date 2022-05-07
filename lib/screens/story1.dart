import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kan/controller/fb_story_controller.dart';
import 'package:kan/prefs/shared_prefs.dart';

class StoryOne extends StatefulWidget {


  const StoryOne({
    Key? key,
  }) : super(key: key);

  @override
  _StoryOneState createState() => _StoryOneState();
}

class _StoryOneState extends State<StoryOne> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.redAccent,
        title: const Text('قصص الاطفال'),
        centerTitle: true,
      ),
      body: Container(
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
                      image: NetworkImage('image'),
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

                              },
                              icon: Icon(
                               Icons.favorite,
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
                        'nameStory',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),textAlign: TextAlign.center,
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
                    'body',
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
