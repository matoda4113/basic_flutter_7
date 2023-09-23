import 'package:basic_flutter_7/controller/post_controller.dart';
import 'package:basic_flutter_7/vo/postVo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///WritePostPage
///담당자 : ---

class WritePostPage extends StatefulWidget {
  const WritePostPage({Key? key}) : super(key: key);

  @override
  State<WritePostPage> createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  TextEditingController titleInputController = TextEditingController();
  TextEditingController contentsInputController = TextEditingController();
  PostController postController = Get.find<PostController>();
  String title="";
  String contents="";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleInputController.dispose();
    contentsInputController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WritePostPage")),
      body: Container(
        child: Column(
          children: [
            Text("제목"),
            TextField(
              controller: titleInputController,
              decoration: InputDecoration(
                hintText: "제목을 입력해주세요.",
              ),
              onChanged: (value){
                setState(() {
                  title = value;
                });
              },
            ),
            Text("내용"),
            TextField(
              controller: contentsInputController,
              decoration: InputDecoration(
                hintText: "내용을 입력해주세요.",
              ),
              onChanged: (value){
                setState(() {
                  contents = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () async{
                  PostVo userPost= PostVo();
                  userPost.writerId= "sdfsdf";
                  userPost.title = title;
                  userPost.contents = contents;
                  await postController.writePost(userPost);
                  await postController.getPostList();
                  Get.back();

                },
                child: Text("글쓰기"))
          ],
        ),
      ),
    );
  }
}
