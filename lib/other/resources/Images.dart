import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class Images {
  static var isRtl = false;

  static Widget get preloader => Image.asset("assets/preloader.png");

  static Widget get next => Opacity(opacity: 0.5, child: Transform(
      transform: Matrix4.rotationY(math.pi*(isRtl ? 1 : 0)),
      child: SvgPicture.asset("assets/next.svg")
  ));
  static Widget get filter => SvgPicture.asset("assets/filter.svg");
}