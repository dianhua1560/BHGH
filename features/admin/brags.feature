Feature: Manage the bragboard as an admin
	As an administrator of the site 
	So that I can track engagement with and monitor use of the bragboard 
	I want to see an admin panel listing key metrics

Background: brags have been added to the bragboard

	Given the following brags exist:
	| title  | author  | subject  | body |
	| title1 | admin1@gmail.com | scholar1@gmail.com | body1 |
	| title2 | admin1@gmail.com | scholar2@gmail.com | body2 |

	Given the following members exist:
	| name | email | position |
	| admin1 | admin1@gmail.com | admin | 
	| tutor1 | tutor1@gmail.com | tutor |
	| scholar1 | scholar1@gmail.com | user | 
	| scholar2 | scholar2@gmail.com | user |

Scenario: Admin can see admin button
	Given that I am logged in as "admin1@gmail.com"
	Then I should be able to use the admin page for brag "title1"

Scenario: Scholars cannot see admin button
	Given that I am logged in as "scholar1@gmail.com"
	When I try to use the admin page for brag "title1"
	Then I should not be authorized

Scenario: Scholars cannot access admin page
	Given that I am logged in as "scholar1@gmail.com"
	When I try to use the admin page for all brags
	Then I should not be authorized

Scenario: Admins can access admin page
	Given that I am logged in as "admin1@gmail.com"
	Then I should be able to use the admin page for all brags
