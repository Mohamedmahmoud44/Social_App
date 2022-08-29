
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shareed/bloc_observer.dart';
import 'package:social_app/shareed/components/constants.dart';
import 'package:social_app/shareed/cubit/cubit.dart';
import 'package:social_app/shareed/cubit/states.dart';
import 'package:social_app/shareed/network/local/cache_helper.dart';
import 'package:social_app/shareed/network/remote/dio_helper.dart';
import 'package:social_app/shareed/styles/themes.dart';

import 'layout/social_app/cubit/cubit.dart';
import 'layout/social_app/social_layout.dart';
import 'modules/social_app/social_login/social_login_screen.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;

  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // String? token = CacheHelper.getData(key: 'token');
  uId= CacheHelper.getData(key: 'uId');



  // if(onBoarding!=null)
  // {
  //   if(token!=null)widget =ShopLayout();
  //   else widget = ShopLoginScreen();
  // }else
  //   {
  //     widget = OnBoardingScreen();
  //   }

  if(uId !=null)
  {
    widget =SocialLayout();
  }else
  {
    widget = SocialLoginScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );


}
class MyApp extends StatelessWidget
{

  final bool? isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=> SocialCubit()..getUserData()..getPosts(),),

      ],
      child: BlocProvider(
        create: (BuildContext context)=>AppCubit() ,
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state)
          {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme ,
              themeMode:AppCubit.get(context).isDark ? ThemeMode.dark :ThemeMode.light ,
              home: startWidget,
            );
          },
        ),
      ),
    );
  }
}