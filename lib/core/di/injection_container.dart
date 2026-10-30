import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tickify_task/core/di/injection_container.config.dart';


final getIt = GetIt.instance;

@InjectableInit()
Future<GetIt> configureDependencies() async => getIt.init();