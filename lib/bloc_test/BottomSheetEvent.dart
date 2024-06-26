

import 'package:equatable/equatable.dart';
// تعریف رویداد‌های سفارشی برای BottomSheetBloc
abstract class BottomSheetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// رویداد برای بارگذاری داده‌ها اولیه
class LoadDataEvent extends BottomSheetEvent {}

// رویداد برای به‌روزرسانی متن با تاریخ انتخاب شده
class UpdateTextEvent extends BottomSheetEvent {
  final String date;

  UpdateTextEvent(this.date);

  @override
  List<Object> get props => [date];
}
