import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fam_app/routes/routes.dart';
import 'package:super_fam_app/routes/routes_names.dart';
import 'package:super_fam_app/services/shared_prefrence.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppPref.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      child: MaterialApp(
        title: 'Politician Poster App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppPrefHelper.getLoggedIn()
            ? RoutesName.homePageScreen
            : RoutesName.phoneNumberScreen,
        onGenerateRoute: Routes.generateRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
