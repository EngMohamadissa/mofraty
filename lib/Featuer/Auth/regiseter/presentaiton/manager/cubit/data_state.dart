abstract class MarketState {}

// Initial State
class MarketInitial extends MarketState {}

// Loading State
class MarketLoadInProgress extends MarketState {}

// Loaded State
class MarketLoadSuccess extends MarketState {
  final List<dynamic> marketCategories;
  final String selectedCategory;
  final List<dynamic> marketCategories2;
  final String selectedCategory2;
  final List<dynamic> marketCategories3;

  final String selectedCategory3;

  MarketLoadSuccess(
      {required this.marketCategories,
      required this.selectedCategory,
      required this.marketCategories2,
      required this.selectedCategory2,
      required this.marketCategories3,
      required this.selectedCategory3});
}

// Error State
class MarketLoadFailure extends MarketState {
  final String error;

  MarketLoadFailure({required this.error});
}
