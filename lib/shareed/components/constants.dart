// base url : http://newsapi.org/
// method (url): v2/everything?
// queries : q=apple&from=2022-05-09&to=2022-05-09&sortBy=popularity&apiKey=c9f44bbc0a7441c7acbbbca5cf64616f




import 'package:social_app/modules/social_app/social_login/social_login_screen.dart';

import '../network/local/cache_helper.dart';
import 'compnnents.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value)
  {
    if(value)
    {
      navigateAndFinish(context, SocialLoginScreen(),);
    }
  });



}


// void printFullText(String text)
// {
//   final pattern = RegExp('{1,800}');//800 is the size of each chunk
//   pattern.allMatches(text!).forEach((match))=>print(match.group(0));
// }
String? token ='';

String? uId ='';