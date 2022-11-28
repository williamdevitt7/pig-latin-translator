# Pig Latin Translator for a Cool Engineering Team
Hey Mike & Team - here's a simple English to Pig Latin translator for you.
My email: **will.devitt759@gmail.com**
## Installation & Running the Project

### Getting Started

### Launching the Server
### Testing 
I prefer RSpec, but I decided to use the built-in Rails tests in this project in the interest of simplicity.
To run all available tests, in the project directory, run **bin/rails test**

SPECIAL NOTES:
* Vowels are A, E, I, O, U and sometimes Y. In the examples I was given, specifically "yellow" which was translated to "yellowway", I am considering Y as a vowel here.

### Technology & Versioning

## Design, Implementation, and Implementation Process (for the Dev team!)
### Different Approaches
Here, I'll document the different possible approaches to each problem, and my reasons for choosing the method I did.

### Edge Cases I Considered
### Patterns and Maintainability 

### Reusability, Extendability
I've added a "Language" column to my Translation table. It's overkill right now, adding some extra verbosity to my code, but makes the Translation class extendable in the future to handle translations of many different languages, if our app should require it.
### Performance

### Next Steps:
* Add contstraints to database fields

### Other Documentation
* https://web.ics.purdue.edu/~morelanj/RAO/prepare2.html
* https://en.wikipedia.org/wiki/Pig_Latin


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
