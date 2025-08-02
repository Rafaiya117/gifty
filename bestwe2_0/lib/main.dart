import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/app_State/chat_state.dart';
import 'package:bestwe2_0/app_route/app_route.dart';
import 'package:bestwe2_0/app_route/connectivity/no_connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationState()),
        // ChangeNotifierProvider(create: (_) => ChatState()), // Added here
      ],
      child: MyApp(),
    ),
  );
}


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load();
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ApplicationState(),
//       child: MyApp(),
//     ),
//   );
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasConnection = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((status) {
      setState(() {
        hasConnection = status != ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkConnectivity() async {
    final status = await Connectivity().checkConnectivity();
    setState(() {
      hasConnection = status != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 892),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Bestowe',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: appRouter, 
          builder: (context, child) {
            return hasConnection ? child! : const NoInternetWidget();
          },
        );
      },
    );
  }
}
