import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob_bestmovieapp/auth_fb.dart';

final firestore = FirebaseFirestore.instance;

void setUser() async {
  var userId = await FirebaseAuth.instance.currentUser!.uid;
  firestore.collection('users').doc(userId).set(
    {
      'userId': userId,
      'movies': [],
    },
  );
}

void deleteEntry(Map _deleData) async {
  var userId = await FirebaseAuth.instance.currentUser!.uid;
  firestore.collection('users').doc(userId).update({
    'movies': FieldValue.arrayRemove([_deleData])
  }).then((_) {
    print("success!");
  });
}

void updateUser(Map _newData) async {
  var userId = await FirebaseAuth.instance.currentUser!.uid;
  var _data = await firestore.collection('users').doc(userId).get();

  for (var i = 0; i < _data['movies'].length; i++) {
    if (_newData['id'] == _data['movies'][i]['id']) {
      print('already exist in the database');
      break;
    } else {
      firestore.collection('users').doc(userId).set({
        'movies': FieldValue.arrayUnion([_newData]),
      }, SetOptions(merge: true));
    }
  }
  ;
}

Future<List> getData() async {
  var userId = await FirebaseAuth.instance.currentUser!.uid;
  var _data = await firestore.collection('users').doc(userId).get();
  return _data.data()!['movies'];
}
