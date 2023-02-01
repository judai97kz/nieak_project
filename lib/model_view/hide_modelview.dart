import 'package:get/get.dart';

class HideModelView extends GetxController{
  var hidelogin = 0.obs;
  var hidesignup = 0.obs;
  var hideaccept =0.obs;
  var hideinfo =0.obs;
  updateinlogin(){
    if(hidelogin.value==0){
      hidelogin.value =1;
    }else{
      hidelogin.value=0;
    }
  }

  updateinsignup(){
    if(hidesignup.value==0){
      hidesignup.value =1;
    }else{
      hidesignup.value=0;
    }
  }

  updateinaccept(){
    if(hideaccept.value==0){
      hideaccept.value =1;
    }else{
      hideaccept.value=0;
    }
  }

  updateinuser(){
    if(hideinfo.value==0){
      hideinfo.value =1;
    }else{
      hideinfo.value=0;
    }
  }
}