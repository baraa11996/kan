import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kan/screens/story_screen.dart';
import 'package:kan/widgets/note.dart';

class FahrasStoryScreen extends StatefulWidget {
  const FahrasStoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FahrasStoryScreenState createState() => _FahrasStoryScreenState();
}

class _FahrasStoryScreenState extends State<FahrasStoryScreen> {
  final Stream<QuerySnapshot> storyref =
      FirebaseFirestore.instance.collection("story").snapshots();

 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.redAccent,
        title: Text(' فهرس القصص '),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/back.jfif'),
          )),
          child: StreamBuilder(
              stream: storyref,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return Text('Eroor');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }

                final data = snapshot.requireData;
                return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return StoryScreen(docid: data.docs[index].id,);
                              }),
                              );
                            },
                            child: Container(
                              height: 55.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                  child: Text(
                                '${data.docs[index]['nameStory']}',
                                style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                      );
                    });
              })),
    );
  }
}
