import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kan/screens/story_screen.dart';

import '../prefs/shared_prefs.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  CollectionReference documentFavorite = FirebaseFirestore.instance
      .collection('user')
      .doc(SharedPrefController().getId)
      .collection('favorite');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.redAccent,
        title: Text(' المفضلة '),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back.jfif'),
          ),
        ),
        child: StreamBuilder(
          stream: documentFavorite.snapshots(),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return Text('Error');
            }
            // if (snapshot.hasData && snapshot.data.exists ) {
            //   return Center(child: Text('لا يوجد قصص في المفضلة',style: TextStyle(color: Colors.grey,fontSize: 25.sp),textAlign: TextAlign.center,));
            // }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              print('snapshot.hasData && snapshot.data!.docs.isNotEmpty');
              final data = snapshot.data;
              return ListView.builder(
                itemCount: data!.size,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return StoryScreen(
                                docid: data.docs[index].id,
                              );
                            }),
                          );
                        },
                        child: Dismissible(
                          onDismissed: (_) async {
                            await documentFavorite
                                .doc(data.docs[index].id)
                                .delete();
                          },
                          key: UniqueKey(),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 200.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          data.docs[index]['image'],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${data.docs[index]['nameStory']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('لا يوجد عناصر في المفضلة'),
              );
            }
          },
        ),
      ),
    );
  }
}
