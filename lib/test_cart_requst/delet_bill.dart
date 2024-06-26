// // الخطوة 1: تعريف الـ States
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../Featuer/Auth/cubit/user_cubit_cubit.dart';

// abstract class BillState {}

// class BillDeletInitial extends BillState {}

// class BillDeletLoading extends BillState {}

// class BillDeletSuccess extends BillState {
//   final String message;

//   BillDeletSuccess(this.message);
// }

// class BillDeletFailure extends BillState {
//   final String errorMessage;

//   BillDeletFailure(this.errorMessage);
// }

// // الخطوة 2: إنشاء الـ Cubit
// class BillCubit extends Cubit<BillState> {
//   final Dio dio;

//   BillCubit(this.dio) : super(BillDeletInitial());

//   void deleteBill(int billId, String token) async {
//     emit(BillDeletLoading());
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.delete(
//         'https://almowafraty.com/api/v1/markets/bills/$billId',
//       );
//       emit(BillDeletSuccess(response.data['message']));
//     } on DioException catch (e) {
//       String errorMessage = ErrorHandler.handleDioError(e);
//       emit(BillDeletFailure(errorMessage));
//     } catch (e) {
//       emit(BillDeletFailure("An unexpected error occurred: ${e.toString()}"));
//     }
//   }
// }

// // الخطوة 3: إنشاء الواجهة
// class BillPage extends StatelessWidget {
//   final int billId;
//   final String token;

//   const BillPage({Key? key, required this.billId, required this.token})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Delete Bill'),
//       ),
//       body: BlocProvider(
//         create: (context) => BillCubit(Dio())..deleteBill(billId, token),
//         child: BlocBuilder<BillCubit, BillState>(
//           builder: (context, state) {
//             if (state is BillDeletLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is BillDeletSuccess) {
//               return Center(child: Text(state.message));
//             } else if (state is BillDeletFailure) {
//               return Center(child: Text(state.errorMessage));
//             } else {
//               return const Center(
//                   child: Text('Press the button to delete the bill.'));
//             }
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => context.read<BillCubit>().deleteBill(billId, token),
//         child: const Icon(Icons.delete),
//       ),
//     );
//   }
// }
