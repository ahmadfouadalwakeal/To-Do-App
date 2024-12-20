class TaskModel {
  final int? id;
  final String title;
  final String note;
  final String startTime;
  final String endTime;
  final String date;
  final int isCompleted;
  final int color;
  TaskModel(
      {this.id,
      required this.color,
      required this.title,
      required this.note,
      required this.startTime,
      required this.endTime,
      required this.date,
      required this.isCompleted});

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData['id'],
      color: jsonData['color'],
      title: jsonData['title'],
      note: jsonData['note'],
      startTime: jsonData['startTime'],
      endTime: jsonData['endTime'],
      date: jsonData['date'],
      isCompleted: jsonData['isCompleted'],
    );
  }
}
