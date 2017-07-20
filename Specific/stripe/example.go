func charge() {
	// Set your secret key: remember to change this to your live secret key in production
	// See your keys here: https://dashboard.stripe.com/account/apikeys
	stripe.Key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"

	// Token is created using Stripe.js or Checkout!
	// Get the payment token submitted by the form:
	token := r.FormValue("stripeToken")

	// Charge the user's card:
	params := &stripe.ChargeParams{
		Amount: 1000,
		Currency: "usd",
		Description: "Example charge",
	}
	params.SetSource(token)

	charge, err := charge.New(params)

}
