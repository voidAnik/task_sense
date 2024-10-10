import 'package:flutter/material.dart';

class TaskSearchDelegate extends SearchDelegate<String> {
  // These methods are mandatory you cannot skip them.

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // Build the search results.
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
    // Build the search suggestions.
  }
}
