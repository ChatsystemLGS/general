# Chatsystem

Es soll für ein Chatsystem ein Client – Serveranwendung geschrieben werden. Mit dieser
können User untereinander Nachrichten austauschen.

## Verweise

### Generell

* [Wekan Board](<https://wekan.lgsit.de/b/Ey9toWzCXSSerdjuB/projekt-3-chatsystem>)
* [Gantt Chart](https://docs.google.com/spreadsheets/d/14PY8sXY7jv3Ta3U00aRHLJXFnqE1T4qXwJE6ikMxyYk)
* [Projektanforderungen](Projektanforderungen.pdf)

### GitLab

* [General](<https://gitlab.lgsit.de/projekt-3-chatsystem/general>)
* [Database](<https://gitlab.lgsit.de/projekt-3-chatsystem/database>)
* [Server](<https://gitlab.lgsit.de/projekt-3-chatsystem/server/>)
* [Client](<https://gitlab.lgsit.de/projekt-3-chatsystem/client/>)
* [Protocol](PROTOCOL.md)

## Anforderungen

### Diagramme

* [ER-Diagramm](https://gitlab.lgsit.de/projekt-3-chatsystem/database/-/blob/master/diagrams/database-final.svg)
* [Klassendiagramm](https://gitlab.lgsit.de/projekt-3-chatsystem/server/-/blob/master/diagrams/uml.svg)
* Anwendungsfalldiagramm (wäre riesig und extrem unübersichtlich geworden, informationsgehalt wäre eher gering)
* [Sequenzdiagramme](https://gitlab.lgsit.de/projekt-3-chatsystem/server/-/blob/master/diagrams/sequence.svg)
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

* ein User hat einen Account (Autentifiziert sich mit E-Mail-Adresse und passwort); wird durch E-Mail-Adresse (oder id?) identifiziert
* ein User verfügt über eine Freundesliste; kann freunde mithilfe E-Mail-Adresse hizufügen
* ein User kann einem anderen User Nachrichten senden

### eigene Erweiterte Funktionen

#### hohe Priorität

* Verschlüsselung Socketverbindung
* Verschlüsselung Ende-Ende (Eigentlicher Nachrichteninhalt)
* Blockierung von Nutzern
* Lese-/Empfangsbestätigung
* "typing indicator"
* verification Mail

#### niedrige Priorität

* auf Nachrichten antworten
* Reaktionen auf Nachrichten
* Hinzufügen von Notizen zu Nutzern
* Hinzufügen von Nicknamen zu Nutzern

## Software 

* [Eclipse](https://www.eclipse.org/) (IDE)
* [Visual Studio Code](https://code.visualstudio.com/) (Editor/IDE)
* [IntelliJ](https://www.jetbrains.com/idea/) (IDE)
* [PlantUML](https://plantuml.com/) (Diagram)
* [Dia](http://dia-installer.de/) (Diagram)
* [Astah](https://astah.net/) (Diagram/Modeling)

### Tools/Frameworks/Librarys/...

* [Gradle](https://gradle.org/) (Build Tool)
* [plantuml-gradle-plugin](https://github.com/RoRoche/plantuml-gradle-plugin/) (Sourcecode -> .puml)
* [plantuml-gradle-plugin](https://github.com/red-green-coding/plantuml-gradle-plugin/) (.puml -> .svg/.png/...)
* [MariaDB Connector](https://mariadb.com/kb/en/about-mariadb-connector-j/) (JDBC connector)
* [MigLayout](https://www.miglayout.com/) (Swing Layout Manager)
* [fontawesome](https://fontawesome.com/)
* [Scenebuilder](https://gluonhq.com/products/scene-builder/) (JavaFX Layout Manager, integriert in IntelliJ)
