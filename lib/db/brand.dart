import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService{
  Firestore _firestore = Firestore.instance;

  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();

    _firestore.collection('brands').document(brandId).setData({'brand': name});
  }
}