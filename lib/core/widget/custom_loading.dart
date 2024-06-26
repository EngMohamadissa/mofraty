import 'package:eghyptproject/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildLoadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(color: Colors.red),
  );
}

Widget builError(String masseg) {
  return Center(
      child: Column(
    children: [
      SvgPicture.asset('assets/images/No connection-rafiki.svg'),
      Text(
        masseg,
        style: const TextStyle(color: Colors.red),
      ),
    ],
  ));
}
