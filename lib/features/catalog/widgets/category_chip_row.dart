import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../models/category.dart';

class CategoryChipRow extends StatefulWidget {
  final ValueChanged<String>? onSelected;
  final String? initialSelected;

  const CategoryChipRow({
    super.key,
    this.onSelected,
    this.initialSelected,
  });

  @override
  State<CategoryChipRow> createState() => _CategoryChipRowState();
}

class _CategoryChipRowState extends State<CategoryChipRow> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelected ?? CategoryData.chipLabels.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: CategoryData.chipLabels.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final label = CategoryData.chipLabels[index];
          final isSelected = label == _selected;
          return GestureDetector(
            onTap: () {
              setState(() => _selected = label);
              widget.onSelected?.call(label);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primary : AppColors.surface,
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.border,
                ),
              ),
              child: Text(
                label,
                style: AppText.labelMd.copyWith(
                  color:
                      isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
