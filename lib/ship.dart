import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:star_cheese/cheese.dart';
import 'package:star_cheese/game.dart';

class Ship extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef<StarCheeser> {
  Ship({
    super.position,
  }) : super(
          size: Vector2(64, 32),
          children: [
            RectangleHitbox(
              position: Vector2(16, 16),
              size: Vector2(32, 16),
            ),
          ],
        );

  Vector2 impulse = Vector2(0, 1);

  @override
  void update(double dt) {
    super.update(dt);

    final newPosition = position + impulse * dt * 40;
    if (newPosition.y + size.y <= 128 && newPosition.y >= -128) {
      position.x = newPosition.x;
      position.y = newPosition.y;
    }

    impulse.y += dt * 2;
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    animation = await SpriteAnimation.load(
      'ship.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.2,
        textureSize: size,
      ),
    );
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Cheese) {
      other.removeFromParent();
      gameRef.onCheeseCollected();
    }
  }
}
