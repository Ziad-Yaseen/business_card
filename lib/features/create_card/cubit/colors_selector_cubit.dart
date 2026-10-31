import 'package:flutter_bloc/flutter_bloc.dart';

class ColorsSelectorCubit extends Cubit<int> {
  ColorsSelectorCubit() : super(0);

  int maxNumOfColors = 6;

  void slect(int index) => emit(index);
}
