import 'package:cine_bot/l10n/app_localizations.dart';
import 'package:cine_bot/models/movie.dart';
import 'package:cine_bot/screens/movie_screen.dart';
import 'package:cine_bot/utils/app_theme.dart';
import 'package:cine_bot/widgets/faded_image.dart';
import 'package:flutter/material.dart';

displayAlert(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: darkGrey,
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Ok', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

displayWatchlist(BuildContext context, List<Movie> movies) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: darkGrey,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController, // this is key
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Optional drag handle
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.watchlist,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: movies.isNotEmpty
                      ? GridView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), // disable inner scroll
                          shrinkWrap:
                              true, // so GridView takes only needed space
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                MovieScreen.route,
                                arguments: movie,
                              ),
                              child: FadedImage(
                                image: movie.posterImage,
                              ),
                            );
                          },
                        )
                      :  Center(child: Text(AppLocalizations.of(context)!.noMoviesAdded)),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
