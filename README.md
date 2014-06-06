The (Out)Game Plan
==================

Manager Accounts → Event Check In → Event Bracketing → Event Summary


Module 1: Manager Accounts
--------------------------
A specific store will have one master account. Later, we may want for a master account to be able to create accounts with less privileges. For now, this feature is not needed. Signing in to an account through a portal will reveal that specific user’s personal management page.

User Accounts needs:
* Account MODEL
  - Username PARAM
  - Password PARAM
  - HAS MANY: Event OBJECTS
* Limited view of all events only belonging to this account


Module 2: Event Check In
------------------------
A specific event would have a group of players, and a set of details about it.

Event check-in needs:
* See '/mockup-event-checkin'
* Event OBJECT
  - See '/mockup-events'
  - Name PARAM
  - Date PARAM
  - Type PARAM (As in “Magic The Gathering”, or “Yu-Gi-Oh”)
  - Bracket PARAM (As in "elimination", "non-elimination", "draft")
    * Dependant on type parameter
  - Description PARAM
  - HAS MANY: Player OBJECTS
    * First Name PARAM
    * Last Name PARAM
    * Email PARAM
* NEW/CREATE form
  - See '/mockup-new'
* Related to bracketing
  - See MODULE 3


Module 3: Event Bracketing
--------------------------
A specific event would have a type of bracket. The available bracket types and the way a bracket is calculated is dependant on the type of Event. For example, a "Magic The Gathering" event that is a "Draft" may specifically use pods of 8 players, whereas a different game's "Draft" could use 16.

Event bracketing needs:
* See '/mockup-event-brackets'
* Event OBJECT
  - See MODULE 2
  - HAS ONE: Bracket OBJECT
    * Not sure if a separate object for the bracket is the best implementation
* Specific "Netrunner" rules
  - Non-elimination Swiss
  - There are two different teams
    * A player can never play a player of the same team
    * Each player is still matched up against their best possible match
      - Highest wins plays highest wins from opposite teams
  - For uneven teams, people get a by
    * A by can either be a win or a loss or a tie

Module 4: Event Summary
-----------------------
A list of all players at the end of the game, in the order or most wins to least wins. This could become more later down the line, with full statistics and more options.

Event summary needs:
* See '/mockup-event-summary'
* Event OBJECT
  - See MODULE 2
* Bracket OBJECT
  - Once again, not sure if a separate object for the bracket is the best implementation
  - See MODULE 3



