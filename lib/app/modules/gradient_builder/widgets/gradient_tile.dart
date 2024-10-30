import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/enums/gradient.enum.dart';
import 'package:schematic/app/models/user_gradient.model.dart';

class GradientTile extends StatelessWidget {
  final UserGradientModel gradient;
  final VoidCallback? onUse;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onPublish;
  const GradientTile({
    super.key,
    required this.gradient,
    this.onDelete,
    this.onEdit,
    this.onUse,
    this.onPublish,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: ThemeManager().defaultBorder(),
      ),
      child: ExpansionTile(
        leading: Icon(
          GradientType.values
              .firstWhere((element) => element == gradient.gradient!.type)
              .icon,
        ),

        title: Text(
          gradient.name ?? "Untitled",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        subtitle: Text("${gradient.gradient!.colors.length} colors"),
        onExpansionChanged: (value) {},
        tilePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: gradient.gradient!.toGradient().value,
            ),
            alignment: Alignment.center,
            child: gradient.published!
                ? const Text("Published")
                : NeoButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      onPublish?.call();
                    },
                    child: const Text(
                      "Publish",
                    ),
                  ),
          ),
          const Divider(),
          Row(
            children: [
              ...gradient.gradient!.colors.take(5).map(
                (element) {
                  return CircleAvatar(
                    radius: 10,
                    backgroundColor: element,
                  );
                },
              ),
              if (gradient.gradient!.colors.length > 5)
                CircleAvatar(
                  radius: 10,
                  child: Text(
                    '+${gradient.gradient!.colors.length - 5}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: NeoButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(ThemeManager().infoColor),
                      elevation: const WidgetStatePropertyAll(0),
                      shadowColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      minimumSize:
                          const WidgetStatePropertyAll(Size.fromHeight(25)),
                      shape:
                          const WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      )),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 5),
                      ),
                    ),
                    onPressed: () {
                      onUse?.call();
                    },
                    child: const Text("Use"),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  onEdit?.call();
                },
                child: Icon(
                  MdiIcons.pencilOutline,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  onDelete?.call();
                },
                child: Icon(
                  MdiIcons.trashCanOutline,
                  color: ThemeManager().dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension IconGradient on GradientType {
  IconData? get icon => {
        GradientType.linear: Icons.linear_scale_outlined,
        GradientType.radial: Icons.circle_outlined,
        GradientType.sweep: Icons.gradient,
      }[this];
}
