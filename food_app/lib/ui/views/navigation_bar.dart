import 'package:flutter/material.dart';
import 'package:food_app/ui/views/anasayfa.dart';
import 'package:food_app/ui/views/favoriler_sayfa.dart';
import 'package:food_app/ui/views/sepet_sayfa.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// Ana sayfa altındaki gezinme çubuğu ve alt sayfaların listesi
class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomNavigationBar> createState() => _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  // Sayfaların listesi
  var pageList = [Anasayfa(), FavoriSayfa(), SepetSayfa()];

  // Seçilen sayfanın indeksini saklayan değişken
  late int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Seçilen sayfanın içeriğini gösteren widget
      body: pageList[selectedIndex],
      // Alt gezinme çubuğu
      bottomNavigationBar: GNav(
        backgroundColor: Colors.transparent,
        color: Colors.green,
        activeColor: Colors.white,
        gap: 8,
        padding: EdgeInsets.all(16),
        selectedIndex: selectedIndex, // Seçilen sayfanın indeksi
        tabs: [
          GButton(icon: Icons.home, text: "  Anasayfa"),
          GButton(icon: Icons.favorite_border, text: "  Favoriler"),
          GButton(icon: Icons.shopping_basket_outlined, text: "  Sepet"),
        ],
        onTabChange: (indeks) {
          setState(() {
            selectedIndex = indeks; // Seçilen sayfanın indeksini güncelle
            print(selectedIndex.toString());
          });
        },
      ),
    );
  }
}
