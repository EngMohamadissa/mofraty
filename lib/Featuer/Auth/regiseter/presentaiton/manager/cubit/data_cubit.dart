import 'package:dio/dio.dart';
import 'package:eghyptproject/Featuer/Auth/cubit/user_cubit_cubit.dart';
import 'package:eghyptproject/Featuer/Auth/regiseter/presentaiton/manager/cubit/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCubit extends Cubit<MarketState> {
  final Dio dio;

  DataCubit(this.dio) : super(MarketInitial());

  void fetchMarketCategories() async {
    emit(MarketLoadInProgress());
    try {
      const String url =
          'https://backend.almowafraty.com/api/v1/markets/auth/register';
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final List<dynamic> marketCategories =
            response.data['market_categories'];
        final List<dynamic> marketCategories2 = response.data['cities'];

        final idstor = marketCategories[0]['id'].toString();
        await prefs.setString('storeid', idstor);

        final List<dynamic> marketCategories3 = marketCategories2.isNotEmpty
            ? marketCategories2
                .firstWhere((city) => city['name'] == 'الأسكندرية')['childrens']
            : [];
        final idcity = marketCategories3[0]['id'].toString();

        await prefs.setString('codid', idcity);
        if (marketCategories.isNotEmpty) {
          emit(MarketLoadSuccess(
            marketCategories2: marketCategories2,
            selectedCategory2: marketCategories2[0]['id'].toString(),
            marketCategories: marketCategories,
            selectedCategory: marketCategories[0]['id'].toString(),
            selectedCategory3: marketCategories3[0]['id'].toString(),
            marketCategories3: marketCategories3,
          ));
        } else {
          emit(MarketLoadFailure(error: 'No categories found.'));
        }
      } else {
        emit(MarketLoadFailure(
            error:
                'Failed to load data: HTTP status code ${response.statusCode}'));
      }
    } on DioException catch (e) {
      String errorMessage = ErrorHandler.handleDioError(e);
      emit(MarketLoadFailure(error: errorMessage));
    } catch (e) {
      emit(MarketLoadFailure(
          error: "An unexpected error occurred: ${e.toString()}"));
    }
  }
}
