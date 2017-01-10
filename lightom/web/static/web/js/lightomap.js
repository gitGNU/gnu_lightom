var lightomap;
var marker;
var cirle;
var html;
var json;
var popup = L.popup();

function initLightomap(e) {
    lightomap = new L.map('lightomap').setView([-9.6565863, -35.7384311], 13);
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: '<a href="http://openstreetmap.org">Map</a>',
	maxZoom: 18}).addTo(lightomap);
    lightomap.doubleClickZoom.disable();
}

function addPoint(j) {
    html = "<b>Id:</b> " + j.Id + "<br/>" +
	"<b>Nome:</b> " + j.Nome + "<br/>" +
	"<b>Estado:</b> <a href='#'> " + j.Estado + "</a><br>" +
	"<b>Dimerização:</b> <a href='#'> " + j.Dismerizar + "%</a><br/>" +
	"<b>Potência:</b> " + j.Potencia + "<br/>" +
	"<b>Tensão:</b> " + j.Tensao + "<br/>" +
	"<b>Latitude:</b> " + j.Latitude + "<br/>" +
	"<b>Longitude:</b> " + j.Longitude + "<br/>"; 
    marker = L.marker([j.Latitude, j.Longitude]).addTo(lightomap);
    marker.bindPopup(html);
}

function addCircle(j) {
    circle = L.circle([j.Latitude, j.Longitude], {
	color: 'red',
	fillColor: '#f03',
	fillOpacity: 0.5,
	radius: 400
    }).addTo(lightomap);
    circle.bindPopup("Setor de cobertura");
}

function clickMap(e) {
    json = {"Id": "1234",
	    "Nome": "Innovate",
	    "Estado": "Desligado",
	    "Dismerizar": "100",
	    "Potencia": "100",
	    "Tensao": "100",
	    "Latitude": e.latlng.lat.toString(),
	    "Longitude": e.latlng.lng.toString()};
    addPoint(json);
}

function doubleClickMap(e) {
    json = {"Latitude": e.latlng.lat.toString(),
	    "Longitude": e.latlng.lng.toString()};
    addCircle(json);
}
