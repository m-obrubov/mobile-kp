import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/navigation.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  List<String> results;

  @override
  Widget build(BuildContext context) {
    _search();

    return Scaffold(
      appBar: AppBar(
        title: Text('Статистика'),
      ),
      body: _resultList()
    );
  }

  void _search() {
    results = [
      '21.10.2018\n'
          'Предмет труда: человек\n'
          'Характер труда: исполнительские профессии',
      '23.10.2018\n'
          'Предмет труда: техника\n'
          'Характер труда: творческие профессии',
      '22.10.2018\n'
          'Предмет труда: знаковая система\n'
          'Характер труда: исполнительские профессии',
      '23.10.2018\n'
          'Предмет труда: природа\n'
          'Характер труда: творческие профессии'
    ];
    setState(() {
      //TODO логика поиска по фильтру
    });
  }

  Widget _resultList() {
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider(height: 12.0);
        final index = i ~/ 2;
        return ListTile(
          title: Text(
              results[index]
          ),
          onTap: () => moveWithHistory(context, null /* Страница с результатами*/),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
      },
      itemCount: results.length * 2,
      padding: EdgeInsets.all(16.0),
    );
  }
}