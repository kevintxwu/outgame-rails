The (Out)Game Plan
------------------

MANAGER ACCOUNTS → EVENT CHECK IN → EVENT BRACKETING → EVENT SUMMARY


Module 1: MANAGER ACCOUNTS
--------------------------
A specific store will have one master account. Later, we may want for a master account to be able to create accounts with less privileges. For now, this feature is not needed. Signing in to an account through a portal will reveal that specific user’s personal management page.

User Accounts needs:
• Account MODEL
  o Username PARAM
  o Password PARAM
  o HAS MANY: Event OBJECTS
• Limited view of all events only belonging to this account


Module 2: EVENT CHECK IN
------------------------
A specific event would have a group of players, and a set of details about it.

Event check-in needs:
• See '/mockup-event-checkin'
• Event OBJECT
  o See '/mockup-events'
  o Name PARAM
  o Date PARAM
  o Type PARAM (As in “Magic The Gathering”, or “Yu-Gi-Oh”)
  o Bracket PARAM (As in "elimination", "non-elimination", "draft")
    • Dependant on type parameter
  o Description PARAM
  o HAS MANY: Player OBJECTS
    • First Name PARAM
    • Last Name PARAM
    • Email PARAM
• NEW/CREATE form
  o See '/mockup-new'
• Related to bracketing
  o See MODULE 3


Module 3: EVENT BRACKETING
--------------------------
A specific event would have a type of bracket. The available bracket types and the way a bracket is calculated is dependant on the type of Event. For example, a "Magic The Gathering" event that is a "Draft" may specifically use pods of 8 players, whereas a different game's "Draft" could use 16.

Event bracketing needs:
• See '/mockup-event-brackets'
• Event OBJECT
  o See MODULE 2
  o HAS ONE: Bracket OBJECT
    • Not sure if a separate object for the bracket is the best implementation
• Specific "Netrunner" rules
  o Non-elimination Swiss
  o There are two different teams
    • A player can never play a player of the same team
    • Each player is still matched up against their best possible match
      o Highest wins plays highest wins from opposite teams
  o For uneven teams, people get a by
    • A by can either be a win or a loss or a tie

Module 4: EVENT SUMMARY
-----------------------
A list of all players at the end of the game, in the order or most wins to least wins. This could become more later down the line, with full statistics and more options.

Event summary needs:
• See '/mockup-event-summary'
• Event OBJECT
  o See MODULE 2
• Bracket OBJECT
  o Once again, not sure if a separate object for the bracket is the best implementation
  o See MODULE 3


