class Lams {
  final String? title;
  final String? image;

  Lams({
    this.title,
    this.image,
  });

  Lams.fromFirestore(
    Map firestore,
  )   : title = firestore['title'] ?? '',
        image = firestore['image'];

  Map<String, dynamic> toJson() => {
        'title': title,
        "image": image,
      };
}
