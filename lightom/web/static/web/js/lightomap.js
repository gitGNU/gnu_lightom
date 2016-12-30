var lightomap;

function initLightomap() {
    var marker;
    var cirle;

    lightomap = new L.map('lightomap').setView([-9.6565863, -35.7384311], 8);    
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: '<a href="http://openstreetmap.org">Map</a>',
	maxZoom: 18}).addTo(lightomap);
    marker = L.marker([-9.6565863, -35.7384311]).addTo(lightomap);
    marker.bindPopup("<b>Lightom</b><br>Innovate.").openPopup();
    circle = L.circle([-9.6565863, -35.7384311], {
	color: 'red',
	fillColor: '#f03',
	fillOpacity: 0.5,
	radius: 500
    }).addTo(lightomap);
    circle.bindPopup("Setor de cobertura");
}
