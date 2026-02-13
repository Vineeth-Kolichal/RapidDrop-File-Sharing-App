import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependency_injection/config/configure_injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/theme.dart';
import 'features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Text styles
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    //Theme
    AppTheme theme = AppTheme(appTextTheme);
    return MultiBlocProvider(
      // Providing multiple blocs at the root of the widget tree
      providers: [BlocProvider(create: (context) => getIt<NumberTriviaBloc>())],
      child: MaterialApp.router(
        title: "App title",
        themeMode: ThemeMode.system,
        theme: theme.light(),
        darkTheme: theme.dark(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}


