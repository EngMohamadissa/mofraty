// import 'package:dio/dio.dart';
// import 'package:eghyptproject/core/utils/app_router.dart';
// import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
// import 'package:eghyptproject/core/widget/custom_botton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:go_router/go_router.dart';

// class VeirfyCodeView extends StatelessWidget {
//   const VeirfyCodeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: BlocProvider(
//         create: (context) => VerifyCodeCubit(),
//         child: const Scaffold(
//           body: VerifyCodeViewBody(),
//         ),
//       ),
//     );
//   }
// }

// class VerifyCodeViewBody extends StatefulWidget {
//   const VerifyCodeViewBody({super.key});

//   @override
//   VerifyCodeViewBodyState createState() => VerifyCodeViewBodyState();
// }

// class VerifyCodeViewBodyState extends State<VerifyCodeViewBody> {
//   String _verificationCode = '';
//   // final List<String> _codeDigits = List.filled(6, '', growable: false);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
//       listener: (context, state) {
//         if (state is VerifyCodeSuccess) {
//           showCustomSnackBar(context, state.massage, color: Colors.green);
//           // Navigate to the reset password view
//           GoRouter.of(context).push(AppRouter.kResetpasswordView);
//         } else if (state is VerifyCodeFailure) {
//           showCustomSnackBar(context, state.errorMessage, color: Colors.red);
//         }
//       },
//       builder: (context, state) {
//         if (state is VerifyCodeLoading) {
          // return const Center(
          //     child: CircularProgressIndicator(
          //   color: Colors.red,
          // ));
        // }
//         return buildBody(context);
//       },
//     );
//   }

//   Widget buildBody(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       // decoration: buildLinearGradient(),
//       child: ListView(
//         children: [
//           const SizedBox(height: 32),
//           const Text(
//             "التحقق من الكود",
//             textAlign: TextAlign.center,
//             // style: Styles.textStyleRL,
//           ),
//           const SizedBox(height: 16),
//           const Divider(
//             thickness: 1.8,
//             indent: 50,
//             endIndent: 50,
//             color: Colors.grey,
//           ),
//           const SizedBox(height: 250),
//           buildOtpCode(context),
//           const SizedBox(height: 8),
//           const SizedBox(height: 38),
//           buildVerifyButton(context),
//         ],
//       ),
//     );
//   }

//   OtpTextField buildOtpCode(BuildContext context) {
//     return OtpTextField(
//       textStyle: const TextStyle(fontSize: 22),
//       filled: true,
//       fillColor: Colors.white,
//       enabledBorderColor: Colors.grey,
//       focusedBorderColor: Colors.black,
//       fieldWidth: 50.0,
//       borderRadius: BorderRadius.circular(16),
//       numberOfFields: 6,
//       showFieldAsBox: true,

//       // onCodeChanged: (String code) {
//       //   print('Code changed: $code');
//       //   setState(() {
//       //     _verificationCode = code;
//       //   });
//       // },
//       onSubmit: (String verificationCode) {
//         setState(() {
//           _verificationCode = verificationCode;
//         });
//       },
//     );
//   }

//   Widget buildVerifyButton(BuildContext context) {
//     return CustomButton(
//       onTap: () {
//         final verifyCodeCubit = context.read<VerifyCodeCubit>();
//         verifyCodeCubit.verifyCode(_verificationCode);
//         setState(() {
//           _verificationCode = '';
//         });
//       },
//       text: 'تحقق',
//     );
//   }
// }

// abstract class VerifyCodeState {}

// class VerifyCodeInitial extends VerifyCodeState {}

// class VerifyCodeLoading extends VerifyCodeState {}

// class VerifyCodeSuccess extends VerifyCodeState {
//   final String massage;

//   VerifyCodeSuccess({required this.massage});
// }

// class VerifyCodeFailure extends VerifyCodeState {
//   final String errorMessage;
//   VerifyCodeFailure(this.errorMessage);
// }

// // Cubit
// class VerifyCodeCubit extends Cubit<VerifyCodeState> {
//   VerifyCodeCubit() : super(VerifyCodeInitial());

//   final Dio dio = Dio();

//   Future<void> verifyCode(String code) async {
//     emit(VerifyCodeLoading());
//     try {
//       final response = await dio.post(
//         'https://backend.almowafraty.com/api/v1/markets/auth/verify-code',
//         data: {
//           'verification_code': code,
//         },
//       );
//       if (response.statusCode == 200) {
//         var message = response.data['message'];
//         emit(VerifyCodeSuccess(massage: message));
//         // Navigate to the next page if needed
//       } else {
//         emit(VerifyCodeFailure('Error: ${response.data['message']}'));
//       }
//     } on DioException catch (e) {
//       emit(VerifyCodeFailure('Error: ${e.response!.data['message']}}'));
//     }
//   }
// }
