import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener:(context,state){},
      builder: (context,state){
        var NewsList = NewsCubit.get(context).SportsNews;
        return ConditionalBuilder(
          condition: NewsList.length > 0,
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, index)=>buildNewsItem(article: NewsList[index],context: context),
            separatorBuilder: (ctx,index) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(height: 1,color: Colors.grey[300],),
            ) ,
            itemCount: NewsList.length,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}