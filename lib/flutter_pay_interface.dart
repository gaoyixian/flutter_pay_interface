import 'package:events_widget/event_dispatcher.dart';
import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
typedef ShowBottomSheet = void Function(
      {required BuildContext context,
      required Widget container});

abstract class FlutterPayPlatform extends PlatformInterface {
  FlutterPayPlatform() : super(token: _token);
  static final Object _token = Object();

 static FlutterPayPlatform _instance = MethodChannelFlutterPay();

  /// The default instance of [OaidKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelOaidKit].
  static FlutterPayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OaidKitPlatform] when
  /// they register themselves.
  static set instance(FlutterPayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // 初始化
  Future<void> init(
      {required VerifyReceipt verifyReceipt,
      required LocalizationText localizationText,
      required void Function() onError,
      required ShowBottomSheet showBottomSheet,
      required IWithDrawalMgr withDrawalMgr,
      });
  // 支付
  Future<void> pay(dynamic rsp, int time);
  // 恢复购买
  Future<void> restorePurchases();
  // 退出登录
  Future<void> logout();
  Widget getPlayButton(BuildContext context, double rate, int chooseIndex,
      void Function(int index, int typ) toPay);
  void paymethodBottom(BuildContext context,
      {required int id,
      required int gold,
      required int rmb,
      required void Function(int p1, int p2) toPay});
  void vipPayBottom(BuildContext context, {required int index, required void Function(bool isShow) onchange});
  Widget getLxbysm();
  int getTyp(bool isAli);
  String getPname(bool isAli);
}

class MethodChannelFlutterPay extends FlutterPayPlatform{
  @override
  Widget getLxbysm() {
    // TODO: implement getAndroidlxbysm
    throw UnimplementedError();
  }

  @override
  Widget getPlayButton(BuildContext context, double rate, int chooseIndex, void Function(int index, int typ) toPay) {
    // TODO: implement getPlayButton
    throw UnimplementedError();
  }

  @override
  String getPname(bool isAli) {
    // TODO: implement getPname
    throw UnimplementedError();
  }

  @override
  int getTyp(bool isAli) {
    // TODO: implement getTyp
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> pay(rsp, int time) {
    // TODO: implement pay
    throw UnimplementedError();
  }

  @override
  void paymethodBottom(BuildContext context, {required int id, required int gold, required int rmb, required void Function(int p1, int p2) toPay}) {
    // TODO: implement paymethodBottom
  }

  @override
  Future<void> restorePurchases() {
    // TODO: implement restorePurchases
    throw UnimplementedError();
  }

  @override
  void vipPayBottom(BuildContext context, {required int index, required void Function(bool isShow) onchange}) {
    // TODO: implement vipPayBottom
  }
  
  @override
  Future<void> init({required VerifyReceipt verifyReceipt, required LocalizationText localizationText, required void Function() onError, required ShowBottomSheet showBottomSheet, required IWithDrawalMgr withDrawalMgr})async {
    // TODO: implement init
    // throw UnimplementedError();
  }
}

abstract class IWithDrawalMgr with EventDispatcher {
  static const String eventUpdateWithDrawList = 'updateWithDrawList';
  static const String eventUpdateListLastId = 'updateListLastId';
  static const String updateListUserCash = 'updateListUserCash';
  int get selectAmount;
  set selectAmount(int v);
  //获取支付宝账户
  String get aliName;
  String get aliAccount;
  Future<bool> setAli(String aplipayId);
  getAli(int userId);

  dynamic get userId;
  bool get userHasrealName;
  double get userCash;
  List<IWithDrawalModel> get withdrawalActivityList; //活动提现
  List<IWithDrawalModel> get withdrawalDailyList; //日常提现
  //提现明细列表
  List<IWithDrawDetail> get withDrawList;

  String? get listLastId;
  set listLastId(String? v);
  Future withdrawal(
      int accountType, int id, String accountName, String account);
  Future queryWithdrawList(int pageCount);

  exchangeGold(int id);
  void toUserCertification(BuildContext context);
  void showToast(String tips);
  void navigatorPushTo(BuildContext context, Widget widget);
  Widget getListNodataView(String tips, Function? requestCallback);
  void setMakeEarningsFunc(Widget Function() v);
  void setMakeCashFunc(Widget Function() v);
  void setMakeCashDetailsFunc(Widget Function() v);
  void setPageDef(Type c1, Type c2, Type c3);
}

abstract class IWithDrawalModel {
  int get id;
  double get amount;
  int get dayTime;
  int get weekTime;
  int get auto;
  int get type;
  int get totalCount;
  int get activeType;
}

abstract class IWithDrawDetail {
  // int id = 0;
  String get orderNumber; //订单号
  int get status; //订单状态 默认0 待付款1 付款失败2 已完成3
  double get amount; //提现金额
  // int userId = 0; //提现用户
  int get accountType; //提现账户类型 默认0 支付宝1 微信2 银行卡3
  // String accountName = ''; //提现账户名
  // String account = ''; //提现账户
  int get transferTime; //提现转账时间
  int get createTime; //创建时间
  // int updateTime = 0; //更新时间
  // int type = 0; //提现类型
  applyJson(Map<String, dynamic> json);
}
