import 'package:flutter/material.dart';
import 'indecator_row_pageview.dart';

class RowIndecatorPageView extends StatelessWidget {
  const RowIndecatorPageView({
    super.key,
    required this.imageUrls,
    required this.selectIndex,
  });

  final List<String> imageUrls;
  final int selectIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            imageUrls.length,
            (index) => IndecatorRowPageView(
                  isActive: selectIndex == index ? true : false,
                ))
      ],
    );
  }
}
