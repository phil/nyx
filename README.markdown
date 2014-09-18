# Nyx

Nyx was an evented, reactor based, messaging system. The system will react to
events gathered online and report back to the user.

Nyx should not be seen just as a chat bot, think more of Nyx as a person bot,
that provides useful dashboard like information. 

## Project features

The Core of nyx will be a plugin system. each plugin will be responsbile for
listening to internal messages within the nyx system. Plugins will also be
responsible for the send/receiving of external messages.

### Instant messaging

- Campfire: Listen and respond to user input
- Hipchat: Listen and respond to user input
- Twitter: Listen and respond to user input


### User Interface

- Web interface


### Other

- IMAP Inbox checking


## Running

  ./bin/nyx.rb

## Development

Nyx is being built completely in the open, please read/copy/contribute as you
wish


## Testing

TOOD: writes tests


## Production

Nyx should be easily deployable to cloud solutions such as Heroku of Ninefold,
as well as run on any virtual server. To handle this, a single process, exposing
a single port. 
