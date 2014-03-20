ruleset foursquare_gps {
	meta {
		name "Foursquare GPS"
		description <<
			Interacts with the GPS coordinates of Foursquare checkins.
		>>
		author "Mike Curtis"
		logging off
		use module b505198x5 alias LocationData
	}
	dispatch {
	}
	global {
		threshold = 5;
		calc_dist = function(lat1, lng1, lat2, lng2) {
			r90 = math:pi()/2;
			radiusEarth = 3959;
			
			rlat1 = math:deg2rad(lat1);
			rlng1 = math:deg2rad(lng1);
			rlat2 = math:deg2rad(rlat2);
			rlng2 = math:deg2rad(rlng2);
			
			math:great_circle_distance(rlng1, r90 - rlat1, rlng2, r90 - rlat2, radiusEarth);
		};
	}
	
	rule semantic_translation is active {
		select when location new_current
		pre {
			lat = event:attr("lat");
			lng = event:attr("lng");
			checkin = LocationData:get_location_data("fs_checkin").decode();
			f_lat = checkin.pick("$..lat");
			f_lng = checkin.pick("$..lng");
			dist = calc_dist(lat, lng, f_lat, f_lng);
		}
		if(dist <= threshold) then noop();
		{
			send_directive("semantic_translation") with dist = dist and lat = lat and lng = lng and f_lat = f_lat and f_lng = f_lng;
		}
		fired {
			raise explicit event location_nearby with dist = dist;
		}
		else {
			raise explicit event location_far with dist = dist;	
		}
	}
}
