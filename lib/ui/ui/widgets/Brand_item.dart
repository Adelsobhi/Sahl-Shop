import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sahl_shop/domain/entities/CategoryOrBrandResponseEntity.dart';

import '../../../core/utils/app_colors.dart';

class BrandItem extends StatelessWidget {
 CategoryOrBrandEntity item;
  BrandItem({required this.item});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: CachedNetworkImage(
              width: double.infinity,
              height: 40.h,
              fit: BoxFit.cover,
              imageUrl: item.image??'',
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
              errorWidget: (context, url, error) =>
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://f.nooncdn.com/p/0bc2f531194c502dad79691c1a69d592%7Cpzsku/Z6CAB921245CD5ABDCAF0Z/45/1770238301/3f9a1d7a-d574-4f97-80d0-393951333c7b.jpg?width=800",
                    ),
                  )
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            item.name??'',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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