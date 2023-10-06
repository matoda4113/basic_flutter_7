import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/user_controller.dart';

///SignInPage
///담당자 : ---

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  UserController userController = Get.find<UserController>();

  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: Get.width,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Column(
                  children: [
                    Text(
                      "로그인",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                SizedBox(height: 20,),



                SizedBox(height: 40,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
