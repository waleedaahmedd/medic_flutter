// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CartApiClient implements CartApiClient {
  _CartApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://medicine-hub-api.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<AddToCartResponse> addToCart(authToken, request) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('cart/add',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddToCartResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CartDetailResponse> getCart(authToken) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('cart/getCart',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CartDetailResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CartDeleteResponse> deleteCart(authToken) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('cart/delete',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CartDeleteResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CartItemDeleteResponse> deleteCartItem(authToken, itemId) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(itemId, 'itemId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'itemId': itemId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('cart/deleteItem/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CartItemDeleteResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<UpdateCartItemResponse> updateCartItem(authToken, request) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('cart/updateItem',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UpdateCartItemResponse.fromJson(_result.data);
    return value;
  }
}
