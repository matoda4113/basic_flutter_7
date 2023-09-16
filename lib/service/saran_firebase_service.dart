import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/post_list_model.dart';
import '../vo/postVo.dart';


///SaranFirebaseService
///담당자 : saran

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference post = firestore.collection('Post');


class SaranFirebaseService {

  //포스트 리스트 조회
  Future<PostListModel> getPostList() async{

    try{
      QuerySnapshot querySnapshot = await post.where("isDeleted" ,isEqualTo: false).get();
      return PostListModel.fromQuerySnapshot(querySnapshot);
    }catch(error){
      throw Exception(error);
    }

  }


  //포스트 상세조회
  Future<PostVo> getPostDetail(String docId) async{

    try{
      DocumentSnapshot documentSnapshot = await post.doc(docId).get();
      return PostVo.fromDocumentSnapshot(documentSnapshot);
    }catch(error){
      throw Exception(error);
    }
  }

}