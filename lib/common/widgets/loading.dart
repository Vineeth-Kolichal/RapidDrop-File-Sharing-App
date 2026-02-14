import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';
import '../../core/theme/app_colors.dart';

class Loading extends StatelessWidget {
  ///Example:
  ///-------------------------
  ///```
  /// class HomeScreen extends StatelessWidget {
  ///   const HomeScreen({super.key});
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       appBar: AppBar(
  ///         title: const Text("Home Screen"),
  ///       ),
  ///       body: const Loading(
  ///         isLoading: true // your loding contidtion here
  ///         child: MyUI(), //code for your screen UI,
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const Loading({
    super.key,
    required this.child,
    required this.isLoading,
    this.progress,
    this.message,
  });
  final Widget child;
  final bool isLoading;
  final double? progress;
  final String? message;

  @override
  Widget build(BuildContext context) {
    AppColors? appColors = context.appColors;
    if (!isLoading) {
      return child;
    }

    return Stack(
      children: [
        child,
        Container(
          color: appColors?.kBlack.withValues(alpha: 0.3),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 70,
              decoration: BoxDecoration(
                color: appColors?.surfaceColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (progress != null) ...[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 3,
                        color: appColors?.primary,
                      ),
                    ),
                  ] else ...[
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? const CupertinoActivityIndicator(radius: 15)
                        : const CircularProgressIndicator(strokeWidth: 2),
                  ],
                  15.horizontalSpace,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message ?? "Please Wait...",
                          style: context.labelLarge(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (progress != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            "${(progress! * 100).toStringAsFixed(0)}%",
                            style: context.bodySmall(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
