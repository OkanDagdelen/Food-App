import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:food_app/data/entity/favori_yemekler.dart';
import 'package:food_app/data/entity/favori_yemekler_cevap.dart';

// Favori yemeklerle ilgili veritabanı işlemlerini gerçekleştiren sınıf
class FavoriYemeklerDaoRepository {
  // JSON formatındaki bir yanıtı alır, bu yanıtı işleyerek FavoriYemeklerCevap sınıfına dönüştürür
  // ve içindeki favoriYemekler listesini döndürür. Bu işlemde hata oluşması durumunda boş bir liste döndürülür.
  List<FavoriYemekler> parseFavoriYemeklerCevap(String cevap) {
    try {
      var decodedJson = json.decode(cevap);
      return FavoriYemeklerCevap.fromJson(decodedJson).favoriYemekler;
    } catch (e) {
      print("JSON Ayrıştırma Hatası: $e");
      return [];
    }
  }

  // Belirtilen kullanıcı adına ait favori yemekleri getirmek için bir HTTP POST isteği gönderir.
  // Gelen cevabı işlemek için parseFavoriYemeklerCevap fonksiyonunu kullanarak bir liste döndürür.
  Future<List<FavoriYemekler>> favoriYemekleriGetir(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseFavoriYemeklerCevap(cevap.data.toString());
  }

  // Belirtilen bilgilerle bir yemeği favorilere eklemek için bir HTTP POST isteği gönderir.
  Future<void> favoriYemekEkle(String favori_yemek_adi, String yemek_resim_adi, int yemek_fiyat,
      int yemek_siparis_adet, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "favori_yemek_adi": favori_yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Favorilere Yemek Ekle : ${cevap.data.toString()}");
  }

  // Belirtilen favori yemek ID ve kullanıcı adına ait yemeği favorilerden silmek için bir HTTP POST isteği gönderir.
  Future<void> favoriYemekSil(int favori_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"favori_yemek_id": favori_yemek_id, "kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Favorilerden Silinen Yemek : ${cevap.data.toString()}");
  }
}
