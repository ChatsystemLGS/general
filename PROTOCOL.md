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
    └AUTHENTICATED      : Stadium nach erfolgreicher Anmeldung des Clients
```

## Statuscodes

| Statuscode               | return value(s)                        |
|--------------------------|----------------------------------------|
| OK                       | none/return value(s) of called command |
| INVALID_PARAMETER        | none                                   |
| NOT_ENOUGH_PARAMETERS    | none                                   |
| TOO_MANY_PARAMETERS      | none                                   |
| EMAIL_ALREADY_REGISTERED | none                                   |
| PASSWORD_REQ_NOT_MET     | none                                   |
| EMAIL_NOT_REGISTERED     | none                                   |
| PASSWORD_INVALID         | none                                   |
| NOT_MEMBER_OF_CHANNEL    | none                                   |
| MESSAGE_TOO_LONG         | MAX_MESSAGE_SIZE:Integer               |

## Befehle

### REGISTER

```
required State          : CONNECTED
parameters              : emailAddress:String, password:String
return value(s)         : none
potential status codes  : EMAIL_ALREADY_REGISTERED, PASSWORD_REQ_NOT_MET
```

### LOGIN

```
required State          : CONNECTED
parameters              : emailAddress:String, password:String
return value(s)         : none
potential status codes  : EMAIL_NOT_REGISTERED, PASSWORD_INVALID
```

### SENDMESSAGE

```
required State          : AUTHENTICATED
parameters              : channelID:Integer, data:byte[], dataType:DataType:Enum
return value(s)         : none
potential status codes  : NOT_MEMBER_OF_CHANNEL, MESSAGE_TOO_LONG
```
