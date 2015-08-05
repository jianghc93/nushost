function gmap_form(location) {
    handler = Gmaps.build('Google');    // map init
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        if (location && location.lat && location.lng) {    // statement check - new or edit view
            markers = handler.addMarkers([    // print existent marker
                {
                    "lat": location.lat,
                    "lng": location.lng,
                    "picture": {
                        "url": 'https://cdn2.iconfinder.com/data/icons/lin/32/13.png',
                        "width":  32,
                        "height": 32
                    },
                    "infowindow": "<b>" + location.title + "</b>" + "<br>"
                    + "Date: " + moment(location.time).format("Do MMM YY") + "<br>"
                    + "Time: " + moment(location.time).format("h:mm a") + "<br>"
                    + "Venue: " + location.venue + "<br>"
                }
            ]);
            handler.bounds.extendWith(markers);
            handler.fitMapToBounds();
            handler.getMap().setZoom(16);
        }
        else {    // show the empty map centered at NUS
            handler.fitMapToBounds();
            handler.map.centerOn([1.2956, 103.7767]);
            handler.getMap().setZoom(16);
        }
    });

    var markerOnMap;

    function placeMarker(location) {    // simply method for put new marker on map
        if (markerOnMap) {
            markerOnMap.setPosition(location);
        }
        else {
            markerOnMap = new google.maps.Marker({
                position: location,
                map: handler.getMap()
            });
        }
    }

    google.maps.event.addListener(handler.getMap(), 'click', function(event) {    // event for click-put marker on map and pass coordinates to hidden fields in form
        placeMarker(event.latLng);
        document.getElementById("map_lat").value = event.latLng.lat();
        document.getElementById("map_lng").value = event.latLng.lng();
    });
}

function gmap_show(location) {
    if ((location.lat == null) || (location.lng == null) ) {    // validation check if coordinates are there
        return 0;
    }

    handler = Gmaps.build('Google');    // map init
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers([    // put marker method
            {
                "lat": location.lat,    // coordinates from parameter company
                "lng": location.lng,
                "picture": {    // setup marker icon
                    "url": 'https://cdn2.iconfinder.com/data/icons/lin/32/13.png',
                    "width":  32,
                    "height": 32
                },
                "infowindow": "<b>" + location.title + "</b>" + "<br>"
                + "Date: " + moment(location.time).format("Do MMM YY") + "<br>"
                + "Time: " + moment(location.time).format("h:mm a") + "<br>"
                + "Venue: " + location.venue + "<br>"
            }
        ]);
        handler.bounds.extendWith(markers);
        handler.fitMapToBounds();
        handler.getMap().setZoom(16);    // set the default zoom of the map
    });
}