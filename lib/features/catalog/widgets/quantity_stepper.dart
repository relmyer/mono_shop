import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/app_spacing.dart';

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final int min;
  final int max;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    this.min = 1,
    this.max = 99,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            icon: Icons.remove_rounded,
            onTap: quantity > min ? onDecrement : null,
          ),
          SizedBox(
            width: 40,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: AppText.h3.copyWith(fontSize: 16),
            ),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            onTap: quantity < max ? onIncrement : null,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: onTap == null
              ? AppColors.background
              : AppColors.primary.withAlpha(13),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd - 2),
        ),
        child: Icon(
          icon,
          size: 20,
          color: onTap == null ? AppColors.textDisabled : AppColors.primary,
        ),
      ),
    );
  }
}
