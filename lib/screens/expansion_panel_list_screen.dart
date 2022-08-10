import 'dart:async';

import 'package:flutter/material.dart';

/// 折叠面板页面
class ExpansionPanelListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpansionPanelListState();
}

class _ExpansionPanelListState extends State<ExpansionPanelListScreen> {
  // 一级折叠面板状态
  List<bool> _mainPanelState = [false, false, false];

  // 二级折叠面板状态
  List<bool> _secondaryPanelState = [false, false, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(0xff, 0xff, 0x8a, 0x65),
        // automaticallyImplyLeading: false,
        // centerTitle: true,
        title: Text('折叠面板'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            // 主折叠面板折叠状态的回调
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                _mainPanelState[panelIndex] = !_mainPanelState[panelIndex];
              });
            },
            children: <ExpansionPanel>[
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(title: Text('嵌套折叠面板'));
                },
                body: Padding(
                    padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                    child: ExpansionPanelList(
                        elevation: 0,
                        // 二级叠面板折叠状态的回调
                        expansionCallback: (int panelIndex, bool isExpanded) {
                          setState(() {
                            _secondaryPanelState[panelIndex] =
                                !_secondaryPanelState[panelIndex];
                          });
                        },
                        children: <ExpansionPanel>[
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(title: Text('二级折叠面板1'));
                            },
                            body: Padding(
                                padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 1'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 2'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 3'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                    Divider(),
                                  ],
                                )),
                            canTapOnHeader: true,
                            isExpanded: _secondaryPanelState[0],
                          ),
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(title: Text('二级折叠面板2'));
                            },
                            body: Padding(
                                padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 1'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 2'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 3'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                    Divider(),
                                  ],
                                )),
                            canTapOnHeader: true,
                            isExpanded: _secondaryPanelState[1],
                          ),
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(title: Text('二级折叠面板3'));
                            },
                            body: Padding(
                                padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 1'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 2'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Item 3'),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                  ],
                                )),
                            canTapOnHeader: true,
                            isExpanded: _secondaryPanelState[2],
                          ),
                        ])),
                canTapOnHeader: true,
                isExpanded: _mainPanelState[0],
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(title: Text('普通折叠面板1'));
                },
                body: Padding(
                    padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                    child: Column(
                      children: [
                        Divider(),
                        ListTile(
                          title: Text('Item 1'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Item 2'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Item 3'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ],
                    )),
                canTapOnHeader: true,
                isExpanded: _mainPanelState[1],
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(title: Text('普通折叠面板2'));
                },
                body: Padding(
                    padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                    child: Column(
                      children: [
                        Divider(),
                        ListTile(
                          title: Text('Item 1'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Item 2'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Item 3'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Item 4'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ],
                    )),
                canTapOnHeader: true,
                isExpanded: _mainPanelState[2],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
