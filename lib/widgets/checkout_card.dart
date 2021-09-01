import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooe/models/cart_model.dart';
import 'package:shooe/providers/cart_provider.dart';
import 'package:shooe/theme.dart';

class CheckoutCard extends StatelessWidget {

  final CartModel cartProduct;
  CheckoutCard(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4
      ),
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              cartProduct.product.galleries[0].url,
              width: 60,
              height: 60,
            ),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartProduct.product.name,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2,),
                Text(
                  '\$${cartProduct.product.price}',
                  style: priceTextStyle
                ),
              ],
            ),
          ),
          SizedBox(width: 12,),
          Text(
            '${cartProduct.quantity} items',
            style: secondaryTextStyle.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
