import 'package:flame/components.dart';
import 'dart:ui';

class DialogBox extends TextBoxComponent {
  final VoidCallback onFinished;
  
  DialogBox({required String text, required Vector2 worldsize, 
    required this.onFinished}) : super (
    text,
    position: worldsize,
    boxConfig: TextBoxConfig(dismissDelay: 5.0, 
    maxWidth: 400, timePerChar: 0.1,)
  ) {
    anchor = Anchor.center;
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    if (finished) {
      onFinished();
    }
  }
}
