import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooe/models/product_model.dart';
import 'package:shooe/providers/wishlist_provider.dart';
import 'package:shooe/theme.dart';

class WishlistCard extends StatelessWidget {

  final ProductModel product;
  WishlistCard(this.product);

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.galleries[0].url,
              width: 60,
            ),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishlistProvider.setProduct(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: alertColor,
                  content: Text(
                    'Removed ${product.name} from Wishlist',
                    textAlign: TextAlign.center,
                  )
                )
              );
            },
            child: Image.asset(
              'assets/btn_wishlist_active.png',
              width: 34,
            ),
          )
        ],
      ),
    );
  }
}
