import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../models/product.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsets? padding;

  const ProductGrid({
    super.key,
    required this.products,
    this.physics,
    this.shrinkWrap = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics ?? const NeverScrollableScrollPhysics(),
      padding: padding ?? EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onFavoriteTap: () {
            product.isFavorite = !product.isFavorite;
          },
        );
      },
    );
  }
}
