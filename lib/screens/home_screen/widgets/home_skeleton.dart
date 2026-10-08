import 'package:flutter/material.dart';

class HomeSkeleton extends StatefulWidget {
  const HomeSkeleton({super.key});

  @override
  State<HomeSkeleton> createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget skeletonBox({
    double? width,
    required double height,
    double radius = 12,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                Color(0xFFEDEDED),
                Color(0xFFF7F7F7),
                Color(0xFFEDEDED),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 30),

        // Main heading
        skeletonBox(
          width: 230,
          height: 28,
          radius: 8,
        ),

        const SizedBox(height: 10),

        skeletonBox(
          width: 170,
          height: 28,
          radius: 8,
        ),

        const SizedBox(height: 25),

        // Horizontal category cards
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, __) {
              return skeletonBox(
                width: 100,
                height: 110,
                radius: 14,
              );
            },
          ),
        ),

        const SizedBox(height: 30),

        // Section heading
        skeletonBox(
          width: 210,
          height: 22,
          radius: 7,
        ),

        const SizedBox(height: 15),

        // Recipe cards
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, __) {
              return skeletonBox(
                width: 150,
                height: 180,
                radius: 14,
              );
            },
          ),
        ),

        const SizedBox(height: 30),

        skeletonBox(
          width: 190,
          height: 22,
          radius: 7,
        ),

        const SizedBox(height: 15),

        // Lunch-style list items
        ...List.generate(
          3,
              (index) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                skeletonBox(
                  width: 90,
                  height: 90,
                  radius: 12,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      skeletonBox(
                        width: double.infinity,
                        height: 17,
                        radius: 6,
                      ),
                      const SizedBox(height: 10),
                      skeletonBox(
                        width: 120,
                        height: 15,
                        radius: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 15),

        skeletonBox(
          width: 180,
          height: 22,
          radius: 7,
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, __) {
              return skeletonBox(
                width: 150,
                height: 180,
                radius: 14,
              );
            },
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}