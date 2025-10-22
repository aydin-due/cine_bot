part of 'movie_bloc.dart';

final class MovieState {
  final Status status;
  final String? errorMessage;
  final List<Message> messages;
  final List<Movie> movies;

  MovieState({
    this.status = Status.initial,
    this.errorMessage,
    this.messages = const [],
    this.movies = const [],
  });

  copyWith({
    Status? status,
    String? errorMessage,
    List<Message>? messages,
    List<Movie>? movies,
  }) => MovieState(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    messages: messages ?? this.messages,
    movies: movies ?? this.movies,
  );
}
