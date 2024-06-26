import '../../../data/mydata_modle.dart';

abstract class MydataState {}

class MydataInitial extends MydataState {}

class MydataLoading extends MydataState {}

class MydataLoaded extends MydataState {
  final Market market;
  MydataLoaded(this.market);
}

class MydataError extends MydataState {
  final String message;
  MydataError(this.message);
}

class UpdateNameInitial extends MydataState {}

class UpdateNameLoading extends MydataState {}

class UpdateNameSuccess extends MydataState {
  final String message;
  UpdateNameSuccess(this.message);
}

class UpdateNameError extends MydataState {
  final String message;
  UpdateNameError(this.message);
}
