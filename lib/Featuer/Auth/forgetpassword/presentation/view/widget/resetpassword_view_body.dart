import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/styles.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/funcations/build_linear_greadient.dart';
import '../../../../../../core/utils/funcations/validat_funcation.dart';
import '../../../../../../core/widget/custom_botton.dart';
import '../../../../../../core/widget/custom_text_field.dart';

// class ResetpasswordViewBody extends StatefulWidget {
//   const ResetpasswordViewBody({super.key});

//   @override
//   State<ResetpasswordViewBody> createState() => _ResetpasswordViewBodyState();
// }

// class _ResetpasswordViewBodyState extends State<ResetpasswordViewBody> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
//   @override
//   Widget build(BuildContext context) {
//     final resetCubit = BlocProvider.of<UserCubitCubit>(context);
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
//               " تعيين كلمتك المرور",
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
//               color: Colors.grey,
//             ),
//             const SizedBox(
//               height: 250,
//             ),
//             CustomTextfield(
//               controller: resetCubit.resetpass,
//               validator: checkValidate,
//               suffixIcon: const Icon(Icons.remove_red_eye),
//               prefixIcon: const Icon(Icons.lock),
//               hint: 'كلمة السر',
//               label: const Text(
//                 'ادخل كلملة السر الجديدة',
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             CustomTextfield(
//               controller: resetCubit.resetConfpass,
//               validator: checkValidate,
//               obscureText: true,
//               suffixIcon: const Icon(Icons.remove_red_eye),
//               prefixIcon: const Icon(Icons.lock),
//               hint: 'كلمة السر',
//               label: const Text(
//                 'تأكيد كلملة السر الجديدة',
//               ),
//             ),
//             const SizedBox(
//               height: 38,
//             ),
//             BlocConsumer<UserCubitCubit, UserCubitState>(
//               listener: (context, state) {
//                 if (state is ResetFailure) {
//                   showCustomSnackBar(context, state.errorMessage,
//                       color: Colors.red);
//                 } else if (state is ResetSuccess) {
//                   showCustomSnackBar(context, state.message,
//                       color: Colors.green);
//                   GoRouter.of(context).push(AppRouter.kLoginView);
//                 }
//               },
//               builder: (BuildContext context, UserCubitState state) {
//                 if (state is ResetLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.red,
//                     ),
//                   );
//                 } else {
//                   return CustomButton(
//                     text: 'تأكيد',
//                     onTap: () {
//                       validateMethod(resetCubit);
//                     },
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void validateMethod(UserCubitCubit userCubitCubit) {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.validate();
//       userCubitCubit.reset();
//     } else {
//       autovalidateMode = AutovalidateMode.always;
//       setState(() {});
//     }
//   }
// }

class ResetpasswordViewBody extends StatefulWidget {
  const ResetpasswordViewBody({super.key});

  @override
  State<ResetpasswordViewBody> createState() => _ResetpasswordViewBodyState();
}

class _ResetpasswordViewBodyState extends State<ResetpasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool obscureText = true;
  Icon iconpasswrd = const Icon(Icons.visibility_off);

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
    double boxHeight = screenHeight > breakpointHeight
        ? 80
        : 60; // Larger height for larger screens

    final resetCubit = BlocProvider.of<UserCubitCubit>(context);
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
            Text(" تعيين كلمتك الجديدة",
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
              height: spaceHeight,
            ),
            Image.asset(
                width: imageSize,
                height: imageSize,
                'assets/images/IMG_20240520_225153_669.png'),
            SizedBox(
              height: spaceHeight,
            ),
            CustomTextfield(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              controller: resetCubit.resetpass,
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
                'كلمة المرور الجديدة',
                style: TextStyle(color: kPrimaryColorred),
              ),
            ),
            SizedBox(
              height: screenHeight > breakpointHeight ? 15 : 10,
            ),

            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomTextfield(
                onChanged: (value) {
                  // التأكد من أن رمز الدولة موجود دائماً
                  if (!value.startsWith('+20')) {
                    resetCubit.resetConfpass.text = '+20';
                    resetCubit.resetConfpass.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                          offset: resetCubit.resetConfpass.text.length),
                    );
                  }
                },

                keyboardType: TextInputType.phone,
                controller: resetCubit.resetConfpass,
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
            // CustomTextfield(
            //   floatingLabelBehavior: FloatingLabelBehavior.always,
            //   controller: resetCubit.resetConfpass,
            //   validator: checkValidate,
            //   obscureText: obscureText,
            //   suffixIcon: IconButton(
            //     onPressed: () {
            //       setState(() {
            //         obscureText = !obscureText;
            //         if (obscureText) {
            //           iconpasswrd = const Icon(
            //               Icons.visibility_off); // عندما تكون كلمة المرور مخفية
            //         } else {
            //           iconpasswrd = const Icon(
            //               Icons.visibility); // عندما تكون كلمة المرور مرئية
            //         }
            //       });
            //     },
            //     icon: iconpasswrd,
            //   ),
            //   prefixIcon: const Icon(Icons.lock),
            //   hint: 'كلمة المرور',
            //   hintText: '* * * * * * *',
            //   label: const Text(
            //     'تأكيد كلمة المرور',
            //     style: TextStyle(color: kPrimaryColorred),
            //   ),
            // ),
            SizedBox(
              height: screenHeight > breakpointHeight ? 35 : 25,
            ),
            BlocConsumer<UserCubitCubit, UserCubitState>(
              listener: (context, state) {
                if (state is ResetFailure) {
                  showCustomSnackBar(context, state.errorMessage,
                      color: Colors.red);
                } else if (state is ResetSuccess) {
                  showCustomSnackBar(context, state.message,
                      color: Colors.green);
                  GoRouter.of(context).push(AppRouter.kloginView);
                }
              },
              builder: (BuildContext context, UserCubitState state) {
                if (state is ResetLoading) {
                  return buildLoadingIndicator();
                } else {
                  return CustomButton(
                    text: 'تأكيد',
                    onTap: () {
                      validateMethod(resetCubit);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void validateMethod(UserCubitCubit userCubitCubit) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.validate();
      userCubitCubit.reset();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }
}
