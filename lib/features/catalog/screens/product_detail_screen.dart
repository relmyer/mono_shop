import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/product.dart';
import '../state/cart_state.dart';
import '../widgets/rating_row.dart';
import '../widgets/size_selector.dart';
import '../widgets/quantity_stepper.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/outline_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  String? _selectedSize;
  int _quantity = 1;
  late bool _isFav;
  bool _descExpanded = false;

  @override
  void initState() {
    super.initState();
    _isFav = widget.product.isFavorite;
    if (widget.product.sizes.isNotEmpty) {
      _selectedSize = widget.product.sizes.first;
    }
  }

  void _addToCart(BuildContext context) {
    if (_selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a size')),
      );
      return;
    }
    context.read<CartState>().addItem(
          widget.product,
          _selectedSize!,
          quantity: _quantity,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to cart!'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 320,
                  pinned: true,
                  backgroundColor: AppColors.surface,
                  leading: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(230),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.iconBtnRadius),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        setState(() => _isFav = !_isFav);
                        widget.product.isFavorite = _isFav;
                      },
                      child: Container(
                        margin: const EdgeInsets.all(AppSpacing.sm),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(230),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.iconBtnRadius),
                        ),
                        child: Icon(
                          _isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 20,
                          color: _isFav
                              ? AppColors.wishlistActive
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(right: AppSpacing.md),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(230),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.iconBtnRadius),
                        ),
                        child: const Icon(
                          Icons.share_outlined,
                          size: 20,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildImageSection(product),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildDetailSection(context, product),
                ),
              ],
            ),
          ),
          // Sticky bottom CTA
          _buildBottomCTA(context),
        ],
      ),
    );
  }

  Widget _buildImageSection(Product product) {
    return Container(
      color: AppColors.surface,
      child: Column(
        children: [
          // Main image
          Expanded(
            child: CachedNetworkImage(
              imageUrl: product.images[_selectedImageIndex],
              fit: BoxFit.contain,
              placeholder: (_, __) => Container(
                color: AppColors.background,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.background,
                child: const Icon(Icons.image_outlined,
                    size: 60, color: AppColors.textMuted),
              ),
            ),
          ),
          // Thumbnail row
          if (product.images.length > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(product.images.length, (i) {
                  final isSelected = i == _selectedImageIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedImageIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd - 2),
                        child: CachedNetworkImage(
                          imageUrl: product.images[i],
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => const Icon(
                            Icons.image_outlined,
                            color: AppColors.textMuted,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context, Product product) {
    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: AppSpacing.xs - 1),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(25),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(
                    product.category,
                    style: AppText.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                // Brand + Title
                Text(product.brand, style: AppText.labelMd.copyWith(color: AppColors.textMuted)),
                const SizedBox(height: 2),
                Text(product.title, style: AppText.h2),
                const SizedBox(height: AppSpacing.md),
                // Rating
                RatingRow(
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                  soldCount: product.soldCount,
                ),
                const SizedBox(height: AppSpacing.md),
                // Price row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Formatters.currency(product.price),
                      style: AppText.priceLg,
                    ),
                    if (product.oldPrice != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        Formatters.currency(product.oldPrice!),
                        style: AppText.priceOld.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs + 2,
                            vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(25),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: Text(
                          Formatters.discount(product.discountPercent ?? 0),
                          style: AppText.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    // Quantity stepper
                    QuantityStepper(
                      quantity: _quantity,
                      onDecrement: () =>
                          setState(() => _quantity--),
                      onIncrement: () =>
                          setState(() => _quantity++),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                // Size selector
                Row(
                  children: [
                    Text('Select Size', style: AppText.h3.copyWith(fontSize: 16)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Size Guide',
                        style: AppText.labelSm.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SizeSelector(
                  sizes: product.sizes,
                  initialSize: _selectedSize,
                  onSelected: (size) => setState(() => _selectedSize = size),
                ),
                const SizedBox(height: AppSpacing.xl),
                // Description
                Text('Description', style: AppText.h3.copyWith(fontSize: 16)),
                const SizedBox(height: AppSpacing.sm),
                AnimatedCrossFade(
                  firstChild: Text(
                    product.description,
                    style: AppText.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  secondChild: Text(
                    product.description,
                    style: AppText.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  crossFadeState: _descExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 250),
                ),
                GestureDetector(
                  onTap: () =>
                      setState(() => _descExpanded = !_descExpanded),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(
                      _descExpanded ? 'Read less' : 'Read more',
                      style: AppText.labelSm.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenH,
        AppSpacing.md,
        AppSpacing.screenH,
        AppSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppOutlineButton(
              label: 'Add to Cart',
              icon: Icons.shopping_bag_outlined,
              height: 52,
              onPressed: () => _addToCart(context),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: PrimaryButton(
              label: 'Buy Now',
              icon: Icons.flash_on_rounded,
              height: 52,
              onPressed: () {
                _addToCart(context);
                // Navigate to checkout (placeholder)
              },
            ),
          ),
        ],
      ),
    );
  }
}
