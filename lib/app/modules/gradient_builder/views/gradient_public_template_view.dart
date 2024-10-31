import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/buttons/neo_icon_button.dart';
import 'package:schematic/app/commons/ui/loading.widget.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/gradient_public_controller.dart';
import 'package:schematic/app/modules/gradient_builder/views/grid_gradient_public_view.dart';

class GradientPublicView extends GetView<GradientPublicController> {
  const GradientPublicView({super.key});

  @override
  get controller => Get.put(GradientPublicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Public Gradients"),
        centerTitle: true,
        backgroundColor: ThemeManager().primaryColor,
      ),
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: const Column(),
          tablet: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: ThemeManager().defaultBorder(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      const SliverAppBar(
                        backgroundColor: Colors.transparent,
                        leading: SizedBox.shrink(),
                        expandedHeight: 100,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Explore Stunning Gradients",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Search for gradients to inspire your next design project. Use the search bar to find specific styles.",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        pinned: true, // Keeps the AppBar visible when scrolling
                        leading: const SizedBox.shrink(),
                        expandedHeight: 40,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(15),
                                        hintText: "Search Gradient",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  NeoIconButton(
                                    size: const Size(40, 40),
                                    icon: Icon(MdiIcons.magnify),
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 10),
                                  NeoIconButton(
                                    size: const Size(40, 40),
                                    icon: Icon(MdiIcons.filterVariant),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: double.infinity,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: StreamBuilder(
                            stream:
                                controller.gradientRepo.getPublicGradients(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                    height: Get.height * 0.5,
                                    width: 200,
                                    child:
                                        const Center(child: LoadingWidget()));
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text("Error: ${snapshot.error}"));
                              } else if (snapshot.data == null ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text("No gradients found"),
                                );
                              }
                              return GridGradientPublicView(snapshot: snapshot);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: ThemeManager().defaultBorder(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Gradient Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Explore actions for the selected gradient: copy code, save as image, and more!",
                        style: TextStyle(fontSize: 14),
                      ),
                      const Divider(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeManager().successColor,
                              ),
                              onPressed: () {
                                // Implement code copying functionality
                              },
                              icon: const Icon(Icons.code),
                              label: const Text("Copy Code"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeManager().infoColor,
                              ),
                              onPressed: () {
                                // Implement save as image functionality
                              },
                              icon: const Icon(Icons.image),
                              label: const Text("Save as Image"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Implement additional actions here
                              },
                              icon: const Icon(Icons.more_horiz),
                              label: const Text("More Actions"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          color: Colors.grey[100],
                          padding: const EdgeInsets.all(20),
                          child: Center(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/barrier.png",
                                scale: 4,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Under Construction",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
