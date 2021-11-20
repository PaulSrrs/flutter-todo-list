class Todo {
  Todo({required this.id, required this.title, required this.description, required this.isDone});
  String id;
  String title;
  String description;
  bool isDone;

  setTitle(String newTitle) {
    title = newTitle;
  }

  setDescription(String newDescription) {
    description = newDescription;
  }
}