import 'package:flutter/material.dart';
import 'package:questionnaire_fe/pages/edit_profile.dart';
import 'package:questionnaire_fe/pages/navigation.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var results = <String>[
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => moveWithHistory(context, new EditProfilePage())
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Иван Иванов",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "21 год",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Москва",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
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
            ),
          )
        ],
      ),
    );
  }

}