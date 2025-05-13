import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/Screens/ChatSceen.dart';

Widget CustomCard({required UserModel model, context}) => Stack(clipBehavior: Clip.none, children: [
  Stack(
    children: [
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 50,
            spreadRadius: 0,
            offset: const Offset(10, 10),
          ),
        ]),
        height: 150,
        width: 200,
        child: Card(
          elevation: 10,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              bottom: 8,
            ),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                model.name!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
  Positioned(
    left: 50,
    right: 50,
    child: Image.network(
      model.image!,
      height: 115,
      width: 100,
    ),
  ),
]);
