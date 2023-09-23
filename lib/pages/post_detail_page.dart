import 'package:basic_flutter_7/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../vo/postVo.dart';

///PostDetailPage
///담당자 : ---

class PostDetailPage extends StatefulWidget {
  final String docId;
  const PostDetailPage(this.docId,{Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {

  PostController postController = Get.find<PostController>();

  PostVo? post;
  @override
  void initState() {

    getDetailPost();

    super.initState();
  }

  void getDetailPost() async{
    post = await postController.getPostDetail(widget.docId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PostDetailPage")),
      body: post==null
          ?SizedBox()
          :Container(
        child: Column(
          children: [
            Text(post?.title??""),
            Text(post?.contents??""),
            ElevatedButton(onPressed: () async{

              await postController.updatePost(docId : post!.docId! , contents: "apapapaap 이렇게수정" );
              await postController.getPostList();
              Get.back();

            }, child: Text("내용 수정하기")),
            ElevatedButton(onPressed: () async{

              await postController.deletePost(post!.docId!);
              await postController.getPostList();
              Get.back();

            }, child: Text("문서 물리삭제")),
          ],
        ),
      ),
    );
  }
}
