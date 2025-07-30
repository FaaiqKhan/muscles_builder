import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RichTextComponent extends PositionComponent {
  TextSpan span;
  final TextPainter _textPainter;

  RichTextComponent({
    required this.span,
    Vector2? position,
    TextAlign textAlign = TextAlign.left,
  })  : _textPainter = TextPainter(
    text: span,
    textDirection: TextDirection.ltr,
    textAlign: textAlign,
  ),
        super(position: position ?? Vector2.zero()) {
    _layout();
  }

  void _layout() {
    _textPainter.text = span;
    _textPainter.layout();
    size = Vector2(_textPainter.width, _textPainter.height);
  }

  void updateText(TextSpan newSpan) {
    span = newSpan;
    _layout();
  }

  @override
  void render(Canvas canvas) {
    _textPainter.paint(canvas, Offset.zero);
  }
}