import 'dart:typed_data';

class ImageModel {
  final String id;
  final String groupimage;
  final Uint8List data;

  ImageModel({
    required this.id,
    required this.groupimage,
    required this.data,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json['id'],
    groupimage: json['groupimage'],
    data:Uint8List.fromList(json['data'].cast<int>()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'groupimage': groupimage,
    'data': data,
  };

}