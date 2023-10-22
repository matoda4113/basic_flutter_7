import 'package:basic_flutter_7/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///SignUpPage
///담당자 : ---

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String? email;
  String? password;
  String? passwordConfirm;

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
            appBar: AppBar(title: Text("회원가입하기"),),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("회원가입"),
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
                      obscureText: true,
                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    Text("비밀번호확인"),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "비밀번호를 한번더 입력해주세요.",
                      ),
                      obscureText: true,
                      onChanged: (value){
                        setState(() {
                          passwordConfirm = value;
                        });
                      },
                    ),
                    SizedBox(height: 100,),
                    ElevatedButton(
                        onPressed: () async{
                          if(email==null|| email==""|| password==null|| password==""|| passwordConfirm==null|| passwordConfirm==""){
                            print("똑바로 입력하세요");
                          }else{
                            if(password!=passwordConfirm){
                              print("비밀번호 확인하세요");
                            }else{
                              try{
                                //모든 validation 확인이 끝난후 가능
                                await controller.addUser(email!, password!);
                                print("성공!");
                                Get.back();
                              }catch(e){
                                print(e);
                              }
                            }
                          }
                        },
                        child: Text("회원가입")),


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
