/// Entity types available for podcast searches (`media=podcast`).
///
/// https://performance-partners.apple.com/search-api
enum PodcastEntity {
  /// A podcast show (kind: `podcast`).
  podcast('podcast'),

  /// The author / host of a podcast show (wrapperType: `artist`).
  podcastAuthor('podcastAuthor'),

  /// A single episode of a show (kind: `podcast-episode`).
  podcastEpisode('podcastEpisode');

  const PodcastEntity(this.wireValue);

  /// Value expected by the iTunes API.
  final String wireValue;
}

/// Attributes that can narrow a podcast search to a specific field.
enum PodcastAttribute {
  titleTerm('titleTerm'),
  languageTerm('languageTerm'),
  authorTerm('authorTerm'),
  genreIndex('genreIndex'),
  artistTerm('artistTerm'),
  ratingIndex('ratingIndex'),
  keywordsTerm('keywordsTerm'),
  descriptionTerm('descriptionTerm');

  const PodcastAttribute(this.wireValue);

  /// Value expected by the iTunes API.
  final String wireValue;
}

/// Language of the returned search results.
///
/// The iTunes Search API only supports English and Japanese.
enum LanguageCode {
  english('en_us'),
  japanese('ja_jp');

  const LanguageCode(this.wireValue);

  /// Value expected by the iTunes API.
  final String wireValue;
}
