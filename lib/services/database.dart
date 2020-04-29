import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;

  DatabaseService(this.uid);

  CollectionReference usersCollection = Firestore.instance.collection('Users');

  createUserData(String userName, String email, String photoUrl, String test,
      String members) async {
    Map<String, String> data = <String, String>{
      'Name': userName,
      'Email': email,
      'Photo url': photoUrl,
      'Covid Test': test,
      'Family Members': members
    };
    return await usersCollection.document(uid).setData(data).whenComplete(() {
      print('User data created');
    }).catchError((e) => print(e));
  }

  fetchUserData(String key) async {
    return await usersCollection.document(uid).get().then((snapshot) {
      if (snapshot.exists) {
        print(snapshot.data[key]);
        return snapshot.data[key];
      } else
        return '';
    }).catchError((e) => print(e));
  }
}
