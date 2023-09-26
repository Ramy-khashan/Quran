import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../api/dio_consumer.dart';

import '../repository/hadiths/hadiths_repository_impl.dart';
import '../repository/hadiths_details/hadiths_details_repository_impl.dart';
import '../repository/reciters_repository/reciters_repository_impl.dart';

final sl = GetIt.instance;
Future<void> serviceLocator() async {
  sl.registerSingleton<DioConsumer>(DioConsumer(client: Dio()));
  sl.registerSingleton<RecitersRepositoryImpl>(
      RecitersRepositoryImpl(dio: sl.get<DioConsumer>()));
  sl.registerSingleton<HadithsRepositoryImpl>(
      HadithsRepositoryImpl(dio: sl.get<DioConsumer>()));
  sl.registerSingleton<HadithsDetailsRepositoryImpl>(
      HadithsDetailsRepositoryImpl(dio: sl.get<DioConsumer>()));
}