import 'package:eghyptproject/Featuer/home/presentation/manger/cubit/home_cubit.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColumnCircleAvatarItem extends StatelessWidget {
  const ColumnCircleAvatarItem({
    super.key,
    required this.text,
    required this.subText,
    required this.onTap,
    required this.imagePath,
  });

  final String text;
  final String subText;
  final void Function()? onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    const circleAvatarRadius = 80.0;
    const circleAvatarBackgroundSize = 76.0;
    const textStyle20 = Styles.textStyle20;
    final subTextStyle20 =
        Styles.textStyle20(context).copyWith(fontWeight: FontWeight.w600);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: kPrimaryColorwhit,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: circleAvatarRadius,
              backgroundColor: kPrimaryColorred,
              child: CircleAvatar(
                radius: circleAvatarBackgroundSize,
                backgroundImage: AssetImage(
                  imagePath,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: textStyle20(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subText,
              style: subTextStyle20,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void loadTokenAndInit(HomeCubit cubit) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  if (token != null) {
    cubit.loadSuppliers(token);
  } else {}
}
