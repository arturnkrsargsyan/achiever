import 'package:achiever/application/achievement/performer/achievement_performer_bloc.dart';
import 'package:achiever/di/locator.dart';
import 'package:achiever/presentation/achievement/widgets/create_achievement_body.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateAchievementScreen extends StatelessWidget {
  const CreateAchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AchievementPerformerBloc>(
      create: (context) => Locator.achievementPerformerBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Achievement'),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CreateAchievementBody(),
        ),
      ),
    );
  }
}
