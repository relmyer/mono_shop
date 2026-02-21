import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color bgColor;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.bgColor,
  });
}

class CategoryData {
  static const List<Category> all = [
    Category(
      id: 'sports',
      name: 'Sports',
      icon: Icons.sports_soccer_outlined,
      bgColor: AppColors.catSports,
    ),
    Category(
      id: 'electronics',
      name: 'Electronics',
      icon: Icons.headphones_outlined,
      bgColor: AppColors.catElectronics,
    ),
    Category(
      id: 'jewelry',
      name: 'Jewelry',
      icon: Icons.diamond_outlined,
      bgColor: AppColors.catJewelry,
    ),
    Category(
      id: 'fashion',
      name: "Men's",
      icon: Icons.checkroom_outlined,
      bgColor: AppColors.catFashion,
    ),
    Category(
      id: 'beauty',
      name: 'Beauty',
      icon: Icons.spa_outlined,
      bgColor: AppColors.catBeauty,
    ),
    Category(
      id: 'home',
      name: 'Home',
      icon: Icons.home_outlined,
      bgColor: AppColors.catHome,
    ),
    Category(
      id: 'auto',
      name: 'Automotive',
      icon: Icons.directions_car_outlined,
      bgColor: AppColors.catAuto,
    ),
    Category(
      id: 'more',
      name: 'More',
      icon: Icons.grid_view_rounded,
      bgColor: AppColors.catMore,
    ),
  ];

  static const List<String> chipLabels = [
    'All',
    'Shoes',
    'Watches',
    'Bags',
    'Clothing',
    'Accessories',
  ];
}
