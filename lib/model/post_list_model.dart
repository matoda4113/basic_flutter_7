
import 'package:cloud_firestore/cloud_firestore.dart';

import '../vo/postVo.dart';

class PostListModel {
  List<PostVo>? postList;

  PostListModel({this.postList});

  PostListModel.fromQuerySnapshot(QuerySnapshot querySnapshot) {
    postList = <PostVo>[];
    for (DocumentSnapshot item in querySnapshot.docs) {
      postList!.add(PostVo.fromDocumentSnapshot(item));
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (postList != null) {
      data['postList'] = postList!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}