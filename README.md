# Chatsystem

Es soll für ein Chatsystem ein Client – Serveranwendung geschrieben werden. Mit dieser
können User untereinander Nachrichten austauschen.

## Verweise

### Generell

* [Wekan Board](<https://wekan.lgsit.de/b/Ey9toWzCXSSerdjuB/projekt-3-chatsystem>)
* [Gantt Chart](https://docs.google.com/spreadsheets/d/14PY8sXY7jv3Ta3U00aRHLJXFnqE1T4qXwJE6ikMxyYk)
* [Pflichtenheft](Pflichtenheft.docx)
* [Projektanforderungen](Projektanforderungen.pdf)

### GitLab

* [General](<https://gitlab.lgsit.de/projekt-3-chatsystem/general>)
* [Database](<https://gitlab.lgsit.de/projekt-3-chatsystem/database>)
* [Server](<https://gitlab.lgsit.de/projekt-3-chatsystem/server/>)
* [Client](<https://gitlab.lgsit.de/projekt-3-chatsystem/client/>)

## Anforderungen

### Diagramme

* ER-Diagramm
* Klassendiagramm
* Anwendungsfalldiagramm
* Sequenzdiagramme (z.B. Nachricht senden/Gruppe erstellen/...)
* [Gantt-Diagramm](<https://docs.google.com/spreadsheets/d/e/2PACX-1vTC0DLkoYmxA5_Yiwm0w857usjg7QYMmbXFCuoPP5qKv6U1duBaFtCWt_7MDkKb3OR_ossJ-aOjdv72/pubhtml?widget=false&headers=false&chrome=false>)

### Grundfunktionen

* Ein User kann einen Account erzeugen und sich anmelden.
* Ein User verfügt über eine „Freundesliste“ (Kontaktliste), wo er andere User erkennen kann.
* User können Nachrichten versenden
* User können Gruppen anlegen
* User können Gruppen beitreten und darin Nachrichten versenden
* eine Gruppe kann von einem Gruppenmitglied, welches über Gruppenadministratorenberechtigung verfügt verwaltet werden (löschen, umbenennen, Mitglieder entfernen)

### Erweiterte Funktionen

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
