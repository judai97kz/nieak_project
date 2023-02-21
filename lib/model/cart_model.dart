

class CartModel {
  final String idproduct;
  final String nameproduct;
  final int priceproduct;
  final int amoutproduct;
  final int sizeproduct;
  final String brand;

  CartModel(
      {required this.idproduct,
      required this.nameproduct,
      required this.priceproduct,
      required this.amoutproduct,
      required this.sizeproduct,
      required this.brand});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      idproduct: json['idproduct'],
      nameproduct: json['nameproduct'],
      priceproduct: json['priceproduct'],
      amoutproduct: json['amoutproduct'],
      sizeproduct: json['sizeproduct'],
      brand: json['brand']);

  Map<String, dynamic> toJson() => {
        'idproduct': idproduct,
        'nameproduct': nameproduct,
        'priceproduct': priceproduct,
        'amoutproduct': amoutproduct,
        'sizeproduct': sizeproduct,
        'brand': brand
      };
}
