import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:star_cheese/cheese.dart';
import 'package:star_cheese/game_text.dart';
import 'package:star_cheese/ship.dart';

class StarCheeser extends FlameGame with TapCallbacks, HasCollisionDetection {
  final resolution = Vector2(256, 240);

  late final GameText scoreText;
  int score = 0;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    camera = CameraComponent.withFixedResolution(
      width: resolution.x,
      height: resolution.y,
    );

    final background = await ParallaxComponent.load(
      [
        ParallaxImageData('parallax_2.png'),
        ParallaxImageData('parallax_1.png'),
      ],
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(8, 0),
    );

    background.position.x = -128;
    background.position.y = -120;

    world.add(background);

    world.add(
      Ship(
        position: Vector2(-128, -16),
      ),
    );

    world.add(
      SpawnComponent(
        period: 1,
        factory: (i) => Cheese(),
        area: Rectangle.fromLTWH(
          128,
          -120,
          32,
          240,
        ),
      ),
    );

    world.add(
      scoreText = GameText(
        position: Vector2(-32, -92),
        text: 'Collected: 0',
      ),
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    world.firstChild<Ship>()?.impulse = Vector2(0, -2);
  }

  void onCheeseCollected() {
    score++;
    scoreText.text = 'Collected: $score';
  }
}
