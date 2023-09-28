import 'package:dio/dio.dart';

import '../../../modules/hadiths/model/hadith_model.dart';
import '../../api/dio_consumer.dart';

import '../../api/exceptions.dart';

import 'package:dartz/dartz.dart';

import 'hadiths_repository.dart';

class HadithsRepositoryImpl implements HadithsRepository {
  final DioConsumer dio;

  HadithsRepositoryImpl({required this.dio});
  List<HadithsModel> hadith = [];
  @override
  Future<Either<ServerException, List<HadithsModel>>> hadiths() async {
    try {
     
      hadith = [];
      final res = await dio.get("https://hadis-api-id.vercel.app/hadith");
     for (var element in List.from(res)) {
        hadith.add(HadithsModel.fromJson(element));
      }
      return right(hadith);
    } on DioError catch (e) {
      return left(ServerException(e.message.toString()));
    }
  }
}
