



import 'package:equatable/equatable.dart';



// تعریف وضعیت‌های سفارشی برای BottomSheetBloc
abstract class BottomSheetState extends Equatable {
  @override
  List<Object> get props => [];
}

// وضعیت اولیه باتم شیت
class BottomSheetInitial extends BottomSheetState {}

// وضعیت هنگامی که داده‌ها با موفقیت بارگذاری شود
class BottomSheetLoaded extends BottomSheetState {
  final String data;

  BottomSheetLoaded(this.data);

  @override
  List<Object> get props => [data];
}

// وضعیت هنگامی که متن با تاریخ انتخاب شده به‌روزرسانی شود
class BottomSheetTextUpdated extends BottomSheetState {
  final String data;

  BottomSheetTextUpdated(this.data);

  @override
  List<Object> get props => [data];
}
