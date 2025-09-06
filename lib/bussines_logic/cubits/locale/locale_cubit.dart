import 'dart:ui';

import 'package:bloc/bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void changeLocale(String locale) {
    emit(Locale(locale));
  }
}
