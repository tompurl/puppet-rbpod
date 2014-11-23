# rbpod Puppet Module

This is a fairly simple "meta-module" that installs a bunch of other modules.
The end goal is to create a "appliance" that you can use for cheap and easy
remote backups. More information can be found [here](http://rbpod.tompurl.com "Rbpod home page").

## Quick Start

You can start with one of the following:

* A vanilla Raspberry Pi on which you've installed Raspbian and created a user id.
* A VPS system somewhere
* Anything really running Debian and not much else.

Next you need to download the module and put it in your "modules" folder. You
can download the [package from the Puppet Forge](https://forge.puppetlabs.com/tompurl/rbpod) 
or clone the git repository like so:

    $ git clone https://github.com/tompurl/puppet-rbpod.git rbpod

Add this to your manifest:

    class { 'rbpod' :
      alert_address           => "me@somewhere.com",
      rbpod_domain            => "somewhere.com",
      smtp_host               => "smtp.mandrillapp.com",
      smtp_port               => 587,
      smtp_user_name          => "me@somewhere.com",
      smtp_password           => "somethingSuperClever",
      monit_web_user_name     => "admin",
      monit_web_password      => "monit",
      timezone                => "America/Chicago",
      ssh_port                => 22,
      ssh_keypair_name        => "Something for you",
      ssh_keypair_key         => "somethingVeryCleversomethingVeryCleversomethingVeryCleversomethingVeryClever==",
      ssh_keypair_target_user => "pi",
      host_login_name         => "pi",
      btsync_web_ip           => "0.0.0.0",
      btsync_web_port         => "8888",
      btsync_web_login        => "admin",
      btsync_web_password     => "hopefullySomethingSuperClever",
      harden_sudo             => "true", 
    }

This will provision your entire system. Check out the Tests section below to
see what you need to do next. Also, I know this is a ton of parameters and
those are also explained below.

## Tests

Once the system is provisioned you'll need to test a few things. 

### Monit Email

First, you should start receiving email from ``monit`` after a few minutes.
This will tell you things like "monit is running" and "tor is not running" and
such. Don't worry too much about error notifications from ``monit`` at this point.
Within 5 minutes of your first few messages you should get messages telling you
that everything is up. 

### Mail Transfer Agent

However, while you're waiting for that, let's ssh into the system and see if
you can send mail from the command line. Try running the following command
from your provisioned system:

    $ echo "hello from rbpod" | mail -s "Rbpod test" me@somewhere.com

You shouldn't get any error messages when you execute this command and within
five minutes you should see something in your inbox.

These should also work:

    $ echo "hello from rbpod" | mail -s "Rbpod test" pi
    $ echo "hello from rbpod" | mail -s "Rbpod test" root

This tests that mail sent to a local account is forwarded to
``me@somewhere.com``. Also, please note that you should replace ``pi`` with the
account name that you use to log into your appliance.

#### Email Security Note

Please note that I don't recommend using your regular, personal email account
credentials with the following parameters:

* ``smtp_host``
* ``smtp_user_name``
* ``smtp_password``

I say this because this module will make your system reachable by the public
internet. If someone cracks your appliance then they would also be able to 
access your personal email account. 

I therefore **highly** recommend using some sort of smtp-as-a-service
application like [Mandrill](http://mandrillapp.com "Mandrill login page"). 
Trust me, it's **so** much better than the alternative.

## Monit Web

The web interface to **not** designed to be accessed over the public internet.
Therefore, it only listens on port the loopback interface (127.0.0.1). To view
this interface you therefore need to use the console-based web browser
``elinks``. First, ssh into your appliance and the execute the following
command:

    $ elinks http://localhost:2812
    # username => admin, pass => monit    

You can change the username and password by setting the following parameters:

* ``web_username``
* ``web_password``

## Tested Platforms

Debian 7 on x64 and Raspbian. No effort has yet been made to make it work with
anything else.

## rbpod class parameters

### alert_address

This is the address that will receive all email messages from ``monit`` and any
cron jobs. This should be an account that you check on a regular basis.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### rbpod_domain

This should be the domain name of your email address. So if your email address
is "me@foo.com" then this should be "foo.com". Or maybe something else, who knows?
Every email provider seems to handle stuff like this differently.

We need this value so that your SMTP provider (e.g. mandrill) will trust your
mail sent by the ``nullmailer`` client and actually send it's mail. 

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### smtp_host

This is the host name of your SMTP server.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### smtp_port

The port name for your SMTP server.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### smtp_user_name

The user name for your smtp service.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### smtp_password

The password that goes with the ``$smtp_user_name`` value.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### monit_web_user_name

This is the user name that you want to use to access the monit
web interface.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### monit_web_password

This is the password that you want to use with the ``$monit_web_user_name``
valui.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### timezone

This is your timezone value. An example would be "America/Chicago".
Please note that this is the value where your appliance **is**, not
where **you are**.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### ssh_port

The port that you want SSH to listen on. I default to a non-standard
value for added security.

* Required?
    * True
* Data Type
    * String
* Default Value
    * 9000

### ssh_keypair_name

This value is used with ssh keypair auth, and it is associated with
the public key that you specify. In reality, it can be almost any
string - it just has to make sense to you.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### ssh_keypair_key

This is the public key that you will use to log into your
appliance.  Please note that this should be a string with
**no spaces**. This means that you **don't** have to
include the ``ssh-rsa`` or ``user@host`` portions.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### host_login_name

This should be the "regular" user account that you use to log
into your appliance. For example, if you installed this on a 
Raspberry Pi system running Raspbian, then this value would be
"pi". 

This value is used to configure both btsync and ssh keypair auth.

**Please note** that you should not set this value to ``root``.
It will cause unexpected results. Also please note that you 
should probably not allow root connections to your ssh server.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### btsync_web_ip

This is the IP address that the Btsync web application will
listen on. 

**Please note** that by default this value is ``0.0.0.0``, which 
means that anyone can connect to it. This is useful when you are
initially setting up your device but a bad idea once everything
is configured because this web interface is lacking the following:

* HTTPS
* Hardened security code

After you are done setting up all of your btsync shares, you should
change this value to something like 127.0.0.1. You should only change
it back to something publicly accessible if you need to make a change
to one of your shares.

Also, please note that the btsync web interface does not seem to work
with any console-based web browser that I was able to find. So that
sucks. Also, it appears to be a royal pain in the butt currently to 
set up the web client to use HTTPS. So that sucks too.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### btsync_web_port

TODO

* Required?
    * True
* Data Type
    * String
* Default Value
    * 0.0.0.0

### btsync_web_login

The id that you would like to use to log into the btsync web app.

* Required?
    * True
* Data Type
    * String
* Default Value
    * admin

### btsync_web_password

The password that you would like to use with the
``$btsync_web_login`` id.

* Required?
    * True
* Data Type
    * String
* Default Value
    * (None)

### harden_sudo

Whether or not you would like to make it a little hard to escalate
privileges on your machine using sudo. Ideally, you would set this
to "true" but on some systems (like Vagrant VM's) it will break things.

* Required?
    * True
* Data Type
    * String
* Default Value
    * true
