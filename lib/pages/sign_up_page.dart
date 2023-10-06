import 'package:flutter/material.dart';

///SignUpPage
///담당자 : ---

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SignUpPage")),
      body: Container(
        child: Text("SignUpPage"),
      ),
    );
  }
}
