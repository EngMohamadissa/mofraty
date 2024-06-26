// ignore_for_file: library_private_types_in_public_api

import 'package:eghyptproject/Featuer/home/presentation/view/home_view.dart';
import 'package:eghyptproject/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_svg/svg.dart';
import 'Featuer/Auth/login/presentation/view/login_view.dart';

// class SpashView extends StatefulWidget {
//   const SpashView({super.key});

//   @override
//   _SpashViewState createState() => _SpashViewState();
// }

// class _SpashViewState extends State<SpashView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _animationTopToCenter;
//   late Animation<Offset> _animationRightToCenter;
//   late Animation<Offset> _animationLefttToCenter;
//   late Animation<Offset> _animationBottom;
//   late Animation<double> _animationFadeOut;
//   late Animation<Offset> _animationFifthImage;
//   late Animation<Offset> _animationFifthImageee;
//   late Animation<double> _animationScale;
//   late Animation<double> _animationScaleBottom;
//   late Animation<double> _sizeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 11), // مدة الحركة الكلية
//       vsync: this,
//     );

//     _animationTopToCenter = Tween<Offset>(
//       begin: const Offset(0.0, -5.0),
//       end: const Offset(0.0, 0.0),
//     ).animate(
//       CurvedAnimation(
//           parent: _controller,
//           curve: const Interval(
//             0.0, 0.08, // الحركة الأولى تحدث في الربع الأول من المدة
//             curve: Curves.easeInOut,
//           )),
//     );

//     _animationRightToCenter = Tween<Offset>(
//       begin: const Offset(12.0, 0.0),
//       end: const Offset(0.7, 0.0),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(
//           0.08, 0.16, // الحركة الثانية تحدث في الربع الثاني من المدة
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );

//     _animationLefttToCenter = Tween<Offset>(
//       begin: const Offset(-12.0, 0.0),
//       end: const Offset(-0.6, 0.0),
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(
//         0.16, 0.24, // الحركة الثالثة تحدث في الربع الثالث من المدة
//         curve: Curves.easeInOut,
//       ),
//     ));

//     _animationBottom = Tween<Offset>(
//       begin: const Offset(0.0, 12.0),
//       end: const Offset(0.0, 2.0),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(
//           0.24, 0.24, // الحركة الرابعة تحدث في الربع الأخير من المدة
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );

//     _animationScaleBottom = Tween<double>(
//       begin: 0.005, // الحجم الأولي للصورة الاخيره (تصغيرها)
//       end: 2.0, // الحجم النهائي للصورة (تكبيرها)
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(
//           0.24, 0.34, // تحدد الفترة التي تحدث فيها الحركة
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );

//     _animationFadeOut = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(
//           0.32, 0.40, // بدء الإخفاء بعد الحركة الرابعة
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );

//     _animationFifthImage = Tween<Offset>(
//       begin: const Offset(0.0, -9.0),
//       end: const Offset(0.3, -1.0),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(
//           0.42, 0.42, // عرض الصورة الخامسة بعد الإخفاء
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );

//     _animationFifthImageee = Tween<Offset>(
//       begin: const Offset(0.0, 0.0),
//       end: const Offset(0.0, 0.5),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(
//           0.60, 0.60, // عرض الصورة السادسه
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );

//     _sizeAnimation = Tween<double>(begin: 30.0, end: 90.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(
//           0.42, 0.54, // تحدد الفترة التي تحدث فيها الحركة
//           curve: Curves.easeIn,
//         ),
//       ),
//     );

//     _animationScale = Tween<double>(
//       begin: 0.005, // الحجم الأولي للصورة الاخيره (تصغيرها)
//       end: 2.0, // الحجم النهائي للصورة (تكبيرها)
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(
//           0.60, 0.70, // تحدد الفترة التي تحدث فيها الحركة
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationTopToCenter.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationRightToCenter.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationLefttToCenter.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationBottom.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationFadeOut.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationFifthImage.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationFifthImageee.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationScale.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _animationScaleBottom.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });
//     _sizeAnimation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         checkAllAnimationsCompleted();
//       }
//     });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red,
//       body: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           Center(
//             child: AnimatedBuilder(
//               animation: _sizeAnimation,
//               builder: (context, child) {
//                 return SizedBox(
//                   width: _sizeAnimation.value,
//                   height: _sizeAnimation.value,
//                   child: child,
//                 );
//               },
//               child: SlideTransition(
//                   position: _animationTopToCenter,
//                   child:
//                    SvgPicture.asset('assets/image/ف shape.svg'),
//                   ),
//             ),
//           ),
//           Center(
//             child: FadeTransition(
//               opacity: _animationFadeOut,
//               child: SlideTransition(
//                 position: _animationRightToCenter,
//                 child: Image.asset('assets/images/test_image.png'),

//                 // 'assets/image/photo_2024-04-23_23-16-30-removebg-preview.png'), // تأكد من أن الصورة الثانية مضافة في pubspec.yaml
//               ),
//             ),
//           ),
//           Center(
//             child: FadeTransition(
//               opacity: _animationFadeOut,
//               child: SlideTransition(
//                 position: _animationLefttToCenter,
//                 child: Image.asset('assets/images/test_image.png'),

//                 // 'assets/image/photo_2024-04-23_23-46-54-removebg-preview.png'), // تأكد من أن الصورة الثانية مضافة في pubspec.yaml
//               ),
//             ),
//           ),
//           Center(
//             child: FadeTransition(
//               opacity: _animationScaleBottom,
//               child: FadeTransition(
//                 opacity: _animationFadeOut,
//                 child: SlideTransition(
//                   position: _animationBottom,
//                   child: Image.asset('assets/images/test_image.png'),
//                   // SvgPicture.asset(
//                   //     'assets/image/سوق التجار (1).svg'), // تأكد من أن الصورة الثانية مضافة في pubspec.yaml
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: SlideTransition(
//               position: _animationFifthImage,
//               child: Image.asset('assets/images/test_image.png'),
//               // SvgPicture.asset(
//               //     height: 64, width: 64, 'assets/image/م shape.svg'),
//             ),
//           ),
//           FadeTransition(
//             opacity: _animationScale,
//             child: SlideTransition(
//               position: _animationFifthImageee,
//               child: Image.asset('assets/images/test_image.png'),
//               // Image.asset(
//               //     width: 200,
//               //     height: 200,
//               //     'assets/image/Group_2-removebg-preview.png'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   bool allAnimationsCompleted = false;

//   void checkAllAnimationsCompleted() {
//     if (_animationTopToCenter.status == AnimationStatus.completed &&
//         _animationRightToCenter.status == AnimationStatus.completed &&
//         _animationLefttToCenter.status == AnimationStatus.completed &&
//         _animationBottom.status == AnimationStatus.completed &&
//         _animationFadeOut.status == AnimationStatus.completed &&
//         _animationFifthImage.status == AnimationStatus.completed &&
//         _animationFifthImageee.status == AnimationStatus.completed &&
//         _animationScale.status == AnimationStatus.completed &&
//         _animationScaleBottom.status == AnimationStatus.completed &&
//         _sizeAnimation.status == AnimationStatus.completed &&
//         !allAnimationsCompleted) {
//       allAnimationsCompleted = true;
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginView()),
//       );
//     }
//   }
// }

class SpashView extends StatefulWidget {
  const SpashView({super.key});

  @override
  _SpashViewState createState() => _SpashViewState();
}

class _SpashViewState extends State<SpashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animationTopToCenter;
  late Animation<Offset> _animationRightToCenter;
  late Animation<Offset> _animationLefttToCenter;
  late Animation<Offset> _animationBottom;
  late Animation<double> _animationFadeOut;
  late Animation<Offset> _animationFifthImage;
  late Animation<Offset> _animationFifthImageee;
  late Animation<double> _animationScale;
  late Animation<double> _animationScaleBottom;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8), // مدة الحركة الكلية
      vsync: this,
    );

    _animationTopToCenter = Tween<Offset>(
      begin: const Offset(0.0, -20.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.0, 0.08, // الحركة الأولى تحدث في الربع الأول من المدة
            curve: Curves.easeInOut,
          )),
    );

    _animationRightToCenter = Tween<Offset>(
      begin: const Offset(12.0, 0.0),
      end: const Offset(0.7, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.08, 0.16, // الحركة الثانية تحدث في الربع الثاني من المدة
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationLefttToCenter = Tween<Offset>(
      begin: const Offset(-12.0, 0.0),
      end: const Offset(-0.6, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.16, 0.24, // الحركة الثالثة تحدث في الربع الثالث من المدة
        curve: Curves.easeInOut,
      ),
    ));

    _animationBottom = Tween<Offset>(
      begin: const Offset(0.0, 12.0),
      end: const Offset(0.0, 2.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.24, 0.24, // الحركة الرابعة تحدث في الربع الأخير من المدة
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationScaleBottom = Tween<double>(
      begin: 0.005, // الحجم الأولي للصورة الاخيره (تصغيرها)
      end: 2.0, // الحجم النهائي للصورة (تكبيرها)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.24, 0.34, // تحدد الفترة التي تحدث فيها الحركة
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationFadeOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.32, 0.40, // بدء الإخفاء بعد الحركة الرابعة
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationFifthImage = Tween<Offset>(
      begin: const Offset(0.0, -9.0),
      end: const Offset(0.3, -1.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.42, 0.42, // عرض الصورة الخامسة بعد الإخفاء
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationFifthImageee = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.5),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.60, 0.60, // عرض الصورة السادسه
          curve: Curves.easeInOut,
        ),
      ),
    );

    _sizeAnimation = Tween<double>(begin: 30.0, end: 90.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.42, 0.54, // تحدد الفترة التي تحدث فيها الحركة
          curve: Curves.easeIn,
        ),
      ),
    );

    _animationScale = Tween<double>(
      begin: 0.005, // الحجم الأولي للصورة الاخيره (تصغيرها)
      end: 2.0, // الحجم النهائي للصورة (تكبيرها)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.60, 0.70, // تحدد الفترة التي تحدث فيها الحركة
          curve: Curves.easeInOut,
        ),
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationTopToCenter.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationRightToCenter.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationLefttToCenter.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationBottom.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationFadeOut.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationFifthImage.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationFifthImageee.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationScale.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _animationScaleBottom.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });
    _sizeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkAllAnimationsCompleted();
      }
    });

    // _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      _controller.forward(); // لبدء الحركة بعد التأخير
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) {
                return SizedBox(
                  width: _sizeAnimation.value,
                  height: _sizeAnimation.value,
                  child: child,
                );
              },
              child: SlideTransition(
                  position: _animationTopToCenter,
                  child: SvgPicture.asset('assets/images/ف shape.svg')),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _animationFadeOut,
              child: SlideTransition(
                position: _animationRightToCenter,
                child: Image.asset(
                    'assets/images/photo_2024-04-23_23-16-30-removebg-preview.png'),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _animationFadeOut,
              child: SlideTransition(
                position: _animationLefttToCenter,
                child: Image.asset(
                    'assets/images/photo_2024-04-23_23-46-54-removebg-preview.png'),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _animationScaleBottom,
              child: FadeTransition(
                opacity: _animationFadeOut,
                child: SlideTransition(
                  position: _animationBottom,
                  child: SvgPicture.asset('assets/images/سوق التجار (1).svg'),
                ),
              ),
            ),
          ),
          Center(
            child: SlideTransition(
              position: _animationFifthImage,
              child: SvgPicture.asset(
                  height: 64, width: 64, 'assets/images/م shape.svg'),
              // SvgPicture.asset(
              //     height: 64, width: 64, 'assets/image/م shape.svg'),
            ),
          ),
          FadeTransition(
            opacity: _animationScale,
            child: SlideTransition(
              position: _animationFifthImageee,
              child: Image.asset(
                  width: 200,
                  height: 200,
                  'assets/images/IMG_20240604_223926_050.png'),
            ),
          ),
        ],
      ),
    );
  }

  bool allAnimationsCompleted = false;

  void checkAllAnimationsCompleted() async {
    if (_animationTopToCenter.status == AnimationStatus.completed &&
        _animationRightToCenter.status == AnimationStatus.completed &&
        _animationLefttToCenter.status == AnimationStatus.completed &&
        _animationBottom.status == AnimationStatus.completed &&
        _animationFadeOut.status == AnimationStatus.completed &&
        _animationFifthImage.status == AnimationStatus.completed &&
        _animationFifthImageee.status == AnimationStatus.completed &&
        _animationScale.status == AnimationStatus.completed &&
        _animationScaleBottom.status == AnimationStatus.completed &&
        _sizeAnimation.status == AnimationStatus.completed &&
        !allAnimationsCompleted) {
      allAnimationsCompleted = true;

      final prefs = await SharedPreferences.getInstance();
      print('ssssooowww${prefs.getString('access_token')}');

      if (prefs.getString('access_token') == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
      // prefs.getString('access_token') == null
      //     ? GoRouter.of(context).go(AppRouter.kLoginView)
      //     : GoRouter.of(context).go(AppRouter.kHomeView);
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const LoginView()),
      //   );
      // }
    }
  }

//               child: SlideTransition(
//                   position: _animationTopToCenter,
//                   child: SvgPicture.asset('assets/images/ف shape.svg')),
//             ),
//           ),
//           Center(
//             child: FadeTransition(
//               opacity: _animationFadeOut,
//               child: SlideTransition(
//                 position: _animationRightToCenter,
//                 child: Image.asset(
//                     'assets/images/photo_2024-04-23_23-16-30-removebg-preview.png'),
//               ),
//             ),
//           ),
//           Center(
//             child: FadeTransition(
//               opacity: _animationFadeOut,
//               child: SlideTransition(
//                 position: _animationLefttToCenter,
//                 child: Image.asset(
//                     'assets/images/photo_2024-04-23_23-46-54-removebg-preview.png'),
//               ),
//             ),
//           ),
//           Center(
//             child: FadeTransition(
//               opacity: _animationScaleBottom,
//               child: FadeTransition(
//                 opacity: _animationFadeOut,
//                 child: SlideTransition(
//                   position: _animationBottom,
//                   child: SvgPicture.asset('assets/images/سوق التجار (1).svg'),
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: SlideTransition(
//               position: _animationFifthImage,
//               child: SvgPicture.asset(
//                   height: 64, width: 64, 'assets/images/م shape.svg'),
//               // SvgPicture.asset(
//               //     height: 64, width: 64, 'assets/image/م shape.svg'),
//             ),
//           ),
//           FadeTransition(
//             opacity: _animationScale,
//             child: SlideTransition(
//               position: _animationFifthImageee,
//               child: Image.asset(
//                   width: 200,
//                   height: 200,
//                   'assets/images/Group_2-removebg-preview.png'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   bool allAnimationsCompleted = false;

//   void checkAllAnimationsCompleted() {
//     if (_animationTopToCenter.status == AnimationStatus.completed &&
//         _animationRightToCenter.status == AnimationStatus.completed &&
//         _animationLefttToCenter.status == AnimationStatus.completed &&
//         _animationBottom.status == AnimationStatus.completed &&
//         _animationFadeOut.status == AnimationStatus.completed &&
//         _animationFifthImage.status == AnimationStatus.completed &&
//         _animationFifthImageee.status == AnimationStatus.completed &&
//         _animationScale.status == AnimationStatus.completed &&
//         _animationScaleBottom.status == AnimationStatus.completed &&
//         _sizeAnimation.status == AnimationStatus.completed &&
//         !allAnimationsCompleted) {
//       allAnimationsCompleted = true;
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginView()),
//       );
//     }
//   }
// }
}
