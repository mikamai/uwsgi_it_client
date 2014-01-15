# UwsgiItClient

Ruby client for uwsgi.it API.

## Installation

Add this line to your application's Gemfile:

    gem 'uwsgi_it_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uwsgi_it_client

## Usage

Fist, create a `UwsgiItClient` instance with your account data:
```ruby
client = UwsgiItClient.new(
  username: 'kratos',
  password: 'deimos',
  url:      'https://foobar.com/api/me/'
)
```

Here are the mappings for the existing API calls:

#### List your data

```bash
curl https://kratos:deimos@foobar.com/api/me/
```

```ruby
client.me
```

####  Change company name

```bash
curl -X POST -d '{"company": "God of War 4 S.p.a."}' https://kratos:deimos@foobar.com/api/me/
```

```ruby
client.post :me, {company: 'God of War 4 S.p.a.'}
```

#### Change password

```bash
curl -X POST -d '{"password": "deimos17"}' https://kratos:deimos@foobar.com/api/me/
```

```ruby
client.post :me, {password: 'deimos17'}
```

#### List your containers

```bash
curl https://kratos:deimos17@foobar.com/api/me/containers/
```

```ruby
client.containers
```

#### Show a single container

```bash
curl https://kratos:deimos17@foobar.com/api/containers/30009
```

```ruby
client.container '30009'
```


#### List distros

```bash
curl https://kratos:deimos17@foobar.com/api/distros/
```

```ruby
client.distros
```


#### Set container distro

```bash
curl -X POST -d '{"distro": 2}' https://kratos:deimos17@foobar.com/api/containers/30009
```

```ruby
client.post :container, {distro: 2}, id: '30009'
```


#### Upload ssh keys

```bash
curl -X POST -d '{"ssh_keys": ["ssh-rsa ........."]}' https://kratos:deimos17@foobar.com/api/containers/30009
```

```ruby
client.post :container, {ssh_keys: ["ssh-rsa..."]}, id: '30009'
```


#### List domains

```bash
curl https://kratos:deimos17@foobar.com/api/domains/
```

```ruby
client.domains
```


#### Add domain

```bash
curl -X POST -d '{"name":"mynewdomain.org"}' https://kratos:deimos17@foobar.com/api/domains/
```
```ruby
client.post :domains, {name: 'mynewdomain.org'}
```


#### Delete domain

```bash
curl -X DELETE -d '{"name":"mynewdomain.org"}' https://kratos:deimos17@foobar.com/api/domains/
```
```ruby
client.delete :domains, {name: 'mynewdomain.org'}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request




