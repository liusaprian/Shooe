import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooe/providers/cart_provider.dart';
import 'package:shooe/theme.dart';
import 'package:shooe/widgets/cart_card.dart';

class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Your Cart',
          style: primaryTextStyle,
        ),
        elevation: 0,
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_empty_cart.png',
              width: 80,
            ),
            SizedBox(height: 20,),
            Text(
              'Oops! Your cart is empty',
              style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium
              ),
            ),
            SizedBox(height: 12,),
            Text(
              'Let\'s find your favorite shoes',
              style: secondaryTextStyle,
            ),
            SizedBox(height: 20,),
            Container(width: 154, height: 44,child: TextButton(style: TextButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),onPressed: (){Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);}, child: Text('Explore Store', style: primaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),))),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: cartProvider.carts.map((cartProduct) => CartCard(cartProduct)).toList(),
      );
    }

    Widget customBottomNav() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        height: 180,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: primaryTextStyle,
                  ),
                  Text(
                    '\$${cartProvider.totalPrice()}',
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Divider(
              thickness: 0.4,
              color: subtitleColor,
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Continue to Checkout',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: primaryTextColor,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: backgroundColor3,
      body: cartProvider.carts.length == 0
          ? emptyCart()
          : content(),
      bottomNavigationBar: cartProvider.carts.length == 0
          ? SizedBox()
          : customBottomNav(),
    );
  }
}
