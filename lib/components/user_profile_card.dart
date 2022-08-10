import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/api/base_api.dart';
import 'package:flutter_scaffold/components/simple_list_item.dart';
import 'package:flutter_scaffold/models/dtos/sys_user_query_vo.dart';
import 'package:flutter_scaffold/storage/local_storage.dart';
import 'package:flutter_scaffold/utils/const_values.dart';
import 'package:flutter_scaffold/screens/rich_text_viewer.dart';

class UserProfileCard extends StatefulWidget {
  // 用户
  late final SysUserQueryVo userProfile;

  // 头像大小
  final double avatarWidth = 128.0, avatarHeight = 128.0;

  UserProfileCard({required this.userProfile});

  @override
  State<StatefulWidget> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  late BaseApi _baseApi;
  late LocalStorage _storage;

  // 是否正在初始化数据
  bool _processing = false;
  Map<String, String>? _imageHttpHeaders;

  // 默认头像
  late final Image defaultAvatar;

  // 加载错误图片
  late final Image loadErrorImage;

  @override
  void initState() {
    super.initState();

    defaultAvatar = Image.asset(
      'assets/images/baseline_face_black_48dp.png',
      width: widget.avatarWidth,
      height: widget.avatarHeight,
    );
    loadErrorImage = Image.asset(
      'assets/images/outline_broken_image_black_48dp.png',
      width: widget.avatarWidth,
      height: widget.avatarHeight,
    );
    _init();
  }

  void _init() async {
    // 初始化本地存储
    _storage = await LocalStorage.getInstance();
    _baseApi = BaseApi.instance;
    // 设置 token
    String? userToken = _storage.getString(ConstValues.USER_AUTH_TOKEN);
    if (userToken != null) {
      _imageHttpHeaders = {'token': userToken};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              ((widget.userProfile.avatar != null)
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: widget.avatarWidth,
                      height: widget.avatarHeight,
                      placeholder: (context, url) => defaultAvatar,
                      errorWidget: (context, url, error) => loadErrorImage,
                      imageUrl: BaseApi.getImageURL(widget.userProfile.avatar!),
                      httpHeaders: _imageHttpHeaders,
                    )
                  : defaultAvatar),
              if (widget.userProfile.gender != null)
                CircleAvatar(
                  child: widget.userProfile.gender == 0
                      ? Icon(Icons.female)
                      : Icon(Icons.male),
                ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: SizedBox(
            height: widget.avatarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.userProfile.nickname ?? '这家伙还没想好自己的名字',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  widget.userProfile.remark ?? '',
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return RichTextViewerScreen(
                              baseApi: _baseApi,
                              storage: _storage,
                              imageHttpHeaders: _imageHttpHeaders!,
                              userProfile: widget.userProfile);
                        },
                        fullscreenDialog: true));
                  },
                  label: Text('发消息'),
                  icon: Icon(Icons.chat_outlined),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _getCardStyle1(BuildContext context) {
    return Card(
      // color: Color.fromARGB(0xFF, 0xE1, 0xF5, 0xFE),
      child: Column(
        children: [
          SimpleListItem(
            thumbnail: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ((!_processing && widget.userProfile.avatar != null)
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: widget.avatarWidth,
                        height: widget.avatarHeight,
                        placeholder: (context, url) => defaultAvatar,
                        errorWidget: (context, url, error) => loadErrorImage,
                        imageUrl:
                            BaseApi.getImageURL(widget.userProfile.avatar!),
                        httpHeaders: _imageHttpHeaders,
                      )
                    : defaultAvatar),
                if (!_processing && widget.userProfile.gender != null)
                  widget.userProfile.gender == 0
                      ? Icon(Icons.female)
                      : Icon(Icons.male)
              ],
            ),
            title: (!_processing && widget.userProfile.nickname != null)
                ? widget.userProfile.nickname!
                : '',
            subtitle: (!_processing && widget.userProfile.remark != null)
                ? widget.userProfile.remark!
                : '',
          ),
          ButtonBar(
            children: [
              ElevatedButton.icon(
                onPressed: null,
                label: Text('发消息'),
                icon: Icon(Icons.chat_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
