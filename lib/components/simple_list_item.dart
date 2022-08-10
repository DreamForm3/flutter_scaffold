import 'package:flutter/material.dart';

/// 布局类型类似于 Flutter 自带的 ListTitle，但是没有高度限制，可以放更大的图片
class SimpleListItem extends StatelessWidget {

  /// 构造方法
  ///
  /// [thumbnail] 缩略图
  ///
  /// [title] 标题
  ///
  /// [subtitle] 副标题
  const SimpleListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    this.subtitle = '',
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
                child: _ListItemDescription(
                  title: title,
                  subtitle: subtitle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ListItemDescription extends StatelessWidget {
  const _ListItemDescription({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline3,
        ),
        const Padding(padding: EdgeInsets.only(bottom: 4.0)),
        Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
