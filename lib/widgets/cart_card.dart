import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooe/models/cart_model.dart';
import 'package:shooe/providers/cart_provider.dart';
import 'package:shooe/theme.dart';

class CartCard extends StatelessWidget {

  final CartModel cartProduct;
  CartCard(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: defaultMargin),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartProduct.product.name,
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold
                    ),
                  ),
                  Text(
                    '\$${cartProduct.product.price}',
                    style: priceTextStyle,
                  ),
                ],
              )),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.addProductQuantity(cartProduct.id);
                    },
                    child: Image.asset(
                      'assets/btn_add.png',
                      width: 16,
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(cartProduct.quantity.toString(), style: primaryTextStyle.copyWith(fontWeight: medium),),
                  SizedBox(height: 2,),
                  GestureDetector(
                    onTap: () {
                      cartProvider.reduceProductQuantity(cartProduct.id);
                      if(!cartProvider.productExist(cartProduct.product)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: alertColor,
                            content: Text(
                              'Removed ${cartProduct.product.name} from Your Cart',
                              textAlign: TextAlign.center,
                            )
                          )
                        );
                      }
                    },
                    child: Image.asset(
                      'assets/btn_reduce.png',
                      width: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: () {
              cartProvider.removeProductFromCart(cartProduct.id);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: alertColor,
                      content: Text(
                        'Removed ${cartProduct.product.name} from Your Cart',
                        textAlign: TextAlign.center,
                      )
                  )
              );
            },
            child: Image.asset(
              'assets/image_remove.png',
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
