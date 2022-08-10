import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_scaffold/components/rounded_rectangle_choice_chip.dart';
import 'package:flutter_scaffold/utils/extend_date_utils.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// 图表页面
class ChartsScreen2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChartsScreen2State();
}

class _ChartsScreen2State extends State with TickerProviderStateMixin {
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
    '进出水',
    '污泥',
    'BOD₅去除量',
    'COD去除量',
    'NH₃-N去除量',
    'SS去除量',
    'TN去除量',
    'TP去除量',
  ];
  static final List<String> _timeUnitList = [
    '天',
    '周',
    '月',
    '年',
    // '自定义',
  ];
  static final List<String> _dataCategoryList = ['水质', '处理量', '物耗'];

  late int _currentIndex;

  bool _processing = false;
  bool _loadMoreTable = false;
  bool _loadMoreCharts = false;

  int _contentStep = 1;

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
    _currentIndex = 0;
    _plantArea = _plantAreaList[0];
    _processType = _processTypeList[0];
    _timeUnit = _timeUnitList[0];
    _selectedPlantList.addAll(_plantList);
    _selectedDataCategoryList.addAll(_dataCategoryList);

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
          ActionChip(
              // avatar: Icon(Icons.today),
              label: Text(_monthFormat.format(_dataSearchParam.currentDate)),
              onPressed: () {
                _showDatePickerDialog('日');
              }),
        ],
      ),
      SizedBox(
        height: 16,
      ),
      ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: _loadMoreTable ? 1 : 0.25,
          child: _dataTableImage,
        ),
      ),
      SizedBox(
        height: 16,
      ),
      if (!_loadMoreTable)
        TextButton(
            onPressed: () {
              setState(() {
                _loadMoreTable = true;
              });
            },
            child: Column(
              children: [
                Text('余下内容'),
                Icon(Icons.expand_more_outlined),
              ],
            )),
      ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: _loadMoreCharts ? 1 : 0.5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('处理量:'),
                  DropdownButton(
                    underline: Container(height: 1),
                    value: _processType,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    items: _processTypeList
                        .map<DropdownMenuItem<String>>((String value) {
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
                  // SizedBox(
                  //   width: 16,
                  // ),
                  // Text('对比:'),

                  RoundedRectangleChoiceChip(
                      selectedColor: Color.fromRGBO(255, 138, 101, 1),
                      label: Text('环比'),
                      selected: true == _dataSearchParam.tabParamList[1]['环比'],
                      onSelected: (bool val) {
                        setState(() {
                          _dataSearchParam.tabParamList[1]['环比'] =
                              !_dataSearchParam.tabParamList[1]['环比'];
                        });
                      }),
                  RoundedRectangleChoiceChip(
                      selectedColor: Color.fromRGBO(255, 138, 101, 1),
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
            ],
          ),
        ),
      ),
      if (!_loadMoreCharts)
        TextButton(
            onPressed: () {
              setState(() {
                _loadMoreCharts = true;
              });
            },
            child: Column(
              children: [
                Text('余下内容'),
                Icon(Icons.expand_more_outlined),
              ],
            )),
    ];
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
              });
            },
          ),
          ActionChip(
              // avatar: Icon(Icons.today),
              label: Text(_dateFormat.format(_dataSearchParam.currentDate)),
              onPressed: () {
                _showDatePickerDialog(_timeUnit);
              }),
        ],
      ),
      Wrap(children: _getPlantFilterChips()),
      Wrap(children: _getDateCategoryFilterChips()),
      SizedBox(
        height: 16,
      ),
      _dataTableImage2,
    ];
  }

  List<Widget> _getPlantFilterChips() {
    return _plantList.map((String plant) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
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
        padding: const EdgeInsets.all(4.0),
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
