import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum IntuitiveShimmerType {
  roundedCorners,
  circle,
}

abstract class IntuitiveShimmer<T> extends StatelessWidget {
  final int totalShimmer;
  final Size size;
  final EdgeInsets margin;
  final IntuitiveShimmerType type;

  const IntuitiveShimmer({
    Key? key,
    required this.size,
    this.margin = EdgeInsets.zero,
    required this.totalShimmer,
    this.type = IntuitiveShimmerType.roundedCorners,
  }) : super(key: key);

  @protected
  Widget shimmer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    var maxWidth = size.width;
    final widthReducer = size.width * 0.25;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(totalShimmer, (_) {
        final shimmer = Padding(
          padding: margin,
          child: Shimmer.fromColors(
            enabled: true,
            baseColor: colorScheme.secondaryContainer.withOpacity(0.5),
            highlightColor: colorScheme.secondaryContainer,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                maxHeight: size.height,
              ),
              decoration: BoxDecoration(
                color: colorScheme.background,
                borderRadius: borderRadius,
              ),
            ),
          ),
        );

        if (type == IntuitiveShimmerType.roundedCorners) {
          if (maxWidth <= size.width * 0.5) {
            maxWidth = size.width;
          } else {
            maxWidth = maxWidth - widthReducer;
          }
        }

        return shimmer;
      }),
    );
  }

  @protected
  BorderRadiusGeometry get borderRadius {
    switch (type) {
      case IntuitiveShimmerType.roundedCorners:
        return const BorderRadius.all(Radius.circular(16));
      case IntuitiveShimmerType.circle:
        return BorderRadius.all(Radius.circular(size.width / 2));
    }
  }
}

class BasicIntuitiveShimmer<T> extends IntuitiveShimmer<T> {
  final bool forceLoading;
  final T? data;
  final Widget Function(BuildContext context, T data) builder;

  const BasicIntuitiveShimmer({
    Key? key,
    super.margin,
    super.type,
    required this.data,
    required super.size,
    required this.builder,
    this.forceLoading = false,
    super.totalShimmer = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null || forceLoading) {
      return shimmer(context);
    }

    return Padding(
      padding: margin,
      child: builder(context, data as T),
    );
  }
}

class FutureIntuitiveShimmer<T> extends IntuitiveShimmer<T> {
  final Future<T?> future;
  final AsyncWidgetBuilder<T?> builder;

  const FutureIntuitiveShimmer({
    Key? key,
    super.margin,
    super.type,
    required this.future,
    required this.builder,
    required super.size,
    super.totalShimmer = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return shimmer(context);
        }
        return Padding(
          padding: margin,
          child: builder(context, snapshot),
        );
      },
    );
  }
}
