import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_fe/domain/answer.dart';
import 'package:questionnaire_fe/domain/profession.dart';
import 'package:questionnaire_fe/domain/question.dart';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class StatisticsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _StatisticsPageState();

}

class _StatisticsPageState extends State<StatisticsPage> {

  List<ResultTest> _results;
  List<charts.Series> seriesList;
  List<charts.Series> seriesList2;
  List<charts.Series> seriesList3;
  bool animate;

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];

  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData2() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData3() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 1), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 2), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 3), 25),
      new TimeSeriesSales(new DateTime(2017, 9, 4), 100),
      new TimeSeriesSales(new DateTime(2017, 9, 5), 75),
      new TimeSeriesSales(new DateTime(2017, 9, 6), 88),
      new TimeSeriesSales(new DateTime(2017, 9, 7), 65),
      new TimeSeriesSales(new DateTime(2017, 9, 8), 91),
      new TimeSeriesSales(new DateTime(2017, 9, 9), 100),
      new TimeSeriesSales(new DateTime(2017, 9, 10), 111),
      new TimeSeriesSales(new DateTime(2017, 9, 11), 90),
      new TimeSeriesSales(new DateTime(2017, 9, 12), 50),
      new TimeSeriesSales(new DateTime(2017, 9, 13), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 14), 30),
      new TimeSeriesSales(new DateTime(2017, 9, 15), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 16), 50),
      new TimeSeriesSales(new DateTime(2017, 9, 17), 30),
      new TimeSeriesSales(new DateTime(2017, 9, 18), 35),
      new TimeSeriesSales(new DateTime(2017, 9, 19), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 20), 32),
      new TimeSeriesSales(new DateTime(2017, 9, 21), 31),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

_StatisticsPageState(){
    _results  = new List();
    List<Profession> professions = new List();
    professions.add(new Profession("1","Строит дома и не только!","Архитектор"));
    professions.add(new Profession("1","Картиты его конек!","Художник"));
    professions.add(new Profession("1","Что я слышу? Это же музыкант!","Музыкант"));
    professions.add(new Profession("1","Стой! Стой! Стой! Блин ну ты танцор!","Хореограф"));
    String description = "Вы уверенный в себе и амбициозный человек, для вас нет нечего невозможного. Выша жизнь не возможна без творчества!";
    List<Answer> answers1 = new List();
    List<Answer> answers2 = new List();
    List<Answer> answers3 = new List();
    answers1.add(new Answer("4", "Рисовать"));
    answers2.add(new Answer("1", "Семья"));
    answers3.add(new Answer("3", "Очень люблю"));
    List<QuestionWithAnswers> questions = new List();
    questions.add(new QuestionWithAnswers("1",1,"Чего ты хочешь?",answers1));
    questions.add(new QuestionWithAnswers("2",2,"Что для тебя важно?",answers2));
    questions.add(new QuestionWithAnswers("3",3,"Любишь ли ты программировать?",answers3));
    _results.add(new ResultTest("1",description, professions, questions,"природа","творческие профессии",DateTime.now()));
    _results.add(new ResultTest("1",description, professions, questions,"природа","творческие профессии",DateTime.now()));
    _results.add(new ResultTest("1",description, professions, questions,"природа","творческие профессии",DateTime.now()));
    seriesList = _createSampleData();
    seriesList2 = _createSampleData2();
    seriesList3 = _createSampleData3();
    animate = false;
  }


  @override
  Widget build(BuildContext context) {
    _search();
    return MaterialApp(
        home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.youtube_searched_for),text: "Результаты поиска",),
                    Tab(icon: Icon(Icons.equalizer),text: "Графики",)
                  ],
                ),
            title: Text('Статистика'),
        ),
            body: TabBarView(children: [
              _resultList(),
            SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                        height: 300.0,
                        child: charts.PieChart(seriesList, animate: animate)
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.PieChart(seriesList,
                              animate: animate,
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 60,
                                  arcRendererDecorators: [new charts.ArcLabelDecorator()]))
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.PieChart(seriesList,
                              animate: animate,
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 30, startAngle: 4 / 5 * 3.14, arcLength: 7 / 5 * 3.14))),
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.BarChart(
                            seriesList2,
                            animate: animate,
                            defaultRenderer: new charts.BarRendererConfig(
                                cornerStrategy: const charts.ConstCornerStrategy(30)),
                          )
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.TimeSeriesChart(
                            seriesList3,
                            animate: animate,
                            dateTimeFactory: const charts.LocalDateTimeFactory(),
                          )
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.BarChart(
                            seriesList2,
                            animate: animate,
                            barGroupingType: charts.BarGroupingType.grouped,
                            vertical: false,
                            primaryMeasureAxis: new charts.NumericAxisSpec(
                                tickProviderSpec:
                                new charts.BasicNumericTickProviderSpec(desiredTickCount: 3)),
                            secondaryMeasureAxis: new charts.NumericAxisSpec(
                                tickProviderSpec:
                                new charts.BasicNumericTickProviderSpec(desiredTickCount: 3)),
                          )
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.BarChart(
                            seriesList2,
                            animate: animate,
                            primaryMeasureAxis: new charts.NumericAxisSpec(
                                renderSpec: new charts.SmallTickRendererSpec(
                                  // Tick and Label styling here.
                                )),
                          )
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.LineChart(seriesList,
                              defaultRenderer:
                              new charts.LineRendererConfig(includeArea: true, stacked: true),
                              animate: animate)
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.BarChart(seriesList2, animate: animate)
                      )
                  ),
                  Padding(
                      padding: new EdgeInsets.all(32.0),
                      child: new SizedBox(
                          height: 300.0,
                          child: charts.TimeSeriesChart(
                            seriesList3,
                            animate: animate,
                            defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                            domainAxis: new charts.DateTimeAxisSpec(usingBarRenderer: true),
                            defaultInteractions: false,
                            behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
                          )
                      )
                  ),
                ]

            )
            )
//                  primaryMeasureAxis: new charts.PieChart(seriesList, animate: animate),
//                primaryMeasureAxis: new charts.PieChart(seriesList, animate: animate)


            ])
        ))
    );
  }

  void _search() {
    setState(() {
      //TODO логика поиска по фильтру
    });
  }

  Widget _resultList() {
    List<Widget> listResult = new List();
    Widget widget;

    for (int i = 0; i < _results.length; i++) {
    listResult.add(
         ListTile(
          title: Text(
              DateFormat('yyyy-MM-dd  kk:mm').format(_results[i].date)+'\n'
                  'Предмет труда: ' + _results[i].group + '\n'
                  'Характер труда: ' + _results[i].part,
          ),
          onTap: () => moveWithHistory(context, null /* Страница с результатами*/),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
    );
    };
    widget = new Column(children: listResult);
    return widget;
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}