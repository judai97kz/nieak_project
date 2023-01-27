class Shoes{
  final String idshoes;
  final String nameshoes;
  final String price;
  final String color;
  final String size;
  final String brand;

  Shoes({
    required this.idshoes,
    required this.nameshoes,
    required this.price,
    required this.color,
    required this.size,
    required this.brand
  });

  factory Shoes.fromJson(Map<String,dynamic> json) => Shoes(
      idshoes: json['idshoes'],
      nameshoes: json['nameshoes'],
      price: json['price'],
      color: json['color'],
      size: json['size'],
      brand: json['brand']
  );

  Map<String,dynamic> toJson() => {
    'idshoes':idshoes,
    'nameshoes':nameshoes,
    'price':price,
    'color':color,
    'size':size,
    'brand':brand
  };
}