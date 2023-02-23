import 'dart:io';
import 'dart:math';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/Respositories/add_shoes.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/brand_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/info_page.dart';
import 'package:nieak_project/model_view/shoes_modelview.dart';
import '../model_view/image_modelview.dart';

final List<String> entries = <String>['All', 'Nike', 'Puma', 'Adidas', 'Dior'];
String catelogy = 'All';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final shoesView = Get.put(ShoesModelView());
  final idcart = Get.put(Userid());
  final cartView = Get.put(AddProductHelper());
  final AddShoes allShoes = AddShoes();
  final textfind = TextEditingController();
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  final getimage = Get.put(ImageModelView());
  final _scrollController = ScrollController();
  final getallbrand = Get.put(BrandModelView());

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getimage.getImage();
    getallbrand.getBrand();
  }

  Image convertImg(int i) {
    final Uint8List imageData = getimage.images[i].data;
    final Image image = Image.memory(imageData);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NIEAK'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AnimSearchBar(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 300
                  : 600,
              textController: textfind,
              onSuffixTap: () {},
              autoFocus: true,
              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              onSubmitted: (String) {
                shoesView.findShoes(String, context);
                if (shoesView.result.value == 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sản Phẩm Không Tồn Tại')));
                  shoesView.result.value = 0;
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage("assets/bg2.jfif"))),
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool isScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true),
                    items: [
                      for (int i = 0;
                      i <  10;
                      i++)
                        Stack(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Container(child: convertImg(i),)),

                          ],
                        )
                    ],

                  ),
                  toolbarHeight: 200,
                )
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(1.5),
              child: Column(
                children: [
                  Container(
                      height: 40,
                      width: double.infinity,
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: getallbrand.listbrand.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    shoesView.fetchAll(getallbrand.listbrand[index].id);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 60,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.primaries[Random()
                                              .nextInt(
                                                  Colors.primaries.length)]),
                                      child: Center(
                                        child: Text(getallbrand.listbrand[index].id.toString()
                                         ,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      )),
                  Obx(
                    () => Expanded(
                        child: Scrollbar(
                      thickness: 8.0, // độ dày của con lăn
                      radius: Radius.circular(
                          4.0), // độ cong của các góc của con lăn
                      child: GridView.count(
                        childAspectRatio: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? WidgetsBinding
                                        .instance.window.physicalSize.height <
                                    1300
                                ? (9 / 10)
                                : (11 / 13)
                            : (10 / 11),
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        children: List.generate(
                            shoesView.allShoes.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    getimage.getImageByGroup(
                                        shoesView.allShoes[index].idshoes);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InfoPage(
                                                shoes: shoesView
                                                    .allShoes[index])));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 10,
                                          ),
                                          for (int i = 0;
                                              i < getimage.images.length;
                                              i++)
                                            if (getimage.images[i].id ==
                                                '${shoesView.allShoes[index].idshoes}-1')
                                              Container(
                                                  width: 135,
                                                  height: 135,
                                                  child: convertImg(i)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 50
                                                  : 40,
                                              child: Text(
                                                shoesView
                                                    .allShoes[index].nameshoes,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 11.5),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0, left: 15.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: SizedBox(
                                                height: 20,
                                                child: Text(
                                                    '${myFormat.format(shoesView.allShoes[index].price)} đồng.')),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    )),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
