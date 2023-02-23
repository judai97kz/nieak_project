class BrandModel {
  final String? id;

  BrandModel({
    required this.id,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {'id': id};
}
