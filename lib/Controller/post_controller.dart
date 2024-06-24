import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:realtime_db/Views/home_screen.dart';

class PostController extends GetxController {
  RxBool loader = false.obs;

  addData(String note, String id) async {
    loader.value = true;
    return await FirebaseDatabase.instance.ref('Posts').child(id).set({
      'id': id,
      'note': note,
    }).then((_) {
      loader.value = false;
      update();
      Get.snackbar('Success', 'Post Added Successfully');
      Get.off(() => HomeScreen());
    });
  }
}
