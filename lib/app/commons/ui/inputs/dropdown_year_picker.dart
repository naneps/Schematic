import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DropdownYearPicker extends StatefulWidget {
  final String initialYear;
  final ValueChanged<String> onYearChanged;
  final int startYear;
  final int endYear;
  const DropdownYearPicker({
    super.key,
    required this.initialYear,
    required this.onYearChanged,
    required this.startYear,
    required this.endYear,
  });

  @override
  _DropdownYearPickerState createState() => _DropdownYearPickerState();
}

class _DropdownYearPickerState extends State<DropdownYearPicker> {
  late String _selectedYear;
  late List<String> _years;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedYear,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Select Year',
        prefixIcon: Icon(MdiIcons.calendar),
      ),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedYear = newValue;
          });
          widget.onYearChanged(_selectedYear);
        }
      },
      hint: const Text('Select Year'),
      menuMaxHeight: 200,
      items: _years.map<DropdownMenuItem<String>>(
        (String year) {
          return DropdownMenuItem<String>(
            value: year,
            child: Text(year),
          );
        },
      ).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialYear;
    _years = _generateYearList();
  }

  List<String> _generateYearList() {
    return List<String>.generate(
      widget.endYear - widget.startYear + 1,
      (index) => (widget.startYear + index).toString(),
    );
  }
}
