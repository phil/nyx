nyx
===

nyx is a message based reactor bot. Nyx will listen or poll various sources and
and act upon the messages received. 


Requirements
------------

- Ruby 2
- MongeoDB

See the Gemfile for Ruby dependencies


Installing
----------

rake install


Running
-------

Nyx is runs as a single binary. There is a Foreman Procfile available that includes

To run Nyx on port 5005:

`bundle exec ruby main.rb -p5005`


Connecting to Nyx
-----------------

Use telnet to test that nyx is up and running:

`telnet localhost 5005`

Then send a message

`ping`

  PONG!


Tests
-----

To run the test suite

`bundle exec rspec spec`

the nyx test suite uses em-spec to wrap each test in an eventmchaine

How Nyx Works
-------------

Nyx uses Rubies Eventmachine to handle messages asyncronously. When a new
message is created in the system, it is passed to all subsystems that match,
each of these system can then respond to the message, or create another new
message. 

Roadmap
-------

Nyx is an ongoing project. Hopefully future versions will have bigger and better
subsystems for handling messages, as well as better envirnment and world
knowledge.
