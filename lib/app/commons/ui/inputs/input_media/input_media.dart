import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schematic/app/commons/ui/inputs/input_media/enums.dart';
import 'package:schematic/app/commons/ui/inputs/input_media/image_widget.dart';
import 'package:schematic/app/commons/ui/shapes/dotted_border.dart';

class InputMedia extends StatefulWidget {
  final SourceMedia source;
  final TypeInputMedia type;
  final bool canPreview;
  final TypeMedia typeMedia;
  final int maxMedia;
  final List<String> initialImages;

  const InputMedia({
    super.key,
    this.source = SourceMedia.gallery,
    this.type = TypeInputMedia.single,
    this.initialImages = const [],
    this.typeMedia = TypeMedia.image,
    this.canPreview = false,
    this.maxMedia = 5,
  });

  @override
  State<InputMedia> createState() => _InputMediaState();
}

class _InputMediaState extends State<InputMedia> {
  final picker = ImagePicker();
  late List<XFile> _selectedMedia;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<XFile> newMedia = await pickMedia();
        setState(() {
          if (widget.type == TypeInputMedia.single) {
            _selectedMedia = newMedia;
          } else {
            _selectedMedia.addAll(newMedia);
            if (_selectedMedia.length > widget.maxMedia) {
              _selectedMedia = _selectedMedia.sublist(0, widget.maxMedia);
            }
          }
        });
      },
      child: DottedBorder(
        strokeWidth: 1.0,
        color: Colors.black,
        dashPattern: const [4, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 70,
            minWidth: double.infinity,
          ),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: _selectedMedia.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.images,
                      size: 20,
                      color: Colors.grey.shade400,
                    ),
                    Text(
                      'Tap to select media',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey.shade400),
                    ),
                  ],
                )
              : SizedBox(
                  height: 70,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5),
                    padding: const EdgeInsets.all(5),
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedMedia.length,
                    itemBuilder: (context, index) {
                      final media = _selectedMedia[index];
                      return ImageWidget(
                        media: media,
                        onDeleted: () {
                          setState(() {
                            _selectedMedia.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> initialValue() async {
    // Convert initialImages to XFile if needed
    // widget.initialImages is network images and should be converted to XFile
  }
  @override
  void initState() {
    super.initState();
    _selectedMedia = [];
  }

  Future<List<XFile>> pickMedia() async {
    List<XFile> pickedFiles = [];

    if (widget.type == TypeInputMedia.single) {
      XFile? pickedFile = await _pickSingleMedia();
      if (pickedFile != null) {
        pickedFiles.add(pickedFile);
      }
    } else if (widget.type == TypeInputMedia.multiple) {
      pickedFiles = await _pickMultipleMedia();
    }

    return pickedFiles;
  }

  Future<List<XFile>> _pickMultipleMedia() async {
    List<XFile>? pickedFiles = [];
    if (widget.source == SourceMedia.camera) {
      // Camera doesn't support multiple selection directly, handling single file selection for now
      final XFile? pickedFile = await _pickSingleMedia();
      if (pickedFile != null) pickedFiles = [pickedFile];
    } else if (widget.source == SourceMedia.gallery) {
      if (widget.typeMedia == TypeMedia.image) {
        pickedFiles = await picker.pickMultiImage();
      } else if (widget.typeMedia == TypeMedia.video) {
        // Currently, ImagePicker doesn't support multi-video selection, handling it with single selection for now
        final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
        if (pickedFile != null) pickedFiles = [pickedFile];
      } else if (widget.typeMedia == TypeMedia.media) {
        // Implement your own logic for multiple media selection if needed
        pickedFiles =
            await picker.pickMultipleMedia(); // or any custom implementation
      }
    }
    return pickedFiles ?? [];
  }

  Future<XFile?> _pickSingleMedia() async {
    XFile? pickedFile;

    if (widget.source == SourceMedia.camera) {
      if (widget.typeMedia == TypeMedia.image) {
        pickedFile = await picker.pickImage(source: ImageSource.camera);
      } else if (widget.typeMedia == TypeMedia.video) {
        pickedFile = await picker.pickVideo(source: ImageSource.camera);
      }
    } else if (widget.source == SourceMedia.gallery) {
      if (widget.typeMedia == TypeMedia.image) {
        pickedFile = await picker.pickImage(source: ImageSource.gallery);
      } else if (widget.typeMedia == TypeMedia.video) {
        pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      } else if (widget.typeMedia == TypeMedia.media) {
        pickedFile = await picker.pickMedia(); // Fallback for single media
      }
    }

    return pickedFile;
  }
}
