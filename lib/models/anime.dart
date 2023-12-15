class Anime {
  final String title;
  final String description;
  final List<String> genre;
  final String imageUrl;

  Anime(
      {required this.title,
      required this.description,
      required this.genre,
      required this.imageUrl});

  static List<Anime> animeList = [
    Anime(
        title: "Frieren",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac libero id augue fringilla mollis non sit amet arcu. Sed eu nisi a risus lobortis sagittis. Morbi sed augue quam. Quisque vel tellus eu ipsum gravida dapibus. Nulla vitae posuere nisl. Fusce vestibulum sodales nisi, tempus ultrices ante mattis at.",
        genre: ["Fantasy"],
        imageUrl: 'assets/animeImage.jpg'),
    Anime(
        title: "Frieren",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac libero id augue fringilla mollis non sit amet arcu. Sed eu nisi a risus lobortis sagittis. Morbi sed augue quam. Quisque vel tellus eu ipsum gravida dapibus. Nulla vitae posuere nisl. Fusce vestibulum sodales nisi, tempus ultrices ante mattis at.",
        genre: ["Fantasy"],
        imageUrl: 'assets/animeImage.jpg'),
    Anime(
        title: "Frieren",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac libero id augue fringilla mollis non sit amet arcu. Sed eu nisi a risus lobortis sagittis. Morbi sed augue quam. Quisque vel tellus eu ipsum gravida dapibus. Nulla vitae posuere nisl. Fusce vestibulum sodales nisi, tempus ultrices ante mattis at.",
        genre: ["Fantasy"],
        imageUrl: 'assets/animeImage.jpg'),
  ];
}
