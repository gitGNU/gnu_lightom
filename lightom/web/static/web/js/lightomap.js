var lightomap;
var marker;
var cirle;
var html;
var popup = L.popup();

function initLightomap() {
    lightomap = new L.map('lightomap').setView([-9.6565863, -35.7384311], 8);
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: '<a href="http://openstreetmap.org">Map</a>',
	maxZoom: 18}).addTo(lightomap);
    
    html = "<b>ID:</b> 1234<br> <b>Nome:</b> Innovate <br/> <b>Estado:</b> <a href='#'>Desligar</a><br> <b>Dimerização:</b> <a href='#'>100%</a><br/> <b>Potência:</b> 80%<br> <b>Tensão:</b> 40%<br>"
    marker = L.marker([-9.6565863, -35.7384311]).addTo(lightomap);
    marker.bindPopup(html);

    circle = L.circle([-9.6565863, -35.7384311], {
	color: 'red',
	fillColor: '#f03',
	fillOpacity: 0.5,
	radius: 400
    }).addTo(lightomap);
    circle.bindPopup("Setor de cobertura");
}

function clickLightom(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("Deseja incluir um ponto de iluminação nessa coordenada (" +
		    e.latlng.toString() + ")? <br/><a href='#'>Sim</a><br/>")
        .openOn(lightomap);
}
