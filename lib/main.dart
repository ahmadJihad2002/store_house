import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_constant.dart';
import 'package:store_house/firebase_options.dart';
import 'package:store_house/src/features/account/presentation/bloc/account_cubit.dart';
import 'package:store_house/src/features/auth/pesentation/pages/login/login.dart';
 import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/edit_cubit/edit_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/root_cubit/root_app_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_cuit.dart';
import 'package:store_house/src/root_app.dart';

import 'core/services/cache_helper.dart';
import 'src/features/auth/pesentation/bloc/login/login_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  Widget staringScreen;

  AppConstant.token = await CacheHelper.getData(key: 'token');

  if (AppConstant.token.isEmpty) {
    staringScreen = LoginPage();
  } else {
    staringScreen = RootApp();
  }
  runApp(MyApp(startWidget: staringScreen));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppCubit()),
          BlocProvider(create: (_) => AccountCubit()..getUserInfo()),
          BlocProvider(create: (_) => GoodsCubit()..getAllGoods()),
          BlocProvider(create: (_) => LoginCubit()),
          BlocProvider(create: (_) => RootAppCubit()..init()),
          BlocProvider(create: (_) => EditUnitCubit()),
          BlocProvider(create: (_) => TransactionCubit()..getAllTransactions()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                  displayLarge: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(color: Colors.blue),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(),
            ),
            themeMode: ThemeMode.light,
            darkTheme: ThemeData(),
            home: startWidget));
  }
}
