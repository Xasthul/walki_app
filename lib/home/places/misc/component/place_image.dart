import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vall/app/common/widget/app_loading_indicator.dart';

class PlaceImage extends StatelessWidget {
  const PlaceImage({
    super.key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
  })  : _url = url,
        _width = width,
        _height = height,
        _fit = fit;

  final String _url;
  final double? _width;
  final double? _height;
  final BoxFit? _fit;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: _url,
        width: _width,
        height: _height,
        placeholder: (context, url) => const Center(child: AppLoadingIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.image_rounded),
        fit: _fit,
      );
}
