# Pig Latin Translation Engine
Hey Mike & Team - here's a simple English to Pig Latin translator for you. It handles all provided tests, and looks nice on both desktop and mobile.
My email: **will.devitt759@gmail.com**.

## Installation & Running the Project
https://pig-latin-translation-engine.herokuapp.com/
* I've deployed the application to Heroku for your convienence. See the link above.

However, if you desire to run the project on your local machine, follow these steps (assuming clean setup, no Ruby or Rails.) In your terminal...

* 1: Clone the project to your local machine. Install git if neccessary. 
* 2: Install RVM by following the instructions in this StackOverflow post. https://tinyurl.com/3c8scf7k
* 3: Install ruby-3.1.2 using ```rvm install ruby-3.1.2```.
* 4: Run the command ```rvm use ruby-3.1.2``` to use the correct Ruby instance.
* 5: Install Rails with ```gem install rails```.
* 6: My production instance on Heroku is running on PostGreSQL. Unless you want to follow the (somewhat complex) setup steps for that database (found here: https://devcenter.heroku.com/articles/heroku-postgresql), you'll want to modify the application to use sqlite3. Steps follow.
* 7: Go into ```/pig-latin/translator/Gemfile``` and replace ```gem "pg"``` with ```gem "sqlite3"```.
* 8: Go into ```/pig-latin/translator/config/database.yml``` and replace ```adapter: postgresql``` with ```adapter: sqlite3```, and change the development database from ```database: pig_latin_dev``` to ```database: db/development.sqlite3```.
* 9: Run ```bundle install``` in the main project directory to install all project dependencies. 
* 10: run the command ```rake db:migrate```. This will set up the database for your usage.
* 11: Check that your versions are correctly installed with ```ruby -v", "rvm -v" and "rails -v```. You're now ready to launch the server!
Please don't hesitate to get in touch if you have any problems whatsoever. I've included my email at the head of this file.

### Launching the Server
From the project directory, run **bin/rails server**, **rails server** or just **rails s**.
* NOTE: If you didn't run ```rake db:migrate```, you'll have to click "Run Pending Migrations" in your browser, which will also work.

### Testing 
I decided to use the built-in Rails tests in this project in the interest of simplicity and speed. I've built tests for all key functionality and the provided test cases, including the loading of the single page itself.

To run all available tests, in the project directory, run **bin/rails test**,  **rails test** or just **rails t**. As this project is small, you'll find the tests under **test/controllers** and **test/models**.

### Assumptions & Rules
* Vowels are A, E, I, O, U and sometimes Y. If the first letter is a Y, we consider it a vowel - as given in the example test "yellow". It is slightly more nuanced than this, but for the sake of time, this is how my code is implemented. All other rules are taken from the provided Wikipedia link, **https://en.wikipedia.org/wiki/Pig_Latin**.
* I've also assumed some things in regards to capitalization - the implementation of which isn't perfect. I've attempted to maintain correct capitalization, e.g. "Hello" => "Ellohay", by tracking the indicies of the capital letters.
* When determining if the suffix ("ay" or "way") should be capitalized, I considered a few approaches. I considered capitalizing the suffix if more than half of the characters in the input string were capitalized, but that seemed odd. I ended up assuming that if the last letter is capitalized, the suffix should be too - this is a simple continuation pattern that feels right - there's no set rule on this matter, I believe. Feel free to question this!

### Technology & Versioning
* Ruby - 3.1.2
* Rails - 7.0.4
* RVM - 1.29.12
* Postgres 15
* Heroku (deployment)
To see the next steps I'd take with this project, including technology-wise, read further. This is dead-simple for now.

## Design and Implementation Process
Feel free to take a look at my commit process.
### Approaches
Here, I'll document the different possible approaches to the core problem (translating an English sentence into Pig Latin), and my reasons for choosing my eventual solution. As for why I chose Ruby and Rails - I love the language and the framework, and feel very strong in my use of both. It's one of the reasons I'm applying for this position. I considered JavaScript as well, but I consider Ruby to be cleaner and more readable - and additionally, having the core logic condensed into one class (Translation.rb) would allow one to simply grab
### 1: Use a Library
If I were developing this Pig Latin Translation Engine for our client, my first thought would be - "let's not reinvent the wheel." There are typically libraries out there (many of them good) with solutions for almost every kind of problem under the sun. I found one, but didn't test it: https://rubygems.org/gems/pig_latin/versions/0.0.2. There were a few problems with this solution: 
* **1: Using a library would go against the purpose of this problem.** Of course, the purpose of this problem was to test my development skills. I'd likely never implement a Pig Latin Translator for a client, but in this role I would be solving many problems that are unique and require a unique approach - especially as a mid-level engineer in a startup with so much to learn. I had a ton of fun with this exercise, and drew a lot of satisfaction from demonstrating my skills to myself.
* **2: Project size overhead.** Why make our project bigger, if it could be smaller? That wouldn't have a big impact on this solution, but in a real world scenario, it's important to consider.

### 2: Use String Operations
This was my initial, intuitive approach - I knew the string manipulation I had to do the moment I read the prompt for this exercise. Iterate through the input string on each word until a vowel was reached, storing and then deleting the non-vowels before it from the word, and then simply appending those letters to the end of the string followed by "ay" or "way", depending. However, when I implemented this, I got stuck in somewhat of a "loop hell." My code was verbose and ugly and somewhat harder to read (in my opinion) than my evental implementation below. 
* **1: String operations are simpler to implement.** Logically smooth and sound - there may be a ton of loops required to solve a problem like this, but that's okay - it's still fast, as long as you don't mess up your time complexity and start nesting loops.
* **2: Easier to read.** For those unfamiliar with Regex, string ops are more accessible. However, for this problem, I believe there are many downsides to this approach. As complexity increases, string operations become more complex and harder to maintain - "loop hell." There is another, cleaner way to manipulate strings in this case, because the problem is not neccesarily trivial.

### 3: Use REGEX **(Chosen Approach)**
```/^([^aeiou]*)(.*)/```
This is the Regular Expression I implemented. It: matches every consonant before the first vowel and returns:
* Group 1: Matches every character before the first vowel, not counting Y (we check if the first character is a vowel, inclusive of Y, elsewhere). ```([^aeiou]*)```
* Group 2: Matches every remaining character after that first vowel. ```(.*)```
* We then modify the string, returning "Group 2" + "Group 1". Lastly, we simply add the suffix and punctuation (if applicable.)
This code is found in models/translation.rb, in the "translate" function on line 28.

String operations are generally faster than Regex, but this is easier to read and scale. It handles the simple task of, essentially, swapping characters extremely well. There were enough loops in my attempt to implement string operations to cause me to look for another solution - essentially, my code didn't pass the "smell test", suggesting there was a better solution - and this is what I settled with. The "Pig Latinization" of any given word is vastly simplified with this method, entirely replacing a loop. For further explanation, plugging it into regex101.com unpacks every bit of logic needed. 

### Edge Cases Handled & Considered
This program handles every edge case presented in the required tests - namely punctuation, capitalization, and the "qu" sound (example: quick.) You'll find the solution works great. Other cases I considered are as follows:

* Input is the empty string (validations don't allow this)
* Input is nil (validations don't allow this either)
* String has inconsistent spacing
* Word contains non-letters
* word contains non-normal amounts of whitespace
* String is less than the maximum allowable string size in Ruby: 2^31 - 1 for a 32-bit machine, and 2^63 - 1 for a 64-bit machine. As we don't know the tech capability of every user, I've decided to check against the 32-bit requirements.

### Extensibility and Reusability
* I've added a "Language" column to my Translation table. It's overkill right now, adding some extra verbosity to my code, but makes the Translation class extendible in the future to handle translations of many different languages, if our app should require it. For example, next to the ```to_pig_latin``` function, one could define ```to_french```, ```to_german``` or many other languages, and it would be appropriate.
* I've also added and implemented the appropriate scopes and function names in my model concern, preparing it for extension to many other kinds of languages, as far as the client's imagination could take them. I've made the code modular and made sure the functions follow the single responsibility principle.
* I've factored some of the private methods, scopes, and constants in my Translation model (capitalize, vowel?, REGEXs, etc) into a concern, Translatable - which is the proper place for shared model logic. Currently, there is only one model, but there's lots of logic there that could be used in other language manipulation services that we could implement into this application - things that would be common across classes. Many of the regex patterns and functions that could be used widely across the application are now stored in this module and all that remains is logic unique to the translating of Pig Latin - allowing easy extension of functionality and cleaner code in the future. I've put in a lot of effort into making the core Pig Latin Translation logic readable to the point that you don't need to see the functions that live in the concern to understand what they do - additionally de-cluttering our model and its key components.

### Performance
Given an input of size N (example: "she's a great person") we split the input N into an array of each word, and perform a regular-expression operation on each word. The time complexity of a classic, compiled regular expression is O(N), and so is our single iteration over the length of our input. We further run some ```include?``` and ```match`` functions, which have time complexities of O(1) and O(N) respectively. The many Gsub operations are also each O(N). Our final unique case is iterating over each input word and gathering the indicies of the capital letters, and then (in the worst case of an entirely capitalized word) appropriately capitalizing letters in the translated word. The worst case of this scenario, with 3 non-nested loops, is O(3n). Ignoring the constant, our time complexity comes out to 
* **O(N) time.** 
And, as we generate an extra string to store the translated input, our space complexity is O(2N) which of course comes out to
* **O(N) space.**

## Next Steps to Improve the Project
* Implement a frontend framework, and make it beautiful. This is the most glaring and obvious missing piece. The plain HTML doesn't look great, but I didn't want to over-engineer this takehome. It would be the absolute first thing I implement were I to take this project further. If given more time for this project, I would have chosen React, as that would be used in this role. This includes making the application responsive in both desktop and mobile formats.
* Use AJAX calls and responsive Rails JavaScript when clicking "Create Translation" to avoid reloading the entire page and load only the relevant section of the app instead. This would help to scale and increase the functionality of the application, as reloading the entire page would quickly become an issue.
* Add more contstraints to database fields and scale its implementation.
* Add a dynamic text editor, with full Word-like functionality. 
* Add user login/chat functions. Chatting with others in Pig Latin could be really fun.

## Other Documentation
* https://en.wikipedia.org/wiki/Pig_Latin
* https://web.ics.purdue.edu/~morelanj/RAO/prepare2.html
* https://regex101.com/

Thank you for reading. I appreciate the time you've spent using and testing this application. If you've come this far, go get yourself a treat.
