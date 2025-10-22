part of 'movie_bloc.dart';

abstract class MovieEvent {}

class Init extends MovieEvent {}

class SendMessage extends MovieEvent {
  final String message;
  final BuildContext context;

  SendMessage(this.message, this.context);
}