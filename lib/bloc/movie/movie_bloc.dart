import 'dart:convert';
import 'dart:developer';
import 'package:cine_bot/l10n/app_localizations.dart';
import 'package:cine_bot/models/gemini_error.dart';
import 'package:cine_bot/models/message.dart';
import 'package:cine_bot/models/movie.dart';
import 'package:cine_bot/services/gemini_service.dart';
import 'package:cine_bot/services/movie_service.dart';
import 'package:cine_bot/services/pipedream_service.dart';
import 'package:cine_bot/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieState()) {
    on<Init>(onInit);
    on<SendMessage>(onSendMessage);
  }

  onInit(MovieEvent event, emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // await prefs.remove('chat');
      // await prefs.remove('movies');
      final chat = prefs.getString('chat');
      List<Message> messages = [];
      if (chat != null) {
        messages = (jsonDecode(chat) as List)
            .map((e) => Message.fromJson(e))
            .toList();
      }
      final movies = prefs.getString('movies');
      List<Movie> moviesList = [];
      if (movies != null) {
        moviesList = (jsonDecode(movies) as List)
            .map((e) => Movie.fromJson(e))
            .toList();
      }

      emit(state.copyWith(messages: messages, movies: moviesList));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
    }
  }

  onSendMessage(SendMessage event, emit) async {
    try {
      final msg = event.message.trim();
      if (msg.isEmpty) return;

      List<Message> messages = [...state.messages];
      List<Movie> movies = [...state.movies];

      final geminiService = GeminiService();
      final movieService = MovieService();

      messages.add(Message(text: msg, isUser: true));
      emit(state.copyWith(status: Status.loading, messages: messages));

      await saveMessage(messages);
      await PipedreamService().storeMessage(messages.last);

      final reply = await geminiService.getMovieResponse(msg);

      if (reply.title != null) {
        final movie = await movieService.searchMovie(reply.title ?? '');
        reply.movieId = movie?.id;
        bool alreadyAdded = movies.any((e) => e.id == movie?.id);
        if (!alreadyAdded) {
          if (movie?.id != null) {
            movie?.details = await movieService.getMovieDetails(movie.id);
          }
          movies.add(movie!);
          await saveMovies(movies);
        }
      }

      messages.add(reply);
      await saveMessage(messages);
      await PipedreamService().storeMessage(messages.last);

      emit(
        state.copyWith(
          status: Status.initial,
          messages: messages,
          movies: movies,
        ),
      );
    } on GenerativeAIException catch (e) {
      // If a JSON error is returned, parse it and display the error message
      log(e.toString());
      if (e.message.contains('{')) {
        final error = GeminiError.fromString(e.message);
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage:
                'Error ${error?.code ?? -1}: ${error?.message ?? AppLocalizations.of(event.context)!.unexpectedError}',
          ),
        );
      } else {
        // If the error is not JSON, display the error message as is
        emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
    }
  }

  saveMessage(List<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'chat',
      jsonEncode(messages.map((e) => e.toJson()).toList()),
    );
  }

  saveMovies(List<Movie> movies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'movies',
      jsonEncode(movies.map((e) => e.toJson()).toList()),
    );
  }
}
