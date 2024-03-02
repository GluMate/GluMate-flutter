import 'dart:math';

import 'package:flutter/material.dart';

class SystolicDiastolicPicker extends StatefulWidget {
  final List<int> systolicValues;
  final List<int> diastolicValues;

  const SystolicDiastolicPicker({
    Key? key,
    required this.systolicValues,
    required this.diastolicValues,
  }) : super(key: key);

  @override
  _SystolicDiastolicPickerState createState() => _SystolicDiastolicPickerState();
}

class _SystolicDiastolicPickerState extends State<SystolicDiastolicPicker> {
  int _systolicValue = 100;
  int _diastolicValue = 75;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DropdownButton<int>(
            value: _systolicValue,
            items: widget.systolicValues.map((value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value mmHg'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _systolicValue = value!;
                _diastolicValue = min(_diastolicValue, value);
              });
            },
          ),
        ),
        Expanded(
          child: DropdownButton<int>(
            value: _diastolicValue,
            items: widget.diastolicValues.map((value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value mmHg'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _diastolicValue = value!;
                _systolicValue = max(_systolicValue, value);
              });
            },
          ),
        ),
      ],
    );
  }
}