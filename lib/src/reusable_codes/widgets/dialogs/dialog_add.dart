import 'package:flutter/material.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';

class DialogAdd extends StatefulWidget {
  const DialogAdd({
    super.key,
    required this.title,
    required this.controller,
    this.theOnPressed,
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
    return AlertDialog(
      // insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      insetPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      // titlePadding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 5,
      actionsOverflowButtonSpacing: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.cyan,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 15.0),
        decoration: BoxDecoration(
          gradient: dialogHeaderGradient(),
          borderRadius: BorderRadius.circular(15),
        ), //

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Divider(
                thickness: 1,
                endIndent: 10,
              ),
            ),
            Text(
              'New ${widget.title}',
              style: const TextStyle(color: Color.fromARGB(255, 126, 50, 50)),
            ),
            const Expanded(
              child: Divider(
                thickness: 1,
                indent: 10,
              ),
            ),
          ],
        ),
      ),
      content: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(

            // alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            // prefixIcon: Icon(Icons.close),
            suffixIcon: IconButton(
                onPressed: () => widget.controller.clear(),
                icon: const Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 126, 50, 50),
                )),
            border: const UnderlineInputBorder(),
            hintText: '${widget.title} name',
            // labelText: 'Grasp name2',
            alignLabelWithHint: true),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              // backgroundColor: MaterialStateProperty.all(
              //   Color.lerp(Colors.grey, Colors.red, 0.2),
              // ),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.cyan))),
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancle',
            style: TextStyle(color: Colors.cyan),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.cyan)),
          onPressed: widget.theOnPressed,
          child: const Text('Create'),
        ),
      ],
    );
  }
}
