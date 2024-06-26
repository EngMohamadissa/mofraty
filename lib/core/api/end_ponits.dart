import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndPoint {
  static String baseUrl = "https://backend.almowafraty.com/api/v1/";
  static String signIn = "markets/auth/login";
  static String signUp = "markets/auth/register";
  static String logOut = "markets/auth/logout";
  static String forget = "auth/forget-password";
  static String reset = "markets/auth/reset-password";
  static String refersh = "markets/auth/refresh-token";
  static String showSupplier = "markets/suppliers"; //add id
  static String getAllCollection = "markets/suppliers"; //add type
  static String getBillId = "markets/bills"; //add Id
  static String getBillByStaus = "markets/bills"; //add status
  static String newBillRequest = "markets/bills";
  static String goals = "markets/goals";

  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static String firstname = "first_name";
  static String middlename = "middle_name";
  static String lastname = "last_name";
  static String phonenumber = "phone_number";
  static String password = "password";
  static String confirmPassword = "password_confirmation";
  static String storename = "store_name";
  static String cityid = "city_id";
  static String representatorcode = "representator_code";
  static String marketcategoryid = "market_category_id";
  static String accesstoken = "access_token";
  static String passwordConfirmationMismatch = "password";
  static String phoneNumberEreor = "phone_number";
  static String token = "token";
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String message = "message";
  static String id = "id";
}

class TokenCubit extends Cubit<TokenState> {
  TokenCubit() : super(TokenInitial());

  void getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        emit(TokenLoaded(token));
      } else {
        emit(TokenError('Token not found'));
      }
    } catch (e) {
      emit(TokenError('Error loading token: ${e.toString()}'));
    }
  }
}

abstract class TokenState {}

class TokenInitial extends TokenState {}

class TokenLoaded extends TokenState {
  final String token;

  TokenLoaded(this.token);
}

class TokenError extends TokenState {
  final String message;

  TokenError(this.message);
}
