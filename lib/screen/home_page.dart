import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/Respositories/add_shoes.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/brand_modelview.dart';
import 'package:nieak_project/model_view/comment_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/info_page.dart';
import 'package:nieak_project/model_view/shoes_modelview.dart';
import '../model_view/image_modelview.dart';
import 'dart:math' as math;

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
  final getcomment = Get.put(CommentModelView());

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
          title: const Text(
            'NIEAK',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: AnimSearchBar(
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 300
                        : 600,
                textController: textfind,
                onSuffixTap: () {},
                autoFocus: true,
                // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                onSubmitted: (String) {
                  shoesView.findShoes(String, context);
                },
              ),
            ),
          ],
        ),
        body: Obx(
          () => getallbrand.isBlank == true
              ? CircularProgressIndicator()
              : Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Color.fromRGBO(142, 152, 151, 0.8),
                  ),
                  child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool isScrolled) {
                        return [
                          SliverAppBar(
                            backgroundColor: Colors.white,
                            automaticallyImplyLeading: false,
                            title: getimage.images.length==0?Center(child: CircularProgressIndicator()):CarouselSlider(
                              options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true),
                              items: [
                                for (int i = 0; i < 10; i++)
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
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap: () {
                                              shoesView.fetchAll(getallbrand
                                                  .listbrand[index].id);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                width: 60,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blue),
                                                child: Center(
                                                  child: Text(
                                                    getallbrand
                                                        .listbrand[index].id
                                                        .toString(),
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
                                  childAspectRatio:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? WidgetsBinding.instance.window
                                                      .physicalSize.height <
                                                  1300
                                              ? (9 / 10)
                                              : (12 / 15)
                                          : (10 / 11),
                                  crossAxisCount:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? 2
                                          : 3,
                                  children: List.generate(
                                      shoesView.allShoes.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              getcomment.listComment.value = [];
                                              getcomment.starvalue.value = 0;
                                              getcomment.getStar(
                                                  shoesView.allShoes[index]);
                                              getcomment.getComment(shoesView
                                                  .allShoes[index].idshoes);
                                              getimage.getImageByGroup(shoesView
                                                  .allShoes[index].idshoes);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          InfoPage(
                                                              shoes: shoesView
                                                                      .allShoes[
                                                                  index])));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.5),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child:Column(
                                                    children: [
                                                      Container(
                                                        height: 10,
                                                      ),
                                                      for (int i = 0;
                                                      i <
                                                          getimage
                                                              .images
                                                              .length;
                                                      i++)
                                                        if (getimage
                                                            .images[i]
                                                            .id ==
                                                            '${shoesView.allShoes[index].idshoes}-1')
                                                          Container(
                                                              width: 135,
                                                              height: 135,
                                                              child:
                                                              convertImg(
                                                                  i)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            0,
                                                            10,
                                                            0,
                                                            0),
                                                        child: SizedBox(
                                                          height: MediaQuery.of(
                                                              context)
                                                              .orientation ==
                                                              Orientation
                                                                  .portrait
                                                              ? 50
                                                              : 40,
                                                          child: Text(
                                                            shoesView
                                                                .allShoes[
                                                            index]
                                                                .nameshoes,
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize:
                                                                11.5),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: RatingBar.builder(
                                                          ignoreGestures: true,
                                                          initialRating: shoesView
                                                              .allShoes[index]
                                                              .rating,
                                                          minRating: 1,
                                                          direction:
                                                          Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemSize: 10.0,
                                                          itemPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 4.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate: (rating) {
                                                            print(rating);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            right: 15.0,
                                                            left: 15.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(1.0),
                                                        child: SizedBox(
                                                            height: 20,
                                                            child: Text(
                                                                '${myFormat.format(shoesView.allShoes[index].price)} đồng.')),
                                                      )
                                                    ],
                                                  ), ),
                                            ),
                                          )),
                                ),
                              )),
                            )
                          ],
                        ),
                      )),
                ),
        ));
  }
}
