import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/app_theme.dart';

class SkeletonBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsets? margin;

  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.surface.withAlpha(100),
      highlightColor: AppTheme.surface.withAlpha(50),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class EventCardSkeleton extends StatelessWidget {
  const EventCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 220,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonBox(
            height: 140,
            width: double.infinity,
            borderRadius: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonBox(height: 20, width: 200),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SkeletonBox(height: 16, width: 80),
                    const SizedBox(width: 12),
                    const SkeletonBox(height: 16, width: 60),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TicketSkeleton extends StatelessWidget {
  const TicketSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withAlpha(20)),
      ),
      child: Row(
        children: [
          const SkeletonBox(height: 80, width: 80, borderRadius: 12),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonBox(height: 18, width: 150),
                SizedBox(height: 8),
                SkeletonBox(height: 14, width: 100),
                SizedBox(height: 8),
                SkeletonBox(height: 14, width: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SkeletonBox(height: 100, width: 100, borderRadius: 50),
          const SizedBox(height: 16),
          const SkeletonBox(height: 24, width: 180),
          const SizedBox(height: 8),
          const SkeletonBox(height: 16, width: 220),
          const SizedBox(height: 32),
          ...List.generate(4, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                const SkeletonBox(height: 24, width: 24, borderRadius: 4),
                const SizedBox(width: 16),
                const SkeletonBox(height: 20, width: 120),
                const Spacer(),
                const SkeletonBox(height: 20, width: 20, borderRadius: 4),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
