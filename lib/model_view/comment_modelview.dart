import 'package:get/get.dart';
import 'package:nieak_project/Respositories/comment_database.dart';
import 'package:nieak_project/model/comment_model.dart';

import '../model/shoes_model.dart';

class CommentModelView extends GetxController {
  var listComment = <CommentModel>[].obs;
  var starvalue = 0.0.obs;
  var substars = 0.0.obs;

  getComment(String product) async {
    var list = await CommentDatabaseHelper.getAllComment(product);
    listComment.value = list!;
  }

  addComment(CommentModel model) async {
    await CommentDatabaseHelper.addComment(model);
    getComment(model.productcomment);
  }

  deleteComment(CommentModel model) async {
    await CommentDatabaseHelper.deleteComment(model);
    getComment(model.productcomment);
  }

  getStar(Shoes Pro) async {
    await CommentDatabaseHelper.countStars(Pro);
    getComment(Pro.idshoes);
  }
}
