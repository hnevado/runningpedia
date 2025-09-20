import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/glossary_bloc.dart';

class WineSearchBar extends StatefulWidget {
  const WineSearchBar({Key? key}) : super(key: key);

  @override
  _WineSearchBarState createState() => _WineSearchBarState();
}

class _WineSearchBarState extends State<WineSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlossaryBloc, GlossaryState>(
      listener: (context, state) {
        if (state is GlossaryLoaded) {
          setState(() {
            _isSearching = state.searchQuery?.isNotEmpty ?? false;
            if (!_isSearching) {
              _controller.clear();
            }
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (_isSearching)
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<GlossaryBloc>().add(ResetSearch());
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                },
              ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Buscar término...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (value) {
                  context.read<GlossaryBloc>().add(SearchGlossary(query: value));
                },
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    context.read<GlossaryBloc>().add(ResetSearch());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}