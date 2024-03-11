import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class GoodsComponent extends PositionComponent
    with HasGameRef, Hitbox, Collidable {
  GoodsComponent() {
    addHitbox(HitboxRectangle());
  }
}
