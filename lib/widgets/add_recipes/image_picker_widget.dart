import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(String) onImageSelected;

  const ImagePickerWidget({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = image;
      });
      widget.onImageSelected(
          image.path); // Pasar la ruta de la imagen seleccionada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _image == null
            ? const Text('No se ha seleccionado imagen')
            : Image.file(
                File(_image!.path),
                width: 100,
                height: 100,
              ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Seleccionar de Galería'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text('Tomar Foto'),
            ),
          ],
        ),
      ],
    );
  }
}
