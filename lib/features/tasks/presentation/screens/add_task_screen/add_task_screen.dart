import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/tasks/presentation/components/add_task_component.dart';
import 'package:to_do_app/features/tasks/presentation/cubit/cubit/task_cubit.dart';
import 'package:to_do_app/features/tasks/presentation/cubit/cubit/task_state.dart';

class AddTaskScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColors.white,
            )),
        title: Text(
          AppStrings.addTask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! title
                  AddTaskComponent(
                    text: AppStrings.title,
                    hintText: AppStrings.titleHint,
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //! note
                  AddTaskComponent(
                    text: AppStrings.note,
                    hintText: AppStrings.noteHint,
                    controller: noteController,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //!date
                  AddTaskComponent(
                    readOnly: true,
                    text: AppStrings.date,
                    hintText: DateFormat.yMd().format(
                        BlocProvider.of<TaskCubit>(context).currentDate),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          BlocProvider.of<TaskCubit>(context).getDate(context);
                        },
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.white,
                        )),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //!start - end Time
                  Row(
                    children: [
                      //!start
                      Expanded(
                        child: AddTaskComponent(
                          readOnly: true,
                          text: AppStrings.startTime,
                          hintText:
                              BlocProvider.of<TaskCubit>(context).startTime,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                BlocProvider.of<TaskCubit>(context)
                                    .getStartTime(context);
                              },
                              icon: const Icon(
                                Icons.timer_outlined,
                                color: AppColors.white,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 27.w,
                      ),
                      //!end
                      Expanded(
                        child: AddTaskComponent(
                          readOnly: true,
                          text: AppStrings.endTime,
                          hintText: BlocProvider.of<TaskCubit>(context).endTime,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                BlocProvider.of<TaskCubit>(context)
                                    .getEndTime(context);
                              },
                              icon: const Icon(
                                Icons.timer_outlined,
                                color: AppColors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //! color
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.color,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 6,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 12.w,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<TaskCubit>(context)
                                      .changeCheckMarkIndex(index);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      BlocProvider.of<TaskCubit>(context)
                                          .getColor(index),
                                  child: index ==
                                          BlocProvider.of<TaskCubit>(context)
                                              .currentIndex
                                      ? const Icon(
                                          Icons.check,
                                          color: AppColors.white,
                                        )
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //! add Task Button
                  const Spacer(),
                  SizedBox(
                      height: 48.h,
                      width: double.infinity,
                      child: CustomButton(
                        onPressed: () {},
                        text: AppStrings.createTask,
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
