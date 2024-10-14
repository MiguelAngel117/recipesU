import 'package:recipes/models/combined_model.dart';
import 'package:recipes/models/features_model.dart';
import 'package:recipes/utils/utils.dart';
import 'package:recipes/widgets/add_expenses/category_list.dart';
import 'package:recipes/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:recipes/widgets/add_expenses/create_category.dart';

class BsCategory extends StatefulWidget {
  final CombinedModel cModel;
  const BsCategory({super.key, required this.cModel});

  @override
  State<BsCategory> createState() => _BsCategoryState();
}

class _BsCategoryState extends State<BsCategory> {
  // Utilizamos la lista quemada directamente desde CategoryList
  final List<FeaturesModel> catList = CategoryList().catList;

  @override
  Widget build(BuildContext context) {
    bool hasData = widget.cModel.category != 'Selecciona Categoría';

    return GestureDetector(
      onTap: () {
        categorySelected(catList);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            const Icon(Icons.category_outlined, size: 35.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.7,
                        color: hasData
                            ? widget.cModel.color.toColor()
                            : Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(widget.cModel.category),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Muestra la lista de categorías quemada al seleccionar una categoría
  categorySelected(List<FeaturesModel> catList) {
    void itemSelected(String category, String color) {
      setState(() {
        widget.cModel.category = category;
        widget.cModel.color = color;
        Navigator.pop(context);
      });
    }

    var widgets = [
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: catList.length,
          itemBuilder: (_, i) {
            var item = catList[i];
            return ListTile(
              leading: Icon(
                item.icon.toIcon(),
                color: item.color.toColor(),
                size: 35.0,
              ),
              title: Text(item.category),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ),
              onTap: () {
                itemSelected(item.category, item.color);
              },
            );
          }),
      const Divider(
        thickness: 2.0,
      ),
      ListTile(
          leading: const Icon(Icons.create_new_folder_outlined, size: 35.0),
          title: const Text('Crear nueva Categoría'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
          onTap: () {
            Navigator.pop(context);
            createNewCategory();
          }),
      ListTile(
        leading: const Icon(Icons.edit_outlined, size: 35.0),
        title: const Text('Administrar Categoría'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
        onTap: () {
          Navigator.pop(context);
        },
      )
    ];
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            child: ListView(
              children: widgets,
            ),
          );
        });
  }

  createNewCategory() {
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) => CreateCategory(
              fModel: FeaturesModel(),
            ));
  }
}
