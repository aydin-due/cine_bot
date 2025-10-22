import 'package:cine_bot/l10n/app_localizations.dart';
import 'package:cine_bot/models/movie.dart';
import 'package:cine_bot/utils/app_theme.dart';
import 'package:cine_bot/utils/functions.dart';
import 'package:cine_bot/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});
  static const String route = '/movie';

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateAppBarColor);
  }

  void _updateAppBarColor() {
    final offset = _scrollController.offset;
    final fadeStart = 50.0;
    final fadeEnd = 200.0;

    setState(() {
      _appBarOpacity = (offset - fadeStart) / (fadeEnd - fadeStart);
      _appBarOpacity = _appBarOpacity.clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateAppBarColor);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: darkGrey,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Color.lerp(
              Colors.transparent,
              darkGrey,
              _appBarOpacity,
            ),
            expandedHeight: MediaQuery.of(context).size.height / 3,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(movie.backdropImage, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [darkGrey, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(movie.title, textAlign: TextAlign.center),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: _movieDetails(context, movie, theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieDetails(BuildContext context, Movie movie, TextTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Genre tags
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children:
                movie.details?.genres
                    ?.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: GenreTag(genre: e.name ?? ''),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),

        // Rating and vote count
        Row(
          children: [
            Icon(Icons.star, color: lightGreen, size: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 5),
                  child: Text(
                    Functions.formatDouble(movie.voteAverage),
                    style: theme.titleMedium,
                  ),
                ),
                Text(
                  '(${Functions.formatInt(movie.voteCount)} ${AppLocalizations.of(context)!.reviews.toLowerCase()})',
                  style: theme.bodyMedium?.copyWith(color: lightGrey),
                ),
              ],
            ),
          ],
        ),
        CustomDivider(),

        // Poster and details
        Row(
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 250),
                child: FadedImage(image: movie.posterImage),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieDetail(
                    title: AppLocalizations.of(context)!.originalTitle,
                    value: movie.originalTitle,
                  ),
                  MovieDetail(
                    title: AppLocalizations.of(context)!.runtime,
                    value: '${movie.details?.runtime} min',
                  ),
                  MovieDetail(
                    title: AppLocalizations.of(context)!.releaseDate,
                    value: movie.details?.releaseDate ?? '',
                  ),
                  MovieDetail(
                    title: AppLocalizations.of(context)!.directedBy,
                    value: movie.details?.director ?? '',
                  ),
                ],
              ),
            ),
          ],
        ),
        CustomDivider(),

        // Storyline
        Text(
          AppLocalizations.of(context)!.storyline,
          style: theme.headlineSmall,
        ),
        const SizedBox(height: 10),
        Text(
          movie.overview,
          style: theme.bodyMedium?.copyWith(color: lightGrey),
        ),
        CustomDivider(),

        // Cast
        Text(AppLocalizations.of(context)!.cast, style: theme.headlineSmall),
        Container(
          height: 225,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            scrollDirection: Axis.horizontal,
            itemCount: movie.details?.credits?.cast?.length ?? 0,
            itemBuilder: (context, index) =>
                CastCard(cast: movie.details?.credits?.cast?[index]),
          ),
        ),
      ],
    );
  }
}
