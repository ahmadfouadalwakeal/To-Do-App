import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/database/cache_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper.dart';
import 'package:to_do_app/core/services/service_locator.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/features/tasks/data/model/task_model.dart';
import 'package:to_do_app/features/tasks/presentation/cubit/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  DateTime currentDate = DateTime.now();
  DateTime selectDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //! get date from user
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSuccessState());
    } else {
      print('pickedDate == null');
      emit(GetDateErrorState());
    }
  }

  //! get start time from user
  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      emit(GetStartTimeSuccessState());
    } else {
      print('pickedStartTime==null');
      emit(GetStartTimeErrorState());
    }
  }

  //! get End time from user
  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedEndTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));

    if (pickedEndTime != null) {
      endTime = pickedEndTime.format(context);
      emit(GetEndTimeSuccessState());
    } else {
      print('pickedStartTime==null');
      emit(GetEndTimeErrorState());
    }
  }

  //!get color
  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGrey;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  void changeCheckMarkIndex(index) {
    currentIndex = index;
    emit(ChangeCheckMarkIndexState());
  }

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selectDate = date;
    emit(GetSelectedDateSuccessState());
    getTasks();
  }

  List<TaskModel> tasksList = [];
//!insertTask
  void insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      sl<SqfliteHelper>().insertToDb(TaskModel(
        color: currentIndex,
        title: titleController.text,
        note: noteController.text,
        startTime: startTime,
        endTime: endTime,
        date: DateFormat.yMd().format(currentDate),
        isCompleted: 0,
      ));
      getTasks();
      titleController.clear();
      noteController.clear();
      emit(InsertTaskSuccessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

//!get Task data from Db
  void getTasks() async {
    emit(GetTaskLoadingState());
    await sl<SqfliteHelper>().getFromDb().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
              (element) => element.date == DateFormat.yMd().format(selectDate))
          .toList();
      emit(GetTaskSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetTaskErrorState());
    });
  }

//!update tasks
  void updateTasks(id) async {
    emit(UpdateTaskLoadingState());
    await sl<SqfliteHelper>().updateDp(id).then((value) {
      emit(UpdateTaskSuccessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

  //!delete tasks
  void deleteTasks(id) async {
    emit(DeleteTaskLoadingState());
    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSuccessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }

//!change theme
  bool isDark = false;
  void changeTheme() async {
    isDark = !isDark;
    await sl<CacheHelper>().saveData(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }

  //!get theme
  void getTheme() async {
    isDark = await sl<CacheHelper>().getData(key: 'isDark') ?? false;
    emit(GetThemeState());
  }
}
