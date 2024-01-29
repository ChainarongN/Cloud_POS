import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'providers/provider.dart';
import 'repositorys/repository.dart';

List<SingleChildWidget> routeProvider() {
  return [
    ChangeNotifierProvider(create: (_) => HomeProvider(HomeRepository())),
    ChangeNotifierProvider(create: (_) => MenuProvider(MenuRepository())),
    ChangeNotifierProvider(create: (_) => LoginProvider(LoginRepository())),
    ChangeNotifierProvider(create: (_) => ConfigProvider(ConfigRepository())),
  ];
}
