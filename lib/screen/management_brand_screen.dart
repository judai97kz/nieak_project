import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/model_view/brand_modelview.dart';

import '../model/brand_model.dart';

class EditBrandScreen extends StatefulWidget {
  const EditBrandScreen({Key? key}) : super(key: key);

  @override
  State<EditBrandScreen> createState() => _EditBrandScreenState();
}

class _EditBrandScreenState extends State<EditBrandScreen> {
  final listbrand = Get.put(BrandModelView());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        ()=> SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: ListView.builder(
                      itemCount: listbrand.listbrand.length,
                      itemBuilder: (context,index) => Dismissible(
                          key: Key(listbrand.listbrand[index].id.toString()),
                          confirmDismiss: (direction) {
                            AlertDialog alert = AlertDialog(
                              title: const Text("Thông báo"),
                              content:
                              const Text("Bạn có muốn xóa thương hiệu này?"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      listbrand.deleteBrand(listbrand.listbrand[index]);
                                      Navigator.of(context).pop(true);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Đã xóa !')));
                                    },
                                    child: const Text("Đồng Ý")),
                                const SizedBox(),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text("Hủy"))
                              ],
                            );

                            return showDialog(
                                context: context, builder: (context) => alert);
                          },
                          onDismissed: (direction) {},

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${listbrand.listbrand[index].id}"),
                                  ) ,
                          ))),
          )),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          final textbrand = TextEditingController();
          AlertDialog dialog = AlertDialog(
            title: Text("Nhập Tên Thương Hiệu Mới"),
            content: Padding(
              padding: EdgeInsets.all(4.0),
              child: TextField(
                controller: textbrand,
              ),
            ),actions: [
            ElevatedButton(
                onPressed: () {
                  if(textbrand.text!=""){
                    BrandModel brand = BrandModel(id: textbrand.text);
                    listbrand.addBrand(brand);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Xác Nhận")),
            const SizedBox(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Hủy"))
          ],
          );
          showDialog(
              context: context,
              builder: (context) => dialog);
        },
      ),
    );
  }
}

