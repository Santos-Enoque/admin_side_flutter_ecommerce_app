import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService{
  Firestore _firestore = Firestore.instance;

  void createCategory(String name){
  var id = Uuid();
  String categoryId = id.v1();

    _firestore.collection('categories').document(categoryId).setData({'category': name});
  }
}