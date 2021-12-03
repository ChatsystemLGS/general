## Anforderungen

### Grundfunktionen

* Ein User kann einen Account erzeugen und sich anmelden.
* Ein User verfügt über eine „Freundesliste“ (Kontaktliste), wo er andere User erkennen kann.
* User können Nachrichten versenden

### Erweiterte Funktionen

* User können Gruppen erstellen
* User können Bilder verschicken

## Ideen

### Grundfunktionen

* ein User hat einen Account (Autentifiziert sich mit Email-Adresse und passwort)
* ein User verfügt über eine Frendesliste
* ein User kann einem anderen User Nachrichten senden

### Erweiterte Funktionen

* User Können Gruppen beitreten und darin Nachrichten versenden
* eine Gruppe kann von einem Gruppenmitglied, welches über Gruppenadministratorenberechtigung verfügt verwaltet werden (löschen, umbenennen, mitglieder, entfernen)
* Nachrichten beinhalten arbiträre daten, deren typ angegeben wird. Nachrichteninhalt wird vom client interpretiert (erweiterbarkeit)

## Designentscheidungen Datenbank 

### Unterscheidung 1:1-Konversation/Gruppenkonversation

#### Jede KOnversation ist ein Channel
* Sämtliche Konversationen finden in Channels statt
* 1:1 Konversationen werden ähnlich wie Gruppenkonversationen behandelt

#### alle Konversationstypen haben eine Tabellenübergreifend eizigartige id
* Gruppen und 1:1-Konversationen haben tabellenübergreifend einzigartige Primärschlüssel (UUID/Sequence)
* Eine Tabelle hält alle Nachrichten
* Nachrichten verweisen auf eine KoversationsID
* Gruppen, 1:1-Konversationen und Nachrichten müssen gejoint werden

#### 1:1-Nachrichten und Gruppennachrichten werden separat gespeichert
* zwischen Gruppen und 1:1-Konversationen wird unterschieden
* jeweils eine Tabelle speichert alle Gruppennachrichten/1:1-Nachrichten