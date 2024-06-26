import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message,
    {Color color = Colors.black}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
      duration: const Duration(seconds: 2),
    ),
  );
}

void showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  List<Widget>? actions, // قائمة الأزرار كمعامل اختياري
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.red.shade700, width: 2),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                size: 28, color: Colors.red.shade700),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        content: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            children: [
              TextSpan(text: content),
            ],
          ),
        ),
        actions: actions ??
            <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // لون النص والأيقونات على الزر
                    shadowColor: Colors.redAccent, // لون الظل
                    elevation: 5, // ارتفاع الظل خلف الزر
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // تقريب حواف الزر
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15), // التبطين الداخلي للزر
                  ),
                  child: const Text(
                    'حسنا',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // إغلاق الحوار
                  },
                ),
              ),
            ],
        actionsPadding: const EdgeInsets.only(bottom: 10, right: 10),
      );
    },
  );
}
