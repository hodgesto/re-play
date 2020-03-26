# Requirements

Indoor Goals Hockey Statistics System  
12 January 2020  
Tobias Hodges

## Requirements Definition

### Functional Requirements

-   The system will authenticate an Operator's credentials before allowing use.
-   The system will display a user interface for operation during games when an
Operator is logged in.
-   The system will allow an Operator to create and edit Schedules and
Statistics for Seasons, Divisions, Teams, Games, Players, Names, Numbers, Goals,
Assists, Saves, and Penalties.
-   The system will record Statistics to the Database after each Statistic is
added to the web application.
-   The system will pull from the Database to display Schedules and Statistics
on a dynamic webpage.

#### Additional Functionality

-   The system will display the Game Clock, Period, and Statistics of an active
game in real-time on a webpage, without forcing a user to reload the page.
-   The system will allow an Operator to choose a Sport, shifting the connection
between a Hockey and a Soccer database.
-   The system will allow an Operator to import a Schedule as a CSV file.

### Non-Functional Requirements

-   The system will require minimal training to use properly.
-   The system will allow an Operator to create Schedules (Seasons, Divisions,
Teams, Games, and Players) at any time.
-   The system will allow an Operator to add Statistics (Penalties, Goals,
Assists, and Saves) to Players during a game in real-time.
-   The web application will be accessible through secure login, allowing only
registered users to interact with the Database.
-   The Database will be written in PostgreSQL, allowing hosting on Linux
servers.
-   The web application will be written in Clojure and ClojureScript using Re-
Frame and Reagent.

## Use Cases

### Use Case Diagram

![Use Case Diagram for Hockey Statistics][usecases]

### Case 1

Pre-Season Schedule

#### Actors

-   Operator
-   Viewer

#### Preconditions

-   Operator has internet access.
-   Operator has login access to the Webapp.
-   Viewer has internet access.

#### Postconditions

-   Operator has created season Schedule in Database.
-   Viewer has access to view the new season Schedule.

#### Flow of Events

-   Operator logs in to the secure Webapp.
-   Operator creates a new Season.
-   Operator creates applicable Divisions for the Season.
-   Operator creates registered Teams for each Division.
-   Operator creates Scheduled Games for each Team.
-   Operator creates registered Players for each Team.
-   Operator exits the secure Webapp.
-   Viewer navigates to the Site.
-   Viewer can access but not edit the new scheduling information.

### Case 2

Mid-Season Game

#### Actors

-   Operator
-   Viewer

#### Preconditions

-   Operator has internet access.
-   Operator has login access to the secure Webapp.
-   Viewer has internet access.
-   A Scheduled Game is occurring at this time.
-   Players are generating Statistics for record.

#### Postconditions

-   Operator has created Statistics for Players during the Scheduled Game.
-   Game Clock and Statistics are displayed in real-time throughout the Game.
-   Viewer has access to view the Statistics and Clock for the current Game.

#### Flow of Events

-   Operator logs in to the secure Webapp.
-   Operator begins the Scheduled Game through the Webapp.
-   Game Clock begins and is viewable on the Site.
-   Viewer navigates to the Site and has access to view the Game in real-time.
-   Operator records Goals, Assists, Saves, and Penalties throughout the Game.
-   Operator advances the Period and resets the Game Clock when applicable.
-   Viewer has access to view the Statistics as they are updated in real-time.
-   Operator stops the Game Clock and marks the end of the Game on the Webapp.
-   Viewer has access to see the final score of the Game.
-   Operator exits the secure Webapp.

### Case 3

Post-Game Error Correction

#### Actors

-   Admin
-   Viewer

#### Preconditions

-   Admin has direct Database access.
-   Viewer has internet access.
-   There is a known recording error in the Database.

#### Postconditions

-   The offending error has been removed or remediated.
-   Viewer has access to see the remediated Schedule(s) or Statistic(s).

#### Flow of Events

-   Admin connects directly to the Database.
-   Admin corrects the known error and saves the state of the Database.
-   Admin disconnects from the Database.
-   Viewer navigates to the Site.
-   Viewer has access to see the remediated Schedule(s) or Statistic(s).

## Class Diagram

![UML Class Diagram for Hockey Statistics][classdiagram]

## Requirements Specification

### Functional Requirements

-   The system will take in Operator login credentials and check hashed
passwords against stored hashed passwords.
-   Upon credential validation, the system will display an application which
allows Operators to create and modify Statistics of a Scheduled Game, or create
a Season with a Schedule of Games.
-   Each time a Statistic is created, the system will send a SQL query to the
Database to create or modify a database entry.
-   When a Viewer navigates to the Webapp, the system will query the database
to display the current Season's Schedule in an interactive manner.
-   Upon navigating to a specific Game, Team, or Player, the system will query
the database for updated Statistics and display the Statistics to the webpage.

### Non-Functional Requirements

-   The system will query the database immediately upon creating a Statistic.
-   The system will await final query to the database upon creating a Schedule
until the Schedule is completed by the Operator.
-   The system will report and store any errors in database connection or SQL
queries to the operator and to a log file.

## Data Flow Diagram

![Data Flow Diagram for Hockey Statistics][dataflow]

## Message Sequence Charts

### Case 1

![Message Sequence Chart for Use Case 1][messageseq1]

### Case 2

![Message Sequence Chart for Use Case 2][messageseq2]

### Case 3

![Message Sequence Chart for Use Case 3][messageseq3]

[usecases]: ./images/usecases.svg "Use Cases Diagram"
[classdiagram]: ./images/classdiagram.svg "UML Class Diagram"
[dataflow]: ./images/dataflow.svg "Data Flow Diagram"
[messageseq1]: ./images/messageseq1.svg "Message Sequence Chart for Use Case 1"
[messageseq2]: ./images/messageseq2.svg "Message Sequence Chart for Use Case 2"
[messageseq3]: ./images/messageseq3.svg "Message Sequence Chart for Use Case 3"
