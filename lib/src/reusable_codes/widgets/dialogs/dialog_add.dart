import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/widgets/dialogs/dialog_main_boilerplate.dart';

class DialogAdd extends StatefulWidget {
  const DialogAdd({
    super.key,
    required this.title,
    required this.controller,
    required this.theOnPressed,
  });

  final String title;
  final TextEditingController controller; // TODO: dispose it
  final theOnPressed; // TODO: fix it's error

  @override
  State<DialogAdd> createState() => _DialogAddState();
}

class _DialogAddState extends State<DialogAdd> {
  @override
  Widget build(BuildContext context) {
    return DialogMainBoilerplate(
      theTitle: 'New ${widget.title}',
      theWidgetContent: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            // alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            suffixIcon: IconButton(
              onPressed: () => widget.controller.clear(),
              icon: const Icon(
                Icons.close,
                // color: Color.fromARGB(255, 126, 50, 50),
              ),
            ),
            border: const UnderlineInputBorder(),
            hintText: '${widget.title} name',
            alignLabelWithHint: true),
      ),
      theIsButtonElevatedWithIcon: false,
      theButtonLabel: 'Create',
      theOnPressed: widget.theOnPressed,
    );
  }
}
