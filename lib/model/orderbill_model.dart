class OrderBillModel {
  final String? idbill;
  final String? billtime;
  final String? contentbill;
  final int? pricebill;
  final String userorder;

  OrderBillModel(
      {required this.idbill,
        required this.billtime,
        required this.contentbill,
        required this.pricebill,required this.userorder});

  factory OrderBillModel.fromJson(Map<String, dynamic> json) => OrderBillModel(
      idbill: json['idbill'],
      billtime: json['billtime'],
      contentbill: json['contentbill'],
      pricebill: json['pricebill'],
  userorder: json['userorder']);

  Map<String, dynamic> toJson() => {
    'idbill': idbill,
    'billtime': billtime,
    'contentbill': contentbill,
    'pricebill': pricebill,
    'userorder':userorder,
  };
}
