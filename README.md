# Pig Latin Translator for a Cool Engineering Team
Hey Mike & Team - here's a simple English to Pig Latin translator for you. It handles all provided tests
My email: **will.devitt759@gmail.com**
## Installation & Running the Project
<< PROJECT SITE LINK >>
I've deployed the application to Heroku for your conveinence. 
### Getting Started

### Launching the Server
### Testing 
I prefer RSpec, but I decided to use the built-in Rails tests in this project in the interest of simplicity.
To run all available tests, in the project directory, run **bin/rails test**

### Assumptions & Rules
* Vowels are A, E, I, O, U and sometimes Y. If the first letter is a Y, we consider it a vowel - as given in the example test "yellow". It is slightly more nuanced than this, but for the sake of time, this works fine.

### Technology & Versioning

## Design, Implementation, and Implementation Process (for the Dev team!)
### Different Approaches
Here, I'll document the different possible approaches to each problem, and my reasons for choosing the method I did.
# 1: Use a Library
https://rubygems.org/gems/pig_latin/versions/0.0.2
# 2: Use string operations

# 3: Use REGEX
/^([^aeiou]*)(.*)/ 
Pig Latin Regex: matches every consonant before the first vowel and returns:
Group 1: every character before the first vowel.
Group 2: every remaining character after that first vowel.
gsub! function then returns "GROUP_2" + "GROUP_1"

### Edge Cases Considered
### Patterns and Maintainability 

### Reusability, Extendability
I've added a "Language" column to my Translation table. It's overkill right now, adding some extra verbosity to my code, but makes the Translation class extendable in the future to handle translations of many different languages, if our app should require it. 
Scopes...
### Performance

### Next Steps:
* Add contstraints to database fields

### Issues:

### Other Documentation
* https://web.ics.purdue.edu/~morelanj/RAO/prepare2.html
* https://en.wikipedia.org/wiki/Pig_Latin


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
