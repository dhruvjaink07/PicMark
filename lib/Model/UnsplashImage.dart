class UnsplashImage {
  final String id;
  final String imageUrl;

  UnsplashImage({required this.id, required this.imageUrl});

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      id: json['id'],
      imageUrl: json['urls']['small'],
    );
  }
}
