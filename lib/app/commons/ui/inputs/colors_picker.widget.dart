import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/commons/ui/overlays/scale_dialog.dart';

class ColorPickerWidget extends StatefulWidget {
  final List<Color> initialColors;
  final ValueChanged<List<Color>> onColorsChanged;
  final int minColors;
  final bool multiple;
  const ColorPickerWidget({
    super.key,
    required this.initialColors,
    required this.onColorsChanged,
    this.minColors = 1,
    this.multiple = false,
  });

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ThemeManager().blackColor, width: 2),
        boxShadow: [ThemeManager().defaultShadow()],
      ),
      child: SizedBox(
        height: 40,
        child: colors.isEmpty
            ? _buildAddButton()
            : ReorderableListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                onReorder: _onReorder,
                footer: Row(
                  children: [
                    _buildAddButton(),
                    Tooltip(
                      message:
                          'Double tap to remove color \nTap to edit color \nHold to reorder colors',
                      waitDuration: const Duration(seconds: 1),
                      textStyle: Theme.of(context).textTheme.bodySmall,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: ThemeManager().defaultBorder(),
                      ),
                      child: Icon(
                        MdiIcons.informationOutline,
                        color: ThemeManager().infoColor,
                        size: 20,
                      ),
                    )
                  ],
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return _buildColorItem(index);
                },
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    colors = List.from(widget.initialColors);
  }

  void _addColor(Color color) {
    setState(() {
      colors.add(color);
      widget.onColorsChanged(colors);
    });
  }

  Widget _buildAddButton() {
    return IconButton(
      splashRadius: 20,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        fixedSize: const Size(40, 40),
        shape: const CircleBorder(),
        side: BorderSide(color: Colors.grey.shade300),
        padding: const EdgeInsets.all(0),
        shadowColor: Colors.grey.shade400,
      ),
      icon: const Icon(Icons.add),
      onPressed: _showColorPicker,
    );
  }

  Widget _buildColorItem(int index) {
    return Container(
      key: ValueKey(colors[index]),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onDoubleTap: () {
          _removeColor(index);
        },
        onTap: () {
          _showColorPicker(isUpdate: true, index: index, color: colors[index]);
        },
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.grey.shade300,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: colors[index],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No colors selected. Add a color.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final color = colors.removeAt(oldIndex);
      colors.insert(newIndex, color);
      widget.onColorsChanged(colors);
    });
  }

  void _removeColor(int index) {
    if (colors.length > widget.minColors) {
      setState(() {
        colors.removeAt(index);
        widget.onColorsChanged(colors);
      });
    } else {
      // Show a warning or handle the case when below minimum colors
      Get.snackbar(
        "Minimum Color Requirement",
        "You must keep at least ${widget.minColors} color(s).",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showColorPicker({bool isUpdate = false, int index = 0, Color? color}) {
    Color pickerColor = color ?? Colors.white;
    showDialog(
      context: context,
      builder: (context) {
        return ScaleDialog(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            scrollable: true,
            content: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ColorPicker(
                    pickerColor: pickerColor,
                    portraitOnly: true,
                    labelTypes:
                        ColorLabelType.values.map((type) => type).toList(),
                    onColorChanged: (color) {
                      pickerColor = color;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: const BorderSide(color: Colors.black, width: 1),
                      ),
                      onPressed: () {
                        if (isUpdate) {
                          _updateColor(index, pickerColor);
                        } else {
                          _addColor(pickerColor);
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        isUpdate ? 'Update' : 'Add',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateColor(int index, Color color) {
    setState(() {
      colors[index] = color;
      widget.onColorsChanged(colors);
    });
  }
}
