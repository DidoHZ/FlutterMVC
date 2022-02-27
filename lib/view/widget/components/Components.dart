import 'package:flutter/material.dart' show BorderRadius, BuildContext, Colors, FocusNode, InputBorder, InputChip, InputDecoration, Key, MediaQuery, OutlineInputBorder, Radius, SizedBox, State, StatefulWidget, StatelessWidget, Text, TextEditingController, TextField, TextInputAction, TextInputType, TextStyle, Widget, Wrap, WrapAlignment, WrapCrossAlignment;

class DTextArea extends StatelessWidget {
  const DTextArea({
    Key? key,
    required TextEditingController report,
    required String label,
  })  : _report = report,
        _label = label,
        super(key: key);

  final TextEditingController _report;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TextField(
        keyboardType: TextInputType.multiline,
        enableInteractiveSelection: true,
        maxLines: null,
        textInputAction: TextInputAction.newline,
        expands: true,
        controller: _report,
        decoration: InputDecoration(
            label: Text(_label),
            labelStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(),
      ),
    ));
  }
}

class DTextField extends StatelessWidget {
  const DTextField({
    Key? key,
    required TextEditingController name,
    required String label,
    this.focusNode
  })  : _name = name,
        _label = label,
        super(key: key);

  final TextEditingController _name;
  final String _label;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .23,
        child: TextField(
          controller: _name,
          focusNode: focusNode,
          decoration: InputDecoration(
              label: Text(_label),
              labelStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        )));
  }
}

class InputChipList extends StatefulWidget {
  const InputChipList({
    Key? key,
    required this.chips,
    this.onDelete,
  }) : super(key: key);

  final List<String> chips;
  final Function(int index)? onDelete;

  @override
  State<InputChipList> createState() => _InputChipListState();
}

class _InputChipListState extends State<InputChipList> {
  final TextEditingController controller = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        runSpacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...List.generate(
              widget.chips.length,
              (index) => InputChip(
                  onDeleted: () => widget.onDelete!(index),
                  deleteIconColor: Colors.black54,
                  label: Text(widget.chips[index],softWrap: true,)
                )),
          SizedBox(
              width: 100,
              child: TextField(
                controller: controller, focusNode: focusNode,
                decoration: const InputDecoration(
                    hintText: "Medication",
                    border: InputBorder.none),
                onSubmitted: (_) {
                  if (controller.text.isEmpty) return;
                  setState(() {
                    widget.chips.add(controller.text); controller.clear();
                  });
                  Future.delayed(const Duration(milliseconds: 100))
                        .then((value) => focusNode.requestFocus());
                },
              ))
        ],
      ),
    );
  }
}