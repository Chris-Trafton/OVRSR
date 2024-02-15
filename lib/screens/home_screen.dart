import 'package:flutter/material.dart';
import 'package:ovrsr/services/file_service.dart';
import 'package:ovrsr/utils/app_styles.dart';
import 'package:ovrsr/widgets/custom_textfeild.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    addListeners();
  }

  @override
  void dispose() {
    removeListeners();
    super.dispose();
  }

  void addListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController
    ];

    for (TextEditingController controller in controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  void removeListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController
    ];

    for (TextEditingController controller in controllers) {
      controller.removeListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    setState(() {
      fileService.fieldNotEmpty = fileService.titleController.text.isNotEmpty &&
          fileService.descriptionController.text.isNotEmpty &&
          fileService.tagsController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark, //can use theme
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(() => fileService.newFile(context), "New File"),
                Row(
                  children: [
                    _actionButton(
                        () => fileService.loadFile(context), Icons.file_upload),
                    const SizedBox(width: 8),
                    _actionButton(
                        () => fileService.newDirectory(context), Icons.folder),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
                maxLength: 100,
                maxLines: 3,
                hintText: 'Enter Video Title',
                controller: fileService.titleController),
            const SizedBox(height: 20),
            CustomTextField(
                maxLength: 50000,
                maxLines: 6,
                hintText: 'Enter Video Desciption',
                controller: fileService.descriptionController),
            CustomTextField(
                maxLength: 500,
                maxLines: 4,
                hintText: 'Enter Video Title',
                controller: fileService.tagsController),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                _mainButton(() => fileService.saveContent(context), "Save"),
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  IconButton _actionButton(Function()? onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      splashColor: AppTheme.accent,
      icon: Icon(icon, color: AppTheme.meduim),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dark,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledForegroundColor,
    );
  }
}
