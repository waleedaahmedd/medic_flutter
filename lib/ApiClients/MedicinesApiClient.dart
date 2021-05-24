import 'package:flutter/widgets.dart';
import 'package:medic_flutter_app/Responses/MedicineListResponse.dart';
import 'package:medic_flutter_app/baseUrl.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'MedicinesApiClient.g.dart';


@RestApi(baseUrl: BaseUrl.baseUrl)
abstract class MedicinesApiClient {
  factory MedicinesApiClient(Dio dio, {String baseUrl}) = _MedicinesApiClient;

  //factory ApiClient(Dio dio){
  //dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
  //return _ApiClient(dio, baseUrl: baseUrl);

  @GET("medicine/search")
  Future<MedicineListResponse> getMedicineList(@Header("Authorization") String authToken,
      @Query("pageNumber") int pageNumber,
      @Query("categoryId") int categoryId,
      @Query("medicineName") String medicineName
      );
}


