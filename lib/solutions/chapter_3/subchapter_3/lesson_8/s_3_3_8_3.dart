import 'package:flutter/material.dart';

FormattedTime formatSeconds(int inputSecond) {
  int hours = inputSecond ~/ 3600;
  int remainingSecondsAfterHours = inputSecond % 3600;
  int minutes = remainingSecondsAfterHours ~/ 60;
  int seconds = remainingSecondsAfterHours % 60;
  return FormattedTime(
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}

class FormattedTime {
  final int hours;
  final int minutes;
  final int seconds;

  const FormattedTime({
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  String toString() {
    String result = "";
    if (hours > 0) {
      result += "$hours Stunden ";
    }
    if (minutes > 0) {
      result += "$minutes Minuten ";
    }
    if (seconds > 0) {
      result += "$seconds Sekunden";
    }
    return result;
  }
}

class S3383 extends StatefulWidget {
  const S3383({super.key});

  @override
  State<S3383> createState() => _S3383State();
}

class _S3383State extends State<S3383> {
  final TextEditingController _inputController = TextEditingController();
  String? output;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _inputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Sekunden',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          output?.toString() ?? '',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 32,
        ),
        ElevatedButton(
          onPressed: () {
            final input = int.tryParse(_inputController.text);
            if (input == null) {
              setState(() {
                output = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bitte eine Anzahl an Sekunden eingeben.'),
                ),
              );
              return;
            }
            setState(() {
              output = formatSeconds(input).toString();
            });
          },
          child: const Text('Formatiere'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
