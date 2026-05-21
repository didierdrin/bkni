import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

bool isBase64ProductImage(String src) {
  if (src.isEmpty) return false;
  if (src.startsWith('data:image')) return true;
  if (src.startsWith('http://') || src.startsWith('https://')) return false;
  return !src.contains('://');
}

String normalizeProductImageSrc(String src) {
  if (src.isEmpty) return src;
  if (src.startsWith('data:image')) return src;
  if (src.startsWith('http://') || src.startsWith('https://')) return src;
  return 'data:image/jpeg;base64,$src';
}

Uint8List? decodeProductImageBytes(String src) {
  final normalized = normalizeProductImageSrc(src);
  if (!normalized.startsWith('data:image')) return null;
  final comma = normalized.indexOf(',');
  if (comma < 0) return null;
  try {
    return base64Decode(normalized.substring(comma + 1));
  } catch (_) {
    return null;
  }
}

/// Displays a product image from a network URL or base64 stored in Firestore.
class ProductImage extends StatelessWidget {
  final String src;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ProductImage({
    super.key,
    required this.src,
    this.fit,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (src.isEmpty) {
      return errorWidget ?? const SizedBox.shrink();
    }

    if (isBase64ProductImage(src)) {
      final bytes = decodeProductImageBytes(src);
      if (bytes != null) {
        return Image.memory(
          bytes,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (_, __, ___) =>
              errorWidget ?? const Icon(Icons.broken_image_outlined),
        );
      }
      return errorWidget ?? const Icon(Icons.broken_image_outlined);
    }

    return Image.network(
      src,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, __, ___) =>
          errorWidget ??
          (placeholder ?? const Icon(Icons.broken_image_outlined)),
    );
  }
}
