import 'package:dartz/dartz.dart';

import '../../../modules/hadith_details/model/hadith_details_model.dart';
 import '../../api/exceptions.dart';

abstract class HadithsDetailsRepository {
  Future<Either<ServerException, List<HadithsDetailsModel>>> hadithsDetails({required String name,required int page,required int limit});
}
