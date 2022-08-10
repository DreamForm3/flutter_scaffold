import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
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

class ModifyUserProfileScreen extends StatefulWidget {
  ModifyUserProfileScreen(
      {Key? key,
      required this.baseApi,
      required this.storage,
      required this.imageHttpHeaders,
      required this.loginUserInfo})
      : super(key: key);

  final BaseApi baseApi;
  final LocalStorage storage;

  final Map<String, String> imageHttpHeaders;
  final SysUserQueryVo loginUserInfo;

  // 头像大小
  final double avatarWidth = 80.0, avatarHeight = 80.0;

  @override
  State<StatefulWidget> createState() => _ModifyUserProfileState();
}

class _ModifyUserProfileState extends State<ModifyUserProfileScreen> {
  // 是否正在初始化数据
  bool _processing = false;
  final _formKey = GlobalKey<FormState>();

  // 默认头像
  late final Image defaultAvatar2x;
  // 加载错误图片
  late final Image loadErrorImage2x;
  // 新选择的头像文件
  XFile? _newAvatarImage;

  // 昵称输入框组件
  final TextEditingController _nickNameController = TextEditingController();
  // 个性签名输入框组件
  final TextEditingController _personalizedSignatureController = TextEditingController();
  // 手机号输入框组件
  final TextEditingController _mobileController = TextEditingController();
  // 手机号输入框组件
  final TextEditingController _emailController = TextEditingController();
  // 性别组件
  Gender? _gender;


  @override
  void initState() {
    super.initState();
    defaultAvatar2x = Image.asset(
      'assets/images/baseline_face_black_48dp.png',
      width: widget.avatarWidth * 2,
      height: widget.avatarHeight * 2,
    );
    loadErrorImage2x = Image.asset(
      'assets/images/outline_broken_image_black_48dp.png',
      width: widget.avatarWidth * 2,
      height: widget.avatarHeight * 2,
    );
    // 初始化值
    if (StringUtils.isNotNullOrEmpty(widget.loginUserInfo.nickname)) {
      _nickNameController.text = widget.loginUserInfo.nickname!;
    }
    if (StringUtils.isNotNullOrEmpty(widget.loginUserInfo.phone)) {
      _mobileController.text = widget.loginUserInfo.phone!;
    }
    if (StringUtils.isNotNullOrEmpty(widget.loginUserInfo.email)) {
      _emailController.text = widget.loginUserInfo.email!;
    }
    if (StringUtils.isNotNullOrEmpty(widget.loginUserInfo.remark)) {
      _personalizedSignatureController.text = widget.loginUserInfo.remark!;
    }
    if (widget.loginUserInfo.gender != null) {
      _gender = Gender.values[widget.loginUserInfo.gender!];
    }
  }


  @override
  void dispose() {
    _nickNameController.dispose();
    _personalizedSignatureController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑个人资料'),
      ),
      body: Form(key: _formKey,
        child: ListView(padding: EdgeInsets.all(16.0), children: [
        Center(
          child: GestureDetector(
                onTap: () {
                  _showAvatarBottomSheet(context);
                },
                // 显示头像，如果有新选择的头像就显示新选择的，否则显示旧头像
                // 如果旧头像也没有，就显示默认头像
                child: _newAvatarImage != null
                    ? Image.file(
                        File(_newAvatarImage!.path),
                        fit: BoxFit.cover,
                        width: widget.avatarWidth * 2,
                        height: widget.avatarHeight * 2,
                      )
                    : widget.loginUserInfo.avatar != null
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: widget.avatarWidth * 2,
                            height: widget.avatarHeight * 2,
                            placeholder: (context, url) => defaultAvatar2x,
                            errorWidget: (context, url, error) =>
                                loadErrorImage2x,
                            imageUrl: BaseApi.getImageURL(
                                widget.loginUserInfo.avatar!),
                            httpHeaders: widget.imageHttpHeaders,
                          )
                        : defaultAvatar2x,
              ),
        ),
        TextFormField(
          controller: _nickNameController,
          validator: _validateNickName,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            icon: Icon(Icons.face),
            labelText: '昵称',
          ),
        ),
        TextFormField(
          controller: _personalizedSignatureController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            icon: Icon(Icons.portrait_outlined),
            labelText: '个性签名',
          ),
          // validator: _validateNickName,
        ),
        TextFormField(
          controller: _mobileController,
          validator: _validateMobile,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            icon: Icon(Icons.phone_iphone_outlined),
            // filled: true,
            labelText: '手机号码',
          ),
        ),
        TextFormField(
          controller: _emailController,
          validator: _validateEmail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            icon: Icon(Icons.email_outlined),
            // filled: true,
            labelText: '邮箱',
          ),
        ),
          CustomFormBuilderChoiceChip<Gender>(
            name: 'gender',
            alignment: WrapAlignment.spaceBetween,
            initialValue: _gender,
            onChanged: (Gender? newVal) => {
              setState(() {
                _gender = newVal;
              })
            },
            decoration: InputDecoration(
              labelText: '性别',
              icon: Icon(Icons.transgender),
            ),
            options: [
              CustomFormBuilderFieldOption(
                  value: Gender.FEMALE,
                  child: const Text('女'),
                  avatar: Icon(Icons.female),
              ),
              CustomFormBuilderFieldOption(
                  value: Gender.MALE,
                  child: const Text('男'),
                  avatar: Icon(Icons.male),
              ),
            ],
          ),

        IndicatorButton(
            '保存个人资料',
            _processing,
            onPressed: (BuildContext context) => {_updateProfile(context)}
          // style: ElevatedButton.styleFrom(minimumSize: Size(128, 36)),
        ),
      ]),)
    );
  }

  void _showAvatarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickAvatar(ImageSource.camera);
                },
                child: Text('拍照')),
            Divider(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickAvatar(ImageSource.gallery);
                },
                child: Text('从相册选择')),
            Divider(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消')),
          ],
        );
      },
    );
  }

  /// 选择头像
  void _pickAvatar(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: source);
    // 设置选择好的头像
    setState(() {
      _newAvatarImage = image;
    });
  }

  String? _validateNickName(String? nickName) {
    return StringUtils.isNullOrEmpty(nickName) ? '请输入昵称' : null;
  }

  /// 校验手机号码
  String? _validateMobile(String? mobile) {
    if (StringUtils.isNullOrEmpty(mobile)) {
      return '请输入手机号';
    } else if (mobile!.startsWith('+')) {
      if (!mobile.startsWith('+86')) {
        return '目前只支持中国大陆手机号';
      } else if(!ExtendStringUtils.isChinaMainLandMobile(mobile.substring(3))) {
        return '手机号码格式不正确';
      }
    } else if (!ExtendStringUtils.isChinaMainLandMobile(mobile)) {
      return '手机号码格式不正确';
    }
    return null;
  }

  /// 校验邮箱
  String? _validateEmail(String? email) {
    if (StringUtils.isNotNullOrEmpty(email) && !ExtendStringUtils.isEmail(email!)) {
      return '邮箱格式不正确';
    }
    return null;
  }

  /// 更新用户信息
  void _updateProfile(BuildContext context) async {
    // 校验表单输入项
    if (!_formKey.currentState!.validate()) {
      ToastUtils.showSimpleSnackBar('请检查表单输入项', context);
      return;
    }

    // 标记为正在处理
    setState(() {
      _processing = true;
    });

    SysUserQueryVo _newProfile = SysUserQueryVo(
      nickname: _nickNameController.text,
      phone: _mobileController.text,
      email: _emailController.text,
      gender: _gender == null ? null : _gender!.index,
      remark: _personalizedSignatureController.text,
    );

    try {
      dynamic response = await widget.baseApi.updateUserProfile(
        newProfile: _newProfile,
        newAvatarImage: _newAvatarImage,
        context: context
      );

      if (response is Response) {
        // 更新成功后返回个人中心
        if (response.statusCode == 200) {
          ToastUtils.showSimpleSnackBar('个人资料更新成功', context);
          ApiResult<SysUserQueryVo> apiResult =
          ApiResult<SysUserQueryVo>.fromJson(response.data);
          Navigator.of(context).pop(apiResult.data);
        } else {
          // 更新失败，通知用户错误信息
          ApiResult<String> apiResult =
          ApiResult<String>.fromJson(response.data);
          String errorMsg = apiResult.message ?? '更新失败，请稍后再试';
          ToastUtils.showSimpleSnackBar(errorMsg, context);
        }
      }
    } catch (e) {
      ToastUtils.showSimpleSnackBar('oops 什么东西不对劲', context);
      print(e);
    }

    // 取消正在处理标记
    setState(() {
      _processing = false;
    });
  }
}
