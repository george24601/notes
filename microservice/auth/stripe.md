support cross-origin resource sharing, allowing you to interact securely with our API from a client-side web application (though you should never expose your secret API key in any public website's client-side code

To make the API as explorable as possible, accounts have test mode and live mode API keys. There is no "switch" for changing between modes, just use the appropriate key to perform a live or test transaction.

You can manage your API keys in the Dashboard

Calls made over plain HTTP will fail. API requests without authentication will also fail.

The first, preferred, authentication option is to use your—the platform account’s—secret key and pass a Stripe-Account header identifying the connected account for which the request is being mad


