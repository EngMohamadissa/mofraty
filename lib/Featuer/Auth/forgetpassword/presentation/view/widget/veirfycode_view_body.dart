// import 'package:dio/dio.dart';
// import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
// import 'package:eghyptproject/core/api/api_consumer.dart';
// import 'package:eghyptproject/core/widget/custom_botton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../../core/api/dio_consumer.dart';
// import '../../../../../../core/styles.dart';
// import '../../../../../../core/utils/app_router.dart';
// import '../../../../../../core/utils/funcations/build_linear_greadient.dart';

import 'package:dio/dio.dart';
import 'package:eghyptproject/constant.dart';
import 'package:eghyptproject/core/styles.dart';
import 'package:eghyptproject/core/utils/app_router.dart';
import 'package:eghyptproject/core/utils/funcations/show_snack_bar.dart';
import 'package:eghyptproject/core/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/widget/custom_botton.dart';

class VeirfyCodeView extends StatelessWidget {
  const VeirfyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => VerifyCodeCubit(),
        child: const Scaffold(
          backgroundColor: kPrimaryColorwhit,
          body: VerifyCodeViewBody(),
        ),
      ),
    );
  }
}

class VerifyCodeViewBody extends StatefulWidget {
  const VerifyCodeViewBody({super.key});

  @override
  VerifyCodeViewBodyState createState() => VerifyCodeViewBodyState();
}

class VerifyCodeViewBodyState extends State<VerifyCodeViewBody> {
  String _verificationCode = '';
  // final List<String> _codeDigits = List.filled(6, '', growable: false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
      listener: (context, state) {
        if (state is VerifyCodeSuccess) {
          showCustomSnackBar(context, state.massage, color: Colors.green);
          // Navigate to the reset password view
          GoRouter.of(context).push(AppRouter.kResetpasswordView);
        } else if (state is VerifyCodeFailure) {
          showCustomSnackBar(context, state.errorMessage, color: Colors.red);
        }
      },
      builder: (context, state) {
        if (state is VerifyCodeLoading) {
          return buildLoadingIndicator();
        }
        return buildBody(context);
      },
    );
  }

  Widget buildBody(BuildContext context) {
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

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      // decoration: buildLinearGradient(),
      child: ListView(
        children: [
          const SizedBox(height: 32),
          Text("التحقق من الكود",
              textAlign: TextAlign.center, style: Styles.textStyleRL(context)),
          const SizedBox(height: 16),
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
          buildOtpCode(context),
          SizedBox(
            height: screenHeight > breakpointHeight ? 35 : 25,
          ),
          buildVerifyButton(context),
        ],
      ),
    );
  }

  Directionality buildOtpCode(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OtpTextField(
        textStyle: const TextStyle(fontSize: 22),
        filled: true,

        fillColor: Colors.white,
        enabledBorderColor: const Color.fromARGB(255, 241, 115, 106),
        focusedBorderColor: kPrimaryColorred,
        cursorColor: const Color.fromARGB(255, 241, 115, 106),
        fieldWidth: 50.0,
        borderRadius: BorderRadius.circular(16),
        numberOfFields: 6,
        showFieldAsBox: true,

        // onCodeChanged: (String code) {
        //   print('Code changed: $code');
        //   setState(() {
        //     _verificationCode = code;
        //   });
        // },
        onSubmit: (String verificationCode) {
          setState(() {
            _verificationCode = verificationCode;
          });
        },
      ),
    );
  }

  Widget buildVerifyButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        final verifyCodeCubit = context.read<VerifyCodeCubit>();
        verifyCodeCubit.verifyCode(_verificationCode);
        setState(() {
          _verificationCode = '';
        });
      },
      text: 'تحقق',
    );
  }
}

abstract class VerifyCodeState {}

class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {}

class VerifyCodeSuccess extends VerifyCodeState {
  final String massage;

  VerifyCodeSuccess({required this.massage});
}

class VerifyCodeFailure extends VerifyCodeState {
  final String errorMessage;
  VerifyCodeFailure(this.errorMessage);
}

// Cubit
class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(VerifyCodeInitial());

  final Dio dio = Dio();

  Future<void> verifyCode(String code) async {
    emit(VerifyCodeLoading());
    try {
      final response = await dio.post(
        'https://backend.almowafraty.com/api/v1/markets/auth/verify-code',
        data: {
          'verification_code': code,
        },
      );
      if (response.statusCode == 200) {
        var message = response.data['message'];
        emit(VerifyCodeSuccess(massage: message));
        // Navigate to the next page if needed
      } else {
        emit(VerifyCodeFailure('Error: ${response.data['message']}'));
      }
    } on DioException catch (e) {
      emit(VerifyCodeFailure('Error: ${e.response!.data['message']}}'));
    }
  }
}
