# Protocol for communication between Client and Server - V0.0.1

## Basic design decisions

* there is one socket connection between client and server
* the client communicates with the server by sending requests and getting responses from the server
* requests always consist of a command and a number of parameters depending on the command
* by using events, the server can send data to the client without the client making a request
* the client does not respond to events; they might even get completely ignored

## States

```
CONNECTED              : immediately after the client connects
├───AUTHENTICATED      : succesfull login
│   └───ENCRYPTED      : successfull key exchange -> messages now get encrypted befor transmission
└───DISCONNECTED       : end of session -> ClientHandler closes connection
```

## Encryption

* Commands for key exchange would have to be added
* most state requirements would have to get adjusted accordingly

We are far from implementing encryption...

## Status Codes

### Default (occurs when command parsing fails)

| Statuscode               | return value(s)                                  |
|--------------------------|--------------------------------------------------|
| OK                       | none/return value(s) of called command           |
| NOT_ENOUGH_PARAMETERS    | minParams:Integer                                |
| TOO_MANY_PARAMETERS      | maxParams:Integer                                |
| INVALID_PARAMETER        | index:Integer, expectedType:ArgType:Enum         |
| COMMAND_NOT_FOUND        | none                                             |
| INTERNAL_SERVER_ERROR    | none (causes end of session)                     |
| AUTHENTICATION_REQUIRED  | none                                             |

### Command-Specific (occurs when corresponding ProtocolException gets Thrown)

| Statuscode               | return value(s)                                                                                        |
|--------------------------|--------------------------------------------------------------------------------------------------------|
| EMAIL_ALREADY_REGISTERED | none                                                                                                   |
| PASSWORD_REQ_NOT_MET     | requirement:PasswordRequirement:Enum                                                                   |
| EMAIL_NOT_REGISTERED     | none                                                                                                   |
| PASSWORD_INVALID         | none                                                                                                   |
| MESSAGE_TOO_LONG         | maxSize:Integer                                                                                        |
| TOO_MANY_MESSAGES        | messages:Message[] (returns the latest n messages from tUntil going back in time ordered by timestamp) |
| CHANNEL_NOT_FOUND        | none                                                                                                   |
| USER_NOT_FOUND           | none                                                                                                   |
| NO_PERMISSION            | none                                                                                                   |

## Commands

maybe remove functionality from single commands to make parsing easier and less prone to bugs? (GETCHANNELS -> channelIDs; GETCHANNEL id -> details)

* commands can only return either an array **or** multiple values as defined here
* only 1-dimensional arrays can be returned

### REGISTER

```
required state          : CONNECTED
parameters              : emailAddress:String, nickname:String, password:String
return value(s)         : none
potential status codes  : EMAIL_ALREADY_REGISTERED, PASSWORD_REQ_NOT_MET
```

### LOGIN

```
required state          : CONNECTED
parameters              : emailAddress:String, password:String
return value(s)         : id:Integer
potential status codes  : EMAIL_NOT_REGISTERED, PASSWORD_INVALID
```

### GETPUBLICGROUPS

```
required state          : AUTHENTICATED
parameters              : none
return value(s)         : channels:Channel[]
potential status codes  : none
```

### JOINGROUP

```
required state          : AUTHENTICATED
parameters              : channelId:Integer
return value(s)         : none
potential status codes  : CHANNEL_NOT_FOUND
```

### GETCHANNELS

```
required state          : AUTHENTICATED
parameters              : none
return value(s)         : channels:Channel[]
potential status codes  : none
```

### GETCHANNELMEMBERS

```
required state          : AUTHENTICATED
parameters              : channelId:Integer
return value(s)         : users:User[]
potential status codes  : CHANNEL_NOT_FOUND
```

### GETUSER

```
required state          : AUTHENTICATED
parameters              : userId:Integer / email:String
return value(s)         : user:User
potential status codes  : USER_NOT_FOUND
```

### ADDFRIEND

```
required state          : AUTHENTICATED
parameters              : userId:Integer
return value(s)         : none
potential status codes  : USER_NOT_FOUND
```

### GETRELATEDUSERS (formerly GETFRIENDS)

```
required state          : AUTHENTICATED
parameters              : none
return value(s)         : users:User[]
potential status codes  : none
```

### REMOVEFRIEND

```
required state          : AUTHENTICATED
parameters              : userId:Integer
return value(s)         : none
potential status codes  : USER_NOT_FOUND
```

### BLOCK

```
required state          : AUTHENTICATED
parameters              : userId:Integer
return value(s)         : none
potential status codes  : USER_NOT_FOUND
```

### SENDMESSAGE

```
required state          : AUTHENTICATED
parameters              : channelId:Integer, data:Byte[], dataType:DataType:Enum
return value(s)         : none
potential status codes  : CHANNEL_NOT_FOUND, MESSAGE_TOO_LONG
```

### CREATEDM

```
required state          : AUTHENTICATED
parameters              : userId:Integer
return value(s)         : channelId:Integer
potential status codes  : USER_NOT_FOUND
```

### RECEIVEMESSAGES

```
required state          : AUTHENTICATED
parameters              : channelId:Integer, tFrom:Timestamp, tUntil:Timestamp
return value(s)         : messages:Message[]
potential status codes  : CHANNEL_NOT_FOUND, TOO_MANY_MESSAGES
```

### QUIT

```
required state          : CONNECTED
parameters              : none
return value(s)         : none
potential status codes  : none
```

### CREATEGROUP

```
required state          : AUTHENTICATED
parameters              : channelName:String
return value(s)         : channelId:Integer
potential status codes  : none
```

### ADDTOGROUP

```
required state          : AUTHENTICATED
parameters              : channelId:Integer, userId:Integer
return value(s)         : none
potential status codes  : CHANNEL_NOT_FOUND, USER_NOT_FOUND, NO_PERMISSION
```

### REMOVEFROMGROUP

```
required state          : AUTHENTICATED
parameters              : channelId:Integer, userId:Integer
return value(s)         : none
potential status codes  : CHANNEL_NOT_FOUND, USER_NOT_FOUND, NO_PERMISSION
```

### LEAVEGROUP

```
required state          : AUTHENTICATED
parameters              : channelId:Integer
return value(s)         : none
potential status codes  : CHANNEL_NOT_FOUND
```

## Events

### EVENT:MESSAGE

```
parameters              : message:Message
```

## Datatypes

* command parameters/return values are separated from each other with blanks
* arrays get transmittet as colon separated entrys enclosed by square brackets with no whitespace after each comma e.g. `[object1_attribute1 object1_attribute1,object2_attribute_1 object2_attribute2]`
* byte[]s are not treated like arrays but as continoous binary data
* byte[]s and Strings are transmitted Base64 encoded (Strings are UTF-8 encoded)
* empty Strings are marked with a dash  (`"" => "-"`) because `((Base64) "") => ""`
* `null` values get transmitted as `"null"`
* Timestamps get transmittet as long epoch value

### Message

```
channelId:Integer
authorId:Integer
timestamp:Timestamp
data:byte[]
dataType:Enum
```

### Channel

```
channelId:Integer
channelType:ChannelType:Enum
channelName:String
```

### User

```
userId:Integer
nickname:String
relationship:UserRelationship:Enum
note:String
```

## Example (TODO outdated)

```
> REGISTER ZmVsaXguaGF1cHRtYW5uQGxncy1odS5ldQ== Z0VoIGVpTSwxMjM0
< OK

> LOGIN ZmVsaXguaGF1cHRtYW5uQGxncy1odS5ldQ== Z0VoIGVpTSwxMjM0
< OK 4

> GETPUBLICGROUPS
< OK [2 TWlyY29zIE1vYmJpbmtyZWlz,6 SVQgQkcxMw==]

> JOINGROUP 2
< OK

> JOINGROUP 45
< CHANNEL_NOT_FOUND

> ADDFRIEND bWlya28ud2VpaEBsZ3MtaHUuZXU=
< OK

> GETFRIENDS
< OK [56 TWlkbGFuZA== friend null]

> GETCHANNELS
< OK [2 publicGroup TWlyY29zIE1vYmJpbmtyZWlz,3 privateGroup RG9taW5pa3Mgc3Rpbmt0aWdlIFN0dWJl]

> GETCHANNELMEMBERS 2
< OK [56 TWlkbGFuZA== friend null,3 Q29iYWx0 null null]

> RECEIVEMESSAGES 2 11-12-2021-00:00:00 12-12-2021-00:00:00
< OK [2 21 11-12-2021-10:35:23 SHVpaSwgRGF0ZW4uClVuZCBzb2dhciBtZWhyemVpbGlnLg== text,2 25 11-12-2021-10:36:06 RWluZSBBbnR3b3J0Lg== text]

< EVENT:MESSAGE 2 20 11-12-2021-10:35:23 SHVpaSwgRGF0ZW4uClVuZCBzb2dhciBtZWhyemVpbGlnLg== text
```
