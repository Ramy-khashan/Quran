import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/home_page/cubit/homepage_cubit.dart';

import 'config/change_theme/changetheme_cubit.dart';
import 'config/change_theme/changetheme_states.dart';
 import 'core/utils/app_string.dart';
 import 'modules/navigator_bar/view/navigator_bar.dart';
 
class QuranApp extends StatefulWidget {
  const QuranApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  @override
  void initState() {
    super.initState();
    QuranApp.navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChangeTheme(),
        ),
        BlocProvider(
          create: (context) => HomepageCubit()..getLocationAndPrayTime()..timeStream()
            ..getSavedLocation()
            ..getTime(),
        ),
       
      ],
      child: MaterialApp(
        title: AppString.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: BlocBuilder<ChangeTheme, ChangeThemeState>(
          builder: (context, state) {
            return const NavigatorBarScreen();
          },
        ),
      ),
    );
  }
}
