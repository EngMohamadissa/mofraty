

import 'package:flutter/material.dart';

class IndecatorRowPageView extends StatelessWidget {
  const IndecatorRowPageView({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: isActive ? 22.0 : 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isActive ? Colors.yellow : Colors.grey,
        ),
      ),
    );
  }
}
