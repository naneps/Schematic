import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schematic/app/commons/theme_manager.dart';

/// Represents the different types of date formats.
enum DateFormatType {
  yyyyMMdd, // 2021-09-01
  ddMMyyyy, // 01/09/2021
  MMddyyyy, // 09/01/2021
  MMMdyyyy, // Sep 1, 2021
  DDMMMMyyyy, // Monday, September 1, 2021
  DDMMMyyyy, // Monday, Sep 1, 2021
  MMMDyyyy, // Sep 1, 2021
  DMyyyy, // 1 Sep 2021
  DMMMyyyy, // 1 Sep 2021
  EEEEdMMMMyyyy, // Monday, September 1, 2021
  EdMMMyyyy, // Mon Sep 01 2021
}

enum DatePickerType {
  single,
  range,
}

class InputDate extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final DateFormatType dateFormatType;
  final List<DateTime>? range;
  final DatePickerType datePickerType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const InputDate({
    super.key,
    this.label = 'Date',
    this.controller,
    this.onChanged,
    this.initialValue,
    this.range = const [],
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.dateFormatType = DateFormatType.yyyyMMdd, // Default date format
    this.datePickerType =
        DatePickerType.single, // Default to single date picker
  });

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      validator: widget.validator,
      onTap: () async {
        if (widget.datePickerType == DatePickerType.single) {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate:
                widget.range!.isNotEmpty ? widget.range!.first : DateTime(1990),
            lastDate: widget.range!.isNotEmpty
                ? widget.range!.last
                : DateTime(DateTime.now().year + 1),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: ThemeManager().primaryColor,
                    onPrimary: Colors.white,
                    onSurface: ThemeManager().primaryColor,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            String formattedDate =
                widget.dateFormatType.formatter.format(picked);
            _controller.text = formattedDate;
            if (widget.onChanged != null) {
              widget.onChanged!(formattedDate);
            }
          }
        } else if (widget.datePickerType == DatePickerType.range) {
          DateTimeRange? initialDateRange;
          if (widget.initialValue != null) {
            List<String> dates = widget.initialValue!.split(' - ');
            if (dates.length == 2) {
              DateTime start = DateFormat('yyyy-MM-dd').parse(dates[0]);
              DateTime end = DateFormat('yyyy-MM-dd').parse(dates[1]);
              initialDateRange = DateTimeRange(start: start, end: end);
            }
          }
          final DateTimeRange? picked = await showDateRangePicker(
            context: context,
            firstDate:
                widget.range!.isNotEmpty ? widget.range!.first : DateTime(1990),
            lastDate: widget.range!.isNotEmpty
                ? widget.range!.last
                : DateTime(DateTime.now().year + 1),
            initialDateRange: initialDateRange ??
                DateTimeRange(
                  start: DateTime.now(),
                  end: DateTime.now().add(const Duration(days: 7)),
                ),
            currentDate: DateTime.now(),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: ThemeManager().primaryColor,
                    onPrimary: Colors.white,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: Container(
                  height: 400,
                  width: 400,
                  padding: const EdgeInsets.all(10),
                  child: child!,
                ),
              );
            },
          );
          if (picked != null) {
            String formattedStartDate =
                widget.dateFormatType.formatter.format(picked.start);
            String formattedEndDate =
                widget.dateFormatType.formatter.format(picked.end);
            String formattedDateRange =
                "$formattedStartDate - $formattedEndDate";
            _controller.text = formattedDateRange;
            if (widget.onChanged != null) {
              widget.onChanged!(formattedDateRange);
            }
          }
        }
      },
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      DateTime initialDate =
          DateFormat('yyyy-MM-dd').parse(widget.initialValue!);
      String formattedDate =
          widget.dateFormatType.formatter.format(initialDate);
      _controller.text = formattedDate;
    }
  }
}

extension DateFormatExtension on DateFormatType {
  DateFormat get formatter {
    switch (this) {
      case DateFormatType.yyyyMMdd:
        return DateFormat('yyyy-MM-dd');
      case DateFormatType.ddMMyyyy:
        return DateFormat('dd/MM/yyyy');
      case DateFormatType.MMddyyyy:
        return DateFormat('MM/dd/yyyy');
      case DateFormatType.MMMdyyyy:
        return DateFormat('MMM d, yyyy');
      case DateFormatType.DDMMMMyyyy:
        return DateFormat('EEEE, MMMM d, yyyy');
      case DateFormatType.DDMMMyyyy:
        return DateFormat('EEEE, MMM d, yyyy');
      case DateFormatType.MMMDyyyy:
        return DateFormat('MMM d, yyyy');
      case DateFormatType.DMyyyy:
      case DateFormatType.DMMMyyyy:
        return DateFormat('d MMM yyyy');
      case DateFormatType.EEEEdMMMMyyyy:
        return DateFormat('EEEE, MMMM d, yyyy');
      case DateFormatType.EdMMMyyyy:
        return DateFormat('E, MMM dd yyyy');
      default:
        return DateFormat('yyyy-MM-dd');
    }
  }
}
