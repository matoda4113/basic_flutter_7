import 'package:basic_flutter_7/pages/sign_up_page.dart';
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
      child: GetBuilder<UserController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(title: Text("로그인하기"),),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("로그인"),
                    SizedBox(
                      height: 35,
                    ),
                    Text("이메일"),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "이메일을 입력해주세요.",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value){
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    Text("비밀번호"),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "비밀번호를 입력해주세요.",
                      ),
                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if(
                          email==null||
                              email==""||
                              password==null||
                              password==""
                          ){
                            print("똑바로 입력하세요");
                          }else{
                            try{
                              //모든 validation 확인이 끝난후 가능
                              await controller.login(email!, password!);
                              print("성공!");
                              Get.back();
                            }catch(e){
                              print("에러~");
                              print(e);
                            }


                          }


                        },
                        child: Text("로그인")),
                    SizedBox(height: 50,),
                    ElevatedButton(
                        onPressed: () {

                          Get.to(()=>SignUpPage());

                        },
                        child: Text("회원가입 하러가기")),

                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
