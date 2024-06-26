import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';

abstract class OffersSliderState {}

class OffersSliderInitial extends OffersSliderState {}

class OffersSliderLoading extends OffersSliderState {}

class OffersSliderLoaded extends OffersSliderState {
  final List<Offer> offers;

  OffersSliderLoaded({required this.offers});
}

class OffersSliderError extends OffersSliderState {
  final String message;

  OffersSliderError({required this.message});
}
