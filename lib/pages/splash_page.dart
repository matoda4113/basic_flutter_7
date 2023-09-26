import 'package:flutter/material.dart';

///SplashPage
///담당자 : ---

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    //자동로그인 발동

    //성공하면 메인페이지로감 , 실페하면 로그인 페이지로 감

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          child: Text("앱 로고이미지"),
        ),
      ),
    );
  }
}
