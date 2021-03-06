import 'package:medic_flutter_app/Requests/LoginUserRequest.dart';
import 'package:medic_flutter_app/Requests/RegisterUserRequest.dart';
import 'package:medic_flutter_app/Responses/LoginUserResponse.dart';
import 'package:medic_flutter_app/Responses/RegisterUserResponse.dart';
import 'package:medic_flutter_app/baseUrl.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'UserApiClient.g.dart';

@RestApi(baseUrl: BaseUrl.baseUrl)
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  //factory ApiClient(Dio dio){
  //dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
  //return _ApiClient(dio, baseUrl: baseUrl);
  @POST("auth/register")
  Future<RegisterUserResponse> registerUser(
      @Body() RegisterUserRequest request);

  @POST("auth/login")
  Future<LoginUserResponse> loginUser(@Body() LoginUserRequest request);

/*@GET("category/list")
  Future<CategoryListResponse> getCategoryList(
      @Header("Authorization") String authToken);*/

}
