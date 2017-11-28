// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require rails-ujs
//= require_self

var map = null;
var circleMarker = null;

function placeMarker(latlng) {
  if(circleMarker) { circleMarker.setMap(null); }
  circleMarker = new google.maps.Marker({
    position: latlng,
    map: map
  });
}

function setCircleFields(latLng) {
  var lngField = document.getElementsByName('cap_form[area_circle_longitude]')[0];
  lngField.value = latLng.lng();

  var latField = document.getElementsByName('cap_form[area_circle_lattitude]')[0];
  latField.value = latLng.lat();
}

function initMap() {
  if(!!document.getElementById('map')) {
    var centerPosition = {lat: 0, lng: 0};

    if(!!navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        map.setCenter({lat: position.coords.latitude, lng: position.coords.longitude})
      })
    }

    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 9,
      center: centerPosition
    });

    google.maps.event.addListener(map, 'click', function(clickEvent) {
      placeMarker(clickEvent.latLng);
      setCircleFields(clickEvent.latLng);
    })

  }
}
