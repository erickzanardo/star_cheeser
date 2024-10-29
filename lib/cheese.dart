import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Cheese extends SpriteComponent {
  Cheese({
    super.position,
  }) : super(
          size: Vector2(32, 16),
          children: [
            RectangleHitbox(
              position: Vector2(8, 2),
              size: Vector2(16, 12),
            ),
          ],
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load('cheese.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    x -= 100 * dt;

    if (x + size.x < -128) {
      removeFromParent();
    }
  }
}
