import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/enums/gradient.enum.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/modules/gradient_builder/controllers/user_gradient_card_controller.dart';
import 'package:schematic/app/modules/gradient_builder/widgets/gradient_tile.dart';
import 'package:shimmer/shimmer.dart';

class UserGradientCard extends GetView<UserGradientCardController> {
  final UserGradientModel userGradient;

  @override
  final UserGradientCardController controller;

  UserGradientCard({
    super.key,
    required this.userGradient,
  }) : controller = Get.put(
          UserGradientCardController(
            userGradient: userGradient,
          ),
          tag: userGradient.id,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: ThemeManager().defaultBorder(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const Divider(),
          _buildGradientPreview(),
          const Divider(),
          Obx(() {
            return controller.isLoading.value
                ? _buildShimmer()
                : _buildUserDetails(context);
          }),
        ],
      ),
    );
  }

  Widget _buildGradientPreview() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: userGradient.gradient!.toGradient().value,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.topRight,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          GradientType.values
              .firstWhere((element) => element == userGradient.gradient!.type)
              .icon,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userGradient.name ?? "Untitled",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Row(
                children: [
                  Text(userGradient.gradient!.type.name),
                  const Text(" | "),
                  Text("${userGradient.gradient!.colors.length} colors"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: ThemeManager().secondaryColor,
      highlightColor: ThemeManager().primaryColor,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 15,
        dense: true,
        leading: const CircleAvatar(radius: 16),
        title: Container(height: 14, width: 100, color: Colors.white),
        subtitle: Container(height: 10, width: 80, color: Colors.white),
        trailing: Icon(MdiIcons.dotsVertical),
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context) {
    final user = controller.user.value!;
    print(user.toJson());
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 15,
      dense: true,
      leading: CircleAvatar(
        backgroundColor: ThemeManager().tertiaryColor,
        foregroundColor: Colors.white,
        radius: 15,
        backgroundImage: NetworkImage(
          user.avatar ?? 'https://picsum.photos/200',
        ),
      ),
      title: Text(
        user.name ?? "Anonymous",
        style: Theme.of(context).textTheme.labelSmall,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        userGradient.publishedDate,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: SizedBox(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LikeButton(
              size: 20,
              circleColor: CircleColor(
                start: ThemeManager().dangerColor,
                end: ThemeManager().secondaryColor,
              ),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              isLiked:
                  userGradient.likedBy![controller.userService.uid] ?? false,
              likeCount: userGradient.likeCount,
              onTap: (isLiked) {
                controller.likeGradient();
                return Future.value(!isLiked);
              },
            ),
            LikeButton(
              size: 20,
              circleColor: CircleColor(
                start: ThemeManager().dangerColor,
                end: ThemeManager().secondaryColor,
              ),
              likeBuilder: (isSaved) {
                return Icon(
                  isSaved ? MdiIcons.bookmark : MdiIcons.bookmarkOutline,
                  color: isSaved
                      ? ThemeManager().dangerColor
                      : ThemeManager().secondaryColor,
                  size: 20,
                );
              },
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              isLiked:
                  userGradient.savedBy![controller.userService.uid] ?? false,
              likeCount: userGradient.saveCount,
              onTap: (isSaved) {
                controller.saveGradient();
                return Future.value(!isSaved);
              },
            ),
          ],
        ),
      ),
    );
  }
}
