import 'dart:async';

import 'package:eghyptproject/Featuer/Companies/presentation/manger/slidarcomanies_cubit.dart';
import 'package:eghyptproject/Featuer/Companies/presentation/manger/slidarcomanies_state.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySliderCompanyPagemove extends StatefulWidget {
  final String type;
  const MySliderCompanyPagemove({
    super.key,
    required this.type,
  });

  @override
  MySliderPagemoveState createState() => MySliderPagemoveState();
}

class MySliderPagemoveState extends State<MySliderCompanyPagemove> {
  final PageController _pageController = PageController();
  Timer? _timer;
  // final List<String> _offerImages = [
  //   'assets/images/boy.png',
  //   'assets/images/boy.png',
  //   'assets/images/boy.png',
  // ]; // قائمة الصور
  // late final int _offerLength;
  int _offerLength = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        if (_pageController.hasClients && _offerLength > 0) {
          int nextPage = _pageController.page!.round() + 1;
          if (nextPage >= _offerLength) {
            nextPage = 0;
          }
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OffersSliderCompanyCubit()..getOffersCompanySlider(widget.type),
      child: BlocBuilder<OffersSliderCompanyCubit, OffersSliderCompanyState>(
        builder: (context, state) {
          if (state is OffersSliderCompanyLoading) {
            return buildLoadingIndicator();
          } else if (state is OffersSliderCompanyLoaded &&
              state.offers.isNotEmpty) {
            _offerLength = state.offers.length;
            return AspectRatio(
              aspectRatio: 9 / 4,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _offerLength,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
                      }
                      return Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) *
                              MediaQuery.of(context).size.height,
                          width: Curves.easeOut.transform(value) *
                              MediaQuery.of(context).size.width,
                          child: child,
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              // image: AssetImage(_offerImages[index]),
                              image: NetworkImage(
                                  'https://backend.almowafraty.com/storage/${state.offers[index].image}'), // استخدام العنصر المناسب
                              fit: BoxFit.fill,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 20,
                                offset: Offset(0, 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox(height: 0);
        },
      ),
    );
  }
}
