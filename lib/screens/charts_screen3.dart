import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_scaffold/components/rounded_rectangle_choice_chip.dart';
import 'package:flutter_scaffold/utils/extend_date_utils.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/// 图表页面
class ChartsScreen3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChartsScreen3State();
}

class _ChartsScreen3State extends State with TickerProviderStateMixin {
  static final List<String> _secondaryRouteList = [
    '/daily',
    '/monthly',
    '/annual',
    '/multi'
  ];
  static final List<String> _screenNameList = ['日报', '月报', '年报', '三厂统计'];
  static final List<String> _plantAreaList = [
    '芦村一二三期',
    '芦村四期',
    '芦村全厂',
    '太湖',
    '城北'
  ];
  static final List<String> _plantList = ['芦村', '太湖', '城北'];
  static final List<String> _processTypeList = [
    '进水总量',
    '出水总量',
    '污泥总量',
    'BOD₅去除量',
    'COD去除量',
    'NH₃-N去除量',
    'SS去除量',
    'TN去除量',
    'TP去除量',
  ];
  static final List<String> _waterQualityTypeList = [
    'COD 化学需氧量进水',
    'COD 化学需氧量出水',
    'BOD 生化需氧量进水',
    'BOD 生化需氧量出水',
    'SS 固体悬浮物进水',
    'SS 固体悬浮物出水',
    'TP 总磷进水',
    'TP 总磷出水',
    'NH3 氨氮进水',
    'NH3 氨氮出水',
    'TN 总氮进水',
    'TN 总氮出水',
  ];

  static final List<String> _chemicalTypeList = [
    '电耗',
    '千吨水电耗',
    '絮凝剂',
    '冰醋酸',
    '次氯酸钠',
    '聚合氯化铝',
    '次氯酸钠消毒',
    '乙酸钠'
  ];
  static final List<String> _timeUnitList = [
    '天',
    '月',
    '年',
    '周',
    // '自定义',
  ];
  static final List<String> _dataCategoryList = ['水质', '处理量', '运行', '物耗'];

  late int _currentIndex;

  bool _processing = false;
  bool _loadMoreTable = false;
  bool _loadMoreCharts = false;

  int _contentStep = 1;

  // 图表是否使用自定义时间范围
  bool _customChartDateRange = false;

  late TabController _tabController;

  late _DataSearchParam _dataSearchParam;

  late final Image _dataTableImage;
  late final Image _dataTableImage2;

  // late final Image _halfDataTableImage;

  late TooltipBehavior _tooltip;

  late List<_ChartData> _chartData;

  String _dataType = '进出水';
  late String _plantArea;
  late String _processType;
  late String _timeUnit;
  late List<String> _selectedPlantList = [];
  late List<String> _selectedDataCategoryList = [];
  List<bool> _dailyTablePanelState = List<bool>.filled(4, false);
  List<bool> _monthlyTablePanelState = List<bool>.filled(8, false);
  late List<bool> _chartPanelState;

  late DateFormat _dateFormat;
  final List<DateFormat> _dateFormatList = [
    DateFormat('yyyy/MM/dd'),
    DateFormat('yyyy/MM'),
    DateFormat('yyyy'),
  ];

  GlobalKey _chartTypeKey = GlobalKey();

  List<Color> _paletteList = [
    Color.fromRGBO(0x21, 0xB2, 0x70, 1),
    Color.fromRGBO(0xFF, 0x74, 0x00, 1),
    Color.fromRGBO(0x00, 0xCC, 0x00, 1),
    Color.fromRGBO(0xEF, 0x63, 0x75, 1),
    Color.fromRGBO(0x2E, 0xA2, 0xE5, 1),
    Color.fromRGBO(0x00, 0xC5, 0xCD, 1),
    Color.fromRGBO(0xC1, 0xFF, 0xC1, 1),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _plantArea = _plantAreaList[0];
    _processType = _processTypeList[0];
    _timeUnit = _timeUnitList[_currentIndex];
    _dateFormat = _dateFormatList[_currentIndex];
    _selectedPlantList.addAll(_plantList);
    _selectedDataCategoryList.addAll(_dataCategoryList);

    _chartPanelState = List<bool>.filled(
        _processTypeList.length +
            _waterQualityTypeList.length +
            _chemicalTypeList.length,
        false);

    _dataSearchParam = _DataSearchParam(
        currentDate: ExtendDateUtils.getYesterday(),
        tabParamList: <Map<String, dynamic>>[
          {},
          {'chartType': '进出水', '环比': true, '同比': false},
        ]);

    _tabController = TabController(length: 4, vsync: this);

    _dataTableImage =
        Image.asset('assets/images/dataTableImage.png', fit: BoxFit.fitWidth);

    _dataTableImage2 =
        Image.asset('assets/images/sanChang.png', fit: BoxFit.fitWidth);

    _tooltip = TooltipBehavior(enable: true);

    _chartData = [
      _ChartData('2021/09', [169744, 154680, 0.57, -1.08]),
      _ChartData('2021/10', [156366, 144464, -3.42, -5.59]),
      _ChartData('2021/11', [170921, 152842, 2, 5.47]),
      _ChartData('2021/12', [162003, 159680, -6.77, -7.05]),
      _ChartData('2022/01', [169015, 145312, 5.55, 4.63]),
      _ChartData('2022/02', [166129, 154620, 9.05, 8.54]),
      _ChartData('2022/03', [163161, 155784, -26.63, -27.79]),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _currentIndex = _getRouteIndex(context);
  }

  // int _getRouteIndex(BuildContext context) {
  //   // FlutterScaffoldRouterDelegate delegate = FlutterScaffoldRouterDelegate.of(context);
  //   // FlutterScaffoldRouteConfiguration? configuration = delegate.currentConfiguration;
  //   // String currentPath = configuration?.name;
  //   int index = 0;
  //   FlutterScaffoldRouterDelegate delegate =
  //   FlutterScaffoldRouterDelegate.of(context);
  //   if (delegate != null) {
  //     FlutterScaffoldRouteConfiguration? currentRoute =
  //         delegate.currentConfiguration;
  //     if (currentRoute != null) {
  //       String secondaryPath =
  //       currentRoute.name.substring(currentRoute.name.lastIndexOf('/'));
  //       index = _secondaryRoutes.indexOf(secondaryPath);
  //     }
  //   }
  //
  //   return index > 0 ? index : 0;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 138, 101, 1),
        title: Text(_screenNameList[_currentIndex]),
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: _currentIndex > 2
                ? _getMultiReportWidgets(context)
                : _getReportWidgets(context)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(0xFF, 0xC1, 0x4D, 0x20),
        unselectedItemColor: Color.fromARGB(0xFF, 0x73, 0x73, 0x73),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.light_mode),
            label: '日报',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.dark_mode),
            label: '月报',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.event_note),
            label: '年报',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.device_hub),
            label: '三厂统计',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          // 选择不同时才执行，切换时把最后一个路由弹出，换上新的
          if (index != _currentIndex) {
            // FlutterScaffoldRouterDelegate delegate =
            // FlutterScaffoldRouterDelegate.of(context);
            // List<FlutterScaffoldRouteConfiguration> stack =
            // delegate.routeStack.sublist(0, delegate.routeStack.length - 1);
            // stack.add(FlutterScaffoldRouteConfiguration(
            //     "/nestedRoute" + _secondaryRoutes[index]));
            // delegate.routeStack = stack;
            setState(() {
              _currentIndex = index;
              if (index < 3) {
                _timeUnit = _timeUnitList[index];
                _dateFormat = _dateFormatList[index];
              }
            });
          }
        },
        // showUnselectedLabels: true,
      ),
    );
  }

  List<Widget> _getReportWidgets(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text('水厂:'),
          DropdownButton(
            underline: Container(height: 1),
            value: _plantArea,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            items: _plantAreaList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _plantArea = newValue!;
              });
            },
          ),
          // Text('日期:'),
          TextButton(
            onPressed: () {
              _showDatePickerDialogIOS(context, _timeUnit);
            },
            // icon: Icon(Icons.calendar_month),
            child: Text(_dateFormat.format(_dataSearchParam.currentDate)),
            style: TextButton.styleFrom(
              primary: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
          // ActionChip(
          //     // avatar: Icon(Icons.today),
          //     label: Text(_dateFormat.format(_dataSearchParam.currentDate)),
          //     onPressed: () {
          //       _showDatePickerDialogIOS(context, _timeUnit);
          //     }),
        ],
      ),
      SizedBox(
        height: 16,
      ),
      Text(
        _plantArea + _screenNameList[_currentIndex],
        style: Theme.of(context).textTheme.headline6,
      ),
      SizedBox(
        height: 4,
      ),
      Text(
        _dateFormat.format(_dataSearchParam.currentDate),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      SizedBox(
        height: 4,
      ),
      _currentIndex == 0 ? _getDailyTable(context) : _getMonthlyTable(context),

      // ExpansionPanelList(
      //     elevation: 0,
      //     expansionCallback: (int panelIndex, bool isExpanded) {
      //       setState(() {
      //         _chartPanelState[panelIndex] = !_chartPanelState[panelIndex];
      //       });
      //     },
      //     children: _getChartExpansionPanelList()),

      // ClipRect(
      //   child: Align(
      //     alignment: Alignment.topCenter,
      //     heightFactor: _loadMoreCharts ? 1 : 0.5,
      //     child: Column(
      //       children: [
      //         // SizedBox(
      //         //   height: 16,
      //         // ),
      //       ],
      //     ),
      //   ),
      // ),
      // if (!_loadMoreCharts)
      //   TextButton(
      //       style: TextButton.styleFrom(
      //         primary: Color.fromARGB(0xFF, 0xC1, 0x4D, 0x20),
      //       ),
      //       onPressed: () {
      //         setState(() {
      //           _loadMoreCharts = true;
      //         });
      //       },
      //       child: Column(
      //         children: [
      //           Text('余下内容'),
      //           Icon(Icons.expand_more_outlined),
      //         ],
      //       )),
    ];
  }

  Widget _getChartSearchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 16,
        ),
        RoundedRectangleChoiceChip(
            selectedColor: Color.fromRGBO(255, 138, 101, 1),
            label: Text('近 7 天'),
            selected: !_customChartDateRange,
            onSelected: (bool val) {
              setState(() {
                _customChartDateRange = !val;
              });
            }),
        SizedBox(
          width: 16,
        ),
        RoundedRectangleChoiceChip(

            selectedColor: Color.fromRGBO(255, 138, 101, 1),
            label: Text('自定义'),
            selected: _customChartDateRange,
            onSelected: (bool val) {
              setState(() {
                _customChartDateRange = val;
              });
            }),
        Expanded(child: Container()),
        if (_customChartDateRange)
          TextButton(
            onPressed: () {
              _showDatePickerDialogIOS(context, _timeUnit);
            },
            child: Text('2022/05/01 ~ 05/10'),
            style: TextButton.styleFrom(
              primary: Color.fromARGB(0xFF, 0xC1, 0x4D, 0x20),
            ),
          ),
      ],
    );
  }

  Widget _getChartSearchBar2(BuildContext context) {
    // TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 8,
        ),
        // Text('图表时间范围：'),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.black54),
          onPressed: () async {
            DateTime? newDate = await DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2020, 1, 1),
                maxTime: ExtendDateUtils.getYesterday(),
                currentTime: _dataSearchParam.chartStartDate,
                locale: LocaleType.zh);
            if (newDate != null) {
              setState(() {
                _dataSearchParam.chartStartDate = newDate;
              });
            }
          },
          child: Row(
            children: [
              _dataSearchParam.chartStartDate == null
                  ? Text('开始日期')
                  : Text(_dateFormat.format(_dataSearchParam.chartStartDate!)),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text('到'),
        SizedBox(
          width: 8,
        ),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.black54),
            onPressed: () async {
              DateTime? newDate = await DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2020, 1, 1),
                  maxTime: ExtendDateUtils.getYesterday(),
                  currentTime: _dataSearchParam.chartEndDate,
                  locale: LocaleType.zh);
              if (newDate != null) {
                setState(() {
                  _dataSearchParam.chartEndDate = newDate;
                });
              }
            },
            child: Row(children: [
              _dataSearchParam.chartEndDate == null
                  ? Text('结束日期')
                  : Text(_dateFormat.format(_dataSearchParam.chartEndDate!)),
              Icon(Icons.arrow_drop_down)
            ])),
      ],
    );
  }

  Widget _getChartSummaryBar(
      BuildContext context, String chartType, String total, double comparison) {
    Color comparisonColor = comparison >= 0 ? Colors.red : Colors.green;
    IconData comparisonArrow =
        comparison >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: TextButton(
            style: TextButton.styleFrom(primary: Colors.black),
            child: Row(
                children: [Text(_processType), Icon(Icons.arrow_drop_down)]),
            onPressed: () {},
          ),
          // child: DropdownButton(
          //   underline: Container(height: 1),
          //   value: _processType,
          //   icon: const Icon(Icons.arrow_drop_down),
          //   elevation: 16,
          //   items:
          //       _processTypeList.map<DropdownMenuItem<String>>((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       _plantArea = newValue!;
          //     });
          //   },
          // ),
        ),
        Text(total),
        Row(
          children: [
            Text(
              comparison.toString() + '%',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: comparisonColor, fontWeight: FontWeight.bold),
            ),
            Icon(comparisonArrow, color: comparisonColor),
          ],
        ),
      ],
    );
  }

  Widget _getChart(BuildContext context, String chartType) {
    return SizedBox(
      height: 250,
      child: SfCartesianChart(
        borderWidth: 0,
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
        axes: [
          NumericAxis(
            name: chartType,
            opposedPosition: true,
          )
        ],
        tooltipBehavior: _tooltip,
        // legend: Legend(isVisible: true, position: LegendPosition.top),
        palette: _paletteList,
        series: _getChartSeries(chartType: chartType),
      ),
    );
  }

  ExpansionPanelList _getDailyTable(BuildContext context) {
    return ExpansionPanelList(
        elevation: 0,
        expansionCallback: (int panelIndex, bool isExpanded) {
          setState(() {
            _dailyTablePanelState[panelIndex] =
                !_dailyTablePanelState[panelIndex];
          });
        },
        children: <ExpansionPanel>[
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('一、天气情况'));
            },
            body: Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                headingRowHeight: 0,
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: <DataColumn>[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                      DataCell(Text('天气')),
                      DataCell(Text('多云')),
                      DataCell(Text('一二三期水温(℃)')),
                      DataCell(Text('21.8')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('气温(℃)')),
                      DataCell(Text('21.0~11.5')),
                      DataCell(Text('四期水温(℃)')),
                      DataCell(Text('21.5')),
                    ],
                  ),
                ],
              ),
            ),
            canTapOnHeader: true,
            isExpanded: _dailyTablePanelState[0],
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('二、处理工作量'));
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTable(
                  // headingRowHeight: 0,
                  columnSpacing: 16,
                  horizontalMargin: 16,
                  columns: <DataColumn>[
                    DataColumn(label: Text('项目')),
                    DataColumn(label: Text('当日(t)')),
                    DataColumn(label: Text('累计(t)')),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('运转时间(h)')),
                        DataCell(Text('24')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('运转率(%)')),
                        DataCell(Text('100')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('全厂进水量(m3)')),
                        DataCell(Text('313036')),
                        DataCell(Text('1894141')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('全厂污水处理量(m3)')),
                        DataCell(Text('281923')),
                        DataCell(Text('1703343')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('中科国通总产泥量60%(t)')),
                        DataCell(Text('52.45')),
                        DataCell(Text('297.39')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('中科国通污泥含水率(%)')),
                        DataCell(Text('59.96')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('四期带机总产泥量80%(t)')),
                        DataCell(Text('89.8')),
                        DataCell(Text('560.86')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('四期往中科泥量80%(t)')),
                        DataCell(Text('0')),
                        DataCell(Text('0')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('四期污泥含水率(%)')),
                        DataCell(Text('78.5')),
                        DataCell(Text('--')),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 32,
                  thickness: 8,
                ),
                _getChartSearchBar2(context),
                _getChartSummaryBar(context, '进水总量', '313036 m3', 4.25),
                _getChart(context, '进水总量'),
              ],
            ),
            canTapOnHeader: true,
            isExpanded: _dailyTablePanelState[1],
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('三、水质情况'));
            },
            body: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: DataTable(
                    // dataTextStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 10),
                    // headingTextStyle: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 10),
                    // headingRowHeight: 0,
                    columnSpacing: 16,
                    horizontalMargin: 16,
                    columns: <DataColumn>[
                      DataColumn(label: Text('项目')),
                      DataColumn(label: Text('进水'), tooltip: '进水单位 mg/L'),
                      DataColumn(label: Text('出水'), tooltip: 'mg/L'),
                      DataColumn(label: Text('去除率'), tooltip: '%'),
                      DataColumn(label: Text('去除总量'), tooltip: 't'),
                      DataColumn(label: Text('累计'), tooltip: 't'),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('COD')),
                          DataCell(Tooltip(
                            message: '244.46 mg/L',
                            child: Text('244.46'),
                          )),
                          DataCell(Text('16.79')),
                          DataCell(Text('93.13')),
                          DataCell(Text('64.18')),
                          DataCell(Text('408.32')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('BOD5')),
                          DataCell(Text('119.39')),
                          DataCell(Text('1.57')),
                          DataCell(Text('98.68')),
                          DataCell(Text('33.21')),
                          DataCell(Text('203.77')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('SS')),
                          DataCell(Text('71.13')),
                          DataCell(Text('5')),
                          DataCell(Text('92.97')),
                          DataCell(Text('18.64')),
                          DataCell(Text('125.41')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('NH3-N')),
                          DataCell(Text('21.63')),
                          DataCell(Text('0.19')),
                          DataCell(Text('99.08')),
                          DataCell(Text('6.04')),
                          DataCell(Text('34.82')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('TN')),
                          DataCell(Text('29.10')),
                          DataCell(Text('6.04')),
                          DataCell(Text('79.22')),
                          DataCell(Text('6.5')),
                          DataCell(Text('39.12')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('TP')),
                          DataCell(Text('4.44')),
                          DataCell(Text('0.06')),
                          DataCell(Text('98.57')),
                          DataCell(Text('1.23')),
                          DataCell(Text('7.66')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('pH')),
                          DataCell(Text('7.5')),
                          DataCell(Text('7.32')),
                          DataCell(Text('--')),
                          DataCell(Text('--')),
                          DataCell(Text('--')),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: RichText(
                        text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: 12),
                            children: <TextSpan>[
                          TextSpan(text: '单位：进水、出水 '),
                          TextSpan(
                              text: 'mg/L',
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: '，去除率 '),
                          TextSpan(
                              text: '%', style: TextStyle(color: Colors.red)),
                          TextSpan(text: '，去除总量、累计 '),
                          TextSpan(
                              text: 't', style: TextStyle(color: Colors.red)),
                        ])),
                  ),
                ),
              ],
            ),
            canTapOnHeader: true,
            isExpanded: _dailyTablePanelState[2],
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('四、能耗、物耗'));
            },
            body: Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                // headingRowHeight: 0,
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: <DataColumn>[
                  DataColumn(label: Text('项目')),
                  DataColumn(label: Text('当日(t)')),
                  DataColumn(label: Text('累计(t)')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                      DataCell(Text('全厂电量(kwh)')),
                      DataCell(Text('118650')),
                      DataCell(Text('--')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('千吨水电耗(kwh/kt)')),
                      DataCell(Text('420.85')),
                      DataCell(Text('--')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('除磷药剂 - 聚合铝铁(t)')),
                      DataCell(Text('23.74')),
                      DataCell(Text('94.06')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('除磷药剂 - PAM(kg)')),
                      DataCell(Text('75')),
                      DataCell(Text('405')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('碳源药剂 - 冰醋酸(t)')),
                      DataCell(Text('10.23')),
                      DataCell(Text('53.2')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('消毒药剂 - 次氯酸钠(t)')),
                      DataCell(Text('12.38')),
                      DataCell(Text('86.05')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('泥处理药剂 - PAM(kg)')),
                      DataCell(Text('75')),
                      DataCell(Text('405')),
                    ],
                  ),
                ],
              ),
            ),
            canTapOnHeader: true,
            isExpanded: _dailyTablePanelState[3],
          ),
        ]);
  }

  ExpansionPanelList _getMonthlyTable(BuildContext context) {
    return ExpansionPanelList(
        elevation: 0,
        expansionCallback: (int panelIndex, bool isExpanded) {
          setState(() {
            _monthlyTablePanelState[panelIndex] =
                !_monthlyTablePanelState[panelIndex];
          });
        },
        children: <ExpansionPanel>[
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _monthlyTablePanelState[0],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('一、水质'));
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTable(
                  // headingRowHeight: 0,
                  columnSpacing: 16,
                  horizontalMargin: 16,
                  columns: <DataColumn>[
                    DataColumn(label: Text('项目')),
                    DataColumn(label: Text('最低')),
                    DataColumn(label: Text('最高')),
                    DataColumn(label: Text('平均')),
                    DataColumn(label: Text('去除总量')),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                        DataCell(Text('COD进水')),
                        DataCell(Text('209.50')),
                        DataCell(Text('351.27')),
                        DataCell(Text('265.05')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('COD出水')),
                        DataCell(Text('12.85')),
                        DataCell(Text('17.81')),
                        DataCell(Text('15.35')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('COD去除率')),
                        DataCell(Text('92.7')),
                        DataCell(Text('95.37')),
                        DataCell(Text('94.21')),
                        DataCell(Text('1183.87')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                        DataCell(Text('BOD₅进水')),
                        DataCell(Text('95.85')),
                        DataCell(Text('142.43')),
                        DataCell(Text('120.93')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('BOD₅出水')),
                        DataCell(Text('1.13')),
                        DataCell(Text('2.22')),
                        DataCell(Text('1.58')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('BOD₅去除率')),
                        DataCell(Text('98.4')),
                        DataCell(Text('99.15')),
                        DataCell(Text('98.69')),
                        DataCell(Text('403.41')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                        DataCell(Text('SS进水')),
                        DataCell(Text('60.42')),
                        DataCell(Text('135.54')),
                        DataCell(Text('86.59')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('SS出水')),
                        DataCell(Text('5')),
                        DataCell(Text('5')),
                        DataCell(Text('5')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('SS去除率')),
                        DataCell(Text('91.72')),
                        DataCell(Text('96.31')),
                        DataCell(Text('94.23')),
                        DataCell(Text('386.67')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                        DataCell(Text('NH₃-N进水')),
                        DataCell(Text('60.42')),
                        DataCell(Text('135.54')),
                        DataCell(Text('86.59')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('NH₃-N出水')),
                        DataCell(Text('5')),
                        DataCell(Text('5')),
                        DataCell(Text('5')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('NH₃-N去除率')),
                        DataCell(Text('91.72')),
                        DataCell(Text('96.31')),
                        DataCell(Text('94.23')),
                        DataCell(Text('386.67')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                        DataCell(Text('TN进水')),
                        DataCell(Text('60.42')),
                        DataCell(Text('135.54')),
                        DataCell(Text('86.59')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('TN出水')),
                        DataCell(Text('5')),
                        DataCell(Text('5')),
                        DataCell(Text('5')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('TN去除率')),
                        DataCell(Text('91.72')),
                        DataCell(Text('96.31')),
                        DataCell(Text('94.23')),
                        DataCell(Text('386.67')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                        DataCell(Text('TP进水')),
                        DataCell(Text('60.42')),
                        DataCell(Text('135.54')),
                        DataCell(Text('86.59')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('TP出水')),
                        DataCell(Text('5')),
                        DataCell(Text('5')),
                        DataCell(Text('5')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('TP去除率')),
                        DataCell(Text('91.72')),
                        DataCell(Text('96.31')),
                        DataCell(Text('94.23')),
                        DataCell(Text('386.67')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                        DataCell(Text('PH进水')),
                        DataCell(Text('7.37')),
                        DataCell(Text('7.64')),
                        DataCell(Text('7.52')),
                        DataCell(Text('--')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('PH出水')),
                        DataCell(Text('7.37')),
                        DataCell(Text('7.64')),
                        DataCell(Text('7.52')),
                        DataCell(Text('--')),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 12),
                          children: <TextSpan>[
                        TextSpan(text: '单位：进水、出水 '),
                        TextSpan(
                            text: 'mg/L', style: TextStyle(color: Colors.red)),
                        TextSpan(text: '，去除率 '),
                        TextSpan(
                            text: '%', style: TextStyle(color: Colors.red)),
                        TextSpan(text: '，去除总量 '),
                        TextSpan(
                            text: 't', style: TextStyle(color: Colors.red)),
                      ])),
                ),
              ],
            ),
          ),
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _monthlyTablePanelState[1],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('二、水量'));
            },
            body: Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                // headingRowHeight: 0,
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: <DataColumn>[
                  DataColumn(label: Text('项目')),
                  DataColumn(label: Text('最低(t)')),
                  DataColumn(label: Text('最高(t)')),
                  DataColumn(label: Text('平均(t)')),
                  DataColumn(label: Text('合计(t)')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('全厂进水量')),
                      DataCell(Text('288527')),
                      DataCell(Text('323852')),
                      DataCell(Text('309616')),
                      DataCell(Text('9598083')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('全厂污水量')),
                      DataCell(Text('253554')),
                      DataCell(Text('291558')),
                      DataCell(Text('275244')),
                      DataCell(Text('8532579')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _monthlyTablePanelState[2],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('三、泥量'));
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTable(
                  // headingRowHeight: 0,
                  columnSpacing: 16,
                  horizontalMargin: 16,
                  columns: <DataColumn>[
                    DataColumn(label: Text('项目')),
                    DataColumn(label: Text('最低(t)')),
                    DataColumn(label: Text('最高(t)')),
                    DataColumn(label: Text('平均(t)')),
                    DataColumn(label: Text('合计(t)')),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('中科国通')),
                        DataCell(Text('0')),
                        DataCell(Text('62.83')),
                        DataCell(Text('39.091')),
                        DataCell(Text('1211.83')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('四期带机')),
                        DataCell(Text('0')),
                        DataCell(Text('206.48')),
                        DataCell(Text('128.921')),
                        DataCell(Text('3996.54')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('四期往中科')),
                        DataCell(Text('0')),
                        DataCell(Text('0')),
                        DataCell(Text('0')),
                        DataCell(Text('0')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _monthlyTablePanelState[3],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('四、能耗、物耗'));
            },
            body: Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                headingRowHeight: 0,
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: <DataColumn>[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('--------------------')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                      DataCell(Text('全厂电量(kwh)')),
                      DataCell(Text('3633420')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('千吨水电耗(kwh/kt)')),
                      DataCell(Text('425.83')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('除磷药剂 - 聚合铝铁(t)')),
                      DataCell(Text('23.74')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('除磷药剂 - PAM(kg)')),
                      DataCell(Text('75')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('碳源药剂 - 冰醋酸(t)')),
                      DataCell(Text('10.23')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('消毒药剂 - 次氯酸钠(t)')),
                      DataCell(Text('12.38')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('泥处理药剂 - PAM(kg)')),
                      DataCell(Text('75')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('自来水用量(m3)')),
                      DataCell(Text('13491')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('厂内中水用量(m3)')),
                      DataCell(Text('125000')),
                      DataCell(Text('')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _monthlyTablePanelState[4],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('五、运行'));
            },
            body: Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                headingRowHeight: 0,
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: <DataColumn>[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('-------------------------------')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                      DataCell(Text('运转时间(h)')),
                      DataCell(Text('744')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('运转率(%)')),
                      DataCell(Text('100')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('工伤事故(‰)')),
                      DataCell(Text('0')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('设备完好率(%)')),
                      DataCell(Text('95')),
                      DataCell(Text('')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _monthlyTablePanelState[5],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('六、备注'));
            },
            body: Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                headingRowHeight: 0,
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: <DataColumn>[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('---------------')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                      DataCell(Text('污泥去向 - 新利环保(t)')),
                      DataCell(Text('1211.83')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('污泥去向 - 国联环保(t)')),
                      DataCell(Text('3996.54')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('全厂污泥总量(t)')),
                      DataCell(Text('6420.2')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('中科一二期水量(m3)')),
                      DataCell(Text('2466595')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('中科三期水量(m3)')),
                      DataCell(Text('2426897')),
                      DataCell(Text('')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]);
  }

  ExpansionPanelList _getMultiReportTable(BuildContext context) {
    return ExpansionPanelList(
        elevation: 0,
        expansionCallback: (int panelIndex, bool isExpanded) {
          setState(() {
            _monthlyTablePanelState[panelIndex] =
                !_monthlyTablePanelState[panelIndex];
          });
        },
        children: <ExpansionPanel>[
          if (_selectedDataCategoryList.contains('水质'))
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _monthlyTablePanelState[0],
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(title: Text('一、水质'));
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
                    // headingRowHeight: 0,
                    columnSpacing: 16,
                    horizontalMargin: 16,
                    columns: <DataColumn>[
                      DataColumn(label: Text('项目')),
                      if (_selectedPlantList.contains('芦村'))
                        DataColumn(label: Text('芦村')),
                      if (_selectedPlantList.contains('太湖'))
                        DataColumn(label: Text('太湖')),
                      if (_selectedPlantList.contains('城北'))
                        DataColumn(label: Text('城北')),
                      if (_selectedPlantList.length > 1)
                        DataColumn(label: Text('合计')),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                          DataCell(Text('COD进水')),
                          if (_selectedPlantList.contains('芦村'))
                            DataCell(Text('209.50')),
                          if (_selectedPlantList.contains('太湖'))
                            DataCell(Text('351.27')),
                          if (_selectedPlantList.contains('城北'))
                            DataCell(Text('265.05')),
                          if (_selectedPlantList.length > 1)
                            DataCell(Text('--')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('COD出水')),
                          if (_selectedPlantList.contains('芦村'))
                            DataCell(Text('12.85')),
                          if (_selectedPlantList.contains('太湖'))
                            DataCell(Text('17.81')),
                          if (_selectedPlantList.contains('城北'))
                            DataCell(Text('15.35')),
                          if (_selectedPlantList.length > 1)
                            DataCell(Text('--')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('COD去除量')),
                          if (_selectedPlantList.contains('芦村'))
                            DataCell(Text('92.7')),
                          if (_selectedPlantList.contains('太湖'))
                            DataCell(Text('95.37')),
                          if (_selectedPlantList.contains('城北'))
                            DataCell(Text('94.21')),
                          if (_selectedPlantList.length > 1)
                            DataCell(Text('1183.87')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                          DataCell(Text('BOD进水')),
                          if (_selectedPlantList.contains('芦村'))
                            DataCell(Text('209.50')),
                          if (_selectedPlantList.contains('太湖'))
                            DataCell(Text('351.27')),
                          if (_selectedPlantList.contains('城北'))
                            DataCell(Text('265.05')),
                          if (_selectedPlantList.length > 1)
                            DataCell(Text('--')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('BOD出水')),
                          if (_selectedPlantList.contains('芦村'))
                            DataCell(Text('12.85')),
                          if (_selectedPlantList.contains('太湖'))
                            DataCell(Text('17.81')),
                          if (_selectedPlantList.contains('城北'))
                            DataCell(Text('15.35')),
                          if (_selectedPlantList.length > 1)
                            DataCell(Text('--')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('BOD去除量')),
                          if (_selectedPlantList.contains('芦村'))
                            DataCell(Text('92.7')),
                          if (_selectedPlantList.contains('太湖'))
                            DataCell(Text('95.37')),
                          if (_selectedPlantList.contains('城北'))
                            DataCell(Text('94.21')),
                          if (_selectedPlantList.length > 1)
                            DataCell(Text('1183.87')),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: RichText(
                        text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: 12),
                            children: <TextSpan>[
                          TextSpan(text: '单位：进水、出水 '),
                          TextSpan(
                              text: 'mg/L',
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: '，去除总量 '),
                          TextSpan(
                              text: 't', style: TextStyle(color: Colors.red)),
                        ])),
                  ),
                ],
              ),
            ),
          if (_selectedDataCategoryList.contains('处理量'))
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _monthlyTablePanelState[1],
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(title: Text('二、处理量'));
              },
              body: Align(
                alignment: Alignment.centerLeft,
                child: DataTable(
                  // headingRowHeight: 0,
                  columnSpacing: 16,
                  horizontalMargin: 16,
                  columns: <DataColumn>[
                    DataColumn(label: Text('项目')),
                    if (_selectedPlantList.contains('芦村'))
                      DataColumn(label: Text('芦村')),
                    if (_selectedPlantList.contains('太湖'))
                      DataColumn(label: Text('太湖')),
                    if (_selectedPlantList.contains('城北'))
                      DataColumn(label: Text('城北')),
                    if (_selectedPlantList.length > 1)
                      DataColumn(label: Text('合计')),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('进水量(m3)')),
                        if (_selectedPlantList.contains('芦村'))
                          DataCell(Text('313036')),
                        if (_selectedPlantList.contains('太湖'))
                          DataCell(Text('177038')),
                        if (_selectedPlantList.contains('城北'))
                          DataCell(Text('178459')),
                        if (_selectedPlantList.length > 1)
                          DataCell(Text('668533')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('出水量(m3)')),
                        if (_selectedPlantList.contains('芦村'))
                          DataCell(Text('281923')),
                        if (_selectedPlantList.contains('太湖'))
                          DataCell(Text('159062')),
                        if (_selectedPlantList.contains('城北'))
                          DataCell(Text('173868')),
                        if (_selectedPlantList.length > 1)
                          DataCell(Text('614853')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('污泥量(t)')),
                        if (_selectedPlantList.contains('芦村'))
                          DataCell(Text('194')),
                        if (_selectedPlantList.contains('太湖'))
                          DataCell(Text('119')),
                        if (_selectedPlantList.contains('城北'))
                          DataCell(Text('152')),
                        if (_selectedPlantList.length > 1)
                          DataCell(Text('467')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (_selectedDataCategoryList.contains('运行'))
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _monthlyTablePanelState[4],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('三、运行'));
            },
            body: Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                headingRowHeight: 0,
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: <DataColumn>[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('-------------------------------')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                      DataCell(Text('运转时间(h)')),
                      DataCell(Text('744')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('运转率(%)')),
                      DataCell(Text('100')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('工伤事故(‰)')),
                      DataCell(Text('0')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('设备完好率(%)')),
                      DataCell(Text('95')),
                      DataCell(Text('')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_selectedDataCategoryList.contains('物耗')) ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: _monthlyTablePanelState[3],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text('四、物耗'));
            },
            body: Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                headingRowHeight: 0,
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: <DataColumn>[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('--------------------')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      // DataCell(Align(alignment: Alignment.centerLeft, child: Text('天气'),)),
                      DataCell(Text('全厂电量(kwh)')),
                      DataCell(Text('3633420')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('千吨水电耗(kwh/kt)')),
                      DataCell(Text('425.83')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('除磷药剂 - 聚合铝铁(t)')),
                      DataCell(Text('23.74')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('除磷药剂 - PAM(kg)')),
                      DataCell(Text('75')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('碳源药剂 - 冰醋酸(t)')),
                      DataCell(Text('10.23')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('消毒药剂 - 次氯酸钠(t)')),
                      DataCell(Text('12.38')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('泥处理药剂 - PAM(kg)')),
                      DataCell(Text('75')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('自来水用量(m3)')),
                      DataCell(Text('13491')),
                      DataCell(Text('')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('厂内中水用量(m3)')),
                      DataCell(Text('125000')),
                      DataCell(Text('')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]);
  }

  List<ExpansionPanel> _getChartExpansionPanelList() {
    List<String> allTyps = <String>[];
    allTyps.addAll(_processTypeList);
    allTyps.addAll(_waterQualityTypeList);
    allTyps.addAll(_chemicalTypeList);

    List<ExpansionPanel> panelList = [];
    for (int i = 0; i < allTyps.length; i++) {
      panelList.add(ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: _chartPanelState[i],
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(allTyps[i],
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Text('30181m3', style: Theme.of(context).textTheme.subtitle1),
              Row(
                children: [
                  Text(
                    '4.83%',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.red),
                  ),
                  Icon(Icons.arrow_drop_up, color: Colors.red),
                ],
              ),
            ],
          );
        },
        body: SfCartesianChart(
          borderWidth: 0,
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          axes: [
            NumericAxis(
              name: allTyps[i],
              opposedPosition: true,
            )
          ],
          tooltipBehavior: _tooltip,
          legend: Legend(isVisible: true, position: LegendPosition.top),
          palette: _paletteList,
          series: _getChartSeries(),
        ),
      ));
    }

    return panelList;
  }

  List<Widget> _getMultiReportWidgets(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            underline: Container(height: 1),
            value: _timeUnit,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            items: _timeUnitList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _timeUnit = newValue!;
                switch (newValue) {
                  case '年':
                    _dateFormat = _dateFormatList[2];
                    break;
                  case '月':
                    _dateFormat = _dateFormatList[1];
                    break;
                  default:
                    _dateFormat = _dateFormatList[0];
                }
              });
            },
          ),
          TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: () {
                _showDatePickerDialogIOS(context, _timeUnit);
              },
              child: Text(_dateFormat.format(_dataSearchParam.currentDate))),
          // ActionChip(
          //     // avatar: Icon(Icons.today),
          //     label: Text(_dateFormat.format(_dataSearchParam.currentDate)),
          //     onPressed: () {
          //       _showDatePickerDialogIOS(context, _timeUnit);
          //     }),
        ],
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('污水厂'),
            Wrap(children: _getPlantFilterChips()),
            Text('内容'),
            Wrap(children: _getDateCategoryFilterChips()),
          ],
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '三厂统计报表',
        style: Theme.of(context).textTheme.headline6,
      ),
      SizedBox(
        height: 4,
      ),
      Text(
        _dateFormat.format(_dataSearchParam.currentDate),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      SizedBox(
        height: 16,
      ),
      _getMultiReportTable(context),
    ];
  }

  List<Widget> _getPlantFilterChips() {
    return _plantList.map((String plant) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
        child: RoundedRectangleChoiceChip(
          selectedColor: Color.fromRGBO(255, 138, 101, 1),
          label: Text(plant),
          selected: _selectedPlantList.contains(plant),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _selectedPlantList.add(plant);
              } else {
                _selectedPlantList.removeWhere((String name) {
                  return name == plant;
                });
              }
            });
          },
        ),
      );
    }).toList();
  }

  List<Widget> _getDateCategoryFilterChips() {
    return _dataCategoryList.map((String dataCategory) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
        child: RoundedRectangleChoiceChip(
          selectedColor: Color.fromRGBO(255, 138, 101, 1),
          label: Text(dataCategory),
          selected: _selectedDataCategoryList.contains(dataCategory),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _selectedDataCategoryList.add(dataCategory);
              } else {
                _selectedDataCategoryList.removeWhere((String name) {
                  return name == dataCategory;
                });
              }
            });
          },
        ),
      );
    }).toList();
  }

  List<ChartSeries<_ChartData, String>> _getChartSeries({String? chartType}) {
    List<ChartSeries<_ChartData, String>> series = [
      SplineAreaSeries<_ChartData, String>(
        dataSource: _chartData,
        xValueMapper: (_ChartData data, _) => data.x,
        yValueMapper: (_ChartData data, _) => data.y[0],
        name: chartType ?? '进水总量',
        borderWidth: 4,
        borderColor: Color.fromRGBO(0x21, 0xB2, 0x70, 1),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0x21, 0xB2, 0x70, 0.5),
            Color.fromRGBO(0x21, 0xB2, 0x70, 0.2)
          ],
        ),
        // dataLabelSettings: DataLabelSettings(
        //     isVisible: true,
        //     labelAlignment: ChartDataLabelAlignment.bottom),
      ),
      // ColumnSeries<_ChartData, String>(
      //   dataSource: _chartData,
      //   xValueMapper: (_ChartData data, _) => data.x,
      //   yValueMapper: (_ChartData data, _) => data.y[1],
      //   name: '出水总量',
      //   // dataLabelSettings: DataLabelSettings(
      //   //   isVisible: true,
      //   // ),
      // ),
    ];

    // if (_dataSearchParam.tabParamList[1]['环比']) {
    //   series.add(LineSeries<_ChartData, String>(
    //     dataSource: _chartData,
    //     xValueMapper: (_ChartData data, _) => data.x,
    //     yValueMapper: (_ChartData data, _) => data.y[2],
    //     name: '进水环比',
    //     yAxisName: '对比',
    //     // dataLabelSettings: DataLabelSettings(
    //     //   isVisible: true,
    //     // ),
    //   ));
    //   series.add(LineSeries<_ChartData, String>(
    //     dataSource: _chartData,
    //     xValueMapper: (_ChartData data, _) => data.x,
    //     yValueMapper: (_ChartData data, _) => data.y[3],
    //     name: '出水环比',
    //     yAxisName: '对比',
    //     // dataLabelSettings: DataLabelSettings(
    //     //   isVisible: true,
    //     // ),
    //   ));
    // }

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
  void _showDatePickerDialog(String timeUnit) async {
    DateTime? newDate;
    switch (timeUnit) {
      case '月':
        newDate = await showMonthPicker(
          context: context,
          initialDate: _dataSearchParam.currentDate,
          firstDate: DateTime(2020, 1, 1),
          lastDate: ExtendDateUtils.getYesterday(),
        );
        break;

      case '年':
        newDate = await showDatePicker(
          context: context,
          initialDate: _dataSearchParam.currentDate,
          firstDate: DateTime(2020, 1, 1),
          lastDate: ExtendDateUtils.getYesterday(),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDatePickerMode: DatePickerMode.year,
        );
        break;

      default:
        newDate = await showDatePicker(
          context: context,
          initialDate: _dataSearchParam.currentDate,
          firstDate: DateTime(2020, 1, 1),
          lastDate: ExtendDateUtils.getYesterday(),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );
    }

    if (newDate != null &&
        newDate.compareTo(_dataSearchParam.currentDate) != 0) {
      setState(() {
        _dataSearchParam.currentDate = newDate!;
      });
    }
  }

  /// 日期选择弹出框
  void _showDatePickerDialogIOS(BuildContext context, String timeUnit) async {
    DateTime? newDate;
    switch (timeUnit) {
      case '月':
        newDate = await showMonthPicker(
          context: context,
          initialDate: _dataSearchParam.currentDate,
          firstDate: DateTime(2020, 1, 1),
          lastDate: ExtendDateUtils.getYesterday(),
        );
        break;

      case '年':
        newDate = await showDatePicker(
          context: context,
          initialDate: _dataSearchParam.currentDate,
          firstDate: DateTime(2020, 1, 1),
          lastDate: ExtendDateUtils.getYesterday(),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDatePickerMode: DatePickerMode.year,
        );
        break;

      default:
        newDate = await DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2020, 1, 1),
            maxTime: ExtendDateUtils.getYesterday(), onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          print('confirm $date');
        }, currentTime: _dataSearchParam.currentDate, locale: LocaleType.zh);
    }

    if (newDate != null &&
        newDate.compareTo(_dataSearchParam.currentDate) != 0) {
      setState(() {
        _dataSearchParam.currentDate = newDate!;
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

/// 搜索参数
class _DataSearchParam {
  /// 当前日期
  late DateTime currentDate;

  // 图表开始日期
  DateTime? chartStartDate;

  // 图表结束日期
  DateTime? chartEndDate;
  late List<Map<String, dynamic>> tabParamList;

  _DataSearchParam(
      {required this.currentDate,
      required this.tabParamList,
      this.chartStartDate,
      this.chartEndDate});
}
