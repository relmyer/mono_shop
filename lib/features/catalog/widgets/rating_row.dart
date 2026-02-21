import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';

class RatingRow extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final int? soldCount;
  final bool compact;

  const RatingRow({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.soldCount,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, _) => const Icon(
            Icons.star_rounded,
            color: AppColors.star,
          ),
          itemCount: 5,
          itemSize: compact ? 14 : 18,
          unratedColor: AppColors.border,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          Formatters.rating(rating),
          style: compact
              ? AppText.caption
                  .copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)
              : AppText.labelMd.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '(${Formatters.reviewCount(reviewCount)})',
          style: compact ? AppText.caption : AppText.bodySm,
        ),
        if (soldCount != null && !compact) ...[
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: AppColors.textMuted,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            Formatters.soldCount(soldCount!),
            style: AppText.bodySm,
          ),
        ],
      ],
    );
  }
}
