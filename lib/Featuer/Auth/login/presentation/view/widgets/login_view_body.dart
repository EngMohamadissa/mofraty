import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/utils/app_router.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/styles.dart';
import '../../../../../../core/utils/funcations/build_linear_greadient.dart';
import '../../../../../../core/utils/funcations/validat_funcation.dart';
import '../../../../../../core/widget/custom_botton.dart';
import '../../../../../../core/widget/custom_text_field.dart';
import '../../../../cubit/user_cubit_cubit.dart';
import 'row_navigator_to_forgetpassowrd.dart';
import 'row_navigator_to_rigester_view.dart';

// class LoginViewBody extends StatefulWidget {
//   const LoginViewBody({super.key});

//   @override
//   State<LoginViewBody> createState() => _LoginViewBodyState();
// }

// class _LoginViewBodyState extends State<LoginViewBody> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
//   bool isSubmitting = false;
//   @override
//   Widget build(BuildContext context) {
//     final userCubit = BlocProvider.of<UserCubitCubit>(context);

//     return Form(
//       key: formKey,
//       autovalidateMode: autovalidateMode,
//       child: Container(
//         height: MediaQuery.of(context).size.height,
//         decoration: buildLinearGradient(),
//         child: ListView(
//           children: [
//             const SizedBox(
//               height: 32,
//             ),
//             const Text(
//               "تسجيل      الدخول",
//               textAlign: TextAlign.center,
//               style: Styles.textStyleRL,
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Divider(
//               thickness: 0.8,
//               indent: 50,
//               endIndent: 50,
//               color: Color.fromARGB(255, 35, 35, 35),
//             ),
//             const SizedBox(
//               height: 250,
//             ),
//             CustomTextfield(
//               controller: userCubit.signInphonenumber,
//               validator: checkValidate,
//               prefixIcon: const Icon(Icons.email),
//               label: const Text(
//                 ' ادخل الرقم',
//               ),
//               hint: 'الرقم',
//               hintText: '+20 1111111111',
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             CustomTextfield(
//               controller: userCubit.signInpassword,
//               validator: checkValidate,
//               obscureText: true,
//               suffixIcon: IconButton(
//                   onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
//               prefixIcon: const Icon(Icons.lock),
//               hint: 'كلمة المرور',
//               hintText: '*******',
//               label: const Text(
//                 'ادخل كلمة المرور',
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             const RowNavigatortoForgetpassowrd(),
//             const SizedBox(
//               height: 38,
//             ),
//             BlocConsumer<UserCubitCubit, UserCubitState>(
//               listener: (context, state) {
//                 if (state is SignInSuccess) {
//                   showCustomSnackBar(context, state.message,
//                       color: Colors.green);
//                   GoRouter.of(context).push(AppRouter.kBillsView);
//                 } else if (state is SignInFailure) {
//                   showCustomSnackBar(context, state.errorMessage,
//                       color: Colors.red);
//                 }
//               },
//               builder: (context, state) {
//                 if (state is SignInLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(color: Colors.red),
//                   );
//                 }
//                 return CustomButton(
//                   onTap: () {
//                     validateMethod(userCubit);
//                   },
//                   text: 'تسجيل',
//                 );
//               },
//             ),
//             // if (state is SignInLoading)
//             //   const Center(child: CircularProgressIndicator())
//             // else if (state is SignInFailure)
//             //   Center(
//             //     child: Text(state.errorMessage),
//             //   )
//             // else
//             //   CustomButton(
//             //     onTap: () {
//             //       validateMethod(userCubit);
//             //     },
//             //     text: 'تسجيل',
//             //   ),
//             const SizedBox(
//               height: 10,
//             ),
//             const RowNavigatortoRigesterView()
//           ],
//         ),
//       ),
//     );
//   }

//   void validateMethod(UserCubitCubit userCubit) {
//     if (formKey.currentState?.validate() ?? false) {
//       userCubit.signIn();
//     } else {
//       setState(() {
//         autovalidateMode = AutovalidateMode.always;
//       });
//     }
//   }
// }

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isSubmitting = false;
  bool obscureText = true;
  Icon iconpasswrd = const Icon(Icons.visibility_off);

  @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<UserCubitCubit>(context).signInphonenumber =
  //       TextEditingController(text: '+20');
  // }

  // void playSound() {
  //   AudioPlayer player = AudioPlayer();
  //   player.play(AssetSource(
  //       'sounds/Cash Purchase Sound Effects(MP3_128K).mp3')); // Correctly using AssetSource
  // }

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubitCubit>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Define your breakpoints and size scaling
    double imageSize = screenWidth < 600 ? screenWidth * 0.5 : 200;
    double spaceHeight = screenHeight < 600 ? 10 : 20;

    // Define a breakpoint for the screen height
    double breakpointHeight = 600.0; // You can adjust this value as needed

    // Set the height of the SizedBox based on the screen height
    double boxHeight = screenHeight > breakpointHeight
        ? 80
        : 60; // Larger height for larger screens

    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: buildLinearGradient(),
        child: ListView(
          children: [
            const SizedBox(
              height: 32,
            ),
            Text(
              "تسجيل الدخول",
              textAlign: TextAlign.center,
              style: Styles.textStyleRL(context),
            ),
            SizedBox(
              height: screenHeight > breakpointHeight ? 18 : 16,
            ),
            const Divider(
              thickness: 1.5,
              indent: 50,
              endIndent: 50,
              color: Color.fromARGB(255, 35, 35, 35),
            ),
            SizedBox(
              height: boxHeight,
            ),
            Image.asset(
                width: imageSize,
                height: imageSize,
                'assets/images/IMG_20240520_225153_669.png'),
            SizedBox(
              height: spaceHeight,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomTextfield(
                onChanged: (value) {
                  // التأكد من أن رمز الدولة موجود دائماً
                  if (!value.startsWith('+20')) {
                    userCubit.signInphonenumber.text = '+20';
                    userCubit.signInphonenumber.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                          offset: userCubit.signInphonenumber.text.length),
                    );
                  }
                },

                keyboardType: TextInputType.phone,
                controller: userCubit.signInphonenumber,
                validator: checkValidate,
                //4  prefixText: '+20',

                suffixIcon: const Icon(Icons.phone),
                label: const Text(
                  ' ادخل الرقم',
                  style: TextStyle(color: kPrimaryColorred),
                ),
                hint: 'الرقم',
                //  hintText: '+20 1111111111',
              ),
            ),
            SizedBox(
              height: screenHeight > breakpointHeight ? 30 : 20,
            ),
            CustomTextfield(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              controller: userCubit.signInpassword,
              validator: checkValidate,
              obscureText: obscureText,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                    if (obscureText) {
                      iconpasswrd = const Icon(
                          Icons.visibility_off); // عندما تكون كلمة المرور مخفية
                    } else {
                      iconpasswrd = const Icon(
                          Icons.visibility); // عندما تكون كلمة المرور مرئية
                    }
                  });
                },
                icon: iconpasswrd,
              ),
              prefixIcon: const Icon(Icons.lock),
              hint: 'كلمة المرور',
              hintText: '* * * * * * *',
              label: const Text(
                'ادخل كلمة المرور',
                style: TextStyle(color: kPrimaryColorred),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const RowNavigatortoForgetpassowrd(),
            SizedBox(
              height: screenHeight > breakpointHeight ? 35 : 25,
            ),
            const RowNavigatortoRigesterView(),
            BlocConsumer<UserCubitCubit, UserCubitState>(
              listener: (context, state) {
                if (state is SignInSuccess) {
                  showCustomSnackBar(context, state.message,
                      color: Colors.green);
                  GoRouter.of(context).push(AppRouter.kHomeView);
                } else if (state is SignInFailure) {
                  showCustomSnackBar(context, state.errorMessage,
                      color: Colors.red);
                }
              },
              builder: (context, state) {
                if (state is SignInLoading) {
                  return buildLoadingIndicator();
                }
                return CustomButton(
                  onTap: () {
                    validateMethod(userCubit);
                  },
                  text: 'تسجيل',
                );
              },
            ),
            SizedBox(
              height: screenHeight > breakpointHeight ? 15 : 10,
            ),
          ],
        ),
      ),
    );
  }

  void validateMethod(UserCubitCubit userCubit) {
    if (formKey.currentState?.validate() ?? false) {
      userCubit.signIn();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
