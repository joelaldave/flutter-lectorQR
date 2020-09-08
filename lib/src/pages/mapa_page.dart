import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();

  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatlng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scan.getLatlng(), zoom: 15),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoiam9lbGFsZGF2ZSIsImEiOiJja2N6ZHBjbXUwMnNtMnhtdHpiOWw4eDY4In0.gCRF0Gh6HcGfvDjZZg7EKQ',
          'id': 'mapbox/$tipoMapa-v11'
          //streets, dark, light, outdoors, satellite
          /* 'id':'mapbox/streets-v11'
          'id':'mapbox/outdoors-v11'
          'id':'mapbox/light-v10'
          'id':'mapbox/dark-v10'
          'id':'mapbox/satellite-v9'
          'id':'mapbox/satellite-streets-v11' */
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatlng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 70.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        /* final tipo = ['streets', 'dark', 'light', 'outdoors', 'satellite'];

        if (tipoMapa == tipo[0])
          tipoMapa = tipo[1];
        else if (tipoMapa == tipo[1])
          tipoMapa = tipo[2];
        else if (tipoMapa == tipo[2])
          tipoMapa = tipo[3];
        else if (tipoMapa == tipo[3])
          tipoMapa = tipo[4];
        else
          tipoMapa = tipo[0]; */

        setState(() {});
      },
    );
  }
}
