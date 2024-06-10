import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/provider/models_provider.dart';
import 'package:flutter_chatgpt/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../model/models_model.dart';

class ModalDropDownWidget extends StatefulWidget {
  const ModalDropDownWidget({super.key});

  @override
  State<ModalDropDownWidget> createState() => _ModalDropDownWidgetState();
}

class _ModalDropDownWidgetState extends State<ModalDropDownWidget> {
  String? currentModels ;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModels = modelsProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : DropdownButton(
                  dropdownColor: scaffoldBackgroundColor,
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<String?>>.generate(
          snapshot.data!.length,
          (index) => DropdownMenuItem(
                value: snapshot.data![index].id,
                child: TextWidget(
                  label: snapshot.data![index].id,
                  fontSize: 15,
                ),
              )),
                  value: currentModels,
                  onChanged: (value) {
                    setState(() {
                      currentModels = value.toString();
                    });
                    modelsProvider.setCurrentModel(value.toString());
                  });
        });
  }
}
/*
DropdownButton(
      dropdownColor: scaffoldBackgroundColor,
      iconEnabledColor: Colors.white,
        items: getModels,
        value: currentModels,
        onChanged: (value) {
          setState(() {
              currentModels = value.toString();
          });
        
        });
\*/