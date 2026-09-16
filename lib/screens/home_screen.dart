import 'package:flutter/material.dart';
import 'roadmap_screen.dart';
import 'job_search_screen.dart';

/*
 * БУЛ ЭКРАН ЭМНЕГЕ КЕРЕК (жөнөкөй сөз менен):
 *
 * Катталгандан кийин колдонуучу так ушул экранга түшөт. Бул жерде эки
 * бөлүк бар (таб'дар аркылуу которулат): "Окуу планы" жана "Вакансия издөө".
 */
class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// SingleTickerProviderStateMixin — таб'дардын арасында которулганда
// анимация жумшак болушу үчүн Flutter'га керек кошумча курал.
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 2 — бизде эки таб бар: "Окуу планы" жана "Вакансиялар".
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Экран жабылганда, эсте бекерге орун ээлеп турбашы үчүн тазалайбыз.
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Салам, ${widget.userId}!'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Окуу планы', icon: Icon(Icons.school)),
            Tab(text: 'Вакансиялар', icon: Icon(Icons.work)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RoadmapScreen(userId: widget.userId),
          const JobSearchScreen(),
        ],
      ),
    );
  }
}
