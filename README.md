# Webhook-king


This website is a receive webhook and can show the detail.


# Running

Running the app finally

```bash

cd webhooking
bundle install
yarn install
cp .env.template .env
# and then change .env configurations for you
rails db:migrate
rails db:seed
rails server
# or foreman -f Profile
```