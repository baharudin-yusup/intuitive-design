import 'package:flutter/widgets.dart';

enum IntuitiveSizeOrientation { portrait, landscape }

class IntuitiveSize {
  String get fn => 'Dimen';

  static double maxWidth(BuildContext context) => MediaQuery.of(context).size.width;

  static double maxHeight(BuildContext context) => MediaQuery.of(context).size.height;

  static double size(BuildContext context) =>
      maxWidth(context) < maxHeight(context) ? maxWidth(context) : maxHeight(context);

  final IntuitiveSizeOrientation orientation;
  late final double _width;
  late final double _height;

  IntuitiveSize(
    BuildContext context, {
    double minWidth = 0,
    double minHeight = 0,
    double maxWidth = 1,
    double maxHeight = 1,
    double? variableWidth,
    double? variableHeight,
    this.orientation = IntuitiveSizeOrientation.portrait,
    bool useRatioWidth = false,
    bool useRatioHeight = false,
    double constantWidthSubtract = 0,
  }) {
    /// Inisialisasi dan konversi nilai input
    final rawSize = MediaQuery.of(context).size;

    final rawMinWidth = minWidth <= 1 ? minWidth * rawSize.width : minWidth;
    final rawMinHeight = minHeight <= 1 ? minHeight * rawSize.height : minHeight;

    final rawMaxWidth = maxWidth <= 1 ? maxWidth * rawSize.width : maxWidth;
    final rawMaxHeight = maxHeight <= 1 ? maxHeight * rawSize.height : maxHeight;

    /// Cek apakah nilai input yang di input sudah sesuai
    assert(rawMinWidth <= rawMaxWidth, 'dimen-error: minWidth > maxWidth');
    assert(rawMinHeight <= rawMaxHeight, 'dimen-error: minHeight > maxHeight');
    assert(variableWidth == null || (variableWidth > 0 && variableWidth < 1),
        'dimen-error: nilai variabel width harus antara 0-1');
    assert(variableHeight == null || (variableHeight > 0 && variableHeight < 1),
        'dimen-error: nilai variabel height harus antara 0-1');

    var rawWidth = variableWidth == null ? minWidth : variableWidth * rawSize.width;
    var rawHeight = variableHeight == null ? minHeight : variableHeight * rawSize.height;

    /// Cek apakah user meminta nilai input bergantung pada rasio
    final ratio = orientation == IntuitiveSizeOrientation.portrait
        ? rawSize.height / rawSize.width
        : rawSize.width / rawSize.height;
    rawWidth = useRatioWidth ? rawWidth / ratio : rawWidth;
    rawHeight = useRatioHeight ? rawHeight / ratio : rawHeight;

    if (rawWidth <= rawMinWidth) {
      _width = rawMinWidth - constantWidthSubtract;
    } else if (rawWidth >= rawMaxWidth) {
      _width = rawMaxWidth - constantWidthSubtract;
    } else {
      _width = rawWidth - constantWidthSubtract;
    }

    if (rawHeight <= rawMinHeight) {
      _height = rawMinHeight;
    } else if (rawHeight >= rawMaxHeight) {
      _height = rawMaxHeight;
    } else {
      _height = rawHeight;
    }

    //
    // _minimumWidth = minWidth <= 1 ? rawSize.width * minWidth : minWidth;
    // _minimumHeight = minHeight <= 1 ? rawSize.height * minHeight : minHeight;
    //
    // _maximumWidth = maxWidth <= 1 ? rawSize.width * maxWidth : maxWidth;
    // _maximumHeight = maxHeight <= 1 ? rawSize.height * maxHeight : maxHeight;
    //
    // variableWidth ??= minWidth;
    // variableHeight ??= minHeight;
    //
    //
    // if (heightWithRatio) {
    //   rawHeight /= ratio;
    // }
    //
    // /// Memasukkan nilai ke dimen
    // _variableWidth =
    // variableWidth <= 1 ? rawSize.width * variableWidth : variableWidth;
    // _variableHeight =
    // variableHeight <= 1 ? rawSize.height * variableHeight : variableHeight;
    //
    // _useMinimumWidth = minWidthCondition ?? _variableWidth < _minimumWidth;
    // _useMinimumHeight = minHeightCondition ?? _variableHeight < _minimumHeight;
    //
    // _useMaximumWidth = maxWidthCondition ?? _variableWidth > _maximumWidth;
    // _useMaximumHeight = maxHeightCondition ?? _variableHeight > _maximumHeight;
    //
    // String message = 'use ';
    // if (_useMinimumWidth) {
    //   message += 'min width & ';
    // } else if (_useMaximumWidth) {
    //   message += 'max width & ';
    // } else {
    //   message += 'variable width & ';
    // }
    //
    // if (_useMinimumHeight) {
    //   message += 'min height configuration';
    // } else if (_useMaximumHeight) {
    //   message += 'max height configuration';
    // } else {
    //   message += 'variable height configuration';
    // }
    //
    // log(message, name: name.isNotEmpty ? 'dimen.$name' : 'dimen');
  }

  double get width {
    return _width;
    // if (_useMinimumWidth) {
    //   return _minimumWidth;
    // }
    //
    // if (_useMaximumWidth) {
    //   return _maximumWidth;
    // }
    //
    // return _variableWidth;
  }

  double get height {
    return _height;
    // if (_useMinimumHeight) {
    //   return _minimumHeight;
    // }
    //
    // if (_useMaximumHeight) {
    //   return _maximumHeight;
    // }
    //
    // return _variableHeight;
  }
}
