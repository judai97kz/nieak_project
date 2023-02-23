import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/image_model.dart';
import '../model/shoes_model.dart';
import '../model_view/add_new.dart';
import '../model_view/add_product_modelview.dart';
import '../model_view/brand_modelview.dart';
import '../model_view/edit_product_modelview.dart';
import '../model_view/image_modelview.dart';
import '../model_view/shoes_modelview.dart';

class EditProductPage extends StatefulWidget {
  final Shoes model;
  const EditProductPage({Key? key, required this.model}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final theindex = Get.put(AddNew());
  final addnewshoes = Get.put(ShoesModelView());
  final imagemodel = Get.put(ImageModelView());
  final brandmana = Get.put(BrandModelView());
  final manaState = Get.put(EditProductModelView());
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  Future<Uint8List> fileToUint8List(File file) async {
    List<int> bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null) {
      theindex.index.value = selectedImages.length;
      imageFileList.addAll(selectedImages);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagemodel.getImageByGroup(widget.model.idshoes);
  }

  Image convertImg(int i) {
    final Uint8List imageData = imagemodel.listimg[i].data;
    final Image image = Image.memory(imageData);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final _idcontroller = TextEditingController(text: widget.model.idshoes);
    final _namecontroller = TextEditingController(text: widget.model.nameshoes);
    final _pricecontroller = TextEditingController(text: widget.model.price.toString());
    final _amoutcontroller = TextEditingController(text: widget.model.amout.toString());
    final _mincontroller = TextEditingController(text: widget.model.minsize.toString());
    final _maxcontroller = TextEditingController(text: widget.model .maxsize.toString());
    final _colorcontroller = TextEditingController(text: widget.model .color);
    brandmana.brandState.value = widget.model.brand;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          theindex.index.value = 0;
          imageFileList = [];
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
                      child: Positioned.fill(
                        child: CarouselSlider(
                          options: CarouselOptions(
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true),
                          items: [
                            for (int i = 0; i < imagemodel.listimg.length; i++)
                              Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        child: convertImg(i),
                                      )),
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: theindex.index.value,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        height: 30,
                        width: 50,
                        child: Image.file(
                          File(imageFileList[index].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectImages();
                      });
                    },
                    child: Text("Chọn Ảnh")),
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
                          context,
                          imagemodel.listimg.length
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
                        context,
                        imagemodel.listimg.length
                      );
                    },
                    child: const Text("Cập Nhật Sản Phẩm")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


