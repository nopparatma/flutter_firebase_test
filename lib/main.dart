import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/core/firebase/fire_base_fire_store.dart';
import 'package:flutter_firebase_test/core/model/product.dart';

import 'core/firebase/fire_base_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBohdCY8al1wtU6-0fKmJ-KjNxZAMPxApw",
      authDomain: "gruchangthai2.firebaseapp.com",
      projectId: "gruchangthai2",
      storageBucket: "gruchangthai2.appspot.com",
      messagingSenderId: "292247113542",
      appId: "1:292247113542:web:1d3103acc964712b769f47",
      measurementId: "G-N7DP2NE6ZB",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: FireBaseFireStore().getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('ERROR');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<Product> products = snapshot.data as List<Product>;

            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var productItem = products[index];
                return ListTile(
                  title: Text(productItem.nameTH),
                  subtitle: Text(productItem.nameEN),
                  trailing: Image.network(productItem.imgUrl),
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
