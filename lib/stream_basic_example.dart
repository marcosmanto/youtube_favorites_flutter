// ignore_for_file: avoid_print

import 'dart:async';

void main() {
  List convidados = ['Daniel', 'João', 'Paulo', 'Marcos'];

  final controller = StreamController();

  // Stream with stream transformer filtering only invited people
  final StreamSubscription subscription = controller.stream
      .where((data) => convidados.contains(data))
      .listen((data) {
    print(data);
  });

  controller.add('Daniel');
  controller.add('Letícia');
  controller.add('Paulo');
  controller.add('Leo');

  controller.close();
}
