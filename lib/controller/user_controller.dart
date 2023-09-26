
import 'package:get/get.dart';
import '../service/saran_firebase_service.dart';
import '../vo/userVo.dart';

class UserController extends GetxController {


  final SaranFirebaseService saranFirebaseService = SaranFirebaseService();

  UserVo? myInfo;

  ///유저등록(회원가입)
  Future<void> addUser(UserVo userInfo) async{
    try{
      await saranFirebaseService.signUpWithEmailAndPassword(userInfo);
    }catch(error){
      throw error;
    }
  }

  ///로그인 (이메일과 비번 직접쳐서 로그인하기)
  Future<void> login(String email ,String password) async{

  }

  ///오토로그인 ( 앱에 저장된 내 이메일과 비번을 토대로 자동로그인하기)
  Future<void> autoLogin() async{

  }

  ///로그아웃
  Future<void> logout() async{

  }

  ///내 유저정보 가져오기 ( 로그인과 상관없이 내 유저정보를 새로고침해서 다시들고오거나 할때사용)
  Future<void> getUser(String userUid) async{
  }

}


