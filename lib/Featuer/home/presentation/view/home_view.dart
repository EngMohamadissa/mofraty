import 'package:flutter/material.dart';
import 'widget/home_view_body.dart';
import 'widget/leading_icons_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E2E2),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: (const Color(0xffE32020)),
        title: const AppBarHomeView(),
      ),
      body: const PopScope(canPop: false, child: HomeViewBody()),
    );
  }
}
