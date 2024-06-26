// import 'dart:async';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/slider_cubit.dart';
// import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/slider_state.dart';
// import 'package:eghyptproject/core/widget/custom_loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MySliderPagemove extends StatefulWidget {
//   final int id;
//   const MySliderPagemove({
//     super.key,
//     required this.id,
//   });

//   @override
//   MySliderPagemoveState createState() => MySliderPagemoveState();
// }

// class MySliderPagemoveState extends State<MySliderPagemove> {
//   final PageController _pageController = PageController();
//   Timer? _timer;
//   // final List<String> _offerImages = [
//   //   'assets/images/boy.png',
//   //   'assets/images/boy.png',
//   //   'assets/images/boy.png',
//   // ]; // قائمة الصور
//   // late final int _offerLength;
//   int _offerLength = 0;

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
//         if (_pageController.hasClients && _offerLength > 0) {
//           int nextPage = _pageController.page!.round() + 1;
//           if (nextPage >= _offerLength) {
//             nextPage = 0;
//           }
//           _pageController.animateToPage(
//             nextPage,
//             duration: const Duration(milliseconds: 600),
//             curve: Curves.easeInOut,
//           );
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => OffersSliderCubit()..getOffersSlider(widget.id),
//       child: BlocBuilder<OffersSliderCubit, OffersSliderState>(
//         builder: (context, state) {
//           if (state is OffersSliderLoading) {
//             return buildLoadingIndicator();
//           } else if (state is OffersSliderLoaded) {
//             _offerLength = state.offers.length;
//             return PageView.builder(
//               controller: _pageController,
//               itemCount: _offerLength,
//               itemBuilder: (context, index) {
//                 return AnimatedBuilder(
//                   animation: _pageController,
//                   builder: (context, child) {
//                     double value = 1.0;
//                     if (_pageController.position.haveDimensions) {
//                       value = _pageController.page! - index;
//                       value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
//                     }
//                     return Center(
//                       child: SizedBox(
//                         height: Curves.easeOut.transform(value) *
//                             MediaQuery.of(context).size.height,
//                         width: Curves.easeOut.transform(value) *
//                             MediaQuery.of(context).size.width,
//                         child: child,
//                       ),
//                     );
//                   },
//                   child: Stack(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           image: DecorationImage(
//                             // image: AssetImage(_offerImages[index]),
//                             image: NetworkImage(state
//                                 .offers[index].image), // استخدام العنصر المناسب
//                             fit: BoxFit.fill,
//                           ),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black45,
//                               blurRadius: 20,
//                               offset: Offset(0, 12),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           return const SizedBox(height: 8, width: 8);
//         },
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/slider_cubit.dart';
import 'package:eghyptproject/Featuer/product_page_supllier/presentation/view/manger/slider_state.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySliderPagemove extends StatefulWidget {
  const MySliderPagemove({
    super.key,
    required this.id,
  });
  final num id;

  @override
  MyHomePagemoveState createState() => MyHomePagemoveState();
}

class MyHomePagemoveState extends State<MySliderPagemove> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _offerLength = 0; // متغير لحفظ طول القائمة

  @override
  void initState() {
    super.initState();

    // نستخدم addPostFrameCallback لضمان تحميل الويدجت
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        if (_pageController.hasClients && _offerLength > 0) {
          int nextPage = _pageController.page!.round() + 1;
          if (nextPage >= _offerLength) {
            nextPage = 0; // عودة إلى البداية
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
      create: (context) => OffersSliderCubit()..getOffersSlider(widget.id),
      child: BlocBuilder<OffersSliderCubit, OffersSliderState>(
        builder: (context, state) {
          if (state is OffersSliderLoading) {
            return buildLoadingIndicator();
          } else if (state is OffersSliderLoaded && state.offers.isNotEmpty) {
            _offerLength = state.offers.length; // تحديث طول القائمة
            return AspectRatio(
              aspectRatio: 7 / 4,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _offerLength,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      // تأثيرات تحريك للانتقال بين الصور
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * .5))
                            .clamp(0.0, 1.0); // تغيير القيمة لتأثير أكثر نعومة
                      }
                      return Center(
                        child: SizedBox(
                          // تعديل الأبعاد لجعل الصورة والحاوية أكبر
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
                          // إزالة الهوامش
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(20), // حدود منحنية
                            image: DecorationImage(
                              image: NetworkImage(state.offers[index].image),
                              fit: BoxFit.cover, // لتغطية الحاوية بالكامل
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

                        // يمكن إضافة المزيد من العناصر هنا إذا لزم الأمر
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is OffersSliderError) {
            return Center(child: Text(state.message));
          }
          return Container(); // حالة البداية أو حالات أخرى
        },
      ),
    );
  }
}
