import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_scaffold/utils/extend_date_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// 标签页页面
class TabBarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State with TickerProviderStateMixin {
  bool _processing = false;

  late TabController _tabController;

  late _DataSearchParam _dataSearchParam;

  late final Image _dataTableImage;

  late TooltipBehavior _tooltip;

  late List<_ChartData> _chartData;

  String _dataType = '进出水';

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final DateFormat _monthFormat = DateFormat('yyyy-MM');

  GlobalKey _chartTypeKey = GlobalKey();

  List<Color> _paletteList = [
    Color.fromARGB(0xFF, 0xFF, 0x74, 0x00),
    Color.fromARGB(0xFF, 0x00, 0xCC, 0x00),
    Color.fromARGB(0xFF, 0xEF, 0x63, 0x75),
    Color.fromARGB(0xFF, 0x2E, 0xA2, 0xE5),
    Color.fromARGB(0xFF, 0x00, 0xC5, 0xCD),
    Color.fromARGB(0xFF, 0xC1, 0xFF, 0xC1),
  ];

  @override
  void initState() {
    super.initState();

    _dataSearchParam = _DataSearchParam(
        currentDate: ExtendDateUtils.getYesterday(),
        tabParamList: <Map<String, dynamic>>[
          {},
          {'chartType': '进出水', '环比': true, '同比': false},
        ]);

    _tabController = TabController(length: 4, vsync: this);

    _dataTableImage =
        Image.asset('assets/images/dataTableImage.png', fit: BoxFit.fitWidth);

    _tooltip = TooltipBehavior(enable: true);

    _chartData = [
      _ChartData('2021-09', [169744, 154680, 0.57, -1.08]),
      _ChartData('2021-10', [156366, 144464, -3.42, -5.59]),
      _ChartData('2021-11', [170921, 152842, 2, 5.47]),
      _ChartData('2021-12', [162003, 159680, -6.77, -7.05]),
      _ChartData('2022-01', [169015, 145312, 5.55, 4.63]),
      _ChartData('2022-02', [166129, 154620, 9.05, 8.54]),
      _ChartData('2022-03', [163161, 155784, -26.63, -27.79]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 138, 101, 1),
        title: const Text('太湖厂 月报'),
        actions: [
          // IconButton(
          //     onPressed: _processing
          //         ? null
          //         : () {
          //             _showDataSearchDialog(context);
          //           },
          //     icon: Icon(Icons.filter_alt),
          //     tooltip: '数据筛选'
          // ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: FaIcon(FontAwesomeIcons.table),
              text: '数据表',
            ),
            Tab(
              icon: FaIcon(FontAwesomeIcons.industry),
              text: '处理量',
            ),
            Tab(
              icon: FaIcon(FontAwesomeIcons.water),
              text: '水质',
            ),
            Tab(
              icon: FaIcon(FontAwesomeIcons.chargingStation),
              text: '物耗',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _getTableTabBarView(),
          _getChartTabBarView(),
          Center(
            child: Text("It's sunny here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }

  Widget _getTableTabBarView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        Row(
          children: [
            // Text('日期:'),
            ActionChip(
                // avatar: Icon(Icons.today),
                label: Text(_monthFormat.format(_dataSearchParam.currentDate)),
                onPressed: _showDatePickerDialog),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        _dataTableImage,
      ]),
    );
  }

  Widget _getChartTabBarView() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          // Row(
          //   children: [
          //     Text('处理量：'),
          //     DropdownButton<String>(
          //       value: _dataType,
          //       onChanged: (String? newValue) {
          //         setState(() {
          //           _dataType = newValue!;
          //         });
          //       },
          //       items: <String>['进出水', '污泥', 'BOD5去除量', 'COD去除量']
          //           .map<DropdownMenuItem<String>>((String value) {
          //         return DropdownMenuItem<String>(
          //           value: value,
          //           child: Text(value),
          //         );
          //       }).toList(),
          //     ),
          //   ],
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text('日期:'),
              ActionChip(
                  // avatar: Icon(Icons.today),
                  label: Text(_monthFormat.format(_dataSearchParam.currentDate)),
                  onPressed: _showDatePickerDialog),
              // SizedBox(
              //   width: 16,
              // ),
              // Text('处理量:'),
              ActionChip(
                  key: _chartTypeKey,
                  label: Text(_dataSearchParam.tabParamList[1]['chartType']),
                  onPressed: () {
                    _showCharTypeDialog(context);
                  }),
              // SizedBox(
              //   width: 16,
              // ),
              // Text('对比:'),
              FilterChip(
                  label: Text('环比'),
                  selected: true == _dataSearchParam.tabParamList[1]['环比'],
                  onSelected: (bool val) {
                    setState(() {
                      _dataSearchParam.tabParamList[1]['环比'] =
                          !_dataSearchParam.tabParamList[1]['环比'];
                    });
                  }),
              FilterChip(
                  label: Text('同比'),
                  selected: true == _dataSearchParam.tabParamList[1]['同比'],
                  onSelected: (bool val) {
                    setState(() {
                      _dataSearchParam.tabParamList[1]['同比'] =
                          !_dataSearchParam.tabParamList[1]['同比'];
                    });
                  }),
            ],
          ),

          SizedBox(
            height: 16,
          ),

          SfCartesianChart(
            // title: ChartTitle(text: '处理量'),
            borderWidth: 0,
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            axes: [
              NumericAxis(
                name: '对比',
                opposedPosition: true,
              )
            ],
            tooltipBehavior: _tooltip,
            legend: Legend(isVisible: true, position: LegendPosition.top),
            palette: _paletteList,
            series: _getChartSeries(),
          ),
        ]));
  }

  List<ChartSeries<_ChartData, String>> _getChartSeries() {
    List<ChartSeries<_ChartData, String>> series = [
      ColumnSeries<_ChartData, String>(
        dataSource: _chartData,
        xValueMapper: (_ChartData data, _) => data.x,
        yValueMapper: (_ChartData data, _) => data.y[0],
        name: '进水',
        // dataLabelSettings: DataLabelSettings(
        //     isVisible: true,
        //     labelAlignment: ChartDataLabelAlignment.bottom),
      ),
      ColumnSeries<_ChartData, String>(
        dataSource: _chartData,
        xValueMapper: (_ChartData data, _) => data.x,
        yValueMapper: (_ChartData data, _) => data.y[1],
        name: '出水',
        // dataLabelSettings: DataLabelSettings(
        //   isVisible: true,
        // ),
      ),
    ];

    if (_dataSearchParam.tabParamList[1]['环比']) {
      series.add(LineSeries<_ChartData, String>(
        dataSource: _chartData,
        xValueMapper: (_ChartData data, _) => data.x,
        yValueMapper: (_ChartData data, _) => data.y[2],
        name: '进水环比',
        yAxisName: '对比',
        // dataLabelSettings: DataLabelSettings(
        //   isVisible: true,
        // ),
      ));
      series.add(LineSeries<_ChartData, String>(
        dataSource: _chartData,
        xValueMapper: (_ChartData data, _) => data.x,
        yValueMapper: (_ChartData data, _) => data.y[3],
        name: '出水环比',
        yAxisName: '对比',
        // dataLabelSettings: DataLabelSettings(
        //   isVisible: true,
        // ),
      ));
    }

    return series;
  }

  void _showDataSearchDialog(BuildContext context) async {
    _DataSearchParam? _newParam =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return _DataSearchScreen(_dataSearchParam, _tabController.index);
            },
            fullscreenDialog: true));

    if (_newParam != null) {
      // 更新数据
      setState(() {
        _dataSearchParam = _newParam;
      });
    }
  }

  /// 日期选择弹出框
  void _showDatePickerDialog() async {
    DateTime? newDate = await showMonthPicker(
      context: context,
      initialDate: _dataSearchParam.currentDate,
      firstDate: DateTime(2020, 1, 1),
      lastDate: ExtendDateUtils.getYesterday(),
      // initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (newDate != null &&
        newDate.compareTo(_dataSearchParam.currentDate) != 0) {
      setState(() {
        _dataSearchParam.currentDate = newDate;
      });
    }
  }

  void _showCharTypeDialog(BuildContext context) async {
    // 获取位置
    final RenderBox? renderBox =
        _chartTypeKey.currentContext?.findRenderObject() as RenderBox;
    final Size? size = _chartTypeKey.currentContext?.size;
    final position = renderBox?.localToGlobal(Offset.zero);

    String? newChartType = await showMenu<String>(
        context: context,
        position: (position != null && size != null)
            ? RelativeRect.fromLTRB(position.dx, position.dx,
                position.dx + size.width, position.dx + size.height)
            : RelativeRect.fromLTRB(100, 100, 100, 100),
        items: <PopupMenuEntry<String>>[
          PopupMenuItem(
            value: '进出水',
            child: Text('进出水'),
          ),
          PopupMenuItem(
            value: '污泥',
            child: Text('污泥'),
          ),
          PopupMenuItem(
            value: 'COD去除总量',
            child: Text('COD去除总量'),
          ),
          PopupMenuItem(
            value: 'BOD5去除总量',
            child: Text('BOD5去除总量'),
          ),
          PopupMenuItem(
            value: '...',
            child: Text('...'),
          ),
        ]);

    if (newChartType != null &&
        newChartType != _dataSearchParam.tabParamList[1]['chartType']) {
      setState(() {
        _dataSearchParam.tabParamList[1]['chartType'] = newChartType;
      });
    }
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final List<double> y;
}

/// 数据筛选全屏对话框
class _DataSearchScreen extends StatelessWidget {
  late _DataSearchParam _dataSearchParam;
  late int _tabIndex;

  _DataSearchScreen(this._dataSearchParam, this._tabIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromRGBO(255, 138, 101, 1),
        title: Text('搜索参数'),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(children: _getDataSearchFields(context))),
    );
  }

  List<Widget> _getDataSearchFields(BuildContext context) {
    List<Widget> list = [
      FormBuilderDateTimePicker(
        name: 'date',
        format: DateFormat('yyyy-MM-dd'),
        inputType: InputType.date,
        initialValue: _dataSearchParam.currentDate,
        firstDate: DateTime(2020, 1, 1),
        lastDate: ExtendDateUtils.getYesterday(),
        decoration: InputDecoration(icon: Icon(Icons.today), labelText: '日期'),
        onChanged: (DateTime? newDate) {
          if (newDate != null) {
            _dataSearchParam.currentDate = newDate;
          }
        },
      )
    ];

    if (_tabIndex == 1) {
      list.add(FormBuilderDropdown<String>(
        name: 'processChartType',
        initialValue: _dataSearchParam.tabParamList[1]['chartType'],
        items: [
          DropdownMenuItem(
            value: '进出水',
            child: Text('进出水'),
          ),
          DropdownMenuItem(
            value: '污泥',
            child: Text('污泥'),
          ),
          DropdownMenuItem(
            value: 'COD去除总量',
            child: Text('COD去除总量'),
          ),
          DropdownMenuItem(
            value: 'BOD5去除总量',
            child: Text('BOD5去除总量'),
          ),
          DropdownMenuItem(
            value: '...',
            child: Text('...'),
          ),
        ],
        onChanged: (String? newVal) {
          if (newVal != null) {
            _dataSearchParam.tabParamList[1]['chartType'] = newVal;
          }
        },
        decoration:
            InputDecoration(icon: Icon(Icons.category), labelText: '处理量'),
      ));
    }

    list.add(ButtonBar(
      children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('取消')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_dataSearchParam);
            },
            child: Text('确定'))
      ],
    ));

    return list;
  }
}

class _DataSearchParam {
  late DateTime currentDate;
  late List<Map<String, dynamic>> tabParamList;

  _DataSearchParam({required this.currentDate, required this.tabParamList});
}
