import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightImg = size.height * 0.3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'Ultimos estrenos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (movies.isEmpty)
          SizedBox(
              width: double.infinity,
              height: heightImg,
              child: const Center(
                child: CircularProgressIndicator(),
              )),
        SizedBox(
          width: double.infinity,
          height: heightImg,
          child: Swiper(
            itemCount: movies.length,
            viewportFraction: 0.9,
            layout: SwiperLayout.DEFAULT,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (_, int index) {
              final movie = movies[index];

              movie.heroId = 'swiper-${movie.id}';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, 'details', arguments: movie),
                  child: Hero(
                    tag: movie.heroId!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned.fill(
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage('assets/loading.gif'),
                              image: NetworkImage(movie.fullBackdropPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // BackGradient

                          Positioned.fill(
                              child: _BackGradient(
                            stops: const [0.88, 1.0],
                          )),

                          //title
                          Positioned(
                            bottom: 4,
                            child: SizedBox(
                              width: size.width*0.8,
                              child: Text(movie.title,
                              textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BackGradient extends StatelessWidget {
  final List<Color> colors;
  final List<double> stops;

  const _BackGradient({
    this.colors = const [Colors.transparent, Colors.black87],
    this.stops = const [0.0, 1.0],
  }) : assert(colors.length == stops.length,
            'Colors and Stops must be same leght');

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            stops: stops,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
    );
  }
}
// class BackGradient extends StatelessWidget {
//   final List<Color> colors;
//   final List<double> stops;
//   const BackGradient({
//     super.key,
//     this.colors = const [Colors.transparent, Colors.black87],
//     this.stops = const [0.0, 1.0],
//   }) : assert(colors.length == stops.length,
//             'Stops and Colors must be same leght');

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             colors: colors,
//             stops: stops,
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter),
//       ),
//     );
//   }
// }
