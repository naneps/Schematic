import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
import 'package:schematic/app/enums/gradient.enum.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_template_controller.dart';

class GradientTemplateView extends GetView<GradientTemplateController> {
  const GradientTemplateView({super.key});

  @override
  GradientTemplateController get controller =>
      Get.put(GradientTemplateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: ThemeManager().defaultBorder(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Your Gradients",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: controller.gradientRepo.getUserGradients(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Something went wrong ${snapshot.error}",
                      ),
                    );
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      shrinkWrap: true,
                      cacheExtent: 1000,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final gradient = snapshot.data![index];
                        return GradientTile(
                          gradient: gradient,
                          onUse: () {
                            controller.onUseGradient(gradient);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientTile extends StatelessWidget {
  final UserGradientModel gradient;
  final VoidCallback? onUse;
  const GradientTile({
    super.key,
    required this.gradient,
    this.onUse,
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
              )),
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
                onTap: () {},
                child: Icon(
                  MdiIcons.pencilOutline,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: Icon(
                  MdiIcons.trashCanOutline,
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
