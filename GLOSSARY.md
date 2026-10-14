# Flatmates

An app for people sharing a home to fairly divide recurring responsibilities and coordinate shared life (calendar, notices, groceries).

## Language

### People & membership

**Flat**:
The shared home a group of people live in; the boundary for all chores, notices, calendar entries and grocery items. A person belongs to one Flat at a time.
_Avoid_: Household, Home, Group

**Mate**:
A member of a Flat. Every Mate, including the Admin, takes part in Chore rotations.
_Avoid_: Flatmate, Member, User, Roommate

**Mate colour**:
The colour a Mate is shown in across the app, with the face that goes with it on their avatar. No two Mates in a Flat share one while there are colours to spare; a Mate can pick any colour no other Mate has.
_Avoid_: Avatar colour, Theme

**Admin**:
The one Mate who can invite others, create or edit Chores, and set the Away rule; initially the Mate who created the Flat. A role on top of being a Mate, not a separate kind of person, and it must be handed to another Mate before the Admin can leave.
_Avoid_: Owner, Landlord, Creator

**Invite**:
The Flat's single reusable code; whoever joins with it becomes a Mate of the Flat directly. It works for 7 days from when it was made, then stops working until the Admin makes a new one. Only the Admin can share or regenerate it, and regenerating revokes the old one.
_Avoid_: Invitation request, Join request

### Calendar

**Event**:
A one-off happening a Mate puts on the Flat's shared calendar (e.g. a party, a plumber visit). Not a Chore.
_Avoid_: Appointment, Entry, Booking

### Chores

**Chore**:
A recurring responsibility in a Flat that is passed between Mates in rotation.
_Avoid_: Task, Duty, Responsibility, Job

**Rotation**:
The ordered list of Mates a Chore passes through round-robin, chosen by the Admin per Chore. A Mate may appear more than once.
_Avoid_: Roster, Schedule, Cycle

**Rotation period**:
The fixed time from the start of one Turn to the start of the next, in whole days (e.g. every 2 days, every week). At 1 day, Turns run back to back.
_Avoid_: Interval, Frequency, Shift

**Turn**:
One Mate's responsibility for a Chore for one day, from local midnight to midnight. A Turn ends when its day ends, whether or not it was done.
_Avoid_: Assignment, Occurrence, Slot

**Turn time**:
The part of the day a Chore's Turns are meant to be done in: Morning, Afternoon, Evening or Night, chosen by the Admin per Chore. The Turn's notifications follow it; the Turn still lasts the whole day.
_Avoid_: Time slot, Shift, Due time

**Done**:
A Turn its Mate has marked complete before its day ended.
_Avoid_: Completed, Finished, Checked off

**Missed**:
A Turn whose day ended without being marked Done.
_Avoid_: Overdue, Failed, Skipped

### Away

**Away**:
A period a Mate marks in advance when they are not around to do Chores. It overlaps a Turn if it covers any part of it.
_Avoid_: Absence, Unavailability, Leave, Out

**Away rule**:
The single Flat-wide policy, chosen by the Admin, for what happens to an Away Mate's Turns: Swap (the default), Skip or Pause.
_Avoid_: Absence policy, Cover rule

**Swap**:
An Away rule where the next Mate in the Rotation covers the Away Mate's Turn, and the Away Mate later takes that Mate's next Turn in return.
_Avoid_: Trade, Payback

**Skip**:
An Away rule where the Away Mate's Turn passes to the next Mate and nothing is owed.
_Avoid_: Pass

**Pause**:
An Away rule where the Chore freezes while the Mate whose Turn it is is Away: a Turn not yet started waits for their return, and a Turn in progress is extended by the Away time. The next Turn starts one Rotation period after the paused Turn's start.
_Avoid_: Freeze, Suspend

### Shared space

**Notice**:
A text post any Mate puts on the Flat's notice board; the Admin can pin it.
_Avoid_: Post, Message, Announcement

**Got it**:
A Mate's acknowledgement that they have read someone else's Notice.
_Avoid_: Like, Seen, Read receipt, Ack

**Grocery item**:
Something a Mate adds to the Flat's single shared grocery list for anyone to buy.
_Avoid_: Shopping item, List entry
