import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/styles.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/funcations/build_linear_greadient.dart';
import '../../../../../../core/utils/funcations/validat_funcation.dart';
import '../../../../../../core/widget/custom_text_field.dart';

// class ForgetpassowrdViewBody extends StatefulWidget {
//   const ForgetpassowrdViewBody({
//     super.key,
//   });

//   @override
//   State<ForgetpassowrdViewBody> createState() => _ForgetpassowrdViewBodyState();
// }

// class _ForgetpassowrdViewBodyState extends State<ForgetpassowrdViewBody> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
//   @override
//   Widget build(BuildContext context) {
//     final forgetCubit = BlocProvider.of<UserCubitCubit>(context);
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
//               " نسيت كلمه السر ",
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
//               color: Colors.black,
//             ),
//             const SizedBox(
//               height: 250,
//             ),
//             CustomTextfield(
//               controller: forgetCubit.forgetPhon,
//               validator: checkValidate,
//               prefixIcon: const Icon(Icons.call),
//               hintText: 'رقم الهاتف',
//               label: const Text(
//                 'ادخل رقم الهاتف',
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             CustomTextfield(
//               controller: forgetCubit.forgetfirstname,
//               validator: checkValidate,
//               prefixIcon: const Icon(Icons.person),
//               hintText: ' الاسم',
//               label: const Text(
//                 'ادخل الاسم',
//               ),
//             ),
//             const SizedBox(
//               height: 38,
//             ),
//             BlocConsumer<UserCubitCubit, UserCubitState>(
//               listener: (context, state) {
//                 if (state is ForgetFailure) {
//                   showCustomSnackBar(context, state.errorMessage,
//                       color: Colors.red);
//                 } else if (state is ForgetSuccess) {
//                   showCustomSnackBar(context, state.message,
//                       color: Colors.green);
//                   GoRouter.of(context).push(AppRouter.kVeirfycodeView);
//                 }
//               },
//               builder: (context, state) {
//                 if (state is ForgetLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(color: Colors.red),
//                   );
//                 }
//                 return CustomButton(
//                   onTap: () {
//                     validateMethod(forgetCubit);
//                   },
//                   text: 'تحقق',
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void validateMethod(UserCubitCubit userCubit) {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.validate();
//       userCubit.forget();
//     } else {
//       autovalidateMode = AutovalidateMode.always;
//       setState(() {});
//     }
//   }
// }

class ForgetpassowrdViewBody extends StatefulWidget {
  const ForgetpassowrdViewBody({
    super.key,
  });

  @override
  State<ForgetpassowrdViewBody> createState() => _ForgetpassowrdViewBodyState();
}

class _ForgetpassowrdViewBodyState extends State<ForgetpassowrdViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<UserCubitCubit>(context).forgetPhon =
  //       TextEditingController(text: '+20 ');
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double screenHeight = MediaQuery.of(context).size.height;
    // Define your breakpoints and size scaling
    double imageSize = screenWidth < 600 ? screenWidth * 0.5 : 200;
    double spaceHeight = screenHeight < 600 ? 20 : 30;

    // Define a breakpoint for the screen height
    double breakpointHeight = 600.0; // You can adjust this value as needed

    // Set the height of the SizedBox based on the screen height
    double boxHeight = screenHeight > breakpointHeight ? 80 : 60;
    final forgetCubit = BlocProvider.of<UserCubitCubit>(context);
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: buildLinearGradient(),
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight > breakpointHeight ? 42 : 32,
            ),
            Text(" نسيت كلمه السر ",
                textAlign: TextAlign.center,
                style: Styles.textStyleRL(context)),
            SizedBox(
              height: screenHeight > breakpointHeight ? 18 : 16,
            ),
            const Divider(
              thickness: 1.8,
              indent: 50,
              endIndent: 50,
              color: Colors.black,
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
            // CustomTextfield(
            //   controller: forgetCubit.forgetPhon,
            //   validator: checkValidate,
            //   prefixIcon: const Icon(Icons.call),
            //   hintText: 'رقم الهاتف',
            //   label: const Text(
            //     'ادخل رقم الهاتف',
            //   ),
            // ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomTextfield(
                onChanged: (value) {
                  // التأكد من أن رمز الدولة موجود دائماً
                  if (!value.startsWith('+20')) {
                    forgetCubit.forgetPhon.text = '+20';
                    forgetCubit.forgetPhon.selection =
                        TextSelection.fromPosition(
                      TextPosition(offset: forgetCubit.forgetPhon.text.length),
                    );
                  }
                },
                keyboardType: TextInputType.phone,
                controller: forgetCubit.forgetPhon,
                validator: checkValidate,
                // prefixText: '+20',

                suffixIcon: const Icon(Icons.phone),
                label: const Text(
                  ' ادخل الرقم',
                  style: TextStyle(color: kPrimaryColorred),
                ),

                //  hintText: '+20 1111111111',
              ),
            ),
            SizedBox(
              height: screenHeight > breakpointHeight ? 12 : 8,
            ),
            CustomTextfield(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              controller: forgetCubit.forgetfirstname,
              validator: checkValidate,
              prefixIcon: const Icon(Icons.person),
              hintText: ' الاسم',
              label: const Text(
                'ادخل الاسم',
                style: TextStyle(color: kPrimaryColorred),
              ),
            ),
            SizedBox(
              height: screenHeight > breakpointHeight ? 35 : 25,
            ),
            BlocConsumer<UserCubitCubit, UserCubitState>(
              listener: (context, state) {
                if (state is ForgetFailure) {
                  showCustomSnackBar(context, state.errorMessage,
                      color: Colors.red);
                } else if (state is ForgetSuccess) {
                  showCustomSnackBar(context, state.message,
                      color: Colors.green);
                  GoRouter.of(context).push(AppRouter.kVeirfycodeView);
                }
              },
              builder: (context, state) {
                if (state is ForgetLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  );
                }
                return CustomButton(
                  onTap: () {
                    validateMethod(forgetCubit);
                  },
                  text: 'تحقق',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void validateMethod(UserCubitCubit userCubit) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.validate();
      userCubit.forget();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }
}
