import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/comment_model.dart';

Widget CommentWidget(BuildContext context, CommentModel cmt) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(cmt.usercomment),
              ),
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: cmt.starsrating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 10.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.cyan)
          ),),
      ),
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            alignment: Alignment.centerLeft,
            child: Text(cmt.contentcomment,textAlign: TextAlign.left,),
          ),
          SizedBox(height: 20,),
          Container(

            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),),
          Container(
            child: Text(cmt.datecomment),
          )
        ],
      ),
    ),
  );
}
