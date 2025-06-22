import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';

class KawaiiCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;

  const KawaiiCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: AppColors.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: child,
      ),
    );
  }
} 