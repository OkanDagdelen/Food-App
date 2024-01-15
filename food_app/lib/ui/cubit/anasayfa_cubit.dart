import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/yemekler.dart';
import 'package:food_app/data/repo/sepet_sayfa_repository.dart';
import 'package:food_app/data/repo/yemeklerdao_repository.dart';



class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit():super(<Yemekler>[]);
  var yrepo = YemeklerDaoRepository();
  var srepo = SepetYemeklerDaoRepository();


  Future <void> yemekleriGetir() async {
    var liste = await yrepo.yemekleriGetir();
    emit(liste);
  }
  Future<void> sepeteYemekEkleme(String yemek_adi , String yemek_resim_adi , int yemek_fiyat , int yemek_siparis_adet ,String kullanici_adi) async {
    await srepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }

  Future<void> yemekleriAra(String aramaKelimesi) async{
    var liste = await yrepo.yemekleriAra(aramaKelimesi);
    emit(liste);
  }

}


