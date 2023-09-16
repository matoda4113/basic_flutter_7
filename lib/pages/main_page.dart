
import 'package:basic_flutter_7/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///MainPage
///담당자 : ---

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  PostController postController = Get.find<PostController>();

  @override
  void initState() {
    super.initState();
    postController.getPostList();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text("a"),),
          body:controller.postList==null
              ?SizedBox()
              : ListView.builder(
              itemCount: controller.postList.length,
              itemBuilder: (BuildContext context,int index){
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                    children: [
                      Text(controller!.postList[index]!.title!),
                      Text(controller!.postList[index]!.contents!),
                    ],
                  ),
                );
              })
        );
      }
    );
  }
}
