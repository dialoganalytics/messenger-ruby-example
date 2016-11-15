# Facebook Messenger Ruby Chatbot

An example Facebook Messenger Ruby chatbot integrated with [Dialog Analytics](https://dialoganalytics.com). Built with [hyperoslo/facebook-messenger](https://github.com/hyperoslo/facebook-messenger).

- [Dialog Documention](https://docs.dialoganalytics.com)
- [Dialog API reference](https://docs.dialoganalytics.com/reference)

## Getting started

Clone this repository and run `bundle install`

Create an account on https://app.dialoganalytics.com, grab your Dialog API token and bot ID.

Set environment variables in `.env`:

```
FACEBOOK_SECRET_TOKEN=...
FACEBOOK_ACCESS_TOKEN=...
DIALOG_API_TOKEN=...
DIALOG_BOT_ID=...
```

Gt your Facebook Messenger tokens at https://developers.facebook.com. Configure your application's webhook settings in the Facebook developer dashboard to the endpoint on which this server will be listening.

__Local development:__ When developping locally, use a service like https://ngrok.com to expose a server running on your machine. This should be something like `https://f562681e.ngrok.io/webhook`

```bash
$ ngrok http 4567
```

Start the bot:

```bash
$ bundle exec rackup -p 4567
```

Go on [messenger.com](https://www.messenger.com), find your bot and start interacting with it.

## Go further

Read more on how to make the most out of the possibilities offered by Dialog here: https://dialoganalytics.com
