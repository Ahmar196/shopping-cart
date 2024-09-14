import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/view/widgets/cartcounter.dart';
import 'package:shopping_cart/view/widgets/productitem.dart';
import 'package:shopping_cart/viewmodel/productVM.dart';
import 'package:shopping_cart/view/screen/cart.dart';
import 'package:shopping_cart/view/screen/wallet.dart'; // Add the import for WalletScreen
import 'package:shopping_cart/view/screen/profile.dart'; // Add the import for ProfileScreen

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _selectedIndex = 0; // Track the selected index for the bottom navigation bar
  final PageController _pageController = PageController(); // Page controller for handling page navigation

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        actions: [
          InkWell(
            onTap: () {
              // Navigate to CartScreen
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(Icons.shopping_cart_rounded, color: Colors.blue, size: 25),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Consumer<ProductsVM>(
                      builder: (context, value, child) => CartCounter(
                        count: value.lst.length.toString(),
                        key: UniqueKey(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.menu_rounded, color: Colors.blue, size: 25),
        ),
        title: Center(
          child: Text("My Mart", style: TextStyle(color: Colors.blue)),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index; // Update selected index on page change
            });
          },
          children: [
            Container(
              height: screenSize.height * 0.24,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: prds.length,
                itemBuilder: (context, index) => ProductItem(
                  key: Key(prds[index]["name"] ?? 'key_$index'),
                  screenSize: screenSize,
                  image: prds[index]["image"] ?? '',
                  itemName: prds[index]["name"] ?? '',
                ),
              ),
            ),
            CartScreen(), // Add CartScreen here
           WalletScreen(), // Add WalletScreen here
           ProfileScreen(), // Add ProfileScreen here
          ],
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index); // Navigate to the selected page
          }); 
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.blue,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_travel),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

final prds = [
  {
    "name": "ABCD",
    "image": "assets\images\Navy_Blue-removebg-preview.png",
  },
  {
    "name": "QWER",
    "image": "assets\images\Navy_Blue-removebg-preview.png",
  },
  {
    "name": "DFSA",
    "image": "assets\images\Navy_Blue-removebg-preview.png",
  },
  {
    "name": "ZXCV",
    "image": "assets\images\Navy_Blue-removebg-preview.png",
  },
  {
    "name": "DFFG",
    "image": "assets\images\Navy_Blue-removebg-preview.png",
  },
  {
    "name": "FVEF",
    "image": "assets\images\Navy_Blue-removebg-preview.png",
  },
  {
    "name": "FF34FG",
    "image": "assets\images\Navy_Blue-removebg-preview.png",
  },
];
