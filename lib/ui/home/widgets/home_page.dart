import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pomo_tempus/ui/home/view_models/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.settings),
              iconSize: 32,
              onPressed: () {
                _configBuilder(context, widget.viewModel);
              },
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.viewModel.actualTimerString == 'focus'
                  ? Icon(Icons.timer)
                  : widget.viewModel.actualTimerString == 'shortBreak'
                  ? Icon(Icons.free_breakfast)
                  : Icon(Icons.weekend),
              Text(
                // widget.viewModel.formattedTimer,
                '${widget.viewModel.actualTimer.inMinutes < 10 ? '0' : ''}${widget.viewModel.actualTimer.inMinutes} : ${widget.viewModel.minuteInSeconds.inSeconds < 10 ? '0' : ''}${widget.viewModel.minuteInSeconds.inSeconds}',
                style: TextStyle(fontSize: 64),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 68),
                  widget.viewModel.isPlaying
                      ? IconButton(
                        icon: Icon(Icons.pause),
                        iconSize: 32,
                        onPressed: () {
                          widget.viewModel.play();
                        },
                      )
                      : IconButton(
                        icon: Icon(Icons.play_arrow),
                        iconSize: 32,
                        onPressed: () {
                          widget.viewModel.play();
                        },
                      ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    iconSize: 32,
                    onPressed: () {
                      widget.viewModel.nextTimer();
                    },
                  ),
                ],
              ),
              SizedBox(height: 64),
            ],
          );
        },
      ),
    );
  }
}

Future<void> _configBuilder(BuildContext context, HomeViewModel viewModel) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Settings"),
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pomodoro:"),
                    SizedBox(
                      width: 75,
                      child: TextFormField(
                        initialValue: "25",
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(suffixText: "min"),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Short break:"),
                    SizedBox(
                      width: 75,
                      child: TextFormField(
                        initialValue: "5",
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(suffixText: "min"),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Long break:"),
                    SizedBox(
                      width: 75,
                      child: TextFormField(
                        initialValue: "15",
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(suffixText: "min"),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Notification enabled: "),
                    Checkbox(
                      value: viewModel.isNotificationEnabled,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizedBox(height: 16),
                BlockPicker(
                  pickerColor: Colors.amber,
                  onColorChanged: (color) {
                    print(color);
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}
