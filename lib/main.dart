import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/authentication/presentation/controller/auth_cubit.dart';
import 'package:products/authentication/presentation/screens/login_screen.dart';
import 'package:products/block_observer.dart';
import 'package:products/core/local/cache_helper.dart';
import 'package:products/core/services/services_locator.dart';
import 'package:products/products/presentation/controller/product_cubit.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ensure that everything in this function already finished then start application `runApp()`

  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  ServicesLocator().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl<AuthCubit>()),
        BlocProvider(
            create: (context) => sl<ProductCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
        theme: appTheme(),
      ),
    );
  }

  ThemeData appTheme(){
    return ThemeData(
      scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.grey[300],
      )
    );
  }
}
