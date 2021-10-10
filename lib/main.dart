import 'package:check_list_app/data/moorDatabase.dart';
import 'package:check_list_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {} 
  );
  var initializationSettings = InitializationSettings( android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {
      if(payload != null){
        print('notification payload ===> $payload');
      }
    }
  );

  runApp(CheckListApp());
}

class CheckListApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
      create:(_) => AppDatabase(),
      child:  MaterialApp(
          title: 'Check List App',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: Home(),
      )
    );
  }
}
