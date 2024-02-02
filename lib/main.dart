import 'package:cloud_pos/route_provider.dart';
import 'package:cloud_pos/routes.dart';
import 'package:cloud_pos/translations/codegen_loader.g.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('th'),
      ],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: routeProvider(),
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Constants.secondaryColor,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        // initialRoute: '/homePage',
        initialRoute: '/loginPage',
        routes: routes,
      ),
    );
  }
}
