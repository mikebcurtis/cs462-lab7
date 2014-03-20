ruleset foursquare_gps {
	meta {
		name "Foursquare GPS"
		description <<
			Interacts with the GPS coordinates of Foursquare checkins.
		>>
		author "Mike Curtis"
		logging off
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
	}
	dispatch {
	}
	global {
	}
  
	rule show_fs_location is active {
		select when web cloudAppSelected
		pre {

			my_html = <<
			        <h5>Venue: #{venue}</h5>
			        <h5>City: #{city}</h5>
			        <h5>Shout: #{shout}</h5>
			        <h5>CreatedAt: #{createdAt}</h5>
			>>;
		}
		{
			SquareTag:inject_styling();
			CloudRain:createLoadPanel("CS 462 Lab 7: Semantic Translation", {}, my_html);
		}
	}
}