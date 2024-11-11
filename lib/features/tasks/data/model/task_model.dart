class TaskModel {
  final String id;
  final String title;
  final String note;
  final String startTime;
  final String endTime;
  final bool isCompleted;
  final int color;
  TaskModel(
      {required this.id,
      required this.color,
      required this.title,
      required this.note,
      required this.startTime,
      required this.endTime,
      required this.isCompleted});

  static List<TaskModel> tasksList = [
    TaskModel(
      id: '1',
      title: 'flutter',
      note: 'Learn Dart',
      startTime: '09:33 pm',
      endTime: '06:15 pm',
      isCompleted: false,
      color: 0,
    ),
    TaskModel(
      id: '1',
      title: 'Java',
      note: 'Learn Android',
      startTime: '09:33 pm',
      endTime: '06:15 pm',
      isCompleted: true,
      color: 1,
    ),
  ];
}
