import 'package:benecol_flutter/screens/about/about_screen.dart';
import 'package:benecol_flutter/screens/about_oat/about_oat_screen.dart';
import 'package:benecol_flutter/screens/calculator/calculator_screen.dart';
import 'package:benecol_flutter/screens/health/health_screen.dart';
import 'package:benecol_flutter/screens/home/home_screen.dart';
import 'package:benecol_flutter/screens/instruction/instruction_screen.dart';
import 'package:benecol_flutter/screens/latest/latest_screen.dart';
import 'package:benecol_flutter/screens/latest/widgets/latest_detail/news_detail_screen.dart';
import 'package:benecol_flutter/screens/login/forget_password/forget_password_screen.dart';
import 'package:benecol_flutter/screens/login/login_screen.dart';
import 'package:benecol_flutter/screens/login/sign_up/sign_up_screen.dart';
import 'package:benecol_flutter/screens/profile/apply_points/apply_points_screen.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_detail/exchange_product_detail_screen.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/exchange_product_form_screen.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_products_screen.dart';
import 'package:benecol_flutter/screens/profile/point_record/point_record_screen.dart';
import 'package:benecol_flutter/screens/profile/profile_screen.dart';
import 'package:benecol_flutter/screens/profile/profile_edit/profile_edit_screen.dart';
import 'package:benecol_flutter/screens/profile/user_message/user_message_screen.dart';
import 'package:benecol_flutter/screens/promotion/promotion_screen.dart';
import 'package:benecol_flutter/screens/reminder/reminder_screen.dart';
import 'package:benecol_flutter/screens/setting/FAQ/faq_screen.dart';
import 'package:benecol_flutter/screens/setting/email/email_screen.dart';
import 'package:benecol_flutter/screens/setting/legal_notice/legal_notice_screen.dart';
import 'package:benecol_flutter/screens/setting/privacy/privacy_screen.dart';
import 'package:benecol_flutter/screens/setting/setting_screen.dart';
import 'package:benecol_flutter/screens/splash/splash_screen.dart';
import 'package:benecol_flutter/screens/store/store_map/store_map_screen.dart';
import 'package:benecol_flutter/screens/store/store_search/store_search_screen.dart';
import 'package:benecol_flutter/screens/store/store_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
    FAQScreen.routeName: (context) => FAQScreen(),
    PrivacyScreen.routeName: (context) => PrivacyScreen(),
    LegalNoticeScreen.routeName: (context) => LegalNoticeScreen(),
    EmailScreen.routeName: (context) => EmailScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
    ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
    SignUpScreen.routeName: (context) => SignUpScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
    ProfileEditScreen.routeName: (context) => ProfileEditScreen(),
    ApplyPointsScreen.routeName: (context) => ApplyPointsScreen(),
    ExchangeProductsScreen.routeName: (context) => ExchangeProductsScreen(),
      ExchangeProductDetailScreen.routeName: (context) => ExchangeProductDetailScreen(),
      ExchangeProductFormScreen.routeName: (context) => ExchangeProductFormScreen(),
    UserMessageScreen.routeName: (context) => UserMessageScreen(),
    PointRecordScreen.routeName: (context) => PointRecordScreen(),
  ReminderScreen.routeName: (context) => ReminderScreen(),
  CalculatorScreen.routeName: (context) => CalculatorScreen(),
  StoreScreen.routeName: (context) => StoreScreen(),
    StoreSearchScreen.routeName: (context) => StoreSearchScreen(),
    StoreMapScreen.routeName: (context) => StoreMapScreen(),
  LatestScreen.routeName: (context) => LatestScreen(),
    NewsDetailScreen.routeName: (context) => NewsDetailScreen(),
  HealthScreen.routeName: (context) => HealthScreen(),
  AboutScreen.routeName: (context) => AboutScreen(),
  AboutOatScreen.routeName: (context) => AboutOatScreen(),
  InstructionScreen.routeName: (context) => InstructionScreen(),
  PromotionScreen.routeName: (context) => PromotionScreen(),
};