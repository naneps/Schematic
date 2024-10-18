import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class ColorPickerWidget extends StatefulWidget {
  final List<Color> initialColors;
  final ValueChanged<List<Color>> onColorsChanged;
  final int minColors;

  const ColorPickerWidget({
    super.key,
    required this.initialColors,
    required this.onColorsChanged,
    this.minColors = 1,
  });

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Colors',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: !GetPlatform.isWeb ? 40 : 90,
            child: ReorderableListView.builder(
              scrollDirection: Axis.horizontal,
              onReorder: _onReorder,
              footer: SizedBox(
                height: 90,
                child: _buildAddButton(),
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return _buildColorItem(index);
              },
            ),
          ),
        ],
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
    return Container(
      key: const ValueKey('add_button'),
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: _showColorPicker,
      ),
    );
  }

  Widget _buildColorItem(int index) {
    return Container(
      key: ValueKey(colors[index]),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        // color: colors[index],
        // borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: colors[index],
          ),
          IconButton(
            icon: const Icon(Icons.palette),
            // color: Colors.white,
            onPressed: () {
              // Prevent removing if it would go below the minimum
              if (colors.length > widget.minColors) {
                _removeColor(index);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            // color: Colors.white,
            onPressed: () {
              if (colors.length > widget.minColors) {
                _removeColor(index);
              }
            },
          ),
        ],
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
    setState(() {
      colors.removeAt(index);
      widget.onColorsChanged(colors);
    });
  }

  void _showColorPicker() {
    Color pickerColor = Colors.white;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
                      setState(() {
                        _addColor(pickerColor);
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text('Select'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
