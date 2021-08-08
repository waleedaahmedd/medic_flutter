// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoriesApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CategoriesApiClient implements CategoriesApiClient {
  _CategoriesApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://medicine-hub-api.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<CategoryListResponse> getCategoryList(authToken) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('category/list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CategoryListResponse.fromJson(_result.data);
    return value;
  }
}
