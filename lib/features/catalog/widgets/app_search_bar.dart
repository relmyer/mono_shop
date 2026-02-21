import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text.dart';
import '../state/cart_state.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onCartTap;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onCartTap,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: readOnly ? onTap : null,
            child: Container(
              height: AppSpacing.searchBarHeight,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.searchBarRadius),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const SizedBox(width: AppSpacing.lg),
                  const Icon(
                    Icons.search_rounded,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: readOnly
                        ? Text(
                            'Search products...',
                            style: AppText.bodyMd
                                .copyWith(color: AppColors.textMuted),
                          )
                        : TextField(
                            controller: controller,
                            onChanged: onChanged,
                            style: AppText.bodyMd,
                            decoration: const InputDecoration(
                              hintText: 'Search products...',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        _CartIconButton(onTap: onCartTap),
      ],
    );
  }
}

class _CartIconButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _CartIconButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartState>(
      builder: (context, cart, _) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: AppSpacing.iconBtnSize + 4,
            height: AppSpacing.iconBtnSize + 4,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius:
                  BorderRadius.circular(AppSpacing.iconBtnRadius),
              border: Border.all(color: AppColors.border),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.textPrimary,
                    size: 22,
                  ),
                ),
                if (cart.itemCount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          cart.itemCount > 9 ? '9+' : '${cart.itemCount}',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
