import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/yemekler.dart';

class FavoriSayfaCubit extends Cubit<List<Yemekler>> {
  FavoriSayfaCubit() : super([]);

  void favoriyeEkle(Yemekler yemek) {
    if (!state.contains(yemek)) {
      emit(List.from(state)..add(yemek));
    }
  }

  void favoridenCikar(Yemekler yemek) {
    if (state.contains(yemek)) {
      emit(List.from(state)..remove(yemek));
    }
  }
}