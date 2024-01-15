class FavoriYemekler {
  String favori_yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  String yemek_fiyat;
  int yemek_siparis_adet;
  String kullanici_adi;

  // FavoriYemekler sınıfının yapıcı metodu (constructor)
  FavoriYemekler({
    required this.favori_yemek_id,
    required this.yemek_adi,
    required this.yemek_resim_adi,
    required this.yemek_fiyat,
    required this.yemek_siparis_adet,
    required this.kullanici_adi,
  });

  // JSON verilerinden FavoriYemekler öğesi oluşturan fabrika metodu
  factory FavoriYemekler.fromJson(Map<String, dynamic> json) {
    return FavoriYemekler(
      favori_yemek_id: json["favori_yemek_id"] as String,
      yemek_adi: json["yemek_adi"] as String,
      yemek_resim_adi: json["yemek_resim_adi"] as String,
      yemek_fiyat: json["yemek_fiyat"] as String,
      yemek_siparis_adet: json["yemek_siparis_adet"] is String
          ? int.parse(json["yemek_siparis_adet"])
          : json["yemek_siparis_adet"] as int,
      kullanici_adi: json["kullanici_adi"] as String,
    );
  }
}
