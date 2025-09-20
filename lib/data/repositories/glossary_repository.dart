import '../datasources/glossary_remote_data_source.dart';
import '../datasources/local_storage.dart';
import '../models/wine_term.dart';

abstract class GlossaryRepository {
  Future<List<WineTerm>> getGlossary();
}

class GlossaryRepositoryImpl implements GlossaryRepository {
  final GlossaryRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;

  GlossaryRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
  });

  @override
  Future<List<WineTerm>> getGlossary() async {
    return await remoteDataSource.fetchGlossary();
  }
}