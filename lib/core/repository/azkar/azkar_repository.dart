import 'package:dartz/dartz.dart';

import '../../../modules/azkar/model/azkar_model.dart';
 import '../../api/exceptions.dart';

abstract class AzkarRepository {
  Future<Either<ServerException, List<AzkarModel>>> azkar({required int azkarId,required String lang});
}
