import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/post_list_model.dart';
import '../vo/postVo.dart';
import '../vo/userVo.dart';


///SaranFirebaseService
///담당자 : saran

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

FirebaseStorage storage = FirebaseStorage.instance;

CollectionReference post = firestore.collection('Post');
CollectionReference userCollection = firestore.collection('User');

class SaranFirebaseService {

  ///Post
  //포스트 리스트 조회
  Future<PostListModel> getPostList() async{

    try{
      QuerySnapshot querySnapshot = await post.where("isDeleted" ,isEqualTo: false).orderBy('createAt' ,descending: true).get();
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
  //포스트 작성하기
  Future<void> writePost(PostVo userPost) async{

    try{

      ///add방식

      await post.add(userPost.toMap());

      ///set방식
      // 문서 참조를 만들고 자동으로 생성된 문서 ID를 가져옴
      // final DocumentReference docReference = post.doc();
      // userPost.docId = docReference.id;
      // await docReference.set(userPost.toMap()); <= 어차피 우리가 만든건 toMap 으로 변환해도 docId가 없어서 의미없음

    }catch(error){
      throw Exception('Error : $error');
    }
  }
  //포스트 수정하기
  Future<void> updatePost({required String docId , required String contents}) async{
    try{
      await post.doc(docId).update({'contents': contents});
    }catch(error){
      throw Exception('Error : $error');
    }
  }
  //포스트 삭제하기
  Future<void> deletePost(String docId) async{
    try{
      await post.doc(docId).delete();
    }catch(error){
      throw Exception('Error : $error');
    }
  }
  ///User
  // 사용자 이메일 및 비밀번호로 가입
  Future<void> signUpWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      // 1. firebase auth 에 email과 password로 등록
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      // 2. 가입 성공 시 사용자의 UID 가져오기
      String? userUid = userCredential.user?.uid;
      // 3. userVo 인스턴스를 생성하는데 그 인스턴스의 멤버변수인 email에 userCredential에서 이메일을 가져와서 할당함.
      UserVo userVo =UserVo(
        email: userCredential.user!.email
      );
      // 4. add방식이 아닌 set으로 create를 함. set방식은 docId를 지정해줘야하는데 2번에서 받은 userUid를 docId로 사용
      await userCollection.doc(userUid).set(userVo.toMap());

    } catch (error) {
      // 가입 실패 시 예외 처리
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          throw '이미 가입되어있는 이메일 입니다.';
        }
      }else{
        throw error;
      }
    }
  }

  //로그인
  Future<UserVo> signInWithEmailAndPassword(String email, String password) async {
    try {

      // 1. firebase auth 에 email과 password로 로그인
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // 2. 로그인 성공 시 사용자의 UID 가져오기
      String? userUid = userCredential.user?.uid;

      // 3.사용자의 UID를 docId로 사용하고있는 문서조회해서 사용자 가져오기
      DocumentSnapshot documentSnapshot = await userCollection.doc(userUid).get();

      // 4. UserVo.fromDocumentSnapshot 로 만들어둔 메소드를 통해 documentSnapshot를 넣고 UserVo인스턴스 만들어서 리턴
      return UserVo.fromDocumentSnapshot(documentSnapshot);

    } catch (error) {
      // 로그인 실패 시 예외 처리
      if (error is FirebaseAuthException) {
        if (error.code == 'user-not-found') {
          throw '계정정보를 찾을 수 없습니다.';
        }
      }else{

        throw error;
      }
      throw error;
    }
  }

  //로그아웃
  Future<void> signOut() async {
    try {
      auth.signOut();
    } catch (error) {
      throw error;
    }
  }

  //내정보 가져오기
  Future<UserVo> getMyInfo(String userUid) async {
    try {

      DocumentSnapshot documentSnapshot = await userCollection.doc(userUid).get();
      return UserVo.fromDocumentSnapshot(documentSnapshot);

    } catch (error) {

      throw error;
    }
  }

  //이미지 수정
  Future<void> editImage(String userUid,File file) async {

    try{
      //1. 스토리지의 파일경로
      Reference ref = storage.ref("profileImageUrl/${userUid}.${file.path.split('.').last}");

      //2. 파일 올리기
      await ref.putFile(file);

      //3. 올린 파일의 주소 불러오기
      final String _urlString = await ref.getDownloadURL();

      //4. firestore에서 해당 userUid를 가진 문서를 찾아서 그 유저 문서의 imagePath와 updateAt 수정하기
      await userCollection.doc(userUid).update({
        'imagePath': _urlString,
        'updateAt':Timestamp.now()
      });

    }catch(error){

      throw Exception(error);
    }
  }




}