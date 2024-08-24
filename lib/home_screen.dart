import 'package:flutter/material.dart';
import 'package:internshalaproject/progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: DashedCircularProgressIndicator(
          progress: 0.5,
          fillColor: Colors.blue,
          dashColor: Colors.grey,
        ),
      ),
    );
  }
}