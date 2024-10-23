import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomSlider extends StatefulWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onMaxChanged;
  final ValueChanged<double>? onMinChanged;
  final Widget? labelBuilder;
  final bool hasMin;
  final bool canEdit;
  const CustomSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.onMaxChanged,
    this.onMinChanged,
    this.labelBuilder,
    this.hasMin = true,
    this.canEdit = true,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late TextEditingController _maxController;
  late TextEditingController _minController;
  bool isUpdated = false;
  String? maxErrorText;
  String? minErrorText;
  late double sliderValue;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildSmallScreen();
          } else {
            return _buildWideScreen();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _maxController.dispose();
    _minController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _maxController = TextEditingController(text: widget.max.toString());
    _minController = TextEditingController(text: widget.min.toString());
    sliderValue = widget.value.clamp(widget.min, widget.max);
  }

  Widget _buildLabelWithIcon() {
    return Row(
      children: [
        if (widget.labelBuilder != null) ...[
          widget.labelBuilder!,
        ] else ...[
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Visibility(
            visible: widget.canEdit,
            child: IconButton(
              icon: Icon(isUpdated ? MdiIcons.check : MdiIcons.pencil),
              onPressed: () {
                setState(() {
                  isUpdated = !isUpdated;
                });
              },
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildMinMaxField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onChanged,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*$'))
      ],
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }

  Widget _buildMinMaxFields() {
    return Column(
      children: [
        if (widget.hasMin) ...[
          _buildMinMaxField(
            controller: _minController,
            label: 'Min',
            onChanged: (value) {
              double minValue = double.tryParse(value) ?? widget.min;
              if (minValue >= widget.max) {
                setState(() {
                  minErrorText = 'Min cannot be greater than or equal to Max';
                });
              } else {
                setState(() {
                  minErrorText = null;
                });
                widget.onMinChanged!(minValue);
                _updateSliderValue();
              }
            },
            errorText: minErrorText,
          ),
          const SizedBox(height: 10),
        ],
        _buildMinMaxField(
          controller: _maxController,
          label: 'Max',
          onChanged: (value) {
            double maxValue = double.tryParse(value) ?? widget.max;
            if (maxValue <= widget.min) {
              setState(() {
                maxErrorText = 'Max cannot be less than or equal to Min';
              });
            } else {
              setState(() {
                maxErrorText = null;
              });
              widget.onMaxChanged!(maxValue);
              _updateSliderValue();
            }
          },
          errorText: maxErrorText,
        ),
      ],
    );
  }

  Widget _buildSliderWithValue() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: SizedBox(
            child: Slider.adaptive(
              thumbColor: Theme.of(context).primaryColor,
              value: sliderValue,
              min: widget.min,
              max: widget.max,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
                widget.onChanged(double.parse(value.toStringAsFixed(2)));
              },
            ),
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(sliderValue.toStringAsFixed(1)),
        ),
      ],
    );
  }

  Widget _buildSmallScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLabelWithIcon(),
        _buildSliderWithValue(),
        if (isUpdated) _buildMinMaxFields(),
      ],
    );
  }

  Widget _buildWideScreen() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: Text(widget.label)),
        Expanded(
          flex: 5,
          child: Slider(
            value: sliderValue,
            min: widget.min,
            max: widget.max,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(sliderValue.toStringAsFixed(1)),
        ),
        Visibility(
          visible: widget.canEdit,
          child: IconButton(
            icon: Icon(isUpdated ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                isUpdated = !isUpdated;
              });
            },
          ),
        ),
        if (isUpdated)
          Expanded(
            flex: 2,
            child: _buildMinMaxFields(),
          ),
      ],
    );
  }

  void _updateSliderValue() {
    setState(() {
      sliderValue = sliderValue.clamp(widget.min, widget.max);
    });
  }
}
