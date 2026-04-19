import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/utils/app_colors.dart';

class CategoryBrandItem extends StatelessWidget {
  const CategoryBrandItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: CachedNetworkImage(
            width: double.infinity,
            height: 30.h,
            fit: BoxFit.cover,
            imageUrl: "https://images.pexels.com/photos/27501997/pexels-photo-27501997.jpeg",
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                backgroundImage: imageProvider,
                radius: 50.r,
              );
            },
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryDark,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            "Technology",
            textWidthBasis: TextWidthBasis.longestLine,
            softWrap: true,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    );
  }
}