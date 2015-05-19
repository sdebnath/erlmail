# Introduction #

ErlMail has several configurable settings that may be changed by the user using the standard OTP process for configuration. Please read the [Design Principles](http://www.erlang.org/doc/pdf/design_principles.pdf) documentation and pay close attention to the section on 'Configuring an Application'.

Each of the configurable parameters is setup as a tuple that looks like {Parameter, Value}. There are a few that have default values in the erlmail.app file that is located in the ebin directory, some of them have default values that are contained within the code. This is usually done to ensure that the parameter has a valid value even if the user does not give one.

# Configuration Parameters #

## server\_list ##
Default: [smtp,imap,pop]
This parameter is used to list the servers that are going to potentially be started by ErlMail. This should NOT be overridden by the user.

## server\_smtp\_start ##
Default:false

This parameter determines if the SMTP server will be started when the ErlMail application is started. The default is false; which will not start the SMTP server. This should be overridden by the user by setting this value it true.

## server\_smtp\_name ##
Default: "smtp.erlsoft.net"

This is the name the email server will use when identifying itself to other email servers. The user is encouraged to change this setting to something more meaningful to their installation.

## server\_smtp\_port ##
Default: 25

This is the TCP port that the server will initially start listening on.

## server\_smtp\_max\_connections ##
Default: 25

This is the maximum number of concurrent connections on an individual server node. This setting is not currently in use.

## server\_smtp\_greeting ##
Default: "ErlMail http://erlsoft.org (NO UCE)"

This defines the text that the email server will present to a client when the client initially creates a connection. Users are encouraged to change this to something more meaningful to their own installation.



## server\_imap\_start ##
Default:false

This parameter determines if the IMAP4 server will be started when the ErlMail application is started. The default is false; which will not start the IMAP4 server. This should be overridden by the user by setting this value it true.







## server\_pop\_start ##
Default:false

This parameter determines if the POP# server will be started when the ErlMail application is started. The default is false; which will not start the POP3 server. This should be overridden by the user by setting this value it true.