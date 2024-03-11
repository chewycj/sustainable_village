import 'package:flame/components.dart';
import '../dialog/dialogbox.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'world_collidable.dart';
import 'sustainablegoods.dart';
import 'friend.dart';

 
class Player extends SpriteAnimationComponent 
    with HasGameRef, Hitbox, Collidable {
  Direction direction = Direction.none;
  final double _playerSpeed = 300.0;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;
  int sustainablegoods = 0;
  int friends = 0;
  late DialogBox dialogbox;

  // String dialogMessage = 'Hi! I\'m Oliver, and I just moved to Sustainable Village! Let\'s start making friends!';

  Player()
      : super(
          size: Vector2.all(50.0),
        ) {
    addHitbox(HitboxRectangle(relation: Vector2.all(0.4)));
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations();
    animation = _standingAnimation;
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );
  
    _runDownAnimation =
      spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation =
      spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runUpAnimation =
      spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
  
    _runRightAnimation =
      spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    _standingAnimation =
      spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }
 
  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          moveUp(delta);
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          moveRight(delta);
        }
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }
  
  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    final screenPosition = gameRef.camera.worldToScreen(position);
    final offset = Vector2(-500, -100); // Adjust as needed
    final adjustedPosition = screenPosition + offset;
    if (other is WorldCollidable) {
      if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
    }

    if (other is GoodsComponent) {
      if (sustainablegoods == 0) {
        dialogbox = DialogBox(text: 'I got a reusable '
        'container for takeaway!', 
        worldsize: adjustedPosition,
        onFinished: () {
        remove(dialogbox);
        },
        );
        add(dialogbox);
      } else if (sustainablegoods == 1) {
        dialogbox = DialogBox(text: 'I got a reusable '
        'cutlery for takeaway foods!', 
        worldsize: adjustedPosition,
        onFinished: () {
        remove(dialogbox);
        },
        );
        add(dialogbox);
      } else if (sustainablegoods == 2) {
        dialogbox = DialogBox(text: 'I got an energy '
        'saving electric appliance!', 
        worldsize: adjustedPosition,
        onFinished: () {
        remove(dialogbox);
        },
        );
        add(dialogbox);
      } else {
        dialogbox = DialogBox(text: 'I got some veggie '
        'seeds to grow my own food!', 
        worldsize: adjustedPosition,
        onFinished: () {
        remove(dialogbox);
        },
        );
        add(dialogbox);
      }
      sustainablegoods += 1;
      remove(other);
    }

    if (other is FriendComponent) {
      if (friends == 0) {
        dialogbox = DialogBox(text: 'What a lovely day '
        'for some gardening!', 
        worldsize: adjustedPosition,
        onFinished: () {
        remove(dialogbox);
        },
        );
        add(dialogbox);
      } else if (friends == 1) {
        dialogbox = DialogBox(text: 'Use reusable '
        'cutlery to reduce plastic waste!', 
        worldsize: adjustedPosition,
        onFinished: () {
        remove(dialogbox);
        },
        );
        add(dialogbox);
      } else if (friends == 2) {
        dialogbox = DialogBox(text: 'Remember to bring '
        'your reusable containers when ordering takeaway!', 
        worldsize: adjustedPosition,
        onFinished: () {
        remove(dialogbox);
        },
        );
        add(dialogbox);
      } else {
        dialogbox = DialogBox(text: 'Check the energy efficiency '
        'of appliances before buying them!', 
        worldsize: adjustedPosition,
        onFinished: () {
        remove(dialogbox);
        },
        );
        add(dialogbox);
      }
      friends += 1;
      remove(other);
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
  }

  bool canPlayerMoveUp() {
  if (_hasCollided && _collisionDirection == Direction.up) {
    return false;
  }
  return true;
  }
  
  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }
  
  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }
  
  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }
}

