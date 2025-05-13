import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({required this.text, this.ontab});
  final String? text;
  final VoidCallback? ontab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.blue[900], borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "$text",
            //
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
