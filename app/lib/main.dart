import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show Random;

import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/UserEntity.dart';
import 'package:app/api/entity/enums/WalletEvent.dart';
import 'package:app/auth/login_page.dart';
import 'package:app/firebase_options.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/main_route.dart';
import 'package:app/preload/preload_page.dart';
import 'package:app/utils/GlobalsWidgets.dart';
import 'package:app/utils/localization/localization_block.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await safeFirebaseInit();
  _showNotification(message);
  log("Received background message: ${message.data}");
}

Future<void> safeFirebaseInit() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (e.toString().contains('A Firebase App named "[DEFAULT]" already exists')) {
      debugPrint('Firebase уже инициализирован.');
    } else {
      rethrow;
    }
  }
}

Future<void> _requestPermissions() async {
  if (Platform.isIOS || Platform.isMacOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  } else if (Platform.isAndroid) {
    final androidImplementation = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationsPermission();
  }
}

Future<void> _showNotification(RemoteMessage remotemessage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.reload();

  const androidDetails = AndroidNotificationDetails(
    'stroy_messenger_chanel',
    'Уведомления в чатах',
    channelDescription: 'Уведомления в чатах',
    importance: Importance.max,
    priority: Priority.high,
  );

  const notificationDetails = NotificationDetails(android: androidDetails);

  if (prefs.getBool(remotemessage.data["chat"]) ?? false) {
    await flutterLocalNotificationsPlugin.cancelAll();
    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(100),
      remotemessage.data["title"],
      remotemessage.data['body'],
      notificationDetails,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await safeFirebaseInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final FirebaseAuth auth = FirebaseAuth.instance;

  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher_foreground'),
    iOS: DarwinInitializationSettings(),
    macOS: DarwinInitializationSettings(),
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await _requestPermissions();

  if (auth.currentUser != null) {
    GlobalsWidgets.uid = auth.currentUser!.uid;
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String notifyId = Platform.isAndroid
        ? await FirebaseMessaging.instance.getToken() ?? "Null"
        : await FirebaseMessaging.instance.getAPNSToken() ?? "Null";
    client.setUserUid(sharedPreferences.getString("phone") ?? "null",
        GlobalsWidgets.uid, notifyId);
  } else {
    (await SharedPreferences.getInstance()).remove("phone");
  }

  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (_) => LanguageBloc())],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  LanguageBloc? languageBloc;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;

  @override
  void initState() {
    languageBloc = LanguageBloc();
    super.initState();
    initLocalization();
    initStore();
  }

  void initStore() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    _purchasesSubscription = _inAppPurchase.purchaseStream.listen(
      handlePurchaseUpdates,
      onDone: _purchasesSubscription.cancel,
      onError: (error) {},
    );
  }

  void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchase in purchaseDetailsList) {
      final purchaseStatus = purchase.status;
      final productId = purchase.productID;

      if (purchaseStatus == PurchaseStatus.purchased &&
          purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
        Dio dio = Dio();
        RestClient client = RestClient(dio);
        final amount = double.parse(productId.split("_")[1]);
        await client.walletEvent(
          GlobalsWidgets.uid,
          WalletEvent.ADD,
          amount,
        );
        GlobalsWidgets.wallet += amount;
        if (mounted) Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    languageBloc?.close();
    _purchasesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (_, __, ___) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            if (state is LanguageLoaded) {
              return MaterialApp(
                title: 'Gnext Logistics',
                debugShowCheckedModeBanner: false,
                locale: Locale(state.locale, ''),
                supportedLocales: const [
                  Locale('ru', 'RU'),
                  Locale('kk', 'KZ'),
                ],
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: ThemeData(useMaterial3: true),
                home: GlobalsWidgets.uid.isNotEmpty
                    ? FutureBuilder(
                        future: getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            GlobalsWidgets.name = snapshot.data!.name;
                            GlobalsWidgets.surname = snapshot.data!.surname;
                            GlobalsWidgets.image = snapshot.data!.photo;
                            GlobalsWidgets.role = snapshot.data!.role;
                            return MainRoute(userEntity: snapshot.data!);
                          } else if (snapshot.hasError) {
                            FirebaseAuth.instance.signOut();
                            return const LoginPage();
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      )
                    : PreloadPage(),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  void initLocalization() async {
    var prefs = await SharedPreferences.getInstance();
    String? lng = prefs.getString("lng");
    final loginBloc = BlocProvider.of<LanguageBloc>(context);
    if (lng != null) loginBloc.add(ToggleLanguageEvent(lng));
  }

  Future<UserEntity> getUser() {
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.getUserByUid(GlobalsWidgets.uid);
  }
}
