// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../core/repositories/user_repository.dart';
// // تأكد من أن لديك هذا الملف ويحتوي على تعريف LogoutModel

// part 'logout_state.dart';

// class LogoutCubit extends Cubit<LogoutState> {
//   final UserRepository userRepository;

//   LogoutCubit(this.userRepository) : super(LogoutInitial());

//   Future<void> logout() async {
//     emit(LogoutLoading());
//     final result = await userRepository.logOut();
//     result.fold(
//       (failure) => emit(LogoutFailure(errorMessage: failure.getFirstErrorMessage())),
//       (user) => emit(LogoutSuccess(message: 'تم تسجيل الخروج بنجاح')),
//     );
//   }
// }



 // .signUp(
    //   var response = await Dio()
    //       .post('https://almowafraty.com/api/v1/markets/auth/logout');
    //   if (response.statusCode == 200) {
    //     emit(LogoutSuccess(response.data['message']));
    //   } else {
    //     emit(LogoutFailure('Error: Failed to log out'));
    //   }
    // } catch (e) {
    //   emit(LogoutFailure('Exception: Failed to log out'));
    // }
