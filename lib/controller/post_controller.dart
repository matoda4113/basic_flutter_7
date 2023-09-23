
import 'package:get/get.dart';
import '../model/post_list_model.dart';
import '../service/saran_firebase_service.dart';
import '../vo/postVo.dart';

class PostController extends GetxController {


  final SaranFirebaseService saranFirebaseService = SaranFirebaseService();

  List<PostVo> postList =[];


  //포스트 리스트 조회
  Future<void> getPostList() async {
    try{
      PostListModel postListModel = await saranFirebaseService.getPostList();
      postList.clear();
      postList.addAll(postListModel.postList!);
      update();
    }catch(error){
      throw Exception(error);
    }
  }

  //포스트 상세조회
  Future<PostVo> getPostDetail(String docId) async {
    try{
      PostVo postDetail = await saranFirebaseService.getPostDetail(docId);
      return postDetail;
    }catch(error){
      throw Exception(error);
    }
  }

  //포스트 작성하기
  Future<void> writePost(PostVo userPost) async {
    try{
      await saranFirebaseService.writePost(userPost);

    }catch(error){
      throw Exception(error);
    }
  }

  //포스트 수정하기
  Future<void> updatePost({required String docId ,required String contents}) async {
    try{
      await saranFirebaseService.updatePost(docId : docId , contents : contents);

    }catch(error){
      throw Exception(error);
    }
  }

  //포스트 삭제하기
  Future<void> deletePost(String docId) async {
    try{
      await saranFirebaseService.deletePost(docId);

    }catch(error){
      throw Exception(error);
    }
  }



}
