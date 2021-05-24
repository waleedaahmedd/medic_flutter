/*
import 'package:flutter/widgets.dart';
import 'package:medic_flutter_app/baseUrl.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'OrdersApiClient.g.dart';

@RestApi(baseUrl: BaseUrl.baseUrl)
abstract class OrdersApiClient {
  factory OrdersApiClient(Dio dio, {String baseUrl}) = _OrdersApiClient;

  //factory ApiClient(Dio dio){
  //dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
  //return _ApiClient(dio, baseUrl: baseUrl);
  @POST("order/placeOrder")
  Future<OrderResponse> placeOrder(
      @Header("Authorization") String authToken, @Body() OrderRequest request);

  @GET("order/getOrdersByUser")
  Future<GetOrderByUserResponse> getOrdersByUser(
      @Header("Authorization") String authToken,
      @Query("pageNumber") int pageNumber);

  @GET("order/getOrderDetails")
  Future<OrderDetailsResponse> getOrdersDetail(
      @Header("Authorization") String authToken, @Query("orderId") int orderId);
}
*/
