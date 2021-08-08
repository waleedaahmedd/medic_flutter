// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MedicinesApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MedicinesApiClient implements MedicinesApiClient {
  _MedicinesApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://medicine-hub-api.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<MedicineListResponse> getMedicineList(
      authToken, pageNumber, categoryId, medicineName) async {
    ArgumentError.checkNotNull(authToken, 'authToken');
    ArgumentError.checkNotNull(pageNumber, 'pageNumber');
    ArgumentError.checkNotNull(categoryId, 'categoryId');
    ArgumentError.checkNotNull(medicineName, 'medicineName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageNumber': pageNumber,
      r'categoryId': categoryId,
      r'medicineName': medicineName
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('medicine/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': authToken},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MedicineListResponse.fromJson(_result.data);
    return value;
  }
}
