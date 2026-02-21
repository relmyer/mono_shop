import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/catalog/state/cart_state.dart';

class MonoShopApp extends StatelessWidget {
  const MonoShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartState()),
      ],
      child: MaterialApp.router(
        title: 'Mono Shop',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
