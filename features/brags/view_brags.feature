Feature: See brags on the bragboard
	As a user
	So that I can view the achievements of myself and my peers
	I want to view the brags on the bragboard

Background: brags have been added to the bragboard

	Given the following brags exist:
	| title  | author  | subject  | body |
	| title1 | admin1@gmail.com | scholar1@gmail.com | body1 |
	| title2 | admin1@gmail.com | scholar2@gmail.com | body2 |

	Given the following members exist:
	| name | email | position |
	| admin1 | admin@gmail.com | admin | 
	| tutor1 | tutor1@gmail.com | tutor |
	| scholar1 | scholar1@gmail.com | user | 
	| scholar2 | scholar2@gmail.com | user |

	

Scenario: can get a list of brags
	Given that I am logged in as "admin1@gmail.com"
	Then I can request the brags list
