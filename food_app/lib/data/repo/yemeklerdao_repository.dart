import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:food_app/data/entity/yemekler.dart';
import 'package:food_app/data/entity/yemekler_cevap.dart';

// YemeklerDaoRepository sınıfı, yemek verilerini API'dan çekmek ve işlemek için kullanılır.
class YemeklerDaoRepository {

  // JSON formatındaki bir cevabı işleyerek Yemekler listesine dönüştüren fonksiyon
  List<Yemekler> parseYemeklerCevap(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  // Tüm yemekleri getiren asenkron bir fonksiyon
  Future<List<Yemekler>> yemekleriGetir() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemeklerCevap(cevap.data.toString());
  }

  // Belirtilen arama kelimesine göre yemekleri getiren asenkron bir fonksiyon
  Future<List<Yemekler>> ara(String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var veri = {"yemek_adi": aramaKelimesi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseYemeklerCevap(cevap.data.toString());
  }

  // Belirtilen arama kelimesine göre yemekleri filtreleyen asenkron bir fonksiyon
  Future<List<Yemekler>> yemekleriAra(String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var result = await Dio().get(url);
    try {
      var decodedData = json.decode(result.data.toString());
      var yemekResult = YemeklerCevap.fromJson(decodedData).yemekler;
      if (aramaKelimesi.isNotEmpty || yemekResult.isNotEmpty) {
        List<Yemekler> yemeklerListesi = [];
        for (var yemek in yemekResult) {
          if (yemek.yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase())) {
            yemeklerListesi.add(yemek);
          }
        }
        return yemeklerListesi;
      } else {
        return yemekResult;
      }
    } catch (e) {
      return [];
    }
  }
}
