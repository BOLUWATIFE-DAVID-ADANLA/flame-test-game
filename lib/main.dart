import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(const MainView());
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: FlameTestGame(),
      ),
    );
  }
}

class FlameTestGame extends FlameGame with PanDetector {
  late Player _player;
  @override
  Color backgroundColor() => Colors.black;
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    debugPrint('image loaded');

    _player = Player();

    add(_player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _player.move(info.delta.global);
  }
}

class Player extends SpriteAnimationComponent
    with HasGameReference<FlameTestGame> {
  Player({Vector2? size, super.anchor = Anchor.center})
      : super(size: size ?? Vector2(48, 48));

  @override
  FutureOr<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
        'Space_ghost_right_idle.png',
        SpriteAnimationData.sequenced(
            loop: true, amount: 9, stepTime: .2, textureSize: Vector2(48, 48)));
    position = game.size / 2;

    return super.onLoad();
  }

  void move(Vector2 img) {
    position.add(img);
  }
}
