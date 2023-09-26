
import 'package:cloud_firestore/cloud_firestore.dart';

class UserVo {
  String? docId;
  String? email;
  String? imagePath;
  bool? isDeleted;
  Timestamp? createAt;
  Timestamp? updateAt;


  UserVo({
    this.docId,
    this.email,
    this.imagePath,
    this.isDeleted,
    this.createAt,
    this.updateAt
  });

  UserVo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    docId = documentSnapshot.id;
    email = documentSnapshot['email'];
    imagePath = documentSnapshot['imagePath'];
    isDeleted = documentSnapshot['isDeleted'];
    createAt = documentSnapshot['createAt'];
    updateAt = documentSnapshot['updateAt'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['email'] = email??"";
    data['imagePath'] = imagePath??"";
    data['isDeleted'] = isDeleted??false;
    data['createAt'] = createAt??Timestamp.now();
    data['updateAt'] = updateAt??Timestamp.now();
    return data;
  }
}