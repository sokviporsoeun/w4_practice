import 'package:flutter/material.dart';
 import 'package:w4_practice/2_download_app/ui/theme/theme.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;
 
 // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              border: Border.all(color: AppColors.neutral),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(controller.ressource.name),
              subtitle: Text('${controller.progress.toString()}% completed - ${controller.downloadSize} of ${controller.ressource.size}'),
              trailing: Icon(controller.getIcon(controller.status)),
              onTap: () => controller.startDownload(),
            ),
          ),
        );
      },
    );
     
    // TODO
  }
}
