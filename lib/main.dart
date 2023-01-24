import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metature2/change%20notifiers/edit_profile_notifier.dart';
import 'package:metature2/change%20notifiers/google_sign_in.dart';
import 'package:metature2/change%20notifiers/edit_text_post_notifier.dart';
import 'package:metature2/change%20notifiers/post_crud_notifier.dart';
import 'package:metature2/models/profile_model.dart';
import 'package:metature2/pages/chat%20page/chat_screen.dart';
import 'package:metature2/pages/main_page.dart';
import 'package:metature2/pages/username_page.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'firebase_options.dart';
import 'pages/home_page.dart';

final _auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(providers: multiProviders(), child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? timer;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "Check your internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    FirebaseAuth.instance.currentUser?.reload();

    timer = Timer.periodic(const Duration(seconds: 5),
        (timer) => FirebaseAuth.instance.currentUser?.reload());
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
      ),
      home: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
                stream: db
                    .collection('user')
                    .doc(_auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.exists &&
                      snapshot.data!.get('username') == null) {
                    return const UsernamePage();
                  }

                  return const MainPage();
                  // return const ChatScreen();
                });
          }
          return const HomePage();
        },
      ), //TODO: Change back to HomePage()
    );
  }
}

List<SingleChildWidget> multiProviders() => [
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => DB()),
      ChangeNotifierProvider(create: (_) => EditTextPostNotifier()),
      ChangeNotifierProvider(create: (_) => PostCRUD()),
      ChangeNotifierProvider(create: (_) => EditProfileNotifier()),
    ];
