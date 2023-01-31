import 'package:nieak_project/Respositories/shoes_database.dart';

import '../model/shoes_model.dart';

class AddShoes {
  Future<void> addShoes() async {
    Shoes shoes3 = Shoes(
        idshoes: "Nike2",
        nameshoes: "Giày Thể Thao Nike Air Jordan 1 Low SE Spades Màu Trắng Đỏ",
        price: 4900000,
        color: "Red",
        minsize: 36,
        maxsize: 39,
        brand: "Nike",
        imagenumber: 5);
    Shoes shoes2 = Shoes(
        idshoes: "Puma1",
        nameshoes: "Giày Thể Thao Puma Astro Kick Màu Đen",
        price: 1790000,
        color: "Black",
        minsize: 39,
        maxsize: 43,
        brand: "Puma",
        imagenumber: 1);
    Shoes shoes1 = Shoes(
        idshoes: "Nike1",
        nameshoes:
            "Giày Thể Thao Nike SB Force 58 Skate Shoes DV5477-001 Màu Xám Trắng",
        price: 3200000,
        color: "Black",
        minsize: 40,
        maxsize: 45,
        brand: "Nike",
        imagenumber: 6);
    Shoes shoes4 = Shoes(
        idshoes: "Adidas1",
        nameshoes: "Giày Thể Thao Nam Adidas Runfalcon F36201 Màu Xanh Đậm",
        price: 1550000,
        color: "Dark Blue",
        minsize: 40,
        maxsize: 42,
        brand: "Adidas",
        imagenumber: 1);
    await ShoesDatabaseHelper.addShoes(shoes1);
    await ShoesDatabaseHelper.addShoes(shoes2);
    await ShoesDatabaseHelper.addShoes(shoes3);
    await ShoesDatabaseHelper.addShoes(shoes4);
  }
}
