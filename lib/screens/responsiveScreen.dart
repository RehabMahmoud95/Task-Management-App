import 'package:flutter/material.dart';
import 'package:task_management_app/constants.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  const ResponsiveScreen(this.mobileBody, this.desktopBody, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.maxWidth < Constants.mobileWidth) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
