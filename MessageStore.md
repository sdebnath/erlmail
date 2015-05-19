# Introduction #

The ErlMail message store is a modular message store that allows end users to create store modules based on the [gen\_store](GenStore.md) behavior to implement any message store backend.

The [message store](MessageStore.md) server is used to handle all mailbox information for all of the components of ErlMail. This will allow for generalized functions that handle a large portion of the processing, and remove some of this processing from the user created store modules based on [gen\_store](GenStore.md).


## Mnesia ##

The message store will need a Mnesia database to coordinate the mailboxes that are open and active across the different distributed servers. This way one server will have the mailbox open and multiple clients on different nodes can have the mailbox in an active state. Only one node can have the mailbox in an open state, which is the state used to actually access and manipulate the mailbox. Multiple nodes can have the mailbox active and they interact with the node that has the mailbox open by passing messages to get information.

Mnesia is used solely to tell which nodes have mailboxes in either the open or active states. This database will be of a ram\_copies type and it will be replicated on each node running a message store. If no message store server is running then the database will be removed. Some database cleanup routine will be needed to check that entries in the database are still running.


## gen\_server ##

The gen\_server that will be running the message store on each node will accept messages via the handle\_info function on each server.

## Interface ##

The interface to the message store will be a set of functions to get and set information on the message store. The local message store will process these functions and send messages to the correct message store that has the mailbox open. If the mailbox is not open, then the local message store will open the mailbox.

A mailbox should be in the open state on one node for the entire duration that the mailbox is in a selected state on any node. If a mailbox is opened on Node A and then set to active on node B, when the mailbox is closed by the client on node A the mailbox should remain open until the mailbox is also closed on node b.



## design notes ##

At this point I'm mostly thinking out loud while typing in this entry. This will change dramatically before implementation.

The message server will only have a mailbox open on one node. All other nodes interested in the mailbox will mark it as active. Requests for information from the mailbox will be sent as a CALL to the open mailbox, no matter where the data is needed. The CALL is being used as most of these functions will need replies. This may change to a cast implementing an ETS table to track the request so that they can be replied to later.

The erlmail\_store will have functions exported that will allow all interaction with the store and many functions that will not be exported that will work with the internals of the message store and the other modules that actually implement the message store logic.

Currently the design is to move much of the processing from the modules back into erlmail\_store; this will make creating future store modules easier. This may be unreasonable, but it is a current design goal.



### non-blocking design ###

Thinking out loud about [TrapExit non-bocking app tutorial](http://trapexit.org/Building_Non_Blocking_Erlang_apps)

We have two nodes; NodeA has the mailbox open, NodeB has the mailbox active. When NodeB want to perform any actions on the mailbox a CALL will be sent to NodeA. NodeA will reply with a NOREPLY immediately allowing more messages to be processed. Transaction ID and From information will be stored on NodeA to reply to the CALL statement once the data is complete.



















