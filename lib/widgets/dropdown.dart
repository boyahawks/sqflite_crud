part of "./widget.dart";

class DropdownButtom extends StatelessWidget {
  final List<String> option;
  final String selectedOption;
  final Function? onChange;

  const DropdownButtom({
    Key? key,
    required this.option,
    required this.selectedOption,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        value: selectedOption,
        onChanged: (newValue) {
          if (newValue != null) {
            if (onChange != null) onChange!(newValue);
          }
        },
        items: option.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
