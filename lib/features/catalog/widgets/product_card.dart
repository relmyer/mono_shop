import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/product.dart';
import 'rating_row.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onFavoriteTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onFavoriteTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = widget.product.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return GestureDetector(
      onTap: () => context.push('/detail', extra: product),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.border.withAlpha(128)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSpacing.cardRadius),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.images.first,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.background,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.background,
                        child: const Icon(
                          Icons.image_outlined,
                          color: AppColors.textMuted,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  // Discount badge
                  if (product.discountPercent != null)
                    Positioned(
                      top: AppSpacing.sm,
                      left: AppSpacing.sm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs + 2,
                            vertical: AppSpacing.xs - 1),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: Text(
                          Formatters.discount(product.discountPercent!),
                          style: AppText.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  // Favorite button
                  Positioned(
                    top: AppSpacing.xs,
                    right: AppSpacing.xs,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _isFav = !_isFav);
                        widget.onFavoriteTap?.call();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(20),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          _isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 18,
                          color: _isFav
                              ? AppColors.wishlistActive
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info section
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md - 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: AppText.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.title,
                    style: AppText.labelMd,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  RatingRow(
                    rating: product.rating,
                    reviewCount: product.reviewCount,
                    compact: true,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Text(
                        Formatters.currency(product.price),
                        style: AppText.priceMd,
                      ),
                      if (product.oldPrice != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          Formatters.currency(product.oldPrice!),
                          style: AppText.priceOld,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
