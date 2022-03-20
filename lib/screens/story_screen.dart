import 'dart:math';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kan/controller/select_controller.dart';
import 'package:kan/prefs/shared_prefs.dart';

import '../model/story.dart';

class StoryScreen extends StatefulWidget {
  final String docid;

  StoryScreen({Key? key, required this.docid}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  CollectionReference storyref = FirebaseFirestore.instance.collection("story");
  CollectionReference userref = FirebaseFirestore.instance.collection("user");
  var documentFavorite = FirebaseFirestore.instance.collection('user').doc(SharedPrefController().getId).collection('favorite');
  var random = Random().nextInt(100000);
  final SelectController controller = Get.put(
    SelectController(),
    // permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.redAccent,
        title: Text('قصص الاطفال'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: storyref.doc(widget.docid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }
            if (snapshot.hasError) {
              return Text('Eroor');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                decoration: BoxDecoration(
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
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data['image']),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              child: GetBuilder<SelectController>(
                                builder: (controller)=>IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    if (controller.selected == true) {
                                      await documentFavorite.doc(random.toString()).set(
                                          {
                                            'favName' : data['nameStory'],
                                            'favBody' : data['body'],
                                            'favImage' : data['image'],
                                          }
                                      );
                                    }else {
                                      await documentFavorite.doc(random.toString()).delete();
                                    };
                                    setState(() {
                                      controller.selected = !controller.selected;
                                    });
                                    print(random);
                                  },
                                  icon: Icon(controller.selected ? Icons.favorite_border : Icons.favorite,color: Colors.redAccent,),
                                ),
                              ),
                            ),
                            Text(
                              data['nameStory'],
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: Icon(
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
                          child: Text(data['body'],style: TextStyle(fontSize: 16.sp),textAlign: TextAlign.center,),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
            return SizedBox();
          }),
    );
  }
}
