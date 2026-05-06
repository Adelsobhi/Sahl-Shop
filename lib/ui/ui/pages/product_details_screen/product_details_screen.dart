import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../domain/entities/ProductResponseEntity.dart';
import '../home_screen/tabs/products_tab/cubit/products_tab_view_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  static String routeName = "product_details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int productCounter = 1;
  int selectedColor = -1;
  int selectedSize = -1;

  List<int> sizes = [35, 38, 39, 40];

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as DataEntity;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔥 TOP BAR
      appBar: AppBar(
        title: Text("Product Details", style: AppStyles.medium14Header),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        child: Column(
          children: [

            // ================= IMAGE SLIDER =================
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: ImageSlideshow(
                  autoPlayInterval: 3000,
                  isLoop: true,
                  height: 280.h,
                  children: args.images!.map((img) {
                    return CachedNetworkImage(
                      imageUrl: img,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              ),
            ),

            // ================= INFO CARD =================
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // TITLE + PRICE
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          args.title ?? "",
                          style: AppStyles.medium14Header,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "EGP ${args.price}",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10),

                  // RATING
                  Row(
                    children: [
                      Icon(Icons.star,
                          color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text("${args.ratingsAverage}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Text("(${args.ratingsQuantity})"),
                      Spacer(),
                      Text("${args.sold} Sold",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  SizedBox(height: 15),

                  // DESCRIPTION
                  ReadMoreText(
                    args.description ?? "",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show more",
                    trimExpandedText: "Show less",
                    style: TextStyle(color: Colors.grey[700]),
                  ),

                  SizedBox(height: 20),

                  // ================= SIZE =================
                  Text("Size",
                      style: AppStyles.medium14Header),

                  SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    children: List.generate(sizes.length, (index) {
                      bool isSelected = selectedSize == index;

                      return ChoiceChip(
                        label: Text("${sizes[index]}"),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            selectedSize = index;
                          });
                        },
                        selectedColor: AppColors.primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 20),

                  // ================= COLOR =================
                  Text("Color",
                      style: AppStyles.medium14Header),

                  SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    children: List.generate(colors.length, (index) {
                      bool isSelected = selectedColor == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = index;
                          });
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: colors[index],
                          child: isSelected
                              ? Icon(Icons.check,
                              color: Colors.white, size: 16)
                              : null,
                        ),
                      );
                    }),
                  ),


                  SizedBox(height: 100),
                  // COUNTER
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        )
                      ],
                      border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // MINUS
                        GestureDetector(
                          onTap: () {
                            if (productCounter > 1) {
                              setState(() => productCounter--);
                            }
                          },
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor.withOpacity(0.1),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),

                        SizedBox(width: 12),

                        // COUNT
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Text(
                            "$productCounter",
                            key: ValueKey(productCounter),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),

                        SizedBox(width: 12),

                        // PLUS
                        GestureDetector(
                          onTap: () {
                            setState(() => productCounter++);
                          },
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM BAR =================
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          children: [

            // PRICE
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total"),
                  Text(
                    "EGP ${(args.price! * productCounter).toStringAsFixed(2)}",
                    style: AppStyles.medium14Header,
                  ),
                ],
              ),
            ),




            // ADD TO CART
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ProductsTabViewModel.get(context)
                      .addToCart(productId: args.id!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Add to Cart",style: AppStyles.medium14Category.copyWith(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}