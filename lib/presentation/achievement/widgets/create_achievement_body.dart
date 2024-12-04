import 'package:achiever/application/achievement/performer/achievement_performer_bloc.dart';
import 'package:achiever/presentation/core/in_app_notifications/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAchievementBody extends StatefulWidget {
  const CreateAchievementBody({super.key});

  @override
  State<CreateAchievementBody> createState() => _CreateAchievementBodyState();
}

class _CreateAchievementBodyState extends State<CreateAchievementBody> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AchievementPerformerBloc, AchievementPerformerState>(
      listener: (context, performerState) {
        performerState.whenOrNull(
          success: () {
            AppToast.success('Achievement created').show();

            Navigator.of(context).pop();
          },
          failure: (message) {
            AppToast.error(message).show();
          },
        );
      },
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Description'),
            controller: descriptionController,
          ),
          Row(
            children: [
              Expanded(
                child: Text(startDate == null
                    ? 'Start Date: Not selected'
                    : 'Start Date: ${startDate!.toLocal()}'.split(' ')[0]),
              ),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != startDate) {
                    setState(() {
                      startDate = picked;
                    });
                  }
                },
                child: const Text('Select Start Date'),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(endDate == null
                    ? 'End Date: Not selected'
                    : 'End Date: ${endDate!.toLocal()}'.split(' ')[0]),
              ),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != endDate) {
                    setState(() {
                      endDate = picked;
                    });
                  }
                },
                child: const Text('Select End Date'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              String failureMessage = '';

              if (titleController.text.isEmpty) {
                failureMessage = 'Title';
              }

              if (descriptionController.text.isEmpty) {
                if (failureMessage.isNotEmpty) {
                  failureMessage += ' and ';
                }
                failureMessage += 'Description';
              }

              if (failureMessage.isNotEmpty) {
                AppToast.error('$failureMessage required').show();
                return;
              }

              context.read<AchievementPerformerBloc>().add(
                    AchievementPerformerEvent.create(
                      title: titleController.text,
                      description: descriptionController.text,
                      startDate: startDate,
                      endDate: endDate,
                    ),
                  );
            },
            child: const Text('Save Achievement'),
          ),
        ],
      ),
    );
  }
}
