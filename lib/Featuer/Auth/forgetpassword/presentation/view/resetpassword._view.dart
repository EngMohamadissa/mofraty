import 'package:flutter/material.dart';

import 'widget/resetpassword_view_body.dart';

class ResetpasswordView extends StatelessWidget {
  const ResetpasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: ResetpasswordViewBody(),
    ));
  }
}
