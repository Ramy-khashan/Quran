import 'package:dartz/dartz.dart';

import '../../../modules/hadiths/model/hadith_model.dart';
import '../../api/exceptions.dart';

abstract class HadithsRepository {
  Future<Either<ServerException, List<HadithsModel>>> hadiths();
}
