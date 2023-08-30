import 'package:empower_u/views/constants/firebase_constants.dart';

class StoreServices{

  //get all users
  static getAllUsers()
  {
    return firebaseFirestore.collection(collectionUser).snapshots();
  }
}