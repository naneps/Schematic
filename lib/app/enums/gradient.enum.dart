// Enum to represent the gradient types
import 'package:flutter/material.dart';

enum AlignmentType {
  center,
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight
}

enum GradientType { linear, radial, sweep }

// Model to represent the gradient configuration
enum TileModeType { clamp, mirror, repeat }

extension AlignmentTypeExtension on AlignmentType {
  Alignment get alignment {
    switch (this) {
      case AlignmentType.center:
        return const Alignment(0.0, 0.0);
      case AlignmentType.topLeft:
        return const Alignment(-1.0, -1.0);
      case AlignmentType.topCenter:
        return const Alignment(0.0, -1.0);
      case AlignmentType.topRight:
        return const Alignment(1.0, -1.0);
      case AlignmentType.centerLeft:
        return const Alignment(-1.0, 0.0);
      case AlignmentType.centerRight:
        return const Alignment(1.0, 0.0);
      case AlignmentType.bottomLeft:
        return const Alignment(-1.0, 1.0);
      case AlignmentType.bottomCenter:
        return const Alignment(0.0, 1.0);
      case AlignmentType.bottomRight:
        return const Alignment(1.0, 1.0);
    }
  }
}

extension GradientTypeExtension on GradientType {
  Gradient get gradient {
    switch (this) {
      case GradientType.linear:
        return const LinearGradient(
          colors: [Colors.red, Colors.blue],
          stops: [0.0, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      case GradientType.radial:
        return const RadialGradient(
          colors: [Colors.red, Colors.blue],
          stops: [0.0, 1.0],
          center: Alignment.center,
          radius: 0.5,
        );
      case GradientType.sweep:
        return const SweepGradient(
          colors: [Colors.red, Colors.blue],
          stops: [0.0, 1.0],
          center: Alignment.center,
          startAngle: 0.0,
          endAngle: 3.14,
        );
    }
  }
}

extension TileModeExtension on TileModeType {
  TileMode get tileMode {
    switch (this) {
      case TileModeType.clamp:
        return TileMode.clamp;
      case TileModeType.mirror:
        return TileMode.mirror;
      case TileModeType.repeat:
        return TileMode.repeated;
    }
  }
}

extension TileModeTypeExtension on TileModeType {
  String get name {
    switch (this) {
      case TileModeType.clamp:
        return 'clamp';
      case TileModeType.mirror:
        return 'mirror';
      case TileModeType.repeat:
        return 'repeated';
    }
  }
}
