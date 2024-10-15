import 'package:recipes/models/features_model.dart';
import 'package:recipes/providers/expenses_provider.dart';
import 'package:recipes/utils/constants.dart';
import 'package:recipes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {
  final FeaturesModel fModel;
  const CreateCategory({super.key, required this.fModel});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().flist;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    Iterable<FeaturesModel> contain;
    contain = fList.where((e) =>
        e.category.toLowerCase() == widget.fModel.category.toLowerCase());

    addCategory() {
      if (contain.isNotEmpty) {
        // Ya existe la categoría
      } else if (widget.fModel.category.isNotEmpty) {
        // Se puede guardar
      } else {
        // Debe dar nombre a la categoría
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: viewInsets),
            child: ListTile(
                trailing: const Icon(
                  Icons.text_fields_outlined,
                  size: 35.0,
                ),
                title: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  initialValue: widget.fModel.category,
                  decoration: InputDecoration(
                      hintText: 'Nombra una categoría',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                )),
          ),
          ListTile(
            onTap: () => selectColor(),
            trailing: CircleColor(
              color: widget.fModel.color.toColor(),
              circleSize: 35.0,
            ),
            title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).cardColor,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: const Center(
                  child: Text('Color'),
                )),
          ),
          ListTile(
            onTap: () => selectIcon(),
            trailing: Icon(
              widget.fModel.icon.toIcon(),
              size: 35.0,
            ),
            title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).cardColor,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: const Center(
                  child: Text('Icono'),
                )),
          ),
          GestureDetector(
            onTap: () {
              addCategory();
            },
            child: const Text('Done'),
          )
        ],
      ),
    );
  }

  selectColor() {
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialColorPicker(
                selectedColor: widget.fModel.color.toColor(),
                physics: const NeverScrollableScrollPhysics(),
                circleSize: 50.0,
                onColorChange: (Color color) {
                  var hexColor =
                      '#${color.value.toRadixString(16).substring(2, 8)}';
                  setState(() {
                    widget.fModel.color = hexColor;
                  });
                },
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Constants.customButton(
                      Colors.green, Colors.transparent, 'Listo'))
            ],
          );
        });
  }

  selectIcon() {}
}
