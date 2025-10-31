abstract class Character {
  final int id;
  final String name;
  final String status;
  final String gender;
  final String imageUrl;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    required this.imageUrl,
  });
}
