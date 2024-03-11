import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class FriendComponent extends PositionComponent
    with HasGameRef, Hitbox, Collidable {
  FriendComponent() {
    addHitbox(HitboxRectangle());
  }

  @override
  void onCollisionEnd(Collidable other) {
    print('I made a new friend!');
    super.onCollisionEnd(other);
  }
}
