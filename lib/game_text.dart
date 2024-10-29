import 'package:google_fonts/google_fonts.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameText extends TextComponent {
  GameText({
    double fontSize = 6,
    Color color = Colors.white,
    super.position,
    super.text,
  }) : super(
          textRenderer: TextPaint(
            style: GoogleFonts.pressStart2p(
              fontSize: fontSize,
              color: color,
            ),
          ),
        );
}
