import 'package:bloc/bloc.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shareed/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() :super(AppInitialState());


  static AppCubit get(context)=> BlocProvider.of(context);
  int currentIndex = 0;



  bool isBottomSheetShown=false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState(
  {
  required bool isShow,
  required IconData Icon,


  })
  {
    isBottomSheetShown = isShow;
    fabIcon = Icon;
    emit(AppChangeBottomSheetState());

  }


  bool isDark =false;

  void changeAppMode()
  {
    isDark =!isDark;

    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
    {
      emit(AppChangeModeState());

    });
  }

}

