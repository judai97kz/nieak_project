import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nieak_project/model_view/add_new.dart';
import 'package:nieak_project/model_view/add_product_modelview.dart';
import 'package:nieak_project/model_view/brand_modelview.dart';
import 'package:nieak_project/model_view/image_modelview.dart';
import 'package:nieak_project/model_view/shoes_modelview.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final theindex = Get.put(AddNew());
  final addnewshoes = Get.put(ShoesModelView());
  final imagemodel = Get.put(ImageModelView());
  final brandmana = Get.put(BrandModelView());
  final manaState = Get.put(AddProductModelView());
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  final _idcontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _pricecontroller = TextEditingController();
  final _amoutcontroller = TextEditingController();
  final _mincontroller = TextEditingController();
  final _maxcontroller = TextEditingController();
  final _colorcontroller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null) {
      theindex.index.value = selectedImages.length;
      imageFileList.addAll(selectedImages);
    } else {
      print("Ko co anh");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        manaState.textid.value = "";
        manaState.textname.value = "";
        manaState.textprice.value= "";
        manaState.textmin.value = "";
        manaState.textmax.value = "";
        manaState.textamout.value = "";
        manaState.textcolor.value = "";
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thêm Sản Phẩm Mới"),
          leading: BackButton(onPressed: () {
            theindex.index.value = 0;
            imageFileList = [];
            manaState.textid.value = "";
            manaState.textname.value = "";
            manaState.textprice.value= "";
            manaState.textmin.value = "";
            manaState.textmax.value = "";
            manaState.textamout.value = "";
            manaState.textcolor.value = "";
            Navigator.of(context).pop();
          }),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: SizedBox(
              height: 1000,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                          child: GridView.builder(
                            itemCount: theindex.index.value,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Image.file(
                                  File(imageFileList[index].path),
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        selectImages();
                        print(theindex.index.value);
                      },
                      child: Text("Chọn Ảnh")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Mã Sản Phẩm",
                          errorText: manaState.textid.value == ""
                              ? null
                              : manaState.textid.value),
                      controller: _idcontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Tên Sản Phẩm",
                          errorText: manaState.textname.value == ""
                              ? null
                              : manaState.textname.value),
                      controller: _namecontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Đơn Giá",
                          errorText: manaState.textprice.value == ""
                              ? null
                              : manaState.textprice.value),
                      controller: _pricecontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Số Lượng",
                          errorText: manaState.textamout.value == ""
                              ? null
                              : manaState.textamout.value),
                      controller: _amoutcontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Cỡ nhỏ",
                          errorText: manaState.textmin.value == ""
                              ? null
                              : manaState.textmin.value),
                      controller: _mincontroller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Cỡ Lớn",
                          errorText: manaState.textmax.value == ""
                              ? null
                              : manaState.textmax.value),
                      controller: _maxcontroller,
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: brandmana.brandState.value,
                            items: [
                              for (int i = 0; i < brandmana.listbrand.length; i++)
                                if (brandmana.listbrand[i].id != 'All')
                                  DropdownMenuItem(
                                    value: brandmana.listbrand[i].id,
                                    child: Text(
                                        brandmana.listbrand[i].id.toString()),
                                  )
                            ],
                            onChanged: (String? newValue) {
                              brandmana.brandState.value = newValue!;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onSubmitted: (passwordcontroller) {
                        manaState.check(
                            _idcontroller.text,
                            _namecontroller.text,
                            _pricecontroller.text,
                            _amoutcontroller.text,
                            _mincontroller.text,
                            _maxcontroller.text,
                            _colorcontroller.text,
                            brandmana.brandState.value,
                            imageFileList,
                            context
                        );
                      },
                      decoration: InputDecoration(
                          labelText: "Màu",
                          errorText: manaState.textcolor.value == ""
                              ? null
                              : manaState.textcolor.value),
                      controller: _colorcontroller,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        manaState.check(
                            _idcontroller.text,
                            _namecontroller.text,
                            _pricecontroller.text,
                            _amoutcontroller.text,
                            _mincontroller.text,
                            _maxcontroller.text,
                            _colorcontroller.text,
                            brandmana.brandState.value,
                          imageFileList,
                          context
                        );

                      },
                      child: Text("Thêm Sản Phẩm")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
