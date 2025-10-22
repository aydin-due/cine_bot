import 'package:cine_bot/bloc/movie/movie_bloc.dart';
import 'package:cine_bot/l10n/app_localizations.dart';
import 'package:cine_bot/utils/app_theme.dart';
import 'package:cine_bot/utils/constants.dart';
import 'package:cine_bot/utils/enums.dart';
import 'package:cine_bot/utils/popups.dart';
import 'package:cine_bot/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static const String route = '/chat';
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  sendMessage(BuildContext context) async {
    FocusScope.of(context).unfocus();
    context.read<MovieBloc>().add(SendMessage(_controller.text, context));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()..add(Init()),
      child: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            displayAlert(
              context,
              AppLocalizations.of(context)!.errorTitle,
              state.errorMessage ?? AppLocalizations.of(context)!.tryAgainLater,
            );
          }
        },
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              );
            }
          });
          return Scaffold(
            appBar: CustomAppbar(
              title: cinebot,
              actions: [
                IconButton(
                  icon: const Icon(Icons.movie_outlined),
                  onPressed: () => displayWatchlist(context, state.movies),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        state.messages.length +
                        (state.status == Status.loading ? 1 : 0),
                    itemBuilder: (context, index) =>
                        (state.status == Status.loading &&
                            index == state.messages.length)
                        ? const BotBubble(isTyping: true)
                        : state.messages[index].isUser
                        ? UserBubble(message: state.messages[index])
                        : BotBubble(
                            message: state.messages[index],
                            poster: state.movies
                                .where(
                                  (e) => e.id == state.messages[index].movieId,
                                )
                                .firstOrNull
                                ?.posterImage,
                          ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: green, width: 1)),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                  child: SafeArea(
                    child: TextField(
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.typeYourMessage,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send_outlined, color: lightGreen),
                          onPressed: () => sendMessage(context),
                        ),
                      ),
                      onSubmitted: (_) => sendMessage(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
