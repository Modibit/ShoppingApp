// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'Branch.dart';

class BranchesPage extends StatefulWidget {
  const BranchesPage({Key? key}) : super(key: key);
  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  Set<Marker> _brancheslist = {};
  late final Completer<GoogleMapController> _controller = Completer();

  void onComplete(GoogleMapController controller) {
    _controller.complete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchpoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "فروشگاه",
          style: TextStyle(
            fontFamily: "Yekan",
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => {Navigator.of(context).pop()},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            )),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.map,
                color: Colors.black54,
              )),
        ],
      ),
      body: GoogleMap(
        markers: _brancheslist,
        liteModeEnabled: true,
        onMapCreated: onComplete,
        initialCameraPosition:
            CameraPosition(target: LatLng(32.795030, 52.149781), zoom: 5),
      ),
    );
  }

  void fetchpoints() async {
    Response response =
        await get(Uri.parse("https://welearn.site/flutter/branches.json"));
    setState(() {
      var pointsJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in pointsJson) {
        print(i['shop_name']);
        Branch branch = Branch(i['shop_name'], i['id'], i['tel'], i['lat'],
            i['lng'], i['manager']);
        Marker _marker = Marker(
            markerId: MarkerId(branch.id.toString()),
            position: LatLng(branch.lat, branch.lng),
            infoWindow:
                InfoWindow(title: branch.name, snippet: branch.manager));
        _brancheslist.add(_marker);
      }
    });
  }
}
