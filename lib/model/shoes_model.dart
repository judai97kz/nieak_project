import 'dart:ffi';

class Shoes {
  final String idshoes;
  final String nameshoes;
  final int price;
  final String color;
  final int minsize;
  final int maxsize;
  final String brand;
  final int imagenumber;
  final int status;

  Shoes(
      {required this.idshoes,
      required this.nameshoes,
      required this.price,
      required this.color,
      required this.minsize,
      required this.maxsize,
      required this.brand,
      required this.imagenumber,
      required this.status});

  factory Shoes.fromJson(Map<String, dynamic> json) => Shoes(
      idshoes: json['idshoes'],
      nameshoes: json['nameshoes'],
      price: json['price'],
      color: json['color'],
      minsize: json['minsize'],
      maxsize: json['maxsize'],
      brand: json['brand'],
      imagenumber: json['imagenumber'],
      status: json['status']);

  Map<String, dynamic> toJson() => {
        'idshoes': idshoes,
        'nameshoes': nameshoes,
        'price': price,
        'color': color,
        'minsize': minsize,
        'maxsize': maxsize,
        'brand': brand,
        'imagenumber': imagenumber,
        'status': status
      };
}
