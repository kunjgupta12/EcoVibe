import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import '../Models/adminModels/adminMetaData.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AdminBloc extends Bloc {
  AdminMetaData? _adminMetaData;

  AdminMetaData get getAdminMetaData => this._adminMetaData!;

  StreamController<AdminMetaData> _adminDataController =
      StreamController<AdminMetaData>.broadcast();
  Stream<AdminMetaData> get adminMetaDataStream =>
      this._adminDataController.stream;
  StreamSink<AdminMetaData> get _adminMetaDataSink =>
      this._adminDataController.sink;

  AdminBloc() {
    fetchMetaData();
  }
  Future<void> fetchMetaData() async {
    if (_adminMetaData == null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("admin_panel")
          .doc("data")
          .get();
      _adminMetaData = AdminMetaData.fromSnapshot(snapshot);

      return;
    } else {
      return Future.value();
    }
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
  }
}
