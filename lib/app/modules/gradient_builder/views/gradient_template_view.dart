import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_button.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: ThemeManager().defaultBorder(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: gradient.gradient!.toGradient().value,
              )),
          const Divider(),
          Text(
            gradient.name!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 5),
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
          SizedBox(
            height: 25,
            child: NeoButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                elevation: WidgetStatePropertyAll(0),
                shadowColor: WidgetStatePropertyAll(Colors.transparent),
                minimumSize: WidgetStatePropertyAll(Size.fromHeight(25)),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 5),
                ),
              ),
              onPressed: () {
                onUse?.call();
              },
              child: const Text("Use"),
            ),
          ),
        ],
      ),
    );
  }
}
