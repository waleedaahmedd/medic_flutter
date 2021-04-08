import 'dart:html';

import 'package:medic_flutter_app/Requests/RegisterUserRequest.dart';
import 'package:medic_flutter_app/Responses/CategoryListResponse.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../baseUrl.dart';

part 'CategoriesApiClient.g.dart';

@RestApi(baseUrl: BaseUrl.baseUrl)
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  //factory ApiClient(Dio dio){
  //dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
  //return _ApiClient(dio, baseUrl: baseUrl);
  @GET("category/list")
  Future<CategoryListResponse> getCategoryList(
      @Header("Authorization") String authToken);
}
