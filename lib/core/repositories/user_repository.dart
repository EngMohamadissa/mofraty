// import 'package:dartz/dartz.dart';
// import 'package:eghyptproject/core/cache/cache_helper.dart';
// import 'package:eghyptproject/core/errors/error_model.dart';

// import '../../Featuer/Auth/data/model/user_model.dart';
// import '../api/api_consumer.dart';
// import '../api/end_ponits.dart';
// import '../errors/exceptions.dart';

// class UserRepository {
//   final ApiConsumer api;

//   UserRepository({required this.api});
//   Future<Either<ErrorModel, SignInModel>> signIn({
//     required String phone,
//     required String password,
//   }) async {
//     try {
//       final response = await api.post(
//         EndPoint.signIn,
//         isFromData: true,
//         data: {
//           ApiKey.phonenumber: phone,
//           ApiKey.password: password,
//         },
//       );
//       final user = SignInModel.fromJson(response);
//       // final decodedToken = JwtDecoder.decode(user.token);
//       CacheHelper().saveData(key: ApiKey.accesstoken, value: user.accessToken);
//       // CacheHelper().saveData(key: ApiKey.accesstoken, value: user.market.id);

//       // CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
//       return Right(user);
//     } on ServerException catch (e) {
//       final validationError = ErrorModel.fromJson(e.errModel.errors);
//       return Left(validationError);
//     }
//   }

//   Future<Either<ErrorModel, SignInModel>> logOut() async {
//     try {
//       final response = await api.get(EndPoint.logOut);
//       final user = SignInModel.fromJson(response);
//       return Right(user);
//     } on ServerException catch (e) {
//       final validationError = ErrorModel.fromJson(e.errModel.errors);
//       return Left(validationError);
//     }
//   }

//   Future<Either<ErrorModel, SignInModel>> signUp({
//     required String signUpfirstname,
//     required String signUpmidllename,
//     required String signUplastname,
//     required String signUpphonenumber,
//     required String signUppassword,
//     required String signUppasswordconfirmation,
//     required String signUpstorename,
//     required String signUpcityid,
//     required String signUprepresentatorcode,
//     required String signUpmarketcategoryid,
//   }) async {
//     try {
//       final response = await api.post(
//         EndPoint.signUp,
//         isFromData: true,
//         data: {
//           ApiKey.firstname: signUpfirstname,
//           ApiKey.middlename: signUpmidllename,
//           ApiKey.lastname: signUplastname,
//           ApiKey.phonenumber: signUpphonenumber,
//           ApiKey.password: signUppassword,
//           ApiKey.confirmPassword: signUppasswordconfirmation,
//           ApiKey.storename: signUpstorename,
//           ApiKey.cityid: signUpcityid,
//           ApiKey.representatorcode: signUprepresentatorcode,
//           ApiKey.marketcategoryid: signUpmarketcategoryid,
//         },
//       );
//       final signUPModel = SignInModel.fromJson(response);
//       return Right(signUPModel);
//     } on ServerException catch (e) {
//       final validationError = ErrorModel.fromJson(e.errModel.errors);
//       return Left(validationError);
//     }
//   }
// }


// //   Future<Either<String, UserModel>> getUserProfile() async {
// //     try {
// //       final response = await api.get(
// //         EndPoint.getUserDataEndPoint(
// //           CacheHelper().getData(key: ApiKey.id),
// //         ),
// //       );
// //       return Right(UserModel.fromJson(response));
// //     } on ServerException catch (e) {
// //       return Left(e.errModel.errorMessage);
// //     }
// //   }
// // }

