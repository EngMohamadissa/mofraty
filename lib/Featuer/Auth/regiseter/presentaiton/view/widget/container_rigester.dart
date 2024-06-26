import 'package:flutter/widgets.dart';

class ContainerRigester extends StatelessWidget {
  const ContainerRigester({
    super.key,
    required this.horizontalPadding,
    required this.textScaleFactor,
  });

  final double horizontalPadding;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 220, 213, 213),
        ),
        height: 50,
        child: Center(
          child: Text(
            'حدد موقع المنشأة',
            style: TextStyle(
              fontSize: 20 * textScaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
