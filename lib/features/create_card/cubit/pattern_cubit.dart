import 'package:flutter_bloc/flutter_bloc.dart';

class PatternCubit extends Cubit<int> {
  PatternCubit() : super(0);

  int maxNumberOfPatterns = 3;

  void select(int index) => emit(index);
}
