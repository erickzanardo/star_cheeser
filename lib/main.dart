import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:star_cheese/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts(
    [GoogleFonts.pressStart2p()],
  );

  runApp(
    GameWidget(
      game: StarCheeser(),
    ),
  );
}
