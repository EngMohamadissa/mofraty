// // ignore_for_file: depend_on_referenced_packages

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:eghyptproject/Featuer/Auth/forgetpassword/forget_repo/forget_repo_implement.dart';
// import 'package:flutter/material.dart';
// // ignore: unnecessary_import
// import 'package:meta/meta.dart';
// part 'reset_state.dart';

// class ResetCubit extends Cubit<ResetState> {
//   ResetCubit(this.forgetRepository) : super(ResetInitial());
//   final ForgetRepository forgetRepository;
//   TextEditingController restVertic = TextEditingController();

//   TextEditingController resetpass = TextEditingController();
//   TextEditingController resetConfpass = TextEditingController();
//   reset() async {
//     emit(ResetLoading());
//     final response = await forgetRepository.fogergetPa(
//       phone: resetpass.text,
//       name: resetConfpass.text,
//     );
//     response.fold(
//         (failure) => emit(ResetFailure(errormessage: failure)),
//         (signInModel) => emit(
//               ResetSuccess(message: signInModel.message),
//             ));
//   }
// }
