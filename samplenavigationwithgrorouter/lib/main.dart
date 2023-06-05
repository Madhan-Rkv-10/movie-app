import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Home/controller/provider/providers.dart';
import 'app_router.dart';
import 'color.dart';

Future main() async {
  await dotenv.load();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp.router(
      // routerConfig: goRouter,
      //      NyAppRouter.returnRouter(false).routeInformationParser,
      // routerDelegate: NyAppRouter.returnRouter(false).routerDelegate,
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
