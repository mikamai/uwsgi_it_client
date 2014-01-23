# UwsgiItClient

Ruby client for uwsgi.it API. Now with a command line tool out of the box.

## Installation

Add this line to your application's Gemfile:

    gem 'uwsgi_it_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uwsgi_it_client

## Usage

After install you can run it with the CLI executable `uwsgi_client` or using the ruby API.

### CLI interface
CLI requires username, password and url to be provided inline with the command unless you provide
a configuration file. You can create this file in the current directory or in your home directory.
The file must be named `.uwsgi_it_client.yml` and should read like the following example:
```yaml
  username: kratos
  password: deimos
  url:      https://foobar.com/api
```
If both files exist (one in the home directory and one in the current directory) then the one in
your current directory will have precedence.


### Ruby API

To use the API, create a `UwsgiItClient` instance with your account data:
```ruby
client = UwsgiItClient.new(
  username: 'kratos',
  password: 'deimos',
  url:      'https://foobar.com/api/'
)
```

Here are the mappings for the existing API calls and CLI commands:

#### List your data

```bash
# Plain Usage
curl https://kratos:deimos@foobar.com/api/me/
```

```ruby
# Ruby Client
client.me
```

```bash
# CLI
uwsgi_client me -u=kratos -p=deimos -a=https://foobar.com/api

# CLI with configuration file
uwsgi_client me
```


####  Change company name

```bash
# Plain Usage
curl -X POST -d '{"company": "God of War 4 S.p.a."}' https://kratos:deimos@foobar.com/api/me/
```

```ruby
# Ruby Client
client.post :me, {company: 'God of War 4 S.p.a.'}
```


#### Change password

```bash
# Plain Usage
curl -X POST -d '{"password": "deimos17"}' https://kratos:deimos@foobar.com/api/me/
```

```ruby
# Ruby Client
client.post :me, {password: 'deimos17'}
```


#### List your containers

```bash
# Plain Usage
curl https://kratos:deimos17@foobar.com/api/me/containers/
```

```ruby
# Ruby Client
client.containers
```

```bash
# CLI
uwsgi_client containers -u=kratos -p=deimos17 -a=https://foobar.com/api
```


#### Show a single container

```bash
# Plain Usage
curl https://kratos:deimos17@foobar.com/api/containers/30009
```

```ruby
# Ruby Client
client.container 30009
```

```bash
# CLI
uwsgi_client containers 30009 -u=kratos -p=deimos17 -a=https://foobar.com/api
```


#### List distros

```bash
# Plain Usage
curl https://kratos:deimos17@foobar.com/api/distros/
```

```ruby
# Ruby Client
client.distros
```

```bash
# CLI
uwsgi_client distros -u=kratos -p=deimos17 -a=https://foobar.com/api
```


#### Set container distro

```bash
# Plain Usage
curl -X POST -d '{"distro": 2}' https://kratos:deimos17@foobar.com/api/containers/30009
```

```ruby
# Ruby Client
client.post :container, {distro: 2}, id: 30009
```


#### Upload ssh keys

```bash
# Plain Usage
curl -X POST -d '{"ssh_keys": ["ssh-rsa ........."]}' https://kratos:deimos17@foobar.com/api/containers/30009
```

```ruby
# Ruby Client
client.post :container, {ssh_keys: ["ssh-rsa..."]}, id: 30009
```


#### List domains

```bash
# Plain Usage
curl https://kratos:deimos17@foobar.com/api/domains/
```

```ruby
# Ruby Client
client.domains
```

```bash
# CLI
uwsgi_client domains -u=kratos -p=deimos17 -a=https://foobar.com/api
```


#### Add domain

```bash
# Plain Usage
curl -X POST -d '{"name":"mynewdomain.org"}' https://kratos:deimos17@foobar.com/api/domains/
```

```ruby
# Ruby Client
client.post :domains, {name: 'mynewdomain.org'}
```


#### Delete domain

```bash
# Plain Usage
curl -X DELETE -d '{"name":"mynewdomain.org"}' https://kratos:deimos17@foobar.com/api/domains/
```

```ruby
# Ruby Client
client.delete :domains, {name: 'mynewdomain.org'}
```


## High level syntax

Post and delete calls are by default low level, if you want the nicer syntax you need to extend your client with `ClientHelpers` module:

```ruby
client.extend UwsgiItClient::ClientHelpers

client.company = 'Umbrella Corp.'

client.password = 'secret'

client.set_distro 3, 30009

client.add_key 'ssh-rsa...', 30009

client.add_keys ['ssh-rsa...', '...'], 30009

client.add_domain 'mynewdomain.org'

client.delete_domain 'mynewdomain.org'
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request




