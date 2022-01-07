# Protokoll für die Kommunikation zwischen Client und Server

## Grundlegende Designentscheidungen

* es besteht eine Socketverbindung zwischen client und server
* der Client kommuniziert mit dem Server, indem er Anfragen sendet und darauf Antworten erhält
* Anfragen bestehen immer aus einem Befehl und vom Befehl abhängig vielen Parametern
* der Server kann mithilfe von Events auch ohne die Initiative der Clientanwendung Informationen an den Client übermitteln
* Events werden vom Client nicht beantwortet; sie können ignoriert werden

## States

```
└───CONNECTED           : Stadium unmittelbar nach der Verbindung eines Clients
    ├AUTHENTICATED      : Stadium nach erfolgreicher Anmeldung des Clients
    └DISCONNECTED       : Stadium nach beenden der Sitzung (-> ClientHandler schließt verbindugn)
```

## Statuscodes

### Default (caused when command parsing fails)

| Statuscode               | return value(s)                                  |
|--------------------------|--------------------------------------------------|
| OK                       | none/return value(s) of called command           |
| NOT_ENOUGH_PARAMETERS    | numExpected:Integer                              |
| TOO_MANY_PARAMETERS      | numExpected:Integer                              |
| INVALID_PARAMETER        | index:Integer                                    |
| COMMAND_NOT_FOUND        | none                                             |
| INTERNAL_SERVER_ERROR    | none (causes end of session)                     |
| AUTHENTICATION_REQUIRED  | none                                             |

### Command-Specific (caused when corresponding ProtocolException gets Thrown)

| Statuscode               | return value(s)                                  |
|--------------------------|--------------------------------------------------|
| EMAIL_ALREADY_REGISTERED | none                                             |
| PASSWORD_REQ_NOT_MET     | none                                             |
| EMAIL_NOT_REGISTERED     | none                                             |
| PASSWORD_INVALID         | none                                             |
| NOT_MEMBER_OF_CHANNEL    | none                                             |
| MESSAGE_TOO_LONG         | MAX_MESSAGE_SIZE:Integer                         |
| TOO_MANY_MESSAGES        | lastMessage:Date, return value of called command |
| CHANNEL_NOT_FOUND        | none                                             |
| USER_NOT_FOUND           | none                                             |
| DM_ALREADY_EXISTS        | channel:Integer                                  |

## Befehle

Befehle minimalisieren? (GETCHANNES -> channelIDs; GETCHANNEL id -> details)

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
return value(s)         : none
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
parameters              : channel:Integer
return value(s)         : users:User[]
potential status codes  : NOT_MEMBER_OF_CHANNEL
```

### GETUSER

```
required state          : AUTHENTICATED
parameters              : id:Integer / email:String
return value(s)         : user:User
potential status codes  : USER_NOT_FOUND
```

### ADDFRIEND

müssen Freunde auch via email hinzugefügt werden können?

```
required state          : AUTHENTICATED
parameters              : id:Integer / email:String
return value(s)         : none
potential status codes  : USER_NOT_FOUND
```

### GETFRIENDS

```
required state          : AUTHENTICATED
parameters              : none
return value(s)         : users:User[]
potential status codes  : none
```

### SENDMESSAGE

```
required state          : AUTHENTICATED
parameters              : channelID:Integer, data:Byte[], dataType:Enum
return value(s)         : none
potential status codes  : NOT_MEMBER_OF_CHANNEL, MESSAGE_TOO_LONG
```

### CREATEDM

```
required state          : AUTHENTICATED
parameters              : userId:Integer
return value(s)         : channel:Integer
potential status codes  : USER_NOT_FOUND, DM_ALREADY_EXISTS
```

### RECEIVEMESSAGES

```
required state          : AUTHENTICATED
parameters              : channelID:Integer, tFrom:Timestamp, tUntil:Timestamp
return value(s)         : messages:Message[]
potential status codes  : NOT_MEMBER_OF_CHANNEL, TOO_MANY_MESSAGES
```

### QUIT

```
required state          : CONNECTED
parameters              : none
return value(s)         : none
potential status codes  : none
```

## Events

### EVENT:MESSAGE

```
parameters              : message
```

## Datatypes

* Parameter werden mit Leerzeichen voneninander getrennt
* Attribute von objekten werden mit Leerzeichen voneinander getrennt
* Listen werden kommagetrennt innerhalb Eckiger Klammern übertragen
* Binärdaten und strings werden base64-codiert übertragen
* leere strings werden als bindestrich gekennzeichnet (`"" => "-"`), weil `((Base64) "") => ""`

### Message

```
channel:Integer
author:Integer
timestamp:Timestamp
data:Base64
dataType:Enum
```

### Channel

```
channel:Integer
type:Enum
channelName:String (optional)
```

### User

```
id:Integer
nickname:String
relationship:Enum
note:String
```

## Example

```
> REGISTER ZmVsaXguaGF1cHRtYW5uQGxncy1odS5ldQ== Z0VoIGVpTSwxMjM0
< OK

> LOGIN ZmVsaXguaGF1cHRtYW5uQGxncy1odS5ldQ== Z0VoIGVpTSwxMjM0
< OK

> GETPUBLICGROUPS
< OK [2 TWlyY29zIE1vYmJpbmtyZWlz, 6 SVQgQkcxMw==]

> JOINGROUP 2
< OK

> JOINGROUP 45
< CHANNEL_NOT_FOUND

> ADDFRIEND bWlya28ud2VpaEBsZ3MtaHUuZXU=
< OK

> GETFRIENDS
< OK [56 TWlkbGFuZA== friend null]

> GETCHANNELS
< OK [2 publicGroup TWlyY29zIE1vYmJpbmtyZWlz, 3 privateGroup RG9taW5pa3Mgc3Rpbmt0aWdlIFN0dWJl]

> GETCHANNELMEMBERS 2
< OK [56 TWlkbGFuZA== friend null, 3 Q29iYWx0 null null]

> RECEIVEMESSAGES 2 11-12-2021-00:00:00 12-12-2021-00:00:00
< OK [2 21 11-12-2021-10:35:23 SHVpaSwgRGF0ZW4uClVuZCBzb2dhciBtZWhyemVpbGlnLg== text, 2 25 11-12-2021-10:36:06 RWluZSBBbnR3b3J0Lg== text]

< EVENT:MESSAGE 2 20 11-12-2021-10:35:23 SHVpaSwgRGF0ZW4uClVuZCBzb2dhciBtZWhyemVpbGlnLg== text
```
