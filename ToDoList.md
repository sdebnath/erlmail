# Introduction #

This is an ongoing list of items that I intend to work on to make ErlMail better or in some cases just plain work.


# Details #

ErlMail General To-Do List
  * Shutdown server in XX minutes
  * impliment change\_code funcations to load new code when needed
  * Check for access to config file on startup
  * move to\_lower\_atom/1 funcations into erlmail\_util module and redirect funcations calls
  * create erlmail\_app file that starts the correct servers and the message store; relocate message store startup from imapd\_app
  * move split\_at/1-2 funcation to erlmail\_util and remove other random refernces (imapd\_util)
  * move unquote/1 funcation to erlmail\_util and remove otehr refernces (imapd\_util)

SMTPD To-Do List:
  * Create multiple respones on EHLO command using extentions
  * Impliment Relay controls and mail queue for sending mail
  * rework command file to include errors for commands that are out of sequence.

SMTPC:
  * create way for sendmail funcation to do DNS lookup on hostname instead of requiring IP Address
  * create way for sendmail funcaiton to do MX record lookup on email address
  * create relay path for sending mail

IMAPD To-Do List
  * See [IMAP Implementation Notes](IMAPImplementation.md)
  * Make sure that the mailbox name is the same with and without the heirachy character on the end.
  * Look into simplifing the responses in the IMAPD\_CMD file. Many of these have very simplar patterns
  * Check status of imap\_capbility\_greeting setting in config file. Did not work last time it was tested
  * Create a function that detects and remvoes doubles quotes on a string, but only if the are the first and last characters in the string
  * UID parse fails gracefully
  * seq\_to\_list with wildcards
  * convert untagged messages to flow through #imapd\_fsm.response. Attach new mail process through #imapd\_fsm.response. Process all untagged messages on certain commands, especialy NOOP
  * create an IMAPD\_RESP or IMAPD\_MAILBOX gen\_server that will monitor actions on mailboxes and provide respones when satus is changed. This way when multiple clients have hte same mailbox open they can receive status changes. This will also allow for new messages to be devlivered by SMTP to trigger a response for the specific client.
  * Store UIDValidity for deleted fodlers inteh user store, under options upon deletion. Check the user store before creating a new folder for older references to the deleted folder. Increment the UIDValidy by 1 and remove reference once created.
  * remove user from FSM
  * remove mailbox information from FSM

IMAPC To\_Do list
  * Check to see if encoding of fetch command properly encodes "1" vs [1](1.md) for the seq set

MIME To-Do List
  * Encode a tree of #mime{} records into an email message
  * Change header split command account for a \t (and other whitespace) after the :
  * get section based on position [.md](.md);[0](0.md);[0,0] = root
  * work on encode/decode to allow for mutliple TO, CC and BCC to be presented as a list of address strings
  * need funcation to split address list in To,CC,BCC fields so that the comma (,) is use only if not in double quotes (")

Message Store / GEN\_STORE
  * check for access to message stores on startup
  * modify SELECT to access a #mailbox\_store{} record and return the most current version of that #mailbox\_store{}. Refactor with new syntax.
  * add funcations for select, insert and update (maybe more) into gen\_store that will take the state and determine the correct store aand then call the correct function from there. re-factor code to use gen\_store:Funcaiont/2 instead of Store:Function/1
  * user module\_info/0 to verify that the gen\_store behavior is defined




