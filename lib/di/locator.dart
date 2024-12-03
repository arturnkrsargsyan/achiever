import 'package:achiever/presentation/core/router/app_router.dart';
import 'package:get_it/get_it.dart';

abstract class Locator {
  static final _gi = GetIt.instance;

  // Router
  static final router = _gi.get<AppRouter>();
}
