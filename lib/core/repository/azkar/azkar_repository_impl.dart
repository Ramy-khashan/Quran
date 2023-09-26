import 'package:dio/dio.dart';
import 'package:quran_app/modules/azkar/model/azkar_model.dart';

import '../../api/dio_consumer.dart';

import '../../api/exceptions.dart';

import 'package:dartz/dartz.dart';

import 'azkar_repository.dart';

class AzkarRepositoryImpl implements AzkarRepository {
  final DioConsumer dio;

  AzkarRepositoryImpl({required this.dio});
  List<AzkarModel> azkarList = [];
  @override
  Future<Either<ServerException,  List<AzkarModel> >> azkar(
      {required int azkarId,required String lang}) async {
    try {
      azkarList = [];
      Map res =
          await dio.get("https://www.hisnmuslim.com/api/$lang/$azkarId.json");

      for (var element in List.from(res.entries.first.value)) {
        azkarList.add(AzkarModel.fromJson(element));
      }
      return right(  azkarList );
    } on DioError catch (e) {
      return left(ServerException(e.message.toString()));
    }
  }
}
