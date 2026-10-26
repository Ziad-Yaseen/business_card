import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayoutNavCubit extends Cubit<int> {
  MainLayoutNavCubit() : super(0);

  void select(int index) => emit(index);
}
