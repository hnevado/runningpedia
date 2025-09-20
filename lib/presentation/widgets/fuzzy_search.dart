import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import '../../data/models/wine_term.dart';

class FuzzySearch {
  static List<WineTerm> search(String query, List<WineTerm> terms) {
    if (query.isEmpty) return terms;
    
    final results = extractTop(
      query: query,
      choices: terms,
      getter: (term) => '${term.termino} ${term.sinonimos.join(' ')} ${term.categoria}',
      cutoff: 70,
      limit: terms.length,
    );
    
    return results.map((result) => result.choice).toList();
  }
}