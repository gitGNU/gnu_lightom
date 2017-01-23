var lightomap;

function initLightomap() {
    lightomap = new L.map('lightomap').setView([-9.6565863, -35.7384311], 13);
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: '<a href="http://openstreetmap.org">Map</a>',
	maxZoom: 18}).addTo(lightomap);
    lightomap.doubleClickZoom.disable();
}

function LoadConcentrador(data) {
    var html = "<b>Serial:</b> " + data.Serial + "<br/>" +
	"<b>Latitude:</b> " + data.Latitude + "<br/>" +
	"<b>Longitude:</b> " + data.Longitude + "<br/>" +
	"<b>IP:</b> " + data.IP + "<br/>" +
	"<b>Atualização:</b> " + data.Atualizacao + "<br/>" +
	"<a href='/web/concentrador/" + data.Serial +
	"'>Acessar dispositivos vinculados</a>"; 
    var marker = L.marker([data.Latitude, data.Longitude]).addTo(lightomap);
    marker.bindPopup(html);
}

function AddConcentrador(event) {
    var data = {"Serial": "#83GNU$",
	    "Latitude": event.latlng.lat.toString(),
	    "Longitude": event.latlng.lng.toString(),
	    "IP": "10.0.0.1",
		"Atualizacao": "11/10/2017 - 13:00:00"};
    var html = "<b>Serial:</b> " + data.Serial + "<br/>" +
	"<b>Latitude:</b> " + data.Latitude + "<br/>" +
	"<b>Longitude:</b> " + data.Longitude + "<br/>" +
	"<b>IP:</b> " + data.IP + "<br/>" +
	"<b>Atualização:</b> " + data.Atualizacao + "<br/>";
    var marker = L.marker([data.Latitude, data.Longitude]).addTo(lightomap);
    marker.bindPopup(html);
}

function LoadDispositivo(data) {
    var html = "<b>Serial:</b> " + data.Serial + "<br/>" +
	"<b>Estado:</b> <a href='#'> " + data.Estado + "</a><br>" +
	"<b>Dimerização:</b> <a href='#'> " + data.Dismerizacao + "%</a><br/>" +
	"<b>Potência:</b> " + data.Potencia + "<br/>" +
	"<b>Tensão:</b> " + data.Tensao + "<br/>" +
	"<b>Corrente:</b> " + data.Corrente + "<br/>" +
	"<b>Fase:</b> " + data.Fase + "<br/>" +
	"<b>Latitude:</b> " + data.Latitude + "<br/>" +
	"<b>Longitude:</b> " + data.Longitude + "<br/>" +
	"<b>IP:</b> " + data.IP + "<br/>" +
	"<b>Atualização:</b> " + data.Atualizacao + "<br/>";
    var marker = L.marker([data.Latitude, data.Longitude]).addTo(lightomap);
    marker.bindPopup(html);
}

/*
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
    json = {"Serial": "#83GNU$",
	    "Estado": "Desligado",
	    "Dismerizacao": "100",
	    "Potencia": "100",
	    "Tensao": "120",
	    "Corrente": "220",
	    "Fase": "1",
	    "Latitude": e.latlng.lat.toString(),
	    "Longitude": e.latlng.lng.toString(),
	    "IP": "10.10.10.1",
	    "Atualizacao": "11/10/2017 - 13:00:00"};
    addPoint(json);
}

function doubleClickMap(e) {
    json = {"Latitude": e.latlng.lat.toString(),
	    "Longitude": e.latlng.lng.toString()};
    addCircle(json);
}
*/
