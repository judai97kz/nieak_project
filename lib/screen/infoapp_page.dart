
import 'package:flutter/material.dart';


class InfoAppPage extends StatefulWidget {
  const InfoAppPage({super.key});

  @override
  State<InfoAppPage> createState() => _InfoAppPageState();
}

class _InfoAppPageState extends State<InfoAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Liên hệ với số : 0367989659 để được tư vấn!"),
      ),
    );
  }
}
