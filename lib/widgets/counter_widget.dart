import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final int max;
  final int min;
  final int value;
  final ValueSetter<int> onValueChanged;
  const CounterWidget({
    Key? key,
    required this.max,
    required this.min,
    required this.value,
    required this.onValueChanged
  }) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 1;

  @override
  void initState() {
    super.initState();
    counter = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: (){
            setState(() {
              if (counter > widget.min) {
                counter -= 1;
                widget.onValueChanged(counter);
              }
            });
          },
          icon: const Icon(Icons.arrow_left)
        ),
        Text(counter.toString()),
        IconButton(
            onPressed: (){
              setState(() {
                if (counter < widget.max) {
                  counter += 1;
                  widget.onValueChanged(counter);
                }
              });
            },
            icon: const Icon(Icons.arrow_right)
        ),
      ],
    );
  }
}
