import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_fe/domain/constants.dart';
import 'package:questionnaire_fe/pages/button.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:questionnaire_fe/pages/statistics.dart';

class StatisticsFilterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _StatisticsFilterPageState();
}

class _StatisticsFilterPageState extends State<StatisticsFilterPage> {
  DateTime _dateFrom = DateTime.now();
  DateTime _dateTo = DateTime.now();
  TextEditingController _cityController = new TextEditingController();
  Constant _gender;
  TextEditingController _ageFromController = new TextEditingController();
  TextEditingController _ageToController = new TextEditingController();

  final _textStyle = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фильтры'),
      ),
      body: SingleChildScrollView(
        padding: new EdgeInsets.all(16.0),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Дата',
              style: _textStyle,
            ),
            _DatePicker(
              labelText: 'С',
              selectedDate: _dateFrom,
              selectDate: (date) {
                setState(() {
                  _dateFrom = date;
                });
              },
            ),
            Divider(),
            _DatePicker(
              labelText: 'По',
              selectedDate: _dateTo,
              selectDate: (date) {
                setState(() {
                  _dateTo = date;
                });
              },
            ),
            Divider(),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Город',
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Пол',
                  style: _textStyle,
                ),
                SizedBox(width: 16.0,),
                DropdownButton<String>(
                  value: _gender != null ? _gender.title : null,
                  hint: Text('Выберите пол'),
                  items: <String>['Мужской', 'Женский'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Text(value)
                    );
                  }).toList(),
                  onChanged: (String value) { setState(() {
                    _gender = Gender.fromTitle(value);
                  }); },
                ),
              ],
            ),
            Divider(),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Возраст',
                    style: _textStyle,
                  ),
                  SizedBox(width: 16.0),
                  Flexible(
                    child: TextField(
                      controller: _ageFromController,
                      decoration: InputDecoration(
                          labelText: 'С'
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Flexible(
                    child: TextField(
                      controller: _ageToController,
                      decoration: InputDecoration(
                        labelText: 'По',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),

            Divider(),
            WideRaisedButton(
              onPressed: () {
                setState(() {
                  _dateFrom = DateTime.now();
                  _dateTo = DateTime.now();
                  _cityController.text = '';
                  _gender = null;
                  _ageFromController.text = '';
                  _ageToController.text = '';
                });
              },
              text: "Сбросить",
              color: Theme.of(context).buttonColor,
              textColor: Colors.black,
            ),
            WideRaisedButton(
              onPressed: () => moveWithHistory(context, new StatisticsPage()),
              text: "Найти",
            ),
          ],
        )
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;

  _DatePicker({Key key, this.labelText, this.selectedDate, this.selectDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(DateFormat.yMMMd().format(selectedDate), style: valueStyle),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }
}
