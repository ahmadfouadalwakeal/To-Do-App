import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/tasks/presentation/components/add_task_component.dart';
import 'package:to_do_app/features/tasks/presentation/cubit/cubit/task_cubit.dart';
import 'package:to_do_app/features/tasks/presentation/cubit/cubit/task_state.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is InsertTaskSuccessState) {
          showToast(message: 'Added Successfully', state: ToastStates.success);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
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
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: BlocProvider.of<TaskCubit>(context).isDark
                      ? AppColors.background
                      : AppColors.white,
                )),
            title: Text(
              AppStrings.addTask,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: BlocProvider.of<TaskCubit>(context).formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! title
                  AddTaskComponent(
                    text: AppStrings.title,
                    hintText: AppStrings.titleHint,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.titleErrorMsg;
                      }
                      return null;
                    },
                    controller:
                        BlocProvider.of<TaskCubit>(context).titleController,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //! note
                  AddTaskComponent(
                    text: AppStrings.note,
                    hintText: AppStrings.noteHint,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.noteErrorMsg;
                      }
                      return null;
                    },
                    controller:
                        BlocProvider.of<TaskCubit>(context).noteController,
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
                  state is InsertTaskLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : SizedBox(
                          height: 48.h,
                          width: double.infinity,
                          child: CustomButton(
                            onPressed: () {
                              if (BlocProvider.of<TaskCubit>(context)
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                BlocProvider.of<TaskCubit>(context)
                                    .insertTask();
                              }
                            },
                            text: AppStrings.createTask,
                          )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
