sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class GetDateLoadingState extends TaskState {}

final class GetDateSuccessState extends TaskState {}

final class GetDateErrorState extends TaskState {}

final class GetStartTimeLoadingState extends TaskState {}

final class GetStartTimeSuccessState extends TaskState {}

final class GetStartTimeErrorState extends TaskState {}

final class GetEndTimeLoadingState extends TaskState {}

final class GetEndTimeSuccessState extends TaskState {}

final class GetEndTimeErrorState extends TaskState {}

final class ChangeCheckMarkIndexState extends TaskState {}

final class ChangeThemeState extends TaskState {}

final class GetThemeState extends TaskState {}

final class GetSelectedDateLoadingState extends TaskState {}

final class GetSelectedDateSuccessState extends TaskState {}

final class InsertTaskLoadingState extends TaskState {}

final class InsertTaskSuccessState extends TaskState {}

final class InsertTaskErrorState extends TaskState {}

final class GetTaskLoadingState extends TaskState {}

final class GetTaskSuccessState extends TaskState {}

final class GetTaskErrorState extends TaskState {}

final class UpdateTaskLoadingState extends TaskState {}

final class UpdateTaskSuccessState extends TaskState {}

final class UpdateTaskErrorState extends TaskState {}

final class DeleteTaskLoadingState extends TaskState {}

final class DeleteTaskSuccessState extends TaskState {}

final class DeleteTaskErrorState extends TaskState {}
