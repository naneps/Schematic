import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/models/apikey_model.dart';
import 'package:schematic/app/modules/setting/controllers/apikey_controller.dart';
import 'package:schematic/app/services/google_generative_service.dart';

class ApikeyTile extends StatefulWidget {
  final ApiKey apiKey;
  final ApiKeyController controller;

  const ApikeyTile({
    super.key,
    required this.apiKey,
    required this.controller,
  });

  @override
  _ApikeyTileState createState() => _ApikeyTileState();
}

class _ApikeyTileState extends State<ApikeyTile> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool _isDeleted = false; // Track if the widget is being deleted

  @override
  Widget build(BuildContext context) {
    return _isDeleted
        ? const SizedBox(
            height: 0,
            width: 0,
          ) // Widget disappears when deleted
        : AnimatedBuilder(
            animation: _flipAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: _buildTile(context),
            ),
            builder: (context, child) {
              final angle = _flipAnimation.value * 3.1416 * 2;
              return Transform(
                transform: Matrix4.rotationX(angle),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
  }

  @override
  void didUpdateWidget(covariant ApikeyTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.apiKey.isDefault!.value != oldWidget.apiKey.isDefault!.value) {
      _onIsDefaultChanged();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Initialize scale animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  Widget _buildTile(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: ThemeManager().defaultBorder(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        leading: CircleAvatar(
          backgroundColor: widget.apiKey.isDefault!.value
              ? ThemeManager().successColor
              : ThemeManager().tertiaryColor,
          child: Icon(
            widget.apiKey.isDefault!.value ? MdiIcons.key : MdiIcons.keyOutline,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(widget.apiKey.name!,
            style: Theme.of(context).textTheme.labelMedium),
        subtitle: Text.rich(TextSpan(
          children: [
            TextSpan(
              text:
                  "${widget.apiKey.keyValue!.replaceRange(widget.apiKey.keyValue!.length ~/ 3, widget.apiKey.keyValue!.length, '*' * (widget.apiKey.keyValue!.length ~/ 4))} ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            WidgetSpan(
                child: InkWell(
              child: Icon(
                MdiIcons.contentCopy,
                size: 16,
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: widget.apiKey.keyValue!))
                    .then(
                  (value) => Get.snackbar("Copied", "Key copied to clipboard!"),
                );
              },
            ))
          ],
        )),
        trailing: SizedBox(
          height: 40,
          width: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NeoButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.apiKey.isDefault!.value
                      ? ThemeManager().successColor
                      : ThemeManager().infoColor,
                  fixedSize: const Size(50, 40),
                ),
                child: Text(widget.apiKey.isDefault!.value ? "Used" : "Use"),
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 250), () {
                    widget.controller.updateApi(widget.apiKey);
                  });
                  setState(() {
                    widget.apiKey.isDefault!.value =
                        !widget.apiKey.isDefault!.value;
                  });
                  _flipTile();
                  Get.find<GoogleGenerativeService>().setApikey();
                },
              ),
              const SizedBox(width: 10),
              NeoIconButton(
                icon: Icon(MdiIcons.trashCanOutline),
                size: const Size(40, 40),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: ThemeManager().errorColor,
                ),
                onPressed: () {
                  _onDelete();
                },
              )
            ],
          ),
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  void _flipTile() {
    if (_controller.isAnimating) return;
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _onDelete() {
    _scaleController.forward().then((_) {
      setState(() {
        _isDeleted = true; // Mark widget as deleted
      });
      widget.controller.deleteApi(widget.apiKey.id!); // Trigger delete logic
    });
  }

  void _onIsDefaultChanged() {
    _flipTile();
  }
}
