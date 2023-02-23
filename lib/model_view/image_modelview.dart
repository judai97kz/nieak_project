import 'package:get/get.dart';
import 'package:nieak_project/Respositories/image_database.dart';
import 'package:nieak_project/model/image_model.dart';

class ImageModelView extends GetxController{
  var images = <ImageModel>[].obs;
  var listimg = <ImageModel>[].obs;
  getImage() async {
    var list = await ImageConvert.getImage();
    images.value = list!;
    print(images.length);
  }
  getImageByGroup(String group) async {
    var list = await ImageConvert.getImageGroup(group);
    listimg.value = list!;
    print(images.length);
  }
  addimage(ImageModel model) async {
    await ImageConvert.saveImage(model);
    getImage();
  }
  deleteimage(String id) async {
    await ImageConvert.deleteImage(id);
    getImage();
  }
}