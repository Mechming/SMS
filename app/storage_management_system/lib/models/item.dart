class Item {
  final int id;
  final String title;
  final int count;
  final int goalAmount;

  Item({required this.id, required this.title, this.count = 0,
    this.goalAmount = 0});
}
