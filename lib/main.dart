// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_overview_10/models/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Dog>(
      create: (context) => Dog(name: "dog10", breed: "breed10", age: 3),
      child: MaterialApp(
        title: 'Provider 10',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider 10"),
      ),
      body: Selector<Dog, String>(
        selector: (BuildContext context, Dog dog) => dog.name,
        builder: (BuildContext context, String name, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                Text(
                  " - name: $name",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                BreedAndAge(),
              ],
            ),
          );
        },
        child: Text(
          "I like dogs very much",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<Dog, String>(
      selector: (BuildContext context, Dog dog) => dog.breed,
      builder: (_, String breed, __) {
        return Column(
          children: [
            Text(
              "- breed:$breed",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Age(),
          ],
        );
      },
    );
  }
}

class Age extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<Dog, int>(
      selector: (BuildContext context, Dog dog) => dog.age,
      builder: (_, int age, __) {
        return Column(
          children: [
            Text(
              "- age: $age",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<Dog>().grow();
                },
                child: Text(
                  "Grow",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        );
      },
    );
  }
}
