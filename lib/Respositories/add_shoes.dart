import 'dart:typed_data';
import 'dart:io';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/shoes_database.dart';
import 'package:nieak_project/model_view/image_modelview.dart';

import '../model/image_model.dart';
import '../model/shoes_model.dart';

class AddShoes {
  final imagemodel = Get.put(ImageModelView());
  Future<Uint8List> fileToUint8List(File file) async {
    List<int> bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }
  Future<void> addShoes() async {
    Shoes nike1 = Shoes(
        idshoes: "Nike1",
        nameshoes:
            "Giày Thể Thao Nike SB Force 58 Skate Shoes DV5477-001 Màu Xám Trắng",
        price: 3200000,
        color: "Black",
        minsize: 40,
        maxsize: 45,
        brand: "Nike",
        imagenumber: 6,amout: 30,rating: 0);
    Shoes nike2 = Shoes(
        idshoes: "Nike2",
        nameshoes: "Giày Thể Thao Nike Air Jordan 1 Low SE Spades Màu Trắng Đỏ",
        price: 4900000,
        color: "Red",
        minsize: 36,
        maxsize: 39,
        brand: "Nike",
        imagenumber: 5,amout: 20,rating: 0);
    Shoes nike3 = Shoes(
        idshoes: "Nike3",
        nameshoes:
            "Giày Thể Thao Nike Air Zoom Pegasus 39 FlyEase Platinum Orange Slate DJ7381-002 Màu Xám",
        price: 3300000,
        color: "Grey",
        minsize: 40,
        maxsize: 41,
        brand: "Nike",
        imagenumber: 4,amout: 23,rating: 0);
    Shoes nike4 = Shoes(
        idshoes: "Nike4",
        nameshoes:
            "Giày Thể Thao Nike Jordan Nu Retro 1 Low Men's Shose Phối Màu",
        price: 5700000,
        color: "Mix",
        minsize: 39,
        maxsize: 45,
        brand: "Nike",
        imagenumber: 6,amout: 32,rating: 0);
    Shoes nike5 = Shoes(
        idshoes: "Nike5",
        nameshoes: "Giày Thể Thao Nike Court Vision Low Next Nature Màu Trắng",
        price: 1980000,
        color: "White",
        minsize: 36,
        maxsize: 44,
        brand: "Nike",
        imagenumber: 6,amout: 24,rating: 0);
    Shoes puma1 = Shoes(
        idshoes: "Puma1",
        nameshoes: "Giày Thể Thao Puma Astro Kick Màu Đen",
        price: 1790000,
        color: "Black",
        minsize: 39,
        maxsize: 43,
        brand: "Puma",
        imagenumber: 4,amout: 13,rating: 0);
    Shoes puma2 = Shoes(
        idshoes: "Puma2",
        nameshoes: "Giày Thể Thao Puma Anzarun Lite Gray 371128 10 Grey",
        price: 2600000,
        color: "Grey",
        minsize: 37,
        maxsize: 41,
        brand: "Puma",
        imagenumber: 3,amout: 35,rating: 0);
    Shoes puma3 = Shoes(
        idshoes: "Puma3",
        nameshoes: "Giày Thể Thao Puma RS-X Core Black Màu Trắng Đen",
        price: 2900000,
        color: "White,Black",
        minsize: 36,
        maxsize: 40,
        brand: "Puma",
        imagenumber: 4,amout: 0,rating: 0);
    Shoes puma4 = Shoes(
        idshoes: "Puma4",
        nameshoes: "Giày Thể Thao Puma RS X3 'Unity' 373308-01 Phối Màu",
        price: 2750000,
        color: "Mix",
        minsize: 36,
        maxsize: 40,
        brand: "Puma",
        imagenumber: 5,amout: 17,rating: 0);
    Shoes puma5 = Shoes(
        idshoes: "Puma5",
        nameshoes: "Giày Thể Thao Puma Ignite Flash EvoKNIT Desert (Đen)",
        price: 2148000,
        color: "Black",
        minsize: 39,
        maxsize: 43,
        brand: "Puma",
        imagenumber: 5,amout: 18,rating: 0);

    Shoes adidas1 = Shoes(
        idshoes: "Adidas1",
        nameshoes: "Giày Thể Thao Nam Adidas Runfalcon F36201 Màu Xanh Đậm",
        price: 1550000,
        color: "Dark Blue",
        minsize: 40,
        maxsize: 42,
        brand: "Adidas",
        imagenumber: 5,amout: 19,rating: 0);
    Shoes adidas2 = Shoes(
        idshoes: "Adidas2",
        nameshoes: "Giày Thể Thao Adidas Alphabounce 1 GZ8991 Màu Đen",
        price: 2600000,
        color: "Black",
        minsize: 40,
        maxsize: 42,
        brand: "Adidas",
        imagenumber: 6,amout: 20,rating: 0);
    Shoes adidas3 = Shoes(
        idshoes: "Adidas3",
        nameshoes:
            "Giày Thể Thao Adidas Originals Day Jogger FW4868 Màu Xám Xanh",
        price: 1550000,
        color: "Dark Blue",
        minsize: 36,
        maxsize: 43,
        brand: "Adidas",
        imagenumber: 6,amout: 21,rating: 0);
    Shoes adidas4 = Shoes(
        idshoes: "Adidas4",
        nameshoes:
            "Giày Thể Thao Adidas Forum Exhibit Mid Shoes HQ1482 Phối Màu",
        price: 3200000,
        color: "Mix",
        minsize: 42,
        maxsize: 43,
        brand: "Adidas",
        imagenumber: 6,amout: 36,rating: 0);
    Shoes adidas5 = Shoes(
        idshoes: "Adidas5",
        nameshoes: "Giày Thể Thao Adidas Nizza Parley Hi Shoes GX6981 Màu Đen",
        price: 3500000,
        color: "Black",
        minsize: 36,
        maxsize: 48,
        brand: "Adidas",
        imagenumber: 6,amout: 0,rating: 0);

    Shoes dior1 = Shoes(
        idshoes: "Dior1",
        nameshoes:
            "Giày Thể Thao Dior Homme B01 Sneaker In Black And White Calfskin",
        price: 12900000,
        color: "Black",
        minsize: 42,
        maxsize: 45,
        brand: "Dior",
        imagenumber: 3,amout: 54,rating: 0);
    Shoes dior2 = Shoes(
        idshoes: "Dior2",
        nameshoes:
            "Giày Thể Thao Dior In White Technical Knit Sneaker Màu Đen - Trắng",
        price: 16500000,
        color: "Black",
        minsize: 45,
        maxsize: 45,
        brand: "Dior",
        imagenumber: 4,amout: 12,rating: 0);

    await ShoesDatabaseHelper.addShoes(nike1);
    await ShoesDatabaseHelper.addShoes(nike2);
    await ShoesDatabaseHelper.addShoes(nike3);
    await ShoesDatabaseHelper.addShoes(nike4);
    await ShoesDatabaseHelper.addShoes(nike5);
    await ShoesDatabaseHelper.addShoes(puma1);
    await ShoesDatabaseHelper.addShoes(puma2);
    await ShoesDatabaseHelper.addShoes(puma3);
    await ShoesDatabaseHelper.addShoes(puma4);
    await ShoesDatabaseHelper.addShoes(puma5);
    await ShoesDatabaseHelper.addShoes(adidas1);
    await ShoesDatabaseHelper.addShoes(adidas2);
    await ShoesDatabaseHelper.addShoes(adidas3);
    await ShoesDatabaseHelper.addShoes(adidas4);
    await ShoesDatabaseHelper.addShoes(adidas5);
    await ShoesDatabaseHelper.addShoes(dior1);
    await ShoesDatabaseHelper.addShoes(dior2);
  }
}
