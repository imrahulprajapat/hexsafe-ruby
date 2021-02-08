# Hexsafe Ruby

Simple Ruby client for the [Hexsafe](https://api.hexsafe.io/hexsafe/swagger#section/API-Guide) API.

## Setup

Simply using rubygems:

    gem install hexsafe

### For Rails apps

Add this line to your application's Gemfile:

```ruby
gem 'hexsafe'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ git clone https://github.com/imrahulprajapat/hexsafe-ruby.git
$ cd hexsafe-ruby
$ bundle
$ gem build hexsafe.gemspec
$ gem install hexsafe-0.0.0.gem
```

## Initializing a client

If you want to call Hexsafe Apis, which is normally what you want to do, it's as simple as:
```ruby
    hex_safe = Hexsafe::Api.new(env: "Test", key: "your-api-key", secret: "your-key-secret")
```
```bash
env: Envoirments i.e Test, Main
key: api key, will get when you create a account on hexsafe
secret: your secret when you create a account on hexsafe
 ```

## Hexsafe's documentation

For more information check the API docs at:

### To Get Account Details
#### All accounts
```ruby
hex_safe.get_accounts
```
#### To Get specific account
```ruby
hex_safe.get_account account_id
 ```
### To Get Balance
#### By account_id
```ruby
hex_safe.get_balance account_id
```
### To Get Transaction
#### By tx_id
```ruby
hex_safe.get_txn ticker, tx_hash
```
```bash
ticker: i.e BTC, ETH
tx_hash: "transaction_id"
```
#### By account_id and timer
```ruby
hex_safe.get_txn_ac account_id, start_time, end_time
```
### Deposits
#### Create Deposits
```ruby
hex_safe.create_deposit body
```
```bash
body = {"account_id": 1028, "wallet_name": "test-wallet", "asset_ticker": "ETH", "quantity": 1.5, "memo": "string", "note": "string"}
```
#### Cancel Deposits
```ruby
hex_safe.cancel_deposit request_id
```
#### Get Deposit by request id
```ruby
hex_safe.get_deposit request_id
```
### Withdrawls
#### Create Withdrawls
```ruby
hex_safe.create_deposit body
```
```bash
body = {"quantity": 1.5, "memo": "string", "note": "string", "account_id": 1028, "asset_ticker": "ETH", "wallet_name": "test-wallet", "to_address": "0x8CfbA3Cd46fB7136Fc04c6B863bCbcb6d5FDb6DA", "fee_price": 75, "fee_limit": 21000}
```
#### Cancel Withdrawls
```ruby
hex_safe.cancel_withdraw request_id
```
#### Get Deposit by request id
```ruby
hex_safe.get_withdraw request_id
```

### Webhook
#### Subscribe Webhook
```ruby
hex_safe.subscribe_webhook body
```
```bash
body = {"url": "https://localhost/callback_url/","account_id": 2,"wallet_type_id": 3, "asset_ticker": "ETH" }
```
#### Get your subscriptions
```ruby
hex_safe.get_subscriptions account_id
```
#### Cancel your subscriptions
```ruby
hex_safe.delete_subscription uuid
```


## Development
- To generate api token you need to discuss with hexsafe support.

## Contributors

https://github.com/imrahulprajapat
