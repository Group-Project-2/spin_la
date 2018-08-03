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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

//set default degree (360*5)
var degree = 1800;
//number of clicks = 0
var clicks = 0;
var map;
var marker;
var infowindow;
var next = { lat: 3.135687, lng: 101.629791 };

function initMap() {

	map = new google.maps.Map(document.getElementById("map"), {
		center: {
				lat: 3.135687,
				lng: 101.629791
		},
		zoom: 18,
		styles: styles,
		mapTypeControl: false,
		streetViewControl: false,
		fullscreenControl: false
	});

	marker = new google.maps.Marker({
		position: next,
		map: map,
		icon: "https://mt.googleapis.com/vt/icon/name=icons/onion/169-ltblue-dot.png",
		animation: google.maps.Animation.DROP,
		title: "Next Academy"
	});

	infowindow = new google.maps.InfoWindow({
		content: "Next Academy Is Here!"
	});

	marker.addListener("click", function() {
		infowindow.open(map, marker);
	});

}

$(document).ready(function(){

	// var navbar = document.querySelector(".navbar");
	// var navlist = document.querySelectorAll(".navbar-links");
	// var count = document.querySelector("#spins-left");

	// window.onscroll = function() {
	// 	if (window.pageYOffset > 80) {
	// 		console.log("Yes");
	// 		navbar.classList.add("bg-light");
	// 		count.style.color = "black";
	// 		navlist.forEach(function(link) {
	// 			link.style.color ="black";
	// 		});
			
	// 	} else {
	// 		console.log("No");
	// 		navbar.classList.remove("bg-light");
	// 		count.style.color = "#fff";
	// 		navlist.forEach(function(link) {
	// 			link.style.color = "#fff";
	// 		});
			
	// 	}
	// }
	
	/*WHEEL SPIN FUNCTION*/
	$('#spin').click(function(){
		
		//add 1 every click
		clicks ++;
		
		/*multiply the degree by number of clicks
	  generate random number between 1 - 360, 
    then add to the new degree*/
		var newDegree = degree*clicks;
		var extraDegree = Math.floor(Math.random() * (360 - 1 + 1)) + 1;
		totalDegree = newDegree+extraDegree;
		
		/*let's make the spin btn to tilt every
		time the edge of the section hits 
		the indicator*/
		$('#wheel .sec').each(function(){
			var t = $(this);
			var noY = 0;
			
			var c = 0;
			var n = 700;	
			var interval = setInterval(function () {
				c++;				
				if (c === n) { 
					clearInterval(interval);				
				}	
					
				var aoY = t.offset().top;
				$("#txt").html(aoY);
				// console.log(aoY);

				
				/*23.7 is the minumum offset number that 
				each section can get, in a 30 angle degree.
				So, if the offset reaches 23.7, then we know
				that it has a 30 degree angle and therefore, 
				exactly aligned with the spin btn*/
				if(aoY < 23.89){
					// console.log('<<<<<<<<');
					$('#spin').addClass('spin');
					setTimeout(function () { 
						$('#spin').removeClass('spin');
					}, 100);	
				}
			}, 10);

			
			$('#inner-wheel').css({
				'transform' : 'rotate(' + totalDegree + 'deg)'			
			});
		 
			noY = t.offset().top;
			
		});

		// $('#no_win').text("<%= flash[:notice] %>").delay( 2000 );
		// $('#no_spin').text("<%= flash[:alert] %>").delay( 2000 );
		// $('#spin_win').text("<%= flash[:success] %>").delay( 2000 );
		// $('#spin_lose').text("<%= flash[:error] %>").delay( 2000 );
		
	});

});//DOCUMENT READY
