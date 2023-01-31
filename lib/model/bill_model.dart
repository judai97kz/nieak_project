class BillModel {
  final String? idbill;
  final String? billtime;
  final String? contentbill;
  final int? pricebill;

  BillModel(
      {required this.idbill,
      required this.billtime,
      required this.contentbill,
      required this.pricebill});

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
      idbill: json['idbill'],
      billtime: json['billtime'],
      contentbill: json['contentbill'],
      pricebill: json['pricebill']);

  Map<String, dynamic> toJson() => {
        'idbill': idbill,
        'billtime': billtime,
        'contentbill': contentbill,
        'pricebill': pricebill
      };
}
