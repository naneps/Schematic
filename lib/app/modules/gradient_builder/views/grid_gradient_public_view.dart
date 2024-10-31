import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/widgets/user_gradient_card.dart';

class GridGradientPublicView extends StatelessWidget {
  final AsyncSnapshot<List<UserGradientModel>> snapshot;
  const GridGradientPublicView({
    required this.snapshot,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: snapshot.data?.length ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1 / 1.2,
      ),
      shrinkWrap: true,
      cacheExtent: 1000,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final userGradient = snapshot.data![index];
        return UserGradientCard(
          key: ValueKey(userGradient.id!),
          userGradient: userGradient,
        )
            .animate(
                delay: Duration(milliseconds: (100 * index).clamp(10, 500)))
            .fade()
            .scaleXY(
              begin: 0.5,
              end: 1.0,
              duration: const Duration(
                milliseconds: 500,
              ),
            );
      },
    );
  }
}
