import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/theme/app_spacing.dart';

class AppOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;

  const AppOutlineButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height = 52,
    this.icon,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = textColor ?? AppColors.primary;
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: borderColor ?? AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: AppText.btnLg.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
