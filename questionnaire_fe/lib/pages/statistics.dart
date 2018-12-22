import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_fe/domain/constants.dart';
import 'package:questionnaire_fe/domain/resultTest.dart';
import 'package:questionnaire_fe/pages/navigation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:questionnaire_fe/pages/result.dart';


class StatisticsPage extends StatefulWidget {

  final List<ResultTest> results;
  const StatisticsPage({Key key, this.results}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _StatisticsPageState(this.results);
}

class _StatisticsPageState extends State<StatisticsPage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  final List<ResultTest> _results;

  _StatisticsPageState(this._results);

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var seriesCan = [
      new charts.Series(
        id: 'Исполнитель',
        domainFn: (_TestPerType testData, _) => testData.type.title,
        measureFn: (_TestPerType testData, _) => testData.count,
        data: _prepareChartData(Work.EXECUTOR, true),
      ),
      new charts.Series(
        id: 'Создатель',
        domainFn: (_TestPerType testData, _) => testData.type.title,
        measureFn: (_TestPerType testData, _) => testData.count,
        data: _prepareChartData(Work.CREATOR, true),
      ),
    ];

    var seriesWant = [
      new charts.Series(
        id: 'Исполнитель',
        domainFn: (_TestPerType testData, _) => testData.type.title,
        measureFn: (_TestPerType testData, _) => testData.count,
        data: _prepareChartData(Work.EXECUTOR, false),
      ),
      new charts.Series(
        id: 'Создатель',
        domainFn: (_TestPerType testData, _) => testData.type.title,
        measureFn: (_TestPerType testData, _) => testData.count,
        data: _prepareChartData(Work.CREATOR, false),
      ),
    ];

    var chartCan = _getBarChart(seriesCan);
    var chartWant = _getBarChart(seriesWant);

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.youtube_searched_for),text: "Результаты поиска"),
            Tab(icon: Icon(Icons.equalizer),text: "Графики")
          ],
          controller: _tabController,
        ),
        title: Text('Статистика'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.separated(
            padding: EdgeInsets.all(16.0),
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => Divider(height: 12.0),
            itemBuilder: (context, index) {
              if(index == 0) return Text(
                "Всего результатов: " + _results.length.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16.0)
              );
              int i = index - 1;
              return ListTile(
                title: Text(
                    DateFormat('yyyy-MM-dd  kk:mm').format(_results[i].date) + ', ' + _results[i].user.gender.title + ', ' +
                        _results[i].user.age.toString() + ', ' + _results[i].user.city + '\n'
                        'Хочу: ' + '"' + _results[i].resultWant.character.title + '-' + _results[i].resultWant.subject.title + '"\n'
                        'Могу: ' + '"' + _results[i].resultCan.character.title + '-' + _results[i].resultCan.subject.title + '"\n'
                ),
                onTap: () => moveWithHistory(context, new ResultPage(_results[i], false)),
                trailing: Icon(Icons.keyboard_arrow_right),
              );
            },
            itemCount: _results.length,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Люди могут:'),
                Padding(
                  padding: new EdgeInsets.all(32.0),
                  child: new SizedBox(
                    height: 300.0,
                    child: chartCan,
                  )
                ),
                Text('Люди хотят:'),
                Padding(
                  padding: new EdgeInsets.all(32.0),
                  child: new SizedBox(
                    height: 300.0,
                    child: chartWant
                  )
                ),
              ]
            )
          )
        ]
      )
    );
  }
  
  _prepareChartData(Work character, bool can) {
    Map<Work, int> data = new Map();
    _results.forEach((res) {
      if(can) {
        if(res.resultCan.character == character) {
          data.update(res.resultCan.subject, (i) => i + 1, ifAbsent: () => 1);
        }
      } else {
        if(res.resultWant.character == character) {
          data.update(res.resultWant.subject, (i) => i + 1, ifAbsent: () => 1);
        }
      }
    });
    List<_TestPerType> result = new List();
    for(var entry in data.entries) {
      result.add(new _TestPerType(entry.key, entry.value));
    }
    return result;
  }

  Widget _getBarChart(List series) {
    return charts.BarChart(
        series,
        defaultRenderer: new charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(30),
          symbolRenderer: new IconRenderer(Icons.work),
        ),
        barGroupingType: charts.BarGroupingType.stacked,
        behaviors: [new charts.SeriesLegend()],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _TestPerType {
  final Work type;
  final int count;

  _TestPerType(this.type, this.count);
}

class IconRenderer extends charts.CustomSymbolRenderer {
  final IconData iconData;

  IconRenderer(this.iconData);

  @override
  Widget build(BuildContext context, {Color color, Size size, bool enabled}) {
    return new SizedBox.fromSize(
        size: size, child: new Icon(iconData, color: color, size: 18.0));
  }
}