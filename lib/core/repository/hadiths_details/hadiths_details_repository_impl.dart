import 'package:dio/dio.dart';

import '../../../modules/hadith_details/model/hadith_details_model.dart';
 import '../../api/dio_consumer.dart';

import '../../api/exceptions.dart';

import 'package:dartz/dartz.dart';

import 'hadiths_details_repository.dart';

class HadithsDetailsRepositoryImpl implements HadithsDetailsRepository {
  final DioConsumer dio;

  HadithsDetailsRepositoryImpl({required this.dio});
  List<HadithsDetailsModel> hadiths = [];
  @override
  Future<Either<ServerException, List<HadithsDetailsModel>>> hadithsDetails(
      {required String name, required int page, required int limit}) async {
    try {
      hadiths = [];
      final res = await dio.get(
          "https://hadis-api-id.vercel.app/hadith/$name?page=$page&limit=$limit");
      
      for (var element in List.from(res["items"])) {
        hadiths.add(HadithsDetailsModel.fromJson(element));
      }
      return right(hadiths);
    } on DioError catch (e) {
      return left(ServerException(e.message.toString()));
    }
  }
}
