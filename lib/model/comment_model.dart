class CommentModel{
  final String idcomment;
  final String usercomment;
  final String contentcomment;
  final String productcomment;
  final double starsrating;
  final String datecomment;

  CommentModel(
  {required this.idcomment,required this.usercomment,required this.contentcomment,required this.productcomment,required this.starsrating,required this.datecomment});

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      idcomment: json['idcomment'],
      usercomment: json['usercomment'],
      contentcomment: json['contentcomment'],
      productcomment: json['productcomment'],
      starsrating: json['starsrating'],
      datecomment: json['datecomment']);

  Map<String, dynamic> toJson() => {
    'idcomment':idcomment,
    'usercomment':usercomment,
    'contentcomment':contentcomment,
    'productcomment':productcomment,
    'starsrating':starsrating,
    'datecomment':datecomment,
  };
}