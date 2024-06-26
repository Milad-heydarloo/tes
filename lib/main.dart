import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_test/BottomSheetBloc.dart';
import 'bloc_test/BottomSheetEvent.dart';
import 'bloc_test/BottomSheetState.dart';






// نقطه ورود برنامه
void main() {
  runApp(
    BlocProvider(
      create: (context) => BottomSheetBloc(),
      child: MyApp(),
    ),
  );
}

// MyApp ویجت اصلی برنامه
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Bottom Sheet',
      home: MyHomePage(),
    );
  }
}




// MyHomePage صفحه اصلی برنامه
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// _MyHomePageState کلاس وضعیت برای MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  // متن اولیه نمایش داده شده در صفحه اصلی
  String mainText = "متن اولیه در صفحه اصلی";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("باتم شیت Flutter BLoC"),
      ),
      body: BlocListener<BottomSheetBloc, BottomSheetState>(
        listener: (context, state) {
          // گوش دادن به تغییرات وضعیت در BottomSheetBloc
          if (state is BottomSheetTextUpdated) {
            // به‌روزرسانی mainText وقتی که BottomSheetTextUpdated دریافت می‌شود
            setState(() {
              mainText = state.data;
            });
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mainText),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showBottomSheet(context),
                child: Text("نمایش باتم شیت"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // تابع نمایش باتم شیت
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocBuilder<BottomSheetBloc, BottomSheetState>(
          builder: (context, state) {
            return BottomSheetContent();
          },
        );
      },
    );
  }
}


class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String displayText = "در حال بارگذاری...";
  String selectedDate = "";



  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomSheetBloc, BottomSheetState>(
      listener: (context, state) {
        if (state is BottomSheetLoaded) {
          setState(() {
            displayText = state.data;
          });
        } else if (state is BottomSheetTextUpdated) {
          setState(() {
            displayText = state.data;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(displayText),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text("انتخاب تاریخ"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedDate.isNotEmpty
                  ? () {
                context.read<BottomSheetBloc>().add(UpdateTextEvent(selectedDate));
              }
                  : null,
              child: Text("به‌روزرسانی متن"),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<BottomSheetBloc>();
      bloc.add(LoadDataEvent());
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
}
