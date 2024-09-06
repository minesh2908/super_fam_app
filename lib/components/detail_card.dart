import 'package:flutter/material.dart';
import 'package:super_fam_app/components/custom_text_field.dart';
import 'package:super_fam_app/model/state_model.dart';

class DetailCard extends StatelessWidget {
  DetailCard({
    required this.searchStateController,
    required this.stateData,
    super.key,
  });

  final StateModal stateData;
  TextEditingController searchStateController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomTextField(
        controller: searchStateController,
        label: 'Search for state...',
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: stateData.indiaStateList?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                searchStateController.text =
                    stateData.indiaStateList![index].name!;
                Navigator.pop(context);
              },
              title: Text(stateData.indiaStateList![index].name!),
            );
          },
        ),
      ),
    );
  }
}
