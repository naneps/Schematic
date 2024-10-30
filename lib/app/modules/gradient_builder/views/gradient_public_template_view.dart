import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_public_controller.dart';

class GradientPublicView extends GetView<GradientPublicController> {
  const GradientPublicView({super.key});

  @override
  get controller => Get.put(GradientPublicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: const Column(),
          tablet: Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: ThemeManager().defaultBorder(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Search Gradient",
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        NeoIconButton(
                          size: const Size(35, 35),
                          icon: Icon(MdiIcons.magnify),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    StreamBuilder(
                      stream: controller.gradientRepo.getPublicGradients(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: LoadingWidget());
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return GridView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              final userGradient = snapshot.data![index];
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: ThemeManager().defaultBorder(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      userGradient.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    const Divider(),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: userGradient.gradient!
                                              .toGradient()
                                              .value,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              )),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
