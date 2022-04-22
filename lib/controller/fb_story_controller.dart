import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kan/helpers/helpers.dart';
import 'package:kan/prefs/shared_prefs.dart';

class FBStoryController with Helpers {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  Stream<QuerySnapshot> story() async* {
    yield* _firebaseFireStoreUsers
        .collection('user')
        .doc(SharedPrefController().getId)
        .collection('favorite')
        .snapshots();
  }
}
