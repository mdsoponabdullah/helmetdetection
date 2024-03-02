import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class GetCachedNetworkImage extends StatelessWidget {
  const GetCachedNetworkImage({super.key, required this.imageUrl,  this.width_,  this.height_});
  final String imageUrl;
  final int? width_;
  final int? height_;

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 10),
      maxNrOfCacheObjects: 150
    )
  );
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: customCacheManager,
      key: UniqueKey(),
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        )),
      ),
      placeholder: (context, url) => Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Image.asset("assets/helmet1.png"),
    );
  }
}
