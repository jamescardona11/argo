import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:argo/src/models/typedef.dart';

class MeasureWidgetWrapper extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onSizeChange;

  const MeasureWidgetWrapper({
    Key? key,
    required this.onSizeChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SizeRenderObject(onSizeChange);
  }
}

class _SizeRenderObject extends RenderProxyBox {
  _SizeRenderObject(this.onSizeChange);

  final OnWidgetSizeChange onSizeChange;
  Size currentSize = Size.zero;

  @override
  void performLayout() {
    super.performLayout();

    Size? newSize = child?.size;

    if (newSize != null && currentSize != newSize) {
      currentSize = newSize;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onSizeChange(newSize);
      });
    }
  }
}
