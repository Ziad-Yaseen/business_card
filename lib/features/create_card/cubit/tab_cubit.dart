import 'package:flutter_bloc/flutter_bloc.dart';

class TabCubit extends Cubit<int> {
  TabCubit() : super(0);

  int maxTabs = 3;

  void select(int index) => emit(index);
}
