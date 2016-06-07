# Facebook Messenger Ruby Bot

An example facebook messenger ruby bot with [Dialog Analytics](https://dialoganalytics.com) integration. Built with [facebook-messenger](https://github.com/hyperoslo/facebook-messenger).


## Getting started

Configure the bot with your credentials in `.env`:

```
FACEBOOK_SECRET_TOKEN=...
FACEBOOK_ACCESS_TOKEN=...
DIALOG_TOKEN=...
```

Start the bot:

```bash
$ bundle exec rackup
```

In development, start a local tunel and configure your application's webhook settings in the facebook developer dashboard:

```bash
$ ngrok http 9292
```


Go on [messenger.com](https://www.messenger.com), find your bot and start interacting with it.
