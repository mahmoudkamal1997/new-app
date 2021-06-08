import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cacheHelper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState>
{
  int currentIndex = 0;

  List<dynamic> BusinessNews = [];
  List<dynamic> SportsNews = [];
  List<dynamic> ScienceNews = [];
  List<Widget> Screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<String> titles=[
    'Business News',
    'Sports News',
    'Science News',
  ];
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  void changeIndex(int index){
    currentIndex = index;
    if(index == 1)
      getSportsNews();
    if(index== 2)
      getScienceNews();
    emit(NewsBottomNavBarState());
  }

  void getBusinessNews(){
    emit(NewsOnloadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      BusinessNews = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }

  void getSportsNews() {
    emit(NewsOnloadingState());
    if (SportsNews.length == 0) {
      DioHelper.getData(
          url: "v2/top-headlines",
          query: {
            'country': 'eg',
            'category': 'sports',
            'apikey': '65f7f556ec76449fa7dc7c0069f040ca',

          }
      ).then((value) {
        SportsNews = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
        print(error.toString());
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScienceNews() {
    emit(NewsOnloadingState());
    if (ScienceNews.length == 0) {
      DioHelper.getData(
          url: "v2/top-headlines",
          query: {
            'country': 'eg',
            'category': 'science',
            'apikey': '65f7f556ec76449fa7dc7c0069f040ca',

          }
      ).then((value) {
        ScienceNews = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;
  void changeThemeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;

      print ('from shared $fromShared');
      emit(NewsChangeThemeModeState());
    }
    else {
      isDark = !isDark;
      CasheHelper.putBoulean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeThemeModeState());
        print('$isDark');
      });
    }
  }
}