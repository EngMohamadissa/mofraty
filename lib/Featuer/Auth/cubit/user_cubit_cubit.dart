import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/data/model/user_model.dart';
import 'package:eghyptproject/core/api/api_consumer.dart';
import 'package:eghyptproject/core/api/end_ponits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_cubit_state.dart';

class UserCubitCubit extends Cubit<UserCubitState> {
  UserCubitCubit({required this.api}) : super(UserInitial());
  // final SharedPreferences prefs;
  //  UserRepository userRepository;
  final ApiConsumer api;
//Sign up phone number
  TextEditingController signUpfirstname = TextEditingController();
  TextEditingController signUpmidllename = TextEditingController();
  TextEditingController signUplastname = TextEditingController();
  TextEditingController signUpphonenumber = TextEditingController(text: '+20');
  TextEditingController signUppassword = TextEditingController();
  TextEditingController signUppasswordconfirmation = TextEditingController();
  TextEditingController signUpstorename = TextEditingController();
  TextEditingController signUpcityid = TextEditingController();
  TextEditingController signUpmarketcategoryid = TextEditingController();
  TextEditingController signUpAria = TextEditingController();
  TextEditingController signUprepresentatorcode = TextEditingController();

//signInController
  TextEditingController signInphonenumber = TextEditingController(text: '+20');
  TextEditingController signInpassword = TextEditingController();
//foget
  TextEditingController forgetPhon = TextEditingController(text: '+20');
  TextEditingController forgetfirstname = TextEditingController();
//vertic
  TextEditingController restVertic = TextEditingController();
//reset
  TextEditingController resetpass = TextEditingController();
  TextEditingController resetConfpass = TextEditingController(text: '+20');

  signUp(String cityID, String marketId) async {
    emit(SignUpLoading());

    // try {
    //   final response = await Dio()
    //       .post('https://backend.almowafraty.com/api/v1/markets/auth/register',
    //           // isFromData: true,
    //           data: {
    //         'first_name': signUpfirstname.text,
    //         'middle_name': signUpmidllename.text,
    //         'last_name': signUplastname.text,
    //         'phone_number': signUpphonenumber.text,
    //         'password': signUppassword.text,
    //         'password_confirmation': signUppasswordconfirmation.text,
    //         'store_name': signUpstorename.text,
    //         'city_id': cityID,
    //         'market_category_id': marketId,
    //         // 'location_details': signUpAria.text,
    //         // 'representator_code': signUprepresentatorcode.text,

    //       }

    //       );
    //   String successMessage = response.data['message'];
    //   emit(SignUpSuccess(successMessage));

    //   return response;
    // }
    try {
      final prefs = await SharedPreferences.getInstance();

      final data = {
        'first_name': signUpfirstname.text,
        'middle_name': signUpmidllename.text,
        'last_name': signUplastname.text,
        'phone_number': signUpphonenumber.text,
        'password': signUppassword.text,
        'password_confirmation': signUppasswordconfirmation.text,
        'store_name': signUpstorename.text,
        'city_id': cityID,
        'market_category_id': marketId,
        if (signUpAria.text.isNotEmpty) 'location_details': signUpAria.text,
        if (signUprepresentatorcode.text.isNotEmpty)
          'representator_code': signUprepresentatorcode.text,
        'deviceToken': prefs.getString('divicetoken'),
      };

      final response = await Dio().post(
        'https://backend.almowafraty.com/api/v1/markets/auth/register',
        data: data,
      );

      String successMessage = response.data['message'];
      emit(SignUpSuccess(successMessage));

      return response;

      // ... بقية الكود
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(SignUpFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(SignUpFailure(
          errorMessage: "An unexpected error occurred: ${e.toString()}"));
    }
    // final response = await userRepository.signUp(
    //   signUpfirstname: signUpfirstname.text,
    //   signUpmidllename: signUpmidllename.text,
    //   signUplastname: signUplastname.text,
    //   signUpphonenumber: signUpphonenumber.text,
    //   signUppassword: signUppassword.text,
    //   signUppasswordconfirmation: signUppasswordconfirmation.text,
    //   signUpstorename: signUpstorename.text,
    //   signUpcityid: signUpcityid.text,
    //   signUprepresentatorcode: signUprepresentatorcode.text,
    //   signUpmarketcategoryid: signUpmarketcategoryid.text,
    // );

    // response.fold(
    //   (failure) => emit(SignUpFailure(errorMessage: failure.message)),
    //   (signUpModel) => emit(SignUpSuccess(message: signUpModel.message)),
    // );
  }

  signIn() async {
    try {
      emit(SignInLoading());
      final response = await Dio().post(
        'https://backend.almowafraty.com/api/v1/markets/auth/login',
        data: {
          ApiKey.phonenumber: signInphonenumber.text,
          ApiKey.password: signInpassword.text
        },
      );
      final data = response.data;
      final token = data['access_token'];
      final userId = data['market']['id'];

      if (response.statusCode == 200) {
        print(response.data['message']);
        final loginResponse = LoginResponse.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();
        var message = loginResponse.message;
        await prefs.setString('access_token', token);
        await prefs.setInt('id', userId);

        emit(SignInSuccess(loginResponse, message, token, userId));
      } else {
        emit(SignInFailure(errorMessage: "Invalid status code"));
      }
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(SignInFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(SignInFailure(
          errorMessage: "An unexpected error occurred: ${e.toString()}"));
    }
  }
  // signIn() async {
  //   emit(SignInLoading());
  //   try {
  //     final response = await api.post(EndPoint.signIn, isFromData: true, data: {
  //       ApiKey.phonenumber: signInphonenumber.text,
  //       ApiKey.password: signInpassword.text
  //     });
  //     String successMessage = response.data['message'];

  //     emit(SignInSuccess());
  //     return response;
  //   } on DioException catch (e) {
  //     String errorMessage = ErrorHandler.handleDioError(e);
  //     emit(SignInFailure(errorMessage: errorMessage));
  //   } catch (e) {
  //     emit(SignInFailure(
  //         errorMessage: "An unexpected error occurred: ${e.toString()}"));
  //   }
  // }
  // final response = await userRepository.signIn(
  //   phone: signInphonenumber.text,
  //   password: signInpassword.text,
  // );

  // response.fold(
  //     (errMessage) => emit(SignInFailure(errorMessage: errMessage.message)),
  //     (signInModel) => emit(
  //           SignInSuccess(message: signInModel.message),
  //         ));

  // emit(LogoutLoading());
  // final result = await UserRepository(api: ApiConsumer()).logOut();
  // result.fold(
  //   (failure) => emit(LogoutFailure(errorMessage: failure.getFirstErrorMessage())),
  //   (user) => emit(LogoutSuccess(message: 'تم تسجيل الخروج بنجاح')),
  // );
  logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs
        .getString('access_token'); // Retrieve token from shared preferences

    if (token == null) {
      emit(LogoutFailure(errorMessage: 'Authentication token not found'));
      return;
    }

    // Dio().options.headers['Authorization'] = 'Bearer $token';

    emit(LogoutLoading());
    try {
      final response = await Dio().get(
        'https://backend.almowafraty.com/api/v1/markets/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Remove the token from SharedPreferences after successful logout
      await prefs.remove('access_token');

      emit(LogoutSuccess(message: response.data['message']));
      return response.data;
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(LogoutFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(LogoutFailure(
          errorMessage: "An unexpected error occurred: ${e.toString()}"));
    }
  }

  forget() async {
    emit(ForgetLoading());
    try {
      final response = await Dio().post(
        'https://backend.almowafraty.com/api/v1/markets/auth/forget-password',
        data: {
          'phone': forgetPhon.text,
          'name': forgetfirstname.text,
        },
      );

      emit(ForgetSuccess(message: response.data['message']));
      return response.data;
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(ForgetFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(ForgetFailure(
          errorMessage: "An unexpected error occurred: ${e.toString()}"));
    }
  }

  reset() async {
    emit(ResetLoading());
    try {
      final response = await Dio().post(
        'https://backend.almowafraty.com/api/v1/markets/auth/forget-password',
        data: {
          ApiKey.password: resetpass.text,
          ApiKey.phonenumber: resetConfpass.text,
        },
      );
      // final user = SignInModel.fromJson(response);
      return response.data;
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(ResetFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(ResetFailure(
          errorMessage: "An unexpected error occurred: ${e.toString()}"));
    }
  }

  Future<void> verifyCode(String code, String token) async {
    emit(VerifyCodeLoading());
    try {
      final response = await Dio().post(
        'https://backend.almowafraty.com/api/v1/markets/auth/verify-code',
        data: {
          'verification_code': code,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // هنا تم إضافة الـ token
          },
        ),
      );
      if (response.statusCode == 200) {
        emit(VerifyCodeSuccess());
      } else {
        emit(VerifyCodeFailure(response.data['message']));
      }
    } catch (e) {
      // emit(VerifyCodeFailure(e.response.data['message']));
      emit(VerifyCodeFailure('حدث خطأ أثناء التحقق من الكود.'));
    }
  }
}

class ErrorHandler implements Exception {
  static String handleDioError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      return extractErrorMessage(e.response);
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "انتهى وقت الاتصال بالخادم";
      case DioExceptionType.sendTimeout:
        return "انتهى وقت إرسال الطلب إلى الخادم";
      case DioExceptionType.receiveTimeout:
        return "انتهى وقت استقبال الرد من الخادم";
      case DioExceptionType.badCertificate:
        return "شهادة الأمان غير صالحة";
      case DioExceptionType.cancel:
        return "تم إلغاء الطلب إلى الخادم";
      case DioExceptionType.connectionError:
        return " خطأ في الإتصال بالخادم تأكد من الاتصال من الانترنت";
      case DioExceptionType.unknown:
        return "فشل الإتصال بالخادم او مشكلة في الإتصال بالإنترنت";
      default:
        return "حدث خطأ غير متوقع";
    }
  }

  static String extractErrorMessage(Response? response) {
    if (response != null && response.data is Map) {
      var responseData = response.data;
      String message = responseData['message'] ?? "حدث خطأ غير متوقع";

      if (responseData.containsKey('errors')) {
        var errors = responseData['errors'];
        if (errors is Map && errors.isNotEmpty) {
          var firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            message += ": ${firstError.first}";
          }
        }
      }
      return message;
    }
    return "حدث خطأ دون معلومات إضافية";
  }
}
