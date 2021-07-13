import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app/base/state_view.dart';
import 'package:flutter_base/app/page/home/home_controller.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:flutter_base/app/widgets/common_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends View {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    controller.getInformation();
    controller.getMarkers();
    controller.announceCancelPoint();
    controller.getCurrentLocation();
    textListener();
    super.initState();
  }

  @override
  void dispose() {
    controller.mapController.future.then((value) => value.dispose());
    textEditingController.dispose();
    super.dispose();
  }

  void textListener() {
    textEditingController.addListener(() {
        controller.research(textEditingController.text);
    });
  }

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18),
    );
  }

  Widget textFieldComplete() {
    return TextField(
      controller: textEditingController,
      style: TextStyle(fontSize: 21),
      decoration: InputDecoration(
          hintText: 'Enter your destination',
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => controller.queryDestination()),
          contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                  Radius.circular(20)
              )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(20)
            ),
          )
      ),
    );
  }

  Widget search(List<String> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          textFieldComplete(),
          Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text(
                          list[index],
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      onTap: () {
                        controller.textSearch(list[index]);
                        controller.queryDestination();
                      },
                    );
                  }
              )
          )
        ],
      ),
    );
  }

  @override
  Widget buildPage(context) {
    controller.createMarkerFull(context);
    controller.createMarkerNotFull(context);
    controller.createMarkerMyLocation(context);
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: Builder(builder: (context) => IconButton(
              icon: Icon(Icons.playlist_play, size: 40),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )),
            centerTitle: true,
            title: Text(
                'Find parking lot'
            ),
            actions: [
              IconButton(
                icon: Icon(controller.visible.value ? Icons.close : Icons.search),
                onPressed: () => controller.toggle(),
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                onTap: (position){
                  GeoPoint latLng = new GeoPoint(position.latitude, position.longitude);
                  controller.chooseFivePL(latLng);
                },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(21.007285, 105.843061),
                    zoom: 16
                ),
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                tiltGesturesEnabled: false,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                markers: Set.from(controller.allMarkers),
                onMapCreated: (GoogleMapController googleMapController){
                  controller.mapController.complete(googleMapController);
                },
              ),
              controller.visible.value ? search(controller.listSearch) : Container()
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.blue
                    ),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text('Hello'),
                              text(controller.name.value?? 'Loading...'),
                              text(controller.numberPhone.value ?? 'Loading...')
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Get.back(),
                            )
                          ],
                        )
                      ],
                    )
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      trailing: Icon(Icons.arrow_right),
                      title: Text('Profile', style: TextStyle(fontSize: 18),),
                      onTap: (){
                        Get.back();
                        Get.toNamed(Routes.PROFILE);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart),
                      trailing: Icon(Icons.arrow_right),
                      title: text('My reservation states'),
                      onTap: () => controller.goToReservation(),
                    ),
                    ListTile(
                      leading: Icon(Icons.directions_car),
                      trailing: Icon(Icons.arrow_right),
                      title: text('My rental state'),
                      onTap: () => controller.goToRent(),
                    ),
                    ListTile(
                      leading: Icon(Icons.event_note),
                      trailing: Icon(Icons.arrow_right),
                      title: text('My bill'),
                      onTap: () => controller.goToBill(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 100, bottom: 10),
                      child: GestureDetector(
                        onTap: () => controller.logOut(),
                        child: Text('Log out', style: TextStyle(fontSize: 18, color: Colors.grey),),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            tooltip: 'My location',
            onPressed: () {
              setState(() {
                controller.moveToMyLocation();
              });
            },
            child: Icon(Icons.my_location),
          ),
        ),
        loading(
            status: controller.status.value,
            context: context
        )
      ],
    ));
  }
}
