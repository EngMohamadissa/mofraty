// import 'package:dartz/dartz.dart';
// import 'package:eghyptproject/Featuer/Auth/data/model/user_model.dart';
// import 'package:eghyptproject/core/errors/error_model.dart';

// import '../../../../core/api/api_consumer.dart';
// import '../../../../core/api/end_ponits.dart';
// import '../../../../core/errors/exceptions.dart';

// class ForgetRepository {
//   final ApiConsumer api;

//   ForgetRepository({required this.api});

//   Future<Either<String, SignInModel>> fogergetPa({
//     required String phone,
//     required String name,
//   }) async {
//     try {
//       final response = await api.post(
//         EndPoint.forget,
//         isFromData: true,
//         data: {
//           ApiKey.phonenumber: phone,
//           ApiKey.firstname: name,
//         },
//       );
//       final user = SignInModel.fromJson(response);
//       return Right(user);
//     } on ServerException catch (e) {
//       final validationError = ErrorModel.fromJson(e.errModel.errors);
//       return Left(validationError.getFirstErrorMessage());
//     }
//   }

//   Future<Either<String, SignInModel>> resetPassword({
//     required String password,
//     required String confPassword,
//   }) async {
//     try {
//       final response = await api.post(
//         EndPoint.forget,
//         isFromData: true,
//         data: {
//           ApiKey.phonenumber: password,
//           ApiKey.firstname: confPassword,
//         },
//       );
//       final user = SignInModel.fromJson(response);
//       return Right(user);
//     } on ServerException catch (e) {
//       final validationError = ErrorModel.fromJson(e.errModel.errors);
//       return Left(validationError.getFirstErrorMessage());
//     }
//   }
// }
