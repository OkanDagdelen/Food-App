import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/yemekler.dart';
import 'package:food_app/ui/cubit/anasayfa_cubit.dart';
import 'package:food_app/ui/cubit/favoriler_sayfa_cubit.dart';
import 'package:food_app/ui/views/detay_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  int adet = 1;
  String kullaniciAdi = "okan_dagdelen";
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "resimler/arkaplan.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          // Diğer sayfa içeriği
          Column(
            children: [
              SizedBox(height: 42),
              Text(
                "Hoş Geldiniz",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "resimler/hamburg.png",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            onChanged: (aramaKelimesi) {
                              context.read<AnasayfaCubit>().yemekleriAra(aramaKelimesi);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search_sharp, color: Colors.white,),
                              hintText: "Canınız ne çekti ?",
                              hintStyle: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                              fillColor: Colors.transparent,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 2),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Menü",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
                        builder: (context, yemeklerListesi) {
                          if (yemeklerListesi.isNotEmpty) {
                            return GridView.builder(
                              itemCount: yemeklerListesi.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.56 / 0.9,
                              ),
                              itemBuilder: (context, indeks) {
                                var yemek = yemeklerListesi[indeks];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetaySayfa(yemek: yemek),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.network(
                                          "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${yemek.yemek_adi} ",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            FavoriSayfaCubit>()
                                                        .favoriyeEkle(yemek);
                                                  },
                                                  icon: const Icon(
                                                    Icons.favorite_border_sharp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${yemek.yemek_fiyat} ₺",
                                                  style: const TextStyle(
                                                      fontSize: 22),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<AnasayfaCubit>()
                                                        .sepeteYemekEkleme(
                                                          yemek.yemek_adi,
                                                          yemek.yemek_resim_adi,
                                                          int.parse(yemek
                                                              .yemek_fiyat),
                                                          adet,
                                                          kullaniciAdi,
                                                        );
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .shopping_cart_outlined,
                                                    size: 30,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
