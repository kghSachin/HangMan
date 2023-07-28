import 'package:flutter/Material.dart';

Widget letter(String character, bool hidden) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Container(
      height: 65,
      width: 50,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(2, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Visibility(
        visible: !hidden,
        child: Center(
          child: Text(
            character,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    ),
  );
}
