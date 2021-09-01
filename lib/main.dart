import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooe/pages/cart_page.dart';
import 'package:shooe/pages/checkout_page.dart';
import 'package:shooe/pages/checkout_success_page.dart';
import 'package:shooe/pages/edit_profile_page.dart';
import 'package:shooe/pages/home/main_page.dart';
import 'package:shooe/pages/login_page.dart';
import 'package:shooe/pages/register_page.dart';
import 'package:shooe/pages/splash_page.dart';
import 'package:shooe/providers/auth_provider.dart';
import 'package:shooe/providers/cart_provider.dart';
import 'package:shooe/providers/page_provider.dart';
import 'package:shooe/providers/product_provider.dart';
import 'package:shooe/providers/transaction_provider.dart';
import 'package:shooe/providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => MainPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
        },
      ),
    );
  }
}