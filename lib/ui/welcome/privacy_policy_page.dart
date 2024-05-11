import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key, required this.ppUrl}) : super(key: key);

  final String ppUrl;
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final WebViewController controller = WebViewController();

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  final UniqueKey _key = UniqueKey();

  @override
  void initState() {
    controller
      ..setBackgroundColor(const Color(0xFFFFFFFC))
      ..loadRequest(Uri.parse(widget.ppUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFC),
          borderRadius: BorderRadius.only(
              topLeft: Radiuss.middle, topRight: Radiuss.middle)),
      child: Container(
          margin: EdgeInsets.only(
            top: Margin.middle.h,
            left: Margin.middle_smaller.w,
            right: Margin.middle_smaller.w,
          ),
          child: _profileInfoWidget()),
    );
  }

  Widget _profileInfoWidget() {
    return WebViewWidget(
      key: _key,
      controller: controller,
      gestureRecognizers: gestureRecognizers,
    );
  }
}
