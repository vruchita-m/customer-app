// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;
import 'dart:ui';

/// The window to which this binding is bound.
ui.SingletonFlutterWindow get window => ui.window;

Locale? get deviceLocale => ui.window.locale;

///The number of device pixels for each logical pixel.
double get pixelRatio => ui.window.devicePixelRatio;

Size get size => ui.window.physicalSize / pixelRatio;

///The horizontal extent of this size.
double get width => size.width;

///The vertical extent of this size
double get height => size.height;
