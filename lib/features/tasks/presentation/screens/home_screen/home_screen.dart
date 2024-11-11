import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/tasks/data/model/task_model.dart';
import 'package:to_do_app/features/tasks/presentation/screens/add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //date now
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: 12.h,
              ),
              //today
              Text(
                AppStrings.today,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: 6.h,
              ),
              //date picker
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primary,
                selectedTextColor: AppColors.white,
                dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                height: 110,
                onDateChange: (date) {
                  // New date selected
                  // setState(() {
                  //   _selectedValue = date;
                  // });
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              //no tasks
              TaskModel.tasksList.isEmpty
                  ? NoTasksWidgets()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: TaskModel.tasksList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(24),
                                      height: 250.h,
                                      color: AppColors.deepGrey,
                                      child: Column(
                                        children: [
                                          //taskCompleted
                                          SizedBox(
                                            height: 48.h,
                                            width: double.infinity,
                                            child: CustomButton(
                                                onPressed: () {},
                                                text: AppStrings.taskCompleted),
                                          ),
                                          SizedBox(
                                            height: 24.h,
                                          ),
                                          //deleteTask
                                          SizedBox(
                                            height: 48.h,
                                            width: double.infinity,
                                            child: CustomButton(
                                                backgroundColor: AppColors.red,
                                                onPressed: () {},
                                                text: AppStrings.deleteTask),
                                          ),
                                          SizedBox(
                                            height: 24.h,
                                          ),

                                          //cancel
                                          SizedBox(
                                            height: 48.h,
                                            width: double.infinity,
                                            child: CustomButton(
                                                onPressed: () {},
                                                text: AppStrings.cancel),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: TaskComponent(
                              taskModel: TaskModel.tasksList[index],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),

        //fab
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(context: context, screen: AddTaskScreen());
          },
          backgroundColor: AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: getColor(taskModel.color),
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  taskModel.title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 8.h,
                ),
                // row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.timer,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      '${taskModel.startTime} - ${taskModel.endTime}',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                //text
                Text(
                  taskModel.note,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 24),
                )
              ],
            ),
          ),
          //divider
          Container(
            width: 1.w,
            height: 75.h,
            color: AppColors.white,
            margin: const EdgeInsets.only(right: 10),
          ),
          //text
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              taskModel.isCompleted ? AppStrings.completed : AppStrings.todo,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class NoTasksWidgets extends StatelessWidget {
  const NoTasksWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AppAssets.noTasks,
        ),
        Text(AppStrings.noTaskTitle,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 24)),
        Text(AppStrings.noTaskSubTitle,
            style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}
