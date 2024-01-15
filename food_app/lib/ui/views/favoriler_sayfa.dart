import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/yemekler.dart';
import 'package:food_app/ui/cubit/anasayfa_cubit.dart';
import 'package:food_app/ui/cubit/favoriler_sayfa_cubit.dart';
import 'package:food_app/ui/views/detay_sayfa.dart';

// Kullanıcının favori yemeklerini gösteren sayfa
class FavoriSayfa extends StatefulWidget {
  const FavoriSayfa({super.key});

  @override
  State<FavoriSayfa> createState() => _FavoriSayfaState();
}

class _FavoriSayfaState extends State<FavoriSayfa> {
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
          BlocBuilder<FavoriSayfaCubit, List<Yemekler>>(
            builder: (context, favoriYemeklerListesi) {
              if (favoriYemeklerListesi.isNotEmpty) {
                return ListView.builder(
                  itemCount: favoriYemeklerListesi.length,
                  itemBuilder: (context, indeks) {
                    var favoriYemek = favoriYemeklerListesi[indeks];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.black12, width: 2.0),
                          boxShadow: [
                            BoxShadow(  // Kutuların altına gölge eklemek için kullanılır.
                              color: Colors.red.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: ListTile(
                              leading: Image.network(
                                "http://kasimadalan.pe.hu/yemekler/resimler/${favoriYemek.yemek_resim_adi}",
                                width: 150,
                                height: 200,
                              ),
                              title: Text(
                                favoriYemek.yemek_adi,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                // Yemek detay sayfasına gitme işlemi
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: favoriYemek))).then((value) {
                                  // Yemek detay sayfasından dönüldüğünde, anasayfa Cubit'ini güncelle
                                  context.read<AnasayfaCubit>().yemekleriGetir();
                                });
                              },
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red,),
                                onPressed: () {
                                  // Favori yemeği silme işlemi
                                  context.read<FavoriSayfaCubit>().favoridenCikar(favoriYemek);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 408.0),
                        child: Text(
                          "Favori Ürünlerinizi Ekleyin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
