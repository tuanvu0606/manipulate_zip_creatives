
var imp_v4 = "";
var imp_client = "";

var click_v4 = "http://google.com";
var click_client = "";
var platform_macro = "";

var destination_url = "http://google.com";


function createImgEl(src) {
      var img = new Image(1,1);
      img.style.display = 'none';
      img.src = src;
      document.body.appendChild(img);
      console.log(src)
    }

createImgEl(imp_client);
createImgEl(imp_v4);

 var clickArea = document.getElementById('unique_animation_container');

 clickArea.onclick = function() {
     createImgEl(click_client);
     createImgEl(click_v4);
     createImgEl(platform_macro);
     window.open(destination_url);
 }

 