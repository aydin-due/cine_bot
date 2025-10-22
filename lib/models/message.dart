class Message {
  final String text;
  final bool isUser;
  final String? title;
  int? movieId;

  Message({required this.text, required this.isUser, this.title, this.movieId});

  Map<String, dynamic> toJson() => {
    'text': text,
    'isUser': isUser,
    'title': title,
    'movieId': movieId,
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    text: json['text'],
    isUser: json['isUser'],
    title: json['title'],
    movieId: json['movieId'],
  );
}
