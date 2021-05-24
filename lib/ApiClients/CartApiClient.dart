/*
import 'package:flutter/widgets.dart';
import 'package:medic_flutter_app/baseUrl.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'CartApiClient.g.dart';

@RestApi(baseUrl: BaseUrl.baseUrl)
abstract class CartApiClient {
  factory CartApiClient(Dio dio, {String baseUrl}) = _CartApiClient;

  //factory ApiClient(Dio dio){
  //dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
  //return _ApiClient(dio, baseUrl: baseUrl);

  @POST("cart/add")
  Future<AddToCartResponse> addToCart(@Header("Authorization") String authToken,
      @Body() AddToCartRequest request);

  @GET("cart/getCart")
  Future<CartDetailResponse> getCart(@Header("Authorization") String authToken);

  @DELETE("cart/delete")
  Future<CartDeleteResponse> deleteCart(
      @Header("Authorization") String authToken);

  @DELETE("cart/deleteItem/")
  Future<CartItemDeleteResponse> deleteCartItem(
      @Header("Authorization") String authToken, @Query("itemId") int itemId);

  @PUT("cart/updateItem")
  Future<UpdateCartItemResponse> updateCartItem(
      @Header("Authorization") String authToken,
      @Body() UpdateCartItemRequest request);
}
*/
