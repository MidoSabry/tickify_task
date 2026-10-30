import 'package:flutter/material.dart';

import '../base/base_state.dart';
import '../theme/app_colors.dart';
import 'shared_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.backgroundColor,
    required this.state,
    required this.onPressed,
  });

  final String title;
  final Color? backgroundColor;
  final BaseState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = state is ButtonLoadingState;
    final isEnabled = state is ButtonEnabledState;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          disabledBackgroundColor: (backgroundColor ?? AppColors.primary)
              .withValues(alpha: 0.45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : AppText(
                text: title,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }
}
