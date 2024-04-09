import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memoriimage_160420076_160420095/screen/game.dart';
import 'package:memoriimage_160420076_160420095/screen/login.dart';
import 'package:memoriimage_160420076_160420095/screen/highscore.dart';
import 'package:shared_preferences/shared_preferences.dart';

String active_user = "";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '')
      runApp(MyLogin());
    else {
      active_user = result;
      runApp(MyApp());
    }
  });
}

Future<String> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString("user_id") ?? '';
    return user_id;
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        'highscore':(context)=>HighScore(),
        '/game':(context) => Game(),
      },




      title: 'Home',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
    void doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
    prefs.remove("final_score");

    main();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: (){
            Navigator.pushNamed(context, '/game');
          },
          color: Color.fromARGB(89, 70, 90, 200),
          textColor: Color.fromARGB(70, 80, 50, 33),
          minWidth: 200, // Menentukan lebar minimum tombol
          height: 100,
          child:Text('Pergi Ke halaman Game'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              //accountname dibenarin
                accountName: Text("xyz"),
                accountEmail: Text("xyz@gmail.com"),
                currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150"))),
            ListTile(
              title: new Text("High Score"),
              leading: new Icon(Icons.high_quality),
            ),
            ListTile(
              title: new Text("Log out "),
              leading: new Icon(Icons.logout),
            )
          ],
        ),
      ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
