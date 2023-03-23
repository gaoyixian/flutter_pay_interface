import 'package:flutter/material.dart';

/// 获取数据
/// key 如:data.name
T? getObjectKeyValueByPath<T>(dynamic object, String key, {T? def}) {
  var keys = key.split('.');
  dynamic obj = object;
  while (obj != null && keys.isNotEmpty) {
    String key0 = keys.removeAt(0);
    obj = obj[key0];
  }
  if (keys.isNotEmpty) {
    return def;
  }
  if (obj is T) {
    return obj;
  }
  return def;
}

typedef LocalizationText = Widget Function(
  String data, {
  Key? key,
  // List<String>? textFormat,
  TextStyle? style,
  TextAlign? textAlign,
  // TextDirection? textDirection,
  // Locale? locale,
  // bool? softWrap,
  // TextOverflow? overflow,
  // double? textScaleFactor,
  // int? maxLines,
  // String? semanticsLabel,
  // TextWidthBasis? textWidthBasis,
  // TextHeightBehavior? textHeightBehavior,
  // Color? selectionColor,
  // InlineSpan? textSpan,
});

typedef VerifyReceipt = Future<bool> Function(String?, String, String);

abstract class FlutterPayInterface {
  // 初始化
  Future<void> init(
      {required VerifyReceipt verifyReceipt,
      required LocalizationText localizationText,
      required void Function() onError});
  // 支付
  Future<void> pay(dynamic rsp, int time);
  // 恢复购买
  Future<void> restorePurchases();
  // 退出登录
  Future<void> logout();
}
