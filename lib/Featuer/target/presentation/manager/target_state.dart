import '../../data/target_model.dart';

abstract class GoalState {}

class GoalInitial extends GoalState {}

class GoalLoading extends GoalState {}

class GoalLoaded extends GoalState {
  final List<Goal> goals;
  GoalLoaded(this.goals);
}

class GoalError extends GoalState {
  final String message;
  GoalError({required this.message});
}
