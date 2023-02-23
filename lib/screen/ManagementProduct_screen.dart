import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nieak_project/mini_widget/mini_management_widget.dart';
import 'package:nieak_project/screen/add_new_product.dart';
import 'package:nieak_project/screen/management_brand_screen.dart';

import '../model_view/shoes_modelview.dart';

class ManagementProduct extends StatefulWidget {
  const ManagementProduct({Key? key}) : super(key: key);

  @override
  State<ManagementProduct> createState() => _ManagementProductState();
}

class _ManagementProductState extends State<ManagementProduct> {
  final shoesView = Get.put(ShoesModelView());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quản Lý"),actions: [
        GestureDetector(child: Icon(Icons.add),onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>EditBrandScreen()));},)
      ],),
      body: Container(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Obx(
              ()=> Container(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: shoesView.ManageShoes.length,
                      itemBuilder: (context,index)=>ManagementProductWidget(model: shoesView.ManageShoes[index])),
                ),
              ),
              SizedBox(height: 70,)
            ],
          ),
        ),
      ),floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>AddNewProduct()));
      },
        child: Icon(Icons.add),
    ),
    );
  }
}
