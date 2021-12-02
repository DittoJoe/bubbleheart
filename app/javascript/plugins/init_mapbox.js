import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/dittojoe/ckwovkach1hlj15r02ne5g0rv/',
      center: [18.0600026, 59.3354662],
      zoom: 11.15
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      new mapboxgl.Marker({ "color": "#9989A9" })
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
      if (markers.length > 1) {
        fitMapToMarkers(map, markers);
      } else if (markers.length == 1) {
        map.flyTo({center: [ marker.lng, marker.lat ], zoom: 14})
      }
    });
  }
};

export { initMapbox };

