import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ScrollToHide extends StatefulWidget {
  Widget child;
  ScrollController controller;
  double height = 40;
  ScrollToHide({
    super.key,
    required this.child,
    required this.controller,
    this.height = 40,
  });

  @override
  State<ScrollToHide> createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isShow ? widget.height : 0,
      child: widget.child,
    );
  }

  @override
  dispose() {
    super.dispose();
    widget.controller.removeListener(listen);
  }

  void hide() {
    if (isShow) {
      setState(() {
        isShow = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  void listen() {
    if (widget.controller.position.userScrollDirection ==
        ScrollDirection.reverse) {
      hide();
    } else if (widget.controller.position.userScrollDirection ==
        ScrollDirection.forward) {
      show();
    }
    if (widget.controller.hasClients) {
      if (widget.controller.offset > 0) {
        show();
      } else {
        hide();
      }
    }
  }

  void show() {
    if (!isShow) {
      setState(() {
        isShow = true;
      });
    }
  }
}
