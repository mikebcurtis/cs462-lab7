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
}
