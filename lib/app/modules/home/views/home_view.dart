import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_get/app/controllers/auth_controller.dart';
import 'package:project_get/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final cAuth = Get.find<AuthController>();

  void showOptions(id) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () {},
            title: Text('Update'),
          ),
          ListTile(
            onTap: (){
              Get.back();
              controller.deleteProduct(id);
            },
          ),
          ListTile(
            onTap: () {},
            title: Text('Delete'),
          ),
          ListTile(
            onTap: () {},
            title: Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => cAuth.logout(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      //1 Menampilkan data tidak Realtime
      // body: FutureBuilder<QuerySnapshot<Object?>>(
      //   future: controller.GetData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       var listAllDocs = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: listAllDocs.length,
      //         itemBuilder: (context, index) => ListTile(
      //           title: Text(
      //               "${(listAllDocs[index].data() as Map<String, dynamic>)["name"]}"),
      //           subtitle: Text(
      //               "${(listAllDocs[index].data() as Map<String, dynamic>)["price"]}"),
      //         ),
      //       );
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // )

      //2 Menampilkan data secara realtime
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var listAllDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listAllDocs.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                  backgroundColor: Colors.white,
                ),
                title: Text(
                    "${(listAllDocs[index].data() as Map<String, dynamic>)["name"]}"),
                subtitle: Text(
                    "${(listAllDocs[index].data() as Map<String, dynamic>)["price"]}"),
                trailing: IconButton(
                  onPressed: () => showOptions(listAllDocs[index].id),
                  icon: Icon(Icons.more_vert),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
        child: Icon(Icons.add),
      ),
    );
  }
}
