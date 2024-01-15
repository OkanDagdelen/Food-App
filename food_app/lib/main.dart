import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/ui/cubit/anasayfa_cubit.dart';
import 'package:food_app/ui/cubit/favoriler_sayfa_cubit.dart';
import 'package:food_app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:food_app/ui/views/navigation_bar.dart';

void main() {
  // Uygulama çalıştırılıyor
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider, uygulama düzeyindeki BLoC'ları yönetir
    return MultiBlocProvider(
      // BlocProvider'lar burada tanımlanır ve her biri ilgili BLoC'yu oluşturur
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
        BlocProvider(create: (context) => FavoriSayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.transparent,
        ),
        home: HomeBottomNavigationBar(),
      ),
    );
  }
}
