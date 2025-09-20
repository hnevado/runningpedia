import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/glossary_remote_data_source.dart';
import 'data/datasources/local_storage.dart';
import 'data/repositories/glossary_repository.dart';
import 'presentation/bloc/glossary_bloc.dart';
import 'presentation/bloc/favorites_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GlossaryBloc(
            glossaryRepository: GlossaryRepositoryImpl(
              remoteDataSource: GlossaryRemoteDataSource(), // Sin baseUrl
              localStorage: LocalStorageImpl(prefs: prefs),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(
            localStorage: LocalStorageImpl(prefs: prefs),
          )..add(LoadFavorites()),
        ),
      ],
      child: MaterialApp(
        title: 'Glosario del running',
        theme: ThemeData(
          primaryColor: Colors.black,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.white,
            brightness: Brightness.light
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Montserrat',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}