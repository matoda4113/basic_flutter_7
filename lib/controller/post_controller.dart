
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
  Future<PostVo> getCommunityDetail(String docId) async {
    try{
      PostVo postDetail = await saranFirebaseService.getPostDetail(docId);
      return postDetail;
    }catch(error){
      throw Exception(error);
    }
  }


}
