import 'package:eghyptproject/Featuer/home/presentation/view/widget/move_photo.dart';

abstract class OffersSliderCompanyState {}

class OffersSliderCompanyInitial extends OffersSliderCompanyState {}

class OffersSliderCompanyLoading extends OffersSliderCompanyState {}

class OffersSliderCompanyLoaded extends OffersSliderCompanyState {
  final List<Offer> offers;

  OffersSliderCompanyLoaded({required this.offers});
}

class OffersSliderCompanyError extends OffersSliderCompanyState {
  final String message;

  OffersSliderCompanyError({required this.message});
}
