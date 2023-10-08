import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const StateApp());

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesProvider(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movies App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    final movies = moviesProvider.onPlayNow;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: ListView.separated(
          itemBuilder: (context, i) {
            return Card(
                child: FadeInImage(
              placeholder: NetworkImage(movies[i].fullBackdropImg),
              image: NetworkImage(movies[i].fullBackdropImg),
            ));
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: moviesProvider.onPlayNow.length),
    );
  }
}
