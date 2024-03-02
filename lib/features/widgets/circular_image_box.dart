import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CircularImageBox extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CircularImageBox({super.key, required this.imageUrl, required this.size});
  static final customCacheManager = CacheManager(
      Config(
          'customCacheKey',
          stalePeriod: const Duration(days: 10),
          maxNrOfCacheObjects: 120
      )
  );
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        cacheManager: customCacheManager,
        key: UniqueKey(),
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(width: 6,color: Colors.blue),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ),
    errorWidget: (context, url, error) => Image.asset("assets/helmet1.png"),
    );
  }
}

