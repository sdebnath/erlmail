# Introduction #

The gen\_store module is a generalize behavior that allows users to create their own message store to work the ErlMail email server. The idea is that you can create a message store to connect to any database, file system or any other way to store data and you do not need to recompile or change the ErlMail server in any way.

There are a few message stores that are being developed as part of the ErlMail server and are constantly changing. Currently the Mnesia Store is the most up-to-date version of an operational store.

After you have loaded ErlMail onto your Erlang server you can start to create you own message store by defining the gen\_store behavior in your code:

```
-behavior(gen_store).
```

This will require you to have certain functions defined for your module that will implement the message store behavior. Since gen\_store is still under development the functions required to create a message store are changing faster than it is reasonable to document them.