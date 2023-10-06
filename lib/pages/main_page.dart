
import 'package:basic_flutter_7/controller/post_controller.dart';
import 'package:basic_flutter_7/controller/user_controller.dart';
import 'package:basic_flutter_7/pages/post_detail_page.dart';
import 'package:basic_flutter_7/pages/sign_in_page.dart';
import 'package:basic_flutter_7/pages/write_post_page.dart';
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
  UserController userController = Get.find<UserController>();

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
          appBar: AppBar(title: Text("메인페이지"),),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Image.network('https://cdn.pixabay.com/photo/2023/05/02/21/08/river-7966163_1280.png',fit: BoxFit.cover,),
                ),
                if(userController.myInfo==null)
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text('로그인하기'),
                  onTap: () {
                    Get.to(()=>SignInPage());
                  },
                ),
                if(userController.myInfo!=null)
                Text(userController.myInfo?.email??"")
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: (){
              Get.to(()=>WritePostPage());
            },

          ),
          body:controller.postList==null
              ?SizedBox()
              : ListView.builder(
              itemCount: controller.postList.length,
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: (){

                    Get.to(()=>PostDetailPage(controller!.postList[index]!.docId!));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                  ),
                );
              })
        );
      }
    );
  }
}
