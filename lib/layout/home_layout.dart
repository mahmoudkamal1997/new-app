import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsState>(
        listener: (context,state){},
        builder: (context,state){
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("${cubit.titles[cubit.currentIndex]}"),
              actions: [

                IconButton(
                  icon:Icon(
                    Icons.brightness_4_outlined),
                  onPressed: (){
                    setState((){
                      NewsCubit.get(context).changeThemeMode();
                      print('from action ${NewsCubit
                          .get(context)
                          .isDark}');
                    });

                  }
                )
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
                BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
                BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),

              ],
            ),
          );
          },
    );
  }
}
