import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/catalog/screens/home_screen.dart';
import '../../features/catalog/screens/catalog_screen.dart';
import '../../features/catalog/screens/product_detail_screen.dart';
import '../../models/product.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String catalog = '/catalog';
  static const String productDetail = '/detail';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        path: catalog,
        name: 'catalog',
        pageBuilder: (context, state) {
          final category = state.extra as String?;
          return MaterialPage(
            child: CatalogScreen(initialCategory: category),
          );
        },
      ),
      GoRoute(
        path: productDetail,
        name: 'productDetail',
        pageBuilder: (context, state) {
          final product = state.extra as Product;
          return MaterialPage(
            child: ProductDetailScreen(product: product),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
