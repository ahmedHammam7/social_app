import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomAuthItem(void Function()? onTap,String image)=>GestureDetector(
  onTap: onTap,
  child: Container(
    alignment: Alignment.center,
    height: 50,
    width: 100,
    decoration: BoxDecoration(
      border:Border.all(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Image(image: AssetImage(image),
    height: 40,width: 45),
  ),
);