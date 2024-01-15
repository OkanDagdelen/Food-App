import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/sepet_yemekler.dart';
import 'package:food_app/data/repo/sepet_sayfa_repository.dart';

// Sepet sayfasının durum yönetimi için Cubit sınıfı
class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  SepetSayfaCubit() : super(<SepetYemekler>[]);

  // Sepet işlemleri için kullanılacak repository
  var srepo = SepetYemeklerDaoRepository();

  // Toplam sepet bilgisini içinde tutacak liste
  List<SepetYemekler> _toplamSepet = [];

  // Kullanıcıya ait sepet yemeklerini getirir ve durumu günceller
  Future<void> sepetYemekleriGetir(String kullanici_adi) async {
    _toplamSepet = await sepetYemekleriTopla(kullanici_adi);
    emit(_toplamSepet);
  }

  // Kullanıcının sepetindeki yemekleri toplar ve benzer yemekleri birleştirir
  Future<List<SepetYemekler>> sepetYemekleriTopla(String kullanici_adi) async {
    var liste = await srepo.sepetYemekleriGetir(kullanici_adi);

    Map<String, SepetYemekler> toplamSepet = {};
    for (var yemek in liste) {
      if (toplamSepet.containsKey(yemek.yemek_adi)) {
        toplamSepet[yemek.yemek_adi]!.yemek_siparis_adet += yemek.yemek_siparis_adet;
      } else {
        toplamSepet[yemek.yemek_adi] = yemek;
      }
    }

    toplamSepet.removeWhere((key, value) => value.yemek_siparis_adet == 0);

    return toplamSepet.values.toList();
  }

  // Kullanıcının sepetini sıfırlar ve durumu günceller
  Future<void> sepetiSifirla(String kullaniciAdi) async {
    await srepo.sepetiSifirla(kullaniciAdi);
    sepetYemekleriGetir(kullaniciAdi);
    emit(<SepetYemekler>[]);
  }

  // Belirtilen sepet yemek ID'sine sahip yemeği sepetten siler ve durumu günceller
  Future<void> sepetYemekSil(int sepet_yemek_id, String kullanici_adi) async {
    await srepo.sepetYemekSil(sepet_yemek_id, kullanici_adi);
    sepetYemekleriGetir(kullanici_adi);
  }

  // Toplam adet ve fiyatı hesaplar
  double toplamAdetVeFiyat(List<SepetYemekler> sepetListesi) {
    double toplamFiyat = 0;
    int toplamAdet = 0;

    for (var yemek in sepetListesi) {
      toplamFiyat += yemek.yemek_siparis_adet * double.parse(yemek.yemek_fiyat);
      toplamAdet += yemek.yemek_siparis_adet;
    }
    return toplamFiyat;
  }
}
