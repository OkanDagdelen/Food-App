import 'package:food_app/data/entity/favori_yemekler.dart';
// FavoriYemeklerCevap sınıfı, favori yemeklerin API cevabını temsil eder
class FavoriYemeklerCevap {
  List<FavoriYemekler> favoriYemekler;
  // API çağrısının başarılı olup olmadığını belirten durum kodu
  int success;

  // FavoriYemeklerCevap sınıfının yapıcı metodu (constructor)
  FavoriYemeklerCevap({
    required this.favoriYemekler,
    required this.success,
  });

  // JSON verilerinden FavoriYemeklerCevap öğesi oluşturan fabrika metodu
  factory FavoriYemeklerCevap.fromJson(Map<String, dynamic> json) {
    // success değerini alır
    int success = json["success"] as int;
    // favori_yemekler dizisini alır
    var jsonArray = json["favori_yemekler"] as List;

    // JSON dizisini FavoriYemekler listesine dönüştürür
    List<FavoriYemekler> favoriYemekler =
    jsonArray.map((jsonArrayNesnesi) => FavoriYemekler.fromJson(jsonArrayNesnesi)).toList();

    // Yeni FavoriYemeklerCevap nesnesini oluşturur ve döndürür
    return FavoriYemeklerCevap(favoriYemekler: favoriYemekler, success: success);
  }
}
