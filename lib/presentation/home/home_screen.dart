import 'package:achiever/application/achievement/watcher/achievements_watcher_cubit.dart';
import 'package:achiever/application/auth/auth_bloc.dart';
import 'package:achiever/application/user/watcher/user_watcher_cubit.dart';
import 'package:achiever/presentation/auth/core/auth_bloc_listener.dart';
import 'package:achiever/presentation/core/router/app_router.gr.dart';
import 'package:achiever/presentation/core/ui/consts/typography.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userWatcher = context.watch<UserWatcherCubit>();

    final user = userWatcher.state.user;

    return AuthBlocListener(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Welcome Achiever',
            style: AppTypography.s24w6h30,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.router.push(
              const CreateAchievementRoute(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Welcome to Achiever'),
              const SizedBox(height: 16),
              Text(
                user?.email ?? 'No user',
              ),
              Expanded(
                child: BlocBuilder<AchievementsWatcherCubit,
                    AchievementsWatcherState>(
                  builder: (context, achievementsState) {
                    return achievementsState.maybeWhen(
                      orElse: () => const SizedBox(),
                      success: (achievements) {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            final achievement = achievements[index];

                            return ListTile(
                              title: Text(achievement.title),
                              subtitle: Text(achievement.description),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemCount: achievements.length,
                        );
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.signOut());
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
