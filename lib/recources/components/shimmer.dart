import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // You can set the color you want for the shimmer effect
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 16,
                    color: Colors
                        .white, // You can set the color you want for the shimmer effect
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // You can set the color you want for the shimmer effect
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
