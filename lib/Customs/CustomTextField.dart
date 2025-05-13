import 'package:flutter/material.dart';


class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({this.label,this.keyboard,this.onchanged,this.obsecure=false, this.onssaved,this.icon,this.controller}) ;
  final String? label;
 final IconData? icon;
  final  TextInputType? keyboard;
  final  Function(String)?onchanged;
  final bool obsecure;
  final void Function(String?)? onssaved;
 final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:const TextStyle(fontWeight: FontWeight.bold),
      obscureText: obsecure,
      onSaved:onssaved ,
      controller:controller ,
      validator: (value) {
        if(value!.isEmpty){
          return"field is required";}
      },
      onChanged:onchanged ,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        label: Text(
          "$label",
          style:  TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
            fontWeight: FontWeight.w400,

          ),
        ),),
      keyboardType: keyboard,
    );
  }
}
