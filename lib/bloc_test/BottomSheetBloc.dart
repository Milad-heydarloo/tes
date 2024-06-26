
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BottomSheetEvent.dart';
import 'BottomSheetState.dart';







// کلاس بلاک برای مدیریت منطق کسب و کار و وضعیت
class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(BottomSheetInitial()) {
    on<LoadDataEvent>((event, emit) {
      emit(BottomSheetLoaded("این داده‌ها از طریق BLoC بارگذاری شده‌اند"));
    });

    on<UpdateTextEvent>((event, emit) {
      emit(BottomSheetTextUpdated("متن به‌روز شده است! تاریخ: ${event.date}"));
    });
  }
}
