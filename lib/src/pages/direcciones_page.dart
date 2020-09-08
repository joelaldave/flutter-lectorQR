import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  final scansBloc = ScansBloc();
  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final scan = snapshot.data;

        if (scan.length == 0) {
          return Center(
            child: Text('no hay datos'),
          );
        }

        return ListView.builder(
          itemCount: scan.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direccion) => scansBloc.borrarScans(scan[i].id),
            child: ListTile(
              leading: Icon(
                Icons.cloud_queue,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scan[i].valor),
              subtitle: Text('id : ${scan[i].id}'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () {
                utils.abrirScan(context, scan[i]);
              },
            ),
          ),
        );
      },
    );
  }
}
