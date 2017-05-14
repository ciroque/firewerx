# Firewerx

Proof of Concept service running on a Raspberry Pi that can control LED's via GPIO and I2C protocol.

#### Setting up the Raspberry Pi

Install the things

##### Erlang and Elixir

```bash
sudo vi /etc/apt/sources.list
```

append the following to the file:

```bash
deb http://packages.erlang-solutions.com/debian wheezy contrib
```

Import the public key:

```bash
wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc
sudo apt-key add erlang_solutions.asc && rm erlang_solutions.asc
```

Install:

```bash
sudo apt-get update
sudo apt-get install -y erlang
sudo apt-get install -y elixir
```

Configure the host

##### Environment

Create a file called `firewerx-env.sh` in `/etc/profile.d/` and add the following content

```bash
#!/bin/sh

export MIX_ENV=prod

```

This will set up the environment variables used by the service.

##### Build

The service must be built using the same OS as that on which it will run (Raspbian in the default case).

1. ssh to the Raspberry Pi
 
1. Clone the repo from github:

    `git clone https://github.com/ciroque/firewerx.git`
    
1. Get the dependencies:

    `mix deps.get`
    
1. Compile the dependencies:

    `mix deps.compile`
    
1. Create the release:
 
    `mix release`
    
    
References: 
 - http://www.phoenixframework.org/v0.6.2/docs/deployment
 
##### Run

`PORT=808 rel/firewerx/bin/firewerx start`

confirm the service is running...

`rel/firewerx/bin/firewerx ping` should return "pong"

`curl http://localhost:808/ping` should return "pong"

also ensure the service can be called from a remote host.
 
### Stage One
A Phoenix service installed and responding to /ping endpoint

### Stage Two
Service blinks an LED while running

Use Periodic Actor ([example](https://gist.github.com/trestrantham/24f0892f2f6881474314))

Use [elixir_ale](https://github.com/ciroque/elixir_ale) for GPIO functions

### Stage Three
Endpoint can manipulate a second LED

HTTP POST /led 

on / off in body (some structured data)

### Stage Four 
Endpoint can cycle between various patterns on Pixel Matrix

HTTP POST /matrix

{ pattern: n }

### Stage Five
Endpoint accepts 8x8 matrix to determine set display state

HTTP POST /matrix/raw

[ [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 1 ]]
