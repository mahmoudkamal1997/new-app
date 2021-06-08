
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

Widget buildNewsItem({@required article,context}){
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(article['url'])));
    },
    child: Padding(
      padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage('${article['urlToImage']}'),
                      fit: BoxFit.cover
                  )

              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                          '${article['title']}',
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey[700],fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],

                ),
              ),
            ),
          ],
        ),
    ),
  );
}

Widget buildArticleList(List NewsList){
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
}

