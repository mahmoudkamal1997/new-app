
abstract class NewsState{}

class NewsInitialState extends NewsState{}

class NewsBottomNavBarState extends NewsState{}

class NewsOnloadingState extends NewsState{}

class NewsGetBusinessSuccessState extends NewsState{}

class NewsGetBusinessErrorState extends NewsState{

  final String error;

  NewsGetBusinessErrorState(this.error);

}


class NewsGetSportsSuccessState extends NewsState{}

class NewsGetSportsErrorState extends NewsState{

  final String error;

  NewsGetSportsErrorState(this.error);

}


class NewsGetScienceSuccessState extends NewsState{}

class NewsGetScienceErrorState extends NewsState{

  final String error;

  NewsGetScienceErrorState(this.error);

}

class NewsChangeThemeModeState extends NewsState{}

class NewsGetSearchSuccessState extends NewsState{}

class NewsGetSearchErrorState extends NewsState{

  final String error;

  NewsGetSearchErrorState(this.error);

}