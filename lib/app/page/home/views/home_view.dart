import 'package:autocomplete_textfield/autocomplete_textfield.dart';
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

  @override
  void initState() {
    controller.checkInternet();
    controller.getInformation();
    controller.getMarkers();
    controller.getDestination();
    controller.announceCancelPoint();
    controller.getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    controller.mapController.future.then((value) => value.dispose());
    super.dispose();
  }

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18),
    );
  }

  Widget autoCompleteTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AutoCompleteTextField(
        clearOnSubmit: false,
        suggestions: controller.destination,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => controller.query(),
            ),
            hintText: 'Enter your destination',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: const BorderRadius.all(
                  Radius.circular(20)
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: const BorderRadius.all(
                  Radius.circular(20)
              ),
            )
        ),
        itemFilter: (item, query){
          return item.toLowerCase().startsWith(query.toLowerCase());
        },
        itemSorter: (a, b){
          return a.compare(b);
        },
        itemSubmitted: (item){
          if (item != null){
            controller.chooseDestination(item);
          }
        },
        itemBuilder: (context , item) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                item,
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        },
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
                  //GeoPoint latLng = new GeoPoint(position.latitude, position.longitude);
                  //_chooseFivePL(latLng);
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
              controller.visible.value ? autoCompleteTextField() : Container()
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
