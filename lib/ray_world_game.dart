import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'components/player.dart';
import '../helpers/direction.dart';
import 'components/world.dart';
import 'components/world_collidable.dart';
import 'helpers/map_loader.dart';
import 'components/friend.dart';
import 'helpers/friend_loader.dart';
import 'components/sustainablegoods.dart';
import 'helpers/sustainablegoods_loader.dart';
import 'components/villagehead.dart';
import 'helpers/villagehead_loader.dart';
import 'components/bus.dart';
import 'helpers/bus_loader.dart';
import 'dialog/dialogbox.dart';

import 'package:flame/components.dart';
import 'dart:ui';

final Player _player = Player();

final World _world = World();
 
class RayWorldGame extends FlameGame with HasCollidables {
  late DialogBox dialogbox;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(_world);
    add(_player);
    addWorldCollision();
    addFriendCollision();
    addGoodsCollision();
    addVillageheadCollision();
    addBusCollision();
    _player.position = _world.size / 2;
    print(_player.position);
    dialogbox = DialogBox(text: 'Hi! I am Oliver, and I have just '
    'moved into Sustainable Village! Let\'s meet new friends, '
    'and discover what a sustainable life is all about!', 
    worldsize: _player.position,
    onFinished: () {
      remove(dialogbox);
      },
    );
    add(dialogbox);
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('cute.mp3');
    FlameAudio.bgm.play('cute.mp3');

    camera.followComponent(_player,
       worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));

  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  void addWorldCollision() async =>
     (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
       add(WorldCollidable()
         ..position = Vector2(rect.left, rect.top)
         ..width = rect.width
         ..height = rect.height);
     });

  void addFriendCollision() async =>
      (await FriendLoader.readFriendCollisionMap()).forEach((rect) {
        add(FriendComponent()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  void addGoodsCollision() async =>
      (await GoodsLoader.readGoodsCollisionMap()).forEach((rect) {
        add(GoodsComponent()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  void addVillageheadCollision() async =>
      (await VillageheadLoader.readVillageheadCollisionMap()).forEach((rect) {
        add(VillageheadComponent()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  void addBusCollision() async =>
    (await BusLoader.readBusCollisionMap()).forEach((rect) {
      add(BusComponent()
        ..position = Vector2(rect.left, rect.top)
        ..width = rect.width
        ..height = rect.height);
    });
}
