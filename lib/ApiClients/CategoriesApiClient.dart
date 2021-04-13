import 'package:medic_flutter_app/Responses/CategoryListResponse.dart';
import 'package:medic_flutter_app/baseUrl.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'CategoriesApiClient.g.dart';

@RestApi(baseUrl: BaseUrl.baseUrl)
abstract class CategoriesApiClient {
  factory CategoriesApiClient(Dio dio, {String baseUrl}) = _CategoriesApiClient;

  //factory ApiClient(Dio dio){
  //dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
  //return _ApiClient(dio, baseUrl: baseUrl);

  @GET("category/list")
  Future<CategoryListResponse> getCategoryList(
      @Header("Authorization") String authToken);
}
