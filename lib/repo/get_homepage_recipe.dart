import 'package:dio/dio.dart';
import 'package:app/api/api_key.dart';
import 'package:app/models/faliure.dart';
import 'package:app/models/food_type.dart';
import 'package:app/repo/get_recipe_info.dart';

class GetHomeRecipes {
  final String key = ApiKey.keys;
  final Dio dio = Dio();

  Future<FoodTypeList> getRecipes(String type, int no) async {
    final url =
        '$BASE_URL/random?number=$no&tags=$type&apiKey=$key';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return FoodTypeList.fromJson(response.data['recipes']);
    } else if (response.statusCode == 401) {
      throw Failure(
        code: 401,
        message: response.data['message'],
      );
    } else {
      throw Failure(
        code: response.statusCode ?? 0,
        message: response.statusMessage ?? 'Unknown error',
      );
    }
  }
}