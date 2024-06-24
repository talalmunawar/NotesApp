import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_db/Views/add_post.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Home Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: FirebaseDatabase.instance.ref('Posts').onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: List.generate(
                      snapshot.data!.snapshot.children.length,
                      (index) {
                        Map<dynamic, dynamic> map =
                            snapshot.data!.snapshot.value as dynamic;
                        List<dynamic> data = [];
                        data.clear();
                        data = map.values.toList();
                        return ListTile(
                          title: Text('${data[index]['note']}'),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
            // Expanded(
            //   child: FirebaseAnimatedList(
            //     query: FirebaseDatabase.instance.ref('Posts'),
            //     itemBuilder: (context, snapshot, animation, index) {
            //       return Card(
            //         child: ListTile(
            //           title: Text(snapshot.child('note').value.toString()),
            //           subtitle: Text(snapshot.child('id').value.toString()),
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPost());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
