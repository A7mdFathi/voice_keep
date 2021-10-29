import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Voice keep',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 45.sp,
          ),
          textAlign: TextAlign.center,
        ),
        const Center(child: CircularProgressIndicator()),
        SizedBox(height: 12.h),
      ],
    ));
  }
}
