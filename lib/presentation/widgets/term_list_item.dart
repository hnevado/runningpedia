import 'package:flutter/material.dart';
import '../../data/models/wine_term.dart';

class TermListItem extends StatelessWidget {
  final WineTerm term;
  final VoidCallback onTap;

  const TermListItem({
    Key? key,
    required this.term,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ListTile(
        title: Text(
          term.termino,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF800020),
          ),
        ),
        subtitle: Text(term.definicionCorta),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}