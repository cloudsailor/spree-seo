# Spree Seo

**Spree SEO** is a plugin to extend SEO capabilities.

## Getting Started

Add spree-seo to your Gemfile and run bunddle install:

```sh
gem 'spree-seo'
```

Next, you need to run the generator to create the migrations:

```console
rails generate spree:seo:install
```

Then run `rails db:migrate` so the migrations can take effect

```console
rails generate spree:seo:install
```

Lastly, you need to mount the engine in `config/routes.rb` so routes can become available:

```code
mount Spree::Seo::Engine, at: '/'
```
s
You should restart your application after these updates. Otherwise, you will run into strange errors, for example, route helpers being undefined.
