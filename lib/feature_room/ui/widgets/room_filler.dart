import 'package:flutter/material.dart';

class RoomIdFiller extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final int charCount;
  final void Function(String value)? onChange;
  final void Function(String value) onSubmit;
  final InputDecoration? decoration;
  final TextCapitalization? capitalization;
  const RoomIdFiller({
    super.key,
    required this.charCount,
    required this.onSubmit,
    this.decoration,
    this.formKey,
    this.onChange,
    this.capitalization,
  });

  @override
  State<RoomIdFiller> createState() => _RoomIdFillerState();
}

class _RoomIdFillerState extends State<RoomIdFiller> {
  late List<String> _listOfValue;
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _textEditingControllers;

  void _changeFocusToNextNode({required String value, required int index}) =>
      (value.isNotEmpty)
          ? (index + 1 != widget.charCount)
              ? FocusScope.of(context).requestFocus(_focusNodes[index + 1])
              : _focusNodes[index].unfocus()
          : null;

  void _changeFocusNodeRemoved({required String value, required int index}) {
    if (value.isNotEmpty) return;
    if (index == 0) return;
    FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
  }

  void _onSubmit({required List<String> value}) =>
      value.any((element) => element == '')
          ? null
          : widget.onSubmit(value.join());

  void _onCodeChanged(String value) =>
      widget.onChange != null ? widget.onChange!(value) : null;

  void _getTextValue(String value, int index) {
    _listOfValue[index] = value;
    _onCodeChanged(value);
    _changeFocusToNextNode(value: value, index: index);
    _changeFocusNodeRemoved(value: value, index: index);
    _onSubmit(value: _listOfValue);
  }

  String? _validate(String? value) {
    if (value != null && value.isEmpty) return "";
    return null;
  }

  @override
  void initState() {
    _listOfValue = List.generate(widget.charCount, (index) => '');
    _focusNodes = List.generate(widget.charCount, (index) => FocusNode());
    _textEditingControllers =
        List.generate(widget.charCount, (index) => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    for (final nodes in _focusNodes) {
      nodes.dispose();
    }

    for (final editingController in _textEditingControllers) {
      editingController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            widget.charCount,
            (index) => SizedBox.square(
              dimension: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorHeight: 50,
                  validator: _validate,
                  maxLength: 1,
                  controller: _textEditingControllers[index],
                  showCursor: false,
                  textCapitalization:
                      widget.capitalization ?? TextCapitalization.none,
                  style: Theme.of(context).textTheme.headlineSmall,
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  decoration: widget.decoration?.copyWith(
                    counterText: "",
                    errorMaxLines: null,
                    errorStyle: const TextStyle(height: 0),
                  ),
                  onChanged: (s) => _getTextValue(s.toUpperCase(), index),
                ),
              ),
            ),
          ),
        ),
      );
}
