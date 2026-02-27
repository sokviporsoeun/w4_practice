import 'package:flutter/material.dart';

class Ressource {
  final String name;
  final int size;   // in MB

  Ressource({required this.name, required this.size}); 
}

enum DownloadStatus { notDownloaded, downloading, downloaded }

class DownloadController extends ChangeNotifier {
  
  DownloadController(this.ressource);

  // DATA
  Ressource ressource;
  DownloadStatus _status = DownloadStatus.notDownloaded;
  double _progress = 0.0;         // 0.0 → 1.0
  double downloadSize = 0;

  // GETTERS
  DownloadStatus get status => _status;
  double get progress => _progress;

  IconData? getIcon(DownloadStatus status){
    if(status == DownloadStatus.notDownloaded){
      return Icons.download;
    }else if(status == DownloadStatus.downloading){
      return Icons.downloading;
    }else if (status == DownloadStatus.downloaded){
      return Icons.folder;
    }
  }

  // ACTIONS
  void startDownload() async {
    if (_status == DownloadStatus.downloading) return;

    // TODO
    // 1 – set status to downloading
    _progress = 0.0;
    _status = DownloadStatus.downloading;
    // 2 – Loop 10 times and increment the download progress (0 -> 0.1 -> 0.2 )
    //      - Wait 1 second :  await Future.delayed(const Duration(milliseconds: 1000));
    for(int i =1; i<=10;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      _progress = (i/10)*100;
      downloadSize = (ressource.size * _progress)/100;
      notifyListeners();
    }

    // 3 – set status to downloaded
    if(_progress == 100){
      _status = DownloadStatus.downloaded;
      notifyListeners();
    }
  }
}


