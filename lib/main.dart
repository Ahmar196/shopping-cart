import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/view/screen/productscreen.dart';
import 'package:shopping_cart/viewmodel/productVM.dart';
import 'package:shopping_cart/viewmodel/themeprovider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsVM()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Shopping Cart App',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.currentTheme, // Apply the current theme
            home: ProductScreen(),
          );
        },
      ),
    );
  }
}
