
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/saran_firebase_service.dart';
import '../vo/userVo.dart';

class UserController extends GetxController {


  final SaranFirebaseService saranFirebaseService = SaranFirebaseService();

  UserVo? myInfo;

  ///유저등록(회원가입)
  Future<void> addUser(String email ,String password) async{
    try{
      await saranFirebaseService.signUpWithEmailAndPassword(email, password);
    }catch(error){
      throw error;
    }
  }

  ///로그인 (이메일과 비번 직접쳐서 로그인하기)
  Future<void> login(String email ,String password) async{

    try{

      UserVo userVo = await saranFirebaseService.signInWithEmailAndPassword(email, password);
      myInfo = userVo;
      update();


      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);


    }catch(error){
      throw error;
    }
  }


  ///오토로그인 ( 앱에 저장된 내 이메일과 비번을 토대로 자동로그인하기)
  Future<void> autoLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = await prefs.getString('email');
    String? password = await prefs.getString('password');

    if(email ==null || password ==null){
      return;
    }
    try{
      login(email,password);
    }catch(error){
      await prefs.remove('email');
      await prefs.remove('password');
      throw Exception('Error : $error');
    }
  }

  ///로그아웃
  Future<void> logout() async{
    try{
      await saranFirebaseService.signOut();
      myInfo = null;
      update();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      await prefs.remove('password');
      Get.closeAllSnackbars();
      Get.snackbar(
        '로그아웃 되었습니다',
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }catch(error){
      throw Exception('Error : $error');
    }
  }


  ///내 유저정보 가져오기 ( 로그인과 상관없이 내 유저정보를 새로고침해서 다시들고오거나 할때사용)
  Future<void> getUser(String userUid) async{
  }

}


