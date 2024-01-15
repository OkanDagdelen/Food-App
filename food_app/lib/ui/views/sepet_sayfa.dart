import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/sepet_yemekler.dart';
import 'package:food_app/ui/cubit/sepet_sayfa_cubit.dart';

// Sepet sayfası için widget
class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  late SepetSayfaCubit sepetSayfaCubit;
  String kullaniciAdi = "okan_dagdelen";
  bool showOrderAnimation = false;

  @override
  void initState() {
    super.initState();
    sepetSayfaCubit = context.read<SepetSayfaCubit>();
    sepetSayfaCubit.sepetYemekleriGetir(kullaniciAdi);
  }

  @override
  Widget build(BuildContext context) {
    List<SepetYemekler> _sepetYemeklerListesi =
        context.watch<SepetSayfaCubit>().state;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "resimler/arkaplan.png",
            fit: BoxFit.cover,
          ),
          BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
            builder: (context, sepetYemeklerListesi) {
              if (sepetYemeklerListesi.isNotEmpty) {
                return ListView.builder(
                  itemCount: sepetYemeklerListesi.length,
                  itemBuilder: (context, indeks) {
                    var sepetYemek = sepetYemeklerListesi[indeks];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.white, Colors.white, Colors.white],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  "http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemek_resim_adi}",
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        sepetYemek.yemek_adi,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black,),
                                      ),
                                      Text(
                                        "Fiyat: ${sepetYemek.yemek_fiyat} ₺",
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Adet:  ${sepetYemek.yemek_siparis_adet}",
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.black54,
                                        content: Text(
                                          "${sepetYemek.yemek_adi} silinsin mi ?",
                                          style: TextStyle(color: Colors.white, fontSize: 15),
                                        ),
                                        action: SnackBarAction(
                                          label: "Evet",
                                          backgroundColor: Colors.white54,
                                          textColor: Colors.black,
                                          onPressed: () {
                                            context.read<SepetSayfaCubit>().sepetYemekSil(
                                              int.parse(sepetYemek.sepet_yemek_id),
                                              kullaniciAdi,
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.remove, color: Colors.red),
                                ),
                              ],
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
                        padding: const EdgeInsets.only(bottom: 508.0),
                        child: Text(
                          "Sepete Ürün Ekleyin",
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
      bottomNavigationBar: _sepetYemeklerListesi.length > 0
          ? BottomAppBar(
        color: Color(0xFF1E5128),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
                builder: (context, sepetYemeklerListesi) {
                  double toplamFiyat =
                  context.read<SepetSayfaCubit>().toplamAdetVeFiyat(sepetYemeklerListesi);
                  return Text(
                    "Toplam : ${toplamFiyat.toStringAsFixed(2)} ₺",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black,),
                  );
                },
              ),
              Container(
                width: 120,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showOrderAnimation = true;
                    });
                    await context.read<SepetSayfaCubit>().sepetiSifirla(kullaniciAdi);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E5128),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    side: const BorderSide(width: 1.0, color: Colors.black),
                  ),
                  child: Text(
                    "Sipariş Ver",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // Sepeti temizleme işlemi
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text("Tüm Ürünleri Sil", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        content: Text("Sepetinizdeki tüm ürünleri silmek istediğinize emin misiniz?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Vazgeç", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<SepetSayfaCubit>().sepetiSifirla(kullaniciAdi);
                              Navigator.of(context).pop();
                            },
                            child: Text("Evet", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete_forever, color: Colors.red, size: 28),
              ),
            ],
          ),
        ),
      )
          : null,
    );
  }
}
