# Protokoll für die Kommunikation zwischen Client und Server

## Grundlegende Designentscheidungen

* es besteht eine socketverbindung zwischen client und server
* der client kommuniziert mit dem Server indem er anfragen sendet und darauf Antworten erhält
* anfragen bestehen immer aus einem Befehl und vom befehl abhängig vielen parametern
* der Server kann mithilfe von events auch ohne die initiative der clientanwendung informationen an den client übermitteln
* events werden vom client nicht beantwortet; sie können ignoriert werden

## States

```
└───CONNECTED           : stadium unmittelbar nach der Verbindung eines clients
    └AUTHENTICATED      : stadium nach erfolgreicher anmeldung des clients
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
| PASSWORD_INVALID         | none                                   |
| PASSWORD_INVALID         | none                                   |

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
