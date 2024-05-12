import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/constants.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/resources/routes.dart';
import 'package:tasks_go_brr/ui/custom/animated_gesture_detector.dart';
import 'package:tasks_go_brr/ui/custom/clippers/app_bar_clipper_4.dart';
import 'package:tasks_go_brr/ui/main/settings/settings_view_model.dart';
import 'package:tasks_go_brr/ui/main/settings/widgets/category_title.widget.dart';
import 'package:tasks_go_brr/utils/locale.dart';

import 'widgets/notifications.widget.dart';
import 'widgets/profile.widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  final SettingsViewModel _model = SettingsViewModel();
  late Future _futureSettings;
  late Future _futurePackageInfo;

  @override
  void initState() {
    _futureSettings = _model.initRepo();
    _futurePackageInfo = _model.getPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.background,
      child: Stack(
        children: [
          FutureBuilder(
            future: _futureSettings,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: Dimens.top_curve_height_4 + Margin.middle.h,
                      ),
                      NotificationsWidget(model: _model),
                      _localizationSettings(),
                      SizedBox(
                        height: Margin.middle.h,
                      ),
                      _themeSettings(),
                      SizedBox(
                        height: Margin.middle.h,
                      ),
                      _devInfo(),
                      SizedBox(
                        height: Margin.middle.h,
                      ),
                      FutureBuilder(
                        future: _futurePackageInfo,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              !snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                "version".tr(
                                    namedArgs: {"ver": snapshot.data!.version}),
                                style: TextStyle(
                                    fontSize: Dimens.text_small_bigger,
                                    fontWeight: FontWeight.w500,
                                    color: context.onSurfaceAccent),
                              ),
                            );
                          } else
                            return Container();
                        },
                      ),
                      SizedBox(
                        height: Margin.big.h + Margin.middle.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: Margin.big.w,
                        ),
                        child: Image.asset(
                          ImagePath.CAT_FREE,
                          color: context.onSurface,
                        ),
                      ),
                      SizedBox(
                        height: Margin.big.h + Margin.middle.h,
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          PreferredSize(
            preferredSize: Size.fromHeight(Dimens.app_bar_height),
            child: ClipPath(
              clipper: AppBarClipper4(),
              child: Container(color: context.secondary),
            ),
          ),
          Column(
            children: [
              SizedBox(height: Dimens.getStatusBarHeight(context)),
              SizedBox(height: Margin.big.h),
              ProfileWidget(model: _model),
            ],
          ),
        ],
      ),
    );
  }

  Widget _localizationSettings() {
    var _languageButtonKey = GlobalKey();
    return Column(
      children: [
        CategoryTitleWidget(text: "settings.localization".tr()),
        SizedBox(
          height: Margin.small.h,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Margin.middle.w * 2),
          child: AnimatedGestureDetector(
            onTap: () => _showLanguageDialog(_languageButtonKey),
            child: Text(
              "${"language".tr()}: ${_model.getCurrentLanguage()}",
              key: _languageButtonKey,
              style: TextStyle(
                color: context.onSurfaceAccent,
                fontWeight: FontWeight.w500,
                fontSize: Dimens.text_normal_smaller,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _themeSettings() {
    return Column(
      children: [
        CategoryTitleWidget(text: "settings.theme".tr()),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            left: Margin.middle.w * 2,
          ),
          child: Column(
            children: [
              SizedBox(
                height: Margin.small.h,
              ),
              _radioItem(
                  id: Themes.LIGHT,
                  selectedId: _model.settings.theme,
                  text: "themes.light".tr()),
              SizedBox(
                height: Margin.middle_smaller.h,
              ),
              _radioItem(
                  id: Themes.DARK,
                  selectedId: _model.settings.theme,
                  text: "themes.dark".tr()),
              SizedBox(
                height: Margin.middle_smaller.h,
              ),
              _radioItem(
                  id: Themes.DEVICE,
                  selectedId: _model.settings.theme,
                  text: "same_as_device".tr()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _devInfo() {
    return Column(
      children: [
        CategoryTitleWidget(text: "settings.dev".tr()),
        SizedBox(
          height: Margin.small.h,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Margin.middle.w * 2),
          child: AnimatedGestureDetector(
            onTap: () => _showRateView(),
            child: Text(
              "rate_my_app".tr(),
              style: TextStyle(
                color: context.onSurfaceAccent,
                fontWeight: FontWeight.w500,
                fontSize: Dimens.text_normal_smaller,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Margin.small.h,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Margin.middle.w * 2),
          child: AnimatedGestureDetector(
            onTap: () => Routes.showBottomPurchasePage(context),
            child: Text(
              "thank_dev".tr(),
              style: TextStyle(
                color: context.onSurfaceAccent,
                fontWeight: FontWeight.w500,
                fontSize: Dimens.text_normal_smaller,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Margin.small.h,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Margin.middle.w * 2),
          child: AnimatedGestureDetector(
            onTap: () => Routes.showDevInfoPage(context),
            child: Text(
              "dev_info".tr(),
              style: TextStyle(
                color: context.onSurfaceAccent,
                fontWeight: FontWeight.w500,
                fontSize: Dimens.text_normal_smaller,
              ),
            ),
          ),
        )
      ],
    );
  }

  _showLanguageDialog(GlobalKey key) async {
    RenderBox? renderBox = key.currentContext!.findRenderObject() as RenderBox?;
    var size = renderBox!.size;
    var offset =
        renderBox.localToGlobal(Offset(0.0, size.height + Margin.small));

    String? result = await showMenu(
        position: RelativeRect.fromLTRB(
            offset.dx + renderBox.size.width * .45,
            offset.dy,
            renderBox.size.width + offset.dx,
            renderBox.size.height + offset.dy),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radiuss.small)),
        color: context.surface,
        items: _getAvailableLocales(),
        context: context,
        elevation: 0);

    if (result != null) {
      await _model.setLocale(context, result);
      setState(() {});
    }
  }

  List<PopupMenuEntry<String>> _getAvailableLocales() {
    List<PopupMenuEntry<String>> list = [];

    for (var locale in EasyLocalization.of(context)!.supportedLocales) {
      list.add(PopupMenuItem(
        enabled: _model.settings.locale != locale.toString(),
        value: locale.toString(),
        child: Text(
          locale.toString().getLanguage(),
          style: TextStyle(
            color: _model.settings.locale != locale.toString()
                ? context.onSurface
                : context.onSurfaceAccent,
            fontWeight: _model.settings.locale != locale.toString()
                ? FontWeight.w500
                : FontWeight.normal,
          ),
        ),
      ));
    }

    list.add(PopupMenuItem(
      value: LocalesSupported.DEVICE,
      enabled: _model.settings.locale != LocalesSupported.DEVICE,
      child: Text(
        "same_as_device".tr(),
        style: TextStyle(
          color: _model.settings.locale != LocalesSupported.DEVICE
              ? context.onSurface
              : context.onSurfaceAccent,
          fontWeight: _model.settings.locale != LocalesSupported.DEVICE
              ? FontWeight.w500
              : FontWeight.normal,
        ),
      ),
    ));

    return list;
  }

  Widget _radioItem(
      {required int id, required int selectedId, required String text}) {
    return AnimatedGestureDetector(
      onTap: () async {
        await _model.setTheme(context, id);
        setState(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: Dimens.radio_button_size,
            height: Dimens.radio_button_size,
            decoration: BoxDecoration(
                color: Color.lerp(context.primary, context.surfaceAccent,
                    id == selectedId ? 0 : 1),
                borderRadius: BorderRadius.all(Radiuss.small_smaller)),
          ),
          SizedBox(
            width: Margin.small.w,
          ),
          Text(
            text,
            style: TextStyle(
              color: context.onSurfaceAccent,
              fontWeight: FontWeight.w500,
              fontSize: Dimens.text_normal_smaller,
            ),
          ),
          Expanded(
              child: Container(
            color: context.background,
            height: 20.h,
          ))
        ],
      ),
    );
  }

  _showRateView() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) inAppReview.requestReview();
  }


}

