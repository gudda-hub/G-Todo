import '../export.dart';

class DropDownBtn extends ConsumerWidget {
  final List<String> itemsList;
  final String? selectedValue;
  final void Function(String?)? onChanged;
  final String hintTxt;

  const DropDownBtn(
    this.selectedValue,
    this.onChanged, {
    super.key,
    required this.hintTxt,
    required this.itemsList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uniqueItems = itemsList.toSet().toList();
    final validSelectedValue =
        uniqueItems.contains(selectedValue) ? selectedValue : null;

    return uniqueItems.isEmpty
        ? const CircularProgressIndicator() // Show a loading indicator if `itemsList` is empty
        : DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: ColorTheme.primaryDark, width: 1)),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select one';
              }
              return null;
            },
            isDense: true,
            value: validSelectedValue, // Use only valid values or null
            borderRadius: BorderRadius.circular(10.0),

            hint: Text(hintTxt),
            onChanged: onChanged,
            items: uniqueItems.map<DropdownMenuItem<String>>(
              (String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(capitalizeFirstLetter(item)),
                );
              },
            ).toList(),
          );
  }
}
