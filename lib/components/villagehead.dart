import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import '../dialog/dialogbox.dart';

class VillageheadComponent extends PositionComponent
    with HasGameRef, Hitbox, Collidable {
  late DialogBox dialogbox;
  VillageheadComponent() {
    addHitbox(HitboxRectangle());
  }

  @override
  void onCollisionEnd(Collidable other) {
    dialogbox = DialogBox(text: 'Welcome to this village!! '
    'We prepared some food for you, please only take what you can finish.'
    ' Also, gifts for you are hidden around the area!', 
    worldsize: Vector2(
      1200 - position.x,
      1200 - position.y,
    ),
    onFinished: () {
      remove(dialogbox);
      },
    );
    add(dialogbox);
    remove(this);
    super.onCollisionEnd(other);
  }
}
