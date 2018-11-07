import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/navigation.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> results;

  @override
  Widget build(BuildContext context) {
    _search();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Статистика'),
        actions : <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ListTile(
                          leading: new Icon(Icons.music_note),
                          title: new Text('Music'),
                        ),
                        new ListTile(
                          leading: new Icon(Icons.photo_album),
                          title: new Text('Photos'),
                        ),
                        new ListTile(
                          leading: new Icon(Icons.videocam),
                          title: new Text('Video'),
                        ),
                      ],
                    );
                  });
            },
          )
        ],
      ),
      body: _resultList(),
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


/*

Column(
  children: <Widget>[
    Text('Дата'),
    Row(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Дата'),
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {},
        )
      ],
    )
  ],
)

*/