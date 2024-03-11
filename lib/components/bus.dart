import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import '../dialog/dialogbox.dart';

class BusComponent extends PositionComponent
    with HasGameRef, Hitbox, Collidable {
  late DialogBox dialogbox;
  BusComponent() {
    addHitbox(HitboxRectangle());
  }

  @override
  void onCollisionEnd(Collidable other) {
    dialogbox = DialogBox(text: 'The public transport here is so convenient! '
    'This is an energy saving option for me to move around the village!', 
    worldsize: Vector2(
      other.position.x,
      other.position.y,
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
