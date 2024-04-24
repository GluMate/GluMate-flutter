import 'package:flutter/material.dart';

class GlucColorAndIndicator {
  final Color color;
  final String indicator;

  GlucColorAndIndicator(this.color, this.indicator);
}

GlucColorAndIndicator getGlucColorAndIndicator(num gluc, String type , String unit) {
  // Adjust gluc value if the unit is mmol/L
  if (unit == "mmol/L") {
    gluc *= 18.018;
  }

  // Apply color logic based on type and gluc value
  if (gluc < 40.00) {
    return GlucColorAndIndicator(Colors.deepOrange, "extremely low");
  } else if ((type == "before meal" || type == "before medication" || type == "fasting") && gluc >= 250) {
    return GlucColorAndIndicator(Colors.red, "extremely high");
  } else if ((type == "before meal" || type == "before medication" || type == "fasting") && gluc >= 100.00) {
    return GlucColorAndIndicator(Colors.orange, "high");
  } else if ((type == "before meal" || type == "before medication" || type == "fasting") && gluc >= 70.00) {
    return GlucColorAndIndicator(Colors.green, "normal");
  } else if ((type == "before meal" || type == "before medication" || type == "fasting") && gluc <= 69.00) {
    return GlucColorAndIndicator(Colors.yellow, "low");
  } else if ((type == "after medication") && gluc >= 380.00) {
    return GlucColorAndIndicator(Colors.red, "extremely high");
  } else if ((type == "after medication") && gluc >= 110.00) {
    return GlucColorAndIndicator(Colors.orange, "high");
  } else if ((type == "after medication") && gluc >= 70.00) {
    return GlucColorAndIndicator(Colors.green, "normal");
  } else if ((type == "after medication") && gluc <= 69.00) {
    return GlucColorAndIndicator(Colors.yellow, "low");
  } else if ((type == "after meal" || type == "after working") && gluc >= 250.00) {
    return GlucColorAndIndicator(Colors.red, "extremely high");
  } else if ((type == "after meal" || type == "after working") && gluc >= 140.00) {
    return GlucColorAndIndicator(Colors.orange, "high");
  } else if ((type == "after meal" || type == "after working") && gluc >= 80.00) {
    return GlucColorAndIndicator(Colors.green, "normal");
  } else if ((type == "after meal" || type == "after working") && gluc <= 79.00) {
    return GlucColorAndIndicator(Colors.yellow, "low");
  } else {
    return GlucColorAndIndicator(Colors.black, "default");
  }
}
