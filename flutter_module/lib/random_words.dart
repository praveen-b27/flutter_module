import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';

class RandomWords extends StatefulWidget {
  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  var _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  static const platform = const MethodChannel('flutter.native/helper');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              platform.invokeMethod('onBackPressed');
            }),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    _suggestions = generateWordPairs().take(30).toList();
    ScrollController _controller = new ScrollController();

    return ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.all(16.0),
        itemCount: 30,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return GestureDetector(
        onTap: () {
          print('object tapped');
        },
        child: ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      ),
    );
  }
}
