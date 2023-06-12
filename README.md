# Bmvp

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Run `mis assets.deploy` to prepare the assets for use
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

This projects needs PSQL database. You can also use docker for that:

  * Run `docker compose up -d` to create and run a detached temporary DB.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


# Testing billing

To test the a user buying an article, you need to:

  * `docker compose up -d`
  * `mix phx.server`
  * Run `ngrok http 4000` in a different terminal window.
  * Go to LemonSqueezy Webhooks section (with test mode enabled) and copy the Ngrok URL into the webhook. 
  * Sign up by creating an account.
  * Write an article using that account.
  * Go to `localhost:4000/u/UserHandler` where `{UserHandler}` is the handler for the user you just created. You can see/change the user handler in `Settings`.
  * Buy the article using card 4242424242424242. This is a test card. All other data is not relevant.
  * Once the purchase is complete check the email. If you used a fake email, check `http://localhost:4000/dev/mailbox/`. 
  * Click the given link. You should be able to see the article.

## Learn more

You can see the fully working webpage in `cashblog.org`.

About the course: 

  * https://pjullrich.gumroad.com/l/bmvp

About the tools used:

  * Free licensed pictures: https://undraw.co 
  * Free licensed icons: https://www.drawkit.com
  * Free components and templates: https://tailwindui.com
  * Free icons that come with Phoenix: https://heroicons.com/
  * ChatGPT for marketing: https://chat.openai.com
  * Free(ish) deployment for Elixir apps: https://fly.io
  * Database with Supabase: https://supabase.com/
  * Payment system with LemonSqueezy: https://app.lemonsqueezy.com/
  * Webhook sandbox testing with ngrok: https://ngrok.com/
  * Mailing system using Mailgun: https://www.mailgun.com/
  * Payed domain registration with Namecheap: https://www.namecheap.com/

About Phoenix:

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

To see emails received in test mode:

  * http://localhost:4000/dev/mailbox/