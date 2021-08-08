// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrdersApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OrdersApiClient implements OrdersApiClient {
  _OrdersApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://medicine-hub-api.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<OrderResponse> placeOrder(authToken, request) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('order/placeOrder',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrderResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetOrderByUserResponse> getOrdersByUser(authToken, pageNumber) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'pageNumber': pageNumber};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'order/getOrdersByUser',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetOrderByUserResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<OrderDetailsResponse> getOrdersDetail(authToken, orderId) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderId': orderId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'order/getOrderDetails',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrderDetailsResponse.fromJson(_result.data);
    return value;
  }
}
