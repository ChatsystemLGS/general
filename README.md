# Chatsystem

Es soll für ein Chatsystem ein Client – Serveranwendung geschrieben werden. Mit dieser
können User untereinander Nachrichten austauschen.

## Anforderungen

### Grundfunktionen

* Ein User kann einen Account erzeugen und sich anmelden.
* Ein User verfügt über eine „Freundesliste“ (Kontaktliste), wo er andere User erkennen kann.
* User können Nachrichten versenden

### Erweiterte Funktionen

* User können Gruppen anlegen
* User können Gruppen beitreten und darin Nachrichten versenden
* eine Gruppe kann von einem Gruppenmitglied, welches über Gruppenadministratorenberechtigung verfügt verwaltet werden (löschen, umbenennen, Mitglieder entfernen)
* Nachrichten beinhalten arbiträre Daten
* Datentyp der Nachricht wird in Nachricht festgehalten
* Nachrichteninhalt wird vom Client interpretiert (Erweiterbarkeit)

## Ideen

### eigene Grundfunktionen

* ein User hat einen Account (Autentifiziert sich mit E-Mail-Adresse und passwort); wird durch UUID eindeutig identifiziert
* ein User verfügt über eine Freundesliste; kann freunde mithilfe UUID hizufügen
* ein User kann einem anderen User Nachrichten senden

### eigene Erweiterte Funktionen

#### hohe Priorität

* Verschlüsselung Socketverbindung
* Verschlüsselung Ende-Ende (Eigentlicher Nachrichteninhalt)
* Blockierung von Nutzern
* Lese-/Empfangsbestätigung
* "typing indicator"

#### niedrige Priorität

* auf Nachrichten antworten
* Reaktionen auf Nachrichten
* Hinzufügen von Notizen zu Nutzern
* Hinzufügen von Nicknamen zu Nutzern
