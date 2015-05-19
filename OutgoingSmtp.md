# Overview #

The SMTP client that is built into ErlMail is capable of sending message to another SMTP server, so the basic construct of sending mail is already in place.

The SMTP server is capable of receiving email for an email address that is listed in the Users and Domains message store, so the basic receiving constructs are already in place.

What needs to be accomplished is building a system where certain computers, either clients or other servers, can send SMTP message to an instance of ErlMail by means of some sort of authentication. Those message would be for users that most likely are not in the Users or Domain message stores. The two most common forms of authentication would be IP address based or user authentication based; initially IP address based authentication will be used.

Once those messages are received they will need to be forwarded to a different SMTP server. In the mean time they will be stored in the Message store and have some META data attached to them. Most notably they will track the number of tries and the time of the most recent try.

A server process will be to be run to find out when messages need to be sent or retried. This will most likely be called the SMTP queue and it will be run as a process under the SMTP supervisor. The process will be notified of a new message and it will retry immediately, Otherwise it will retry messages every X minutes.

A lock will need to be placed on a message as it is being sent by a sending process. This is to prevent another sending process on a different server from trying to send the same message. This will be crucial in a distributed environment with multiple outgoing SMTP servers.

The message name in the message store will be {MessageName,#outgoing\_smtp{},NextRetryTimeStamp}. This follows the tuple with three elements for the name of the messages in the rest of the message store, it also allows for a record of #outgoing\_smtp{} to easily find the messages in the message store and it has a way to keep information about the last attempt, number of tries or any other information about the outgoing smtp process. Finally the NextRetryTimeStamp lets the servers easily filter the list to only message that need to be retried.

## Process Overview ##

  * modify SMTP server to allow messages from known IP addresses even if they are not for any users on the system
  * add message store function to insert message into outgoing queue
  * create SMTP server process to control outgoing messages
  * Integrate SMTP client into outgoing server process.
  * modify messages in message store on failure: delete message with error message or update retry information

## configuration settings ##

  * server\_smtp\_relay\_clients: Default [.md](.md) or none. This setting allows users to set IP addresses that are used to relay email messages through this SMTP server as an outgoing server. This is a list of tuples that are in the form of {IP\_Tuple,CIDR} or {{10,0,0,0},8}. Since the Default is [.md](.md), by default the server is a closed relay and needs a configuration file to allow any IP addresses to send outgoing email.
  * server\_smtp\_retries: Default 10. This is the number of retries the SMTP will attempt before failing the message. A retry count of 0 will never retry the message and fail after the initial attempt.
  * server\_smtp\_retry\_interval: Default [15,30,60,240]. This is a list of integers that is the number of minutes between each retry. The final retry interval in the list will be used for any number of retries after the list is complete. By default the first retry is 15 minutes after the initial sending of the message. The second retry is 30 minutes after the first, the third is 60 minutes after the second and the fourth is 240 minutes after the third. Since the default number of retires is 10 each subsequent retry will be 240 minutes after the previous for a grand total of 1,785 minutes or 29.75 hours.
  * server\_stmp\_failure\_notification: default true. This setting allows the SMTP server to send email notifications on failure or success to the sender of the email message. If this is set to false no email notification will be generated.




## Task List ##
  * Create way to identify valid relay IP addresses through config files - done
  * Check for valid relay IP address as the FSM is created - done
  * add new code into RCPT to allow non-local addresses when relay = true
  * add new code to store message in message store with relay information
  * create smtpd\_queue gen\_server to check queue status on set basis
  * use smtpd\_queue server to send email via SMTPC





















