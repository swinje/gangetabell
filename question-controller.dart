import 'dart:async';

class QuestionEvent {
  QuestionEvent(this.question, this.color);

  String question;
  int color;
}

abstract class QuestionController {
  static StreamController<QuestionEvent> _controller = StreamController();
  static Stream<QuestionEvent> get _stream => _controller.stream;

  static StreamSubscription<QuestionEvent> listen(Function handler) =>
      _stream.listen(handler as dynamic);
  static void add(QuestionEvent _question) => _controller.add(_question);

  static dispose() => _controller.close();
}
