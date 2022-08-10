import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/custom_form_builder_choice_chip.dart';
import 'package:flutter_scaffold/components/custom_form_builder_field_option.dart';
import 'package:flutter_scaffold/components/indicator_button.dart';
import 'package:flutter_scaffold/models/dtos/api_result.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_query_vo.dart';
import 'package:flutter_scaffold/models/enums/gender.dart';
import 'package:flutter_scaffold/storage/local_storage.dart';
import 'package:flutter_scaffold/utils/extend_string_utils.dart';
import 'package:flutter_scaffold/utils/toast_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_query_vo.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class RichTextViewerScreen extends StatefulWidget {
  RichTextViewerScreen(
      {Key? key,
      required this.baseApi,
      required this.storage,
      required this.imageHttpHeaders,
      this.userProfile})
      : super(key: key);

  final BaseApi baseApi;
  final LocalStorage storage;

  final Map<String, String> imageHttpHeaders;
  final SysUserQueryVo? userProfile;

  @override
  State<StatefulWidget> createState() => _RichTextViewerScreenState();
}

class _RichTextViewerScreenState extends State<RichTextViewerScreen> {
  // 是否正在初始化数据
  bool _processing = false;
  final _formKey = GlobalKey<FormState>();

  // 默认头像
  late final Image defaultAvatar;

  // 加载错误图片
  late final Image loadErrorImage;

  late final quill.QuillController _controller;

  // 性别组件
  Gender? _gender;

  @override
  void initState() {
    super.initState();
    defaultAvatar = Image.asset(
      'assets/images/baseline_face_black_48dp.png',
    );
    loadErrorImage = Image.asset(
      'assets/images/outline_broken_image_black_48dp.png',
    );
    _controller = quill.QuillController.basic();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('编辑消息'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(16.0), children: [
            ChipsInput<SysUserQueryVo>(
              enabled: false,
              maxChips: 1,
              initialValue: [
                if (widget.userProfile != null) widget.userProfile!
              ],
              decoration: InputDecoration(
                // icon: Icon(Icons.mail),
                labelText: '消息接收人',
              ),
              onChanged: (data) {
                print(data);
              },
              findSuggestions: (String query) {
                return const [];
              },
              chipBuilder: (context, state, profile) {
                return InputChip(
                  key: ObjectKey(profile),
                  label: Text(profile.nickname ?? profile.username!),
                  avatar: profile.avatar == null
                      ? CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/baseline_face_black_48dp.png'))
                      : CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            BaseApi.getImageURL(profile.avatar!),
                            headers: widget.imageHttpHeaders,
                          ),
                        ),
                  onDeleted: () => state.deleteChip(profile),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              },
              suggestionBuilder: (context, state, profile) {
                return ListTile(
                  key: ObjectKey(profile),
                  leading: profile.avatar == null
                      ? defaultAvatar
                      : CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) => defaultAvatar,
                          errorWidget: (context, url, error) => loadErrorImage,
                          imageUrl: BaseApi.getImageURL(profile.avatar!),
                          httpHeaders: widget.imageHttpHeaders,
                        ),
                  title: Text(profile.username!),
                  subtitle: Text(profile.nickname ?? ''),
                  onTap: () => state.selectSuggestion(profile),
                );
              },
            ),
            SizedBox(
              height: 16,
            ),
            quill.QuillToolbar.basic(controller: _controller),
            quill.QuillEditor(
              controller: _controller,
              scrollController: ScrollController(),
              scrollable: true,
              focusNode: FocusNode(),
              autoFocus: false,
              readOnly: false,
              expands: false,
              padding: EdgeInsets.zero,
              placeholder: '请输入消息内容',
              minHeight: 200,
              maxHeight: 400,
            ),
            IndicatorButton('发送', _processing,
                onPressed: (BuildContext context) => {}
                // style: ElevatedButton.styleFrom(minimumSize: Size(128, 36)),
                ),
          ]),
        ));
  }


}
