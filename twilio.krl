ruleset twilio {
  meta {
    name "Twilio Ruleset for CS462 Lab 7"
    description <<
      Twilio ruleset for CS462 Lab 7.
    >>
    key twilio {
      "account_sid" : "AC7ed04dfd322435aa694a06a9f4c0cace",
      "auth_token" : "6d19c3365cf6f25f583096251fa6f09f"
    }
    use module a8x115 alias twilio with twiliokeys = keys:twilio()
    logging off
  }
  
  global {
    to_phone = "8015104357";
    from_phone = "3852091029";
  }
  
  rule text_nearby is active {
    select when explicit location_nearby
    pre {
      message = "Checkin nearby: " + event:attr("dist") + " miles.";
      debug = to_phone + " " + from_phone + " " + message;
    }
    send_directive("text_nearby") with debug = debug;
    twilio:send_sms(to_phone, from_phone, message);
  }
  
  rule far_away is active {
    select when explicit location_far
    pre {
      message = "Checkin nearby: " + event:attr("dist") + " miles.";
      debug = to_phone + " " + from_phone + " " + message;
    }
    send_directive("far_away") with debug = debug;
  }
}
