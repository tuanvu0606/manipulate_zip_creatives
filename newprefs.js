
var destination_url = "";
// track List
var imp_v4 = "";
var imp_client = "";
var click_v4 = "http://google.com";
var click_client = "";
var platform_macro = "";

var haha;

navigator.geolocation.getCurrentPosition(function(location) {
  latitude_1 = location.coords.latitude;
  longitude_1 = location.coords.longitude;

//latitude_1 = parseFloat("__ADFLAT__");
//longitude_1 = parseFloat("__ADFLNG__");

  var rad = function(x) {
    return x * Math.PI / 180;
  };

var getDistance = function(p1, p2) {
  var R = 6378137; // Earth’s mean radius in meter
  var dLat = rad(p2.lat - p1.lat);
  var dLong = rad(p2.lng - p1.lng);
  var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(rad(p1.lat)) * Math.cos(rad(p2.lat)) *
    Math.sin(dLong / 2) * Math.sin(dLong / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c;
  return d; 
};

// find nearest Location
for(var i = 0; i < lats.length; i++){
  var point = {lat: lats[i], lng: lngs[i]}
  dist = getDistance(point, {lat: latitude_1, lng:longitude_1});
  if((nearest > dist) || (i == 0) ){
    nearest = dist
    store_lat = lats[i];
    store_lng = lngs[i];
    destination_location = decodeURI(list_names[i]);
  }
}

// convert digit to string
var final_dis = ""
if(nearest >  1000){
  final_dis = parseInt(nearest/1000)+"KM"
}else{
  final_dis = parseInt(nearest)+"M"
}

setTimeout(function(){
  var btn = document.createElement("h3");
  var t = document.createTextNode(decodeURI("C%C3%92N")+" "+final_dis + " "+ decodeURI("%C4%90%E1%BA%BEN")+ " THE COFFEE HOUSE");
  var btn_2 = document.createElement("h3"); 
  var t_2 = document.createTextNode((destination_location).toUpperCase());
  btn.appendChild(t);
  btn_2.appendChild(t_2);
  document.getElementById("ab").appendChild(btn);
  document.getElementById("ab").appendChild(btn_2);

//  Change color Character
var change_color = document.getElementById("ab");
change_color.innerHTML= change_color.innerHTML.replace(decodeURI("C%C3%92N"), "<span style='color:hahah;'>"+decodeURI("C%C3%92N")+"</span>");
change_color.innerHTML= change_color.innerHTML.replace(decodeURI("%C4%90%E1%BA%BEN"), "<span style='color:hahah;'>"+decodeURI("%C4%90%E1%BA%BEN")+"</span>");

 destination_url = "https://maps.google.com/?saddr=" + latitude_1+"," + longitude_1+"&daddr="+ store_lat+"," + store_lng;;
// });
}, 400);

  function trackClick(){
    createImgEl(click_client);
    createImgEl(click_v4);
    createImgEl(platform_macro);
    window.open(destination_url);
  }
  function createImgEl(src) {
    var img = new Image(1,1);
    img.style.display = 'none';
    img.src = src;
    document.body.appendChild(img);
  }
  createImgEl(imp_client);
createImgEl(imp_v4);

});
