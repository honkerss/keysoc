import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:keysoc/helper/object_box.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingletonAsync<ObjectBox>(() async => ObjectBox.init());
}
