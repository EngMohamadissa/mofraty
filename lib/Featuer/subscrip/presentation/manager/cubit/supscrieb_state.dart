part of 'supscrieb_cubit.dart';

abstract class SupscriepState {}

class SubscripInitial extends SupscriepState {}

class SubscripLoading extends SupscriepState {}

class SubscripSucces extends SupscriepState {
  final String message;

  SubscripSucces({required this.message});
}

class SubscpriFailure extends SupscriepState {
  final String massage;

  SubscpriFailure(this.massage);
}










// abstract class MydataState {}

// class MydataInitial extends MydataState {}

// class MydataLoading extends MydataState {}

// class MydataLoaded extends MydataState {
//   final Market market;
//   MydataLoaded(this.market);
// }

// class MydataError extends MydataState {
//   final String message;
//   MydataError(this.message);
// }