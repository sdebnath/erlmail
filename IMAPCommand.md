# Introduction #

This is a current listing of the status of IMAP commands and implementation notes to complete those commands. The table below also has the status of testing with IMAP email clients that I intend the IMAP server to be compatible with.

Key: X = Completed, N = Next Version, U = Untested, P = In Progress, ? = Status Unknown


| Command      | State             | RFC | ERLMail | Outlook Exp | Outlook | iPhone | Thunderbird |
|:-------------|:------------------|:----|:--------|:------------|:--------|:-------|:------------|
| CAPABILITY   | Any State         | X   | X       | X           | U       | U      | U           |
| NOOP         | Any State         | X   | X       | X           | U       | U      | U           |
| LOGOUT       | Any State         | X   | X       | X           | U       | U      | U           |
| STARTTLS     | Not Authenticated | N   | N       | N           | N       | N      | N           |
| AUTHENTICATE | Not Authenticated | N   | N       | N           | N       | N      | N           |
| LOGIN        | Not Authenticated | X   | X       | X           | U       | U      | U           |
| SELECT       | Authenticated     |     | X       | X           | U       | U      | U           |
| EXAMINE      | Authenticated     |     | X       | U           | U       | U      | U           |
| CREATE       | Authenticated     |     | X       | X           | U       | U      | U           |
| DELETE       | Authenticated     |     | X       | X           | U       | U      | U           |
| RENAME       | Authenticated     |     | X       | X           | U       | U      | U           |
| SUBSCRIBE    | Authenticated     | X   | X       | X           | U       | U      | U           |
| UNSUBSCRIBE  | Authenticated     | X   | X       | X           | U       | U      | U           |
| LIST         | Authenticated     |     | X       | X           | U       | U      | U           |
| LSUB         | Authenticated     |     | X       | X           | U       | U      | U           |
| STATUS       | Authenticated     | X   | X       | X           | U       | U      | U           |
| APPEND       | Authenticated     | N   | N       | N           | N       | N      | N           |
| CHECK        | Selected          | X   | X       | X           | X       | X      | X           |
| CLOSE        | Selected          | X   | X       | U           | U       | U      | U           |
| EXPUNGE      | Selected          | X   | X       | U           | U       | U      | U           |
| SEARCH       | Selected          | N   | N       | N           | N       | N      | N           |
| FETCH        | Selected          |     | P       |             |         |        |             |
| STORE        | Selected          | X   | X       | U           | U       | U      | U           |
| COPY         | Selected          | X   | X       | U           | U       | U      | U           |
| UID - COPY   | Selected          | X   | X       | U           | U       | U      | U           |
| UID - FETCH  | Selected          |     | P       |             |         |        |             |
| UID - SEARCH | Selected          | N   | N       | N           | N       | N      | N           |
| UID - STORE  | Selected          | X   | X       | X           | U       | U      | U           |


Command RFC Compliance Notes:
  * NOOP   - need to store extra information to be send during NOOP
  * SELECT - work on folder flag/permanentflag data storage
  * CREATE - remove trailing hierarchy chr
  * CREATE - ensure parent folders
  * CREATE - UIDVALIDITY
  * CREATE - Check previously deleted folders with same name for MAX UID and other information
  * DELETE - remove messages from folder and other clean up
  * DELETE - check for \noselect flag; send error
  * DELETE - check for sub folders; remove mail and set \noselect leave folder
  * DELETE - maintain list of Max UID/UIDVALIDITY for deleted folders in case of recreation
  * RENAME - rename sub-folders
  * RENAME - CREATE and parent folders
  * RENAME - maintain list of Max UID/UIDVALIDITY for renamed folders in case of recreation; like deleting a folder
  * RENAME - INBOX special case. Move Mail, but do not delete INBOX. Leave subfolders alone
  * LIST   - incorporate reference's name into folder search
















