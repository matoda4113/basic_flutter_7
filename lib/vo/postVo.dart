
import 'package:cloud_firestore/cloud_firestore.dart';

class PostVo {
  String? docId;
  String? writerId;
  String? title;
  String? contents;
  List<dynamic>? keyword;
  bool? isDeleted;
  Timestamp? createAt;
  Timestamp? updateAt;


  PostVo({
    this.docId,
    this.writerId,
    this.title,
    this.contents,
    this.keyword,
    this.isDeleted,
    this.createAt,
    this.updateAt
  });

  PostVo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    docId = documentSnapshot.id;
    writerId = documentSnapshot['writerId'];
    title = documentSnapshot['title'];
    contents = documentSnapshot['contents'];
    keyword = documentSnapshot['keyword'];
    isDeleted = documentSnapshot['isDeleted'];
    createAt = documentSnapshot['createAt'];
    updateAt = documentSnapshot['updateAt'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['writerId'] = writerId??"";
    data['title'] = title??"";
    data['contents'] = contents??"";
    data['keyword'] = keyword??[];
    data['isDeleted'] = isDeleted??false;
    data['createAt'] = createAt??Timestamp.now();
    data['updateAt'] = updateAt??Timestamp.now();
    return data;
  }
}