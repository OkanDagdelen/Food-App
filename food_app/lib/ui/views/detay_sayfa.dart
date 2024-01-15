import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/yemekler.dart';
import 'package:food_app/ui/cubit/anasayfa_cubit.dart';

// Yemek detaylarını gösteren sayfa
class DetaySayfa extends StatefulWidget {
  final Yemekler yemek;

  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  String kullaniciAdi = "okan_dagdelen";
  int adet = 1;
  int sepetAdet = 0;
  double toplamFiyat = 0.0;

  // Adeti arttırma fonksiyonu
  void arttir() {
    setState(() {
      adet++;
      sepetAdet++;
      toplamFiyat += double.parse(
          widget.yemek.yemek_fiyat); // String'i double'a çevirmek için
    });
  }

  // Adeti azaltma fonksiyonu
  void azalt() {
    setState(() {
      if (adet > 1) {
        adet--;
        sepetAdet--;
        toplamFiyat -=
            double.parse(widget.yemek.yemek_fiyat); // String'i double'a çevir
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "resimler/arkaplan.png",
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: IconButton(
                        iconSize: 30,
                        color: Colors.green,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ],
                ),
                Image.network(
                    "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
                Text("${widget.yemek.yemek_adi}",
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold)),
                Text(
                  "₺ ${widget.yemek.yemek_fiyat}",
                  style: const TextStyle(fontSize: 30),
                ),
                SizedBox(height: 10),
                // Diğer Widget'lar burada...
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: arttir,
                      child: Icon(Icons.add, color: Colors.green),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$adet",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: azalt,
                      child: Icon(Icons.remove, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.green),
                      onPressed: () {
                        // Sepete gitme işlemleri buraya eklenebilir
                      },
                    ),
                    Text(
                      'Toplam: ₺${(adet * double.parse(widget.yemek.yemek_fiyat)).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Sepete ekleme işlemleri için Cubit'ten ilgili metodu çağırır
                    context.read<AnasayfaCubit>().sepeteYemekEkleme(
                        widget.yemek.yemek_adi,
                        widget.yemek.yemek_resim_adi,
                        int.parse(widget.yemek.yemek_fiyat),
                        adet,
                        kullaniciAdi);
                  },
                  child: const Text(
                    "Sepete Ekle",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
