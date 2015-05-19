# Introduction #

For anyone who has been following the project for very long you will know that I think the FETCH command is overly complicated and could have been separated into several commands that would have made the IMAP protocol much easier to implement. All ranting aside the FETCH command does what it needs to do very well and the structure of the command is very efficient, once you understand what the implementers where thinking when they created the commands.



## FETCH command implementation status ##

This is a current summary of the status of the FETCH command in ErlMail's IMAP server.

Key: X = Completed, N = Next Version, U = Untested, P = In Progress, ? = Status Unknown

| FETCH Command | RFC | ErlMail | Outlook Express | Outlook | iPhone | Thunderbird |
|:--------------|:----|:--------|:----------------|:--------|:-------|:------------|
| ALL           | X   | X       | U               | U       | U      | U           |
| FAST          | X   | X       | U               | U       | U      | U           |
| FULL          | X   | X       | U               | U       | U      | U           |
| BODY          |     | P       |                 |         |        |             |
| BODY[.md](.md)<>      |     | P       |                 |         |        |             |
| BODY.PEEK[.md](.md)<> |     | P       |                 |         |        |             |
| BODYSTRUCTURE |     | P       |                 |         |        |             |
| ENVELOPE      | X   | X       | X               | U       | U      | U           |
| FLAGS         | X   | X       | X               | U       | U      | U           |
| INTERNALDATE  | X   | X       | X               | U       | U      | U           |
| RFC822        |     | P       |                 |         |        |             |
| RFC822.HEADER |     | P       |                 |         |        |             |
| RFC822.SIZE   | X   | X       | X               | U       | U      | U           |
| RFC822.TEXT   |     | P       |                 |         |        |             |
| UID           | X   | X       | X               | U       | U      | U           |