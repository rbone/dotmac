# Dotmac

A little collection of scripts and config I use to setup and work with my mac.

## Setup

To get started clone and run the setup script

```
git clone git@github.com:rbone/dotmac.git <your_desired_location>
<your_desired_location>/setup.sh
```

This will by default not install any of the included packages. To add them,
once installed (in a fresh terminal), use the `mac` command. E.g.

```
mac install git
mac install vim
mac install ruby
```

This will run those packages install scripts, and if they have an `init.sh`
script it will add that to the standard terminal init process.

## Why Use This?

I wouldn't recommend anyone use this except for myself. I built it not
because I felt I knew better than all the various tools others have created,
but rather that the experience of building it and knowing every detail of how
my machine was configured was more valuable.
