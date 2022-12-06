# Pig Latin Translation Engine
Hey Mike & Team - here's a simple English to Pig Latin translator for you. It handles all provided tests, and works great on both desktop and mobile (although desktop is recommended.)
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
From the project directory, run ```bin/rails server```, ```rails server``` or just ```rails s```.
* NOTE: If you didn't run ```rake db:migrate```, you'll have to click "Run Pending Migrations" in your browser, which will also work.

### Testing 
I decided to use the built-in Rails tests in this project in the interest of simplicity and speed. I've built tests for all key functionality and the provided test cases, including the loading of the single page itself.

To run all available tests, in the project directory, run ```bin/rails test```,  ```rails test``` or just ```rails t```. As this project is small, you'll find the tests under ```test/controllers``` and ```test/models```.

### Assumptions & Rules
* Vowels are A, E, I, O, U and sometimes Y. If the first letter is a Y, we consider it a vowel - as given in the example test "yellow". It is slightly more nuanced than this, but for the sake of time, this is how my code is implemented. All other rules are taken from the provided Wikipedia link, **https://en.wikipedia.org/wiki/Pig_Latin**.
* I've also assumed some things in regards to capitalization - the implementation of which isn't perfect. I've attempted to maintain correct capitalization, e.g. "Hello" => "Ellohay", by tracking the indicies of the capital letters.
* When determining if the suffix ("ay" or "way") should be capitalized, I considered a few approaches. I considered capitalizing the suffix if more than half of the characters in the input string were capitalized, but that seemed like an incorrect approach. I ended up assuming that if the last letter is capitalized, the suffix should be too - this is a simple continuation pattern that feels right based on what I as a user would expect - there's no set rule on this matter, I believe. Feel free to question this!

### Technology & Versioning
* Ruby - 3.1.2
* Rails - 7.0.4
* RVM - 1.29.12
* Postgres 15
* Heroku (deployment)
To see the next steps I'd take with this project, including technology-wise, read further. This is dead-simple for now.

## Design and Implementation Process
Feel free to take a look at my commit history as well. To start, I broke up the input sentence string into an array of words, calling my ```translate``` function on each individual word, passing that translation back to the caller function, and appending it to a new translated string - producing our output. I then display the latest 15 translations dynamically in the front-end of the application. My primary focuses in development were readability, extensibility, consistency, abstraction and completeness. 
### Approaches
Here, I'll document some different possible approaches to the core problem (translating an English sentence into Pig Latin), and my reasons for choosing my eventual solution. As for why I chose Ruby and Rails - I love the language and the framework, and feel very strong in my use of both. It's one of the reasons I'm applying for this position. I considered JavaScript as well, but I consider Ruby to be cleaner and more readable - and additionally, having the core logic condensed into a class and a concern would allow one to simply grab the logic and implement it in their own project - I could even export it as a package if I was feeling fancy.
### 1 - Use a Library
If I were developing this Pig Latin Translation Engine for our client, my first thought would be - "let's not reinvent the wheel." There are typically libraries out there (many of them good) with solutions for almost every common problem. I found one, but didn't test it: https://rubygems.org/gems/pig_latin/versions/0.0.2. There were a few problems with this solution: 
* **1. Using a library would go against the purpose of this problem.** Of course, the purpose of this problem was to test my development skills. I'd likely never implement a Pig Latin Translator for a client, but in this role I would be solving many problems that are unique and therefore require a unique approach - especially as a mid-level engineer in a startup with much to learn. I had a ton of fun with this exercise, and drew a lot of satisfaction from demonstrating my skills. I think this is a good representation of them (aside from my front-end skills with Bootstrap, which is obviously absent. More on that below.)
* **2. Project size overhead.** Why make our project bigger, if it could be smaller? That wouldn't have a big impact on this solution, but in a real world scenario, it's important to consider.

### 2 - Use String Operations
This was my initial, intuitive approach - I knew the string manipulation I had to do the moment I read the prompt for this exercise. Iterate through the input string on each word until a vowel was reached, storing and then deleting the non-vowels before it, and then simply appending those letters to the end of the string followed by "ay" or "way", depending. However, when I implemented this, I got stuck in somewhat of a "loop hell." My code was verbose and ugly and somewhat harder to read (in my opinion) than my evental implementation.
* **1. String operations are simpler to implement.** Logically smooth and sound - there may be a ton of loops required to solve a problem like this, but that's okay - it's still fast, as long as you don't mess up your time complexity and start nesting loops.
* **2. Easier to read.** For those unfamiliar with Regex, string ops are more accessible. However, for this problem, I believe there are many downsides to this approach. As complexity increases, string operations become more complex and harder to maintain - e.g. "loop hell." There is another, cleaner way to manipulate strings in this case, because the problem is not neccesarily trivial.

### 3 - Use REGEX **(Chosen Approach)**
```/^([^aeiou]*)(.*)/```
This is the Regular Expression I implemented. It matches every consonant before the first vowel and returns:
* Group 1: Every character before the first vowel, not counting Y (we check if the first character is a vowel, inclusive of Y, elsewhere). ```([^aeiou]*)```
* Group 2: Every remaining character after and inclusive of that first vowel. ```(.*)```
* We then modify the string, returning "Group 2" + "Group 1". Lastly, we simply add the suffix and punctuation (if applicable.)
This code is found in ```models/translation.rb```, in the ```translate``` function on line 28.

String operations are generally faster than Regex, but this is easier to read and scale. It handles the simple task of, essentially, swapping characters extremely well. There were enough loops in my attempt to implement string operations to cause me to look for another solution - essentially, my code didn't pass the "smell test", suggesting there was a better solution - and this is what I settled with. The "Pig Latinization" of any given word is vastly simplified with this method, entirely replacing a loop. For further explanation, plugging it into regex101.com unpacks every bit of logic needed. 

### Edge Cases Handled & Considered
This program handles every edge case presented in the required tests - namely punctuation, capitalization, and the "qu" sound (example: quick.) Other cases I considered are as follows:

* Input is the empty string (validations don't allow this)
* Input is nil (validations don't allow this either)
* String has inconsistent spacing
* Word contains non-letters
* Word contains non-normal amounts of whitespace
* String is greater or equal to the maximum allowable string size in Ruby: 2^31 - 1 for a 32-bit machine, and 2^63 - 1 for a 64-bit machine. As we don't know the tech capability of every user, I've decided to check against the 32-bit requirements.

### Extensibility and Reusability
* I've added a "Language" column to my Translation table. It's overkill right now, adding some extra verbosity to my code, but makes the Translation class extendible in the future to handle translations of many different languages, if our app should require it. For example, next to the ```to_pig_latin``` function in the Translation model, one could define ```to_french```, ```to_german``` or many other languages, and it would be appropriate.
* I've factored out some of the private methods, scopes, and constants in my Translation model (capitalize, vowel?, REGEXs, etc) into a concern, Translatable - which is the proper place for shared model logic. Currently, there is only one model, but there's lots of logic there that could be used in other language manipulation services that we could implement - logic that would be common across those classes. Many of these Regex constants and functions that could be used widely across the application are now stored in this module and all that remains in the Translation model is logic unique to Pig Latin - allowing easy extension of functionality and cleaner code in the future. I've also put in a lot of effort into making the core Pig Latin Translation logic readable to the point that you don't need to see the functions that live in the concern to understand what they do - additionally de-cluttering our model and its key components. I'm very passionate about readable and maintainable code. 
* I've also added and implemented the appropriate scopes and functions in the Translatable concern, preparing it for extension to many other kinds of languages, as far as the client's imagination could take them. I've made sure to use these scopes where appropriate, assuming Pig Latin won't be the only translated language. I've made the code modular and made sure the functions follow the Single Responsibility Principle.

### Performance
Given an input of size N (example: "she's a great person") we split the input N into an array of each word, and perform a regular-expression operation on those words. The time complexity of a classic, compiled regular expression is ```O(N)```, and so is our single iteration over the length of the input. We further run some ```include?``` and ```match``` functions, which have time complexities of ```O(1)``` and ```O(N)``` respectively. The many Gsub operations are also each ```O(N)```. Our final unique case involves iterating over each word and gathering the indicies of the capital letters, and then (in the worst case of an entirely capitalized word) appropriately capitalizing letters in the translation. The worst case of this scenario, with 3 non-nested loops, is ```O(3n)```. Ignoring the constant as taught, our time complexity comes out to 
* **O(N) time.** 

And, as we generate an extra string to store the translated input, our space complexity is ```O(2N)``` which of course comes out to
* **O(N) space.**

## Next Steps to Improve the Project
* Use AJAX calls and responsive Rails JavaScript controller interactions when clicking "Create Translation" to avoid reloading the entire page and reload only the relevant section of the app instead. This would help to scale and increase the functionality of the application, as reloading the entire page would quickly become an issue, even though it isn't now.
* Refactor the ```translation.to_pig_latin``` line in the controller to ```translation.translate```, and have an if block in the model that checks against the passed language parameter. This is a needed step to make the translation service more extensible, allowing the controller code to be dead simple and just pass parameters, fufilling its one responsibility and reducing the need to change it in the future.
* Get rid of the if/else block in ```translation.rb```, add "y" to the PIG_LATIN_REGEX capture group 1, and determine suffix with a ternary / ifelse checking if the first character is a vowel. This is definetly cleaner.
* Move uppercase logic into the else block (if we don't remove it. Or, create a block that only executes said logic if the first letter is a vowel.) If the first letter is indeed a vowel, we can just retain the capitalization as all we're doing is appending a suffix. This would improve performance.
* ```get_uppercase_indicies``` and ```maintain_capitalization``` in the Translate class both use simple ```each``` loops, but in different ways - this is inconsistent and also something I missed pre-deadline. I should just pick one (and also change ```maintain_capitalization``` to ```re_capitalize```.)
* Similar to the above, to be consistent, modify ```def vowel? c``` to use REGEX. This was one of the first functions I wrote, and its simplicity is why I didn't change it.
* Modify the ```words``` array in ```to_pig_latin``` instead of creating another string, and save some memory by not creating ```translated str```.
* Take the arrays of words and pig latinized words out from my tests and put them in a function, allowing the translation test to be modified in the future to take arrays of different languages - removing the need to ever change the core test.
* Place string checking logic (uppercase? vowel?) into some module that extends the string class so I can call .uppercase? on an instance of a string.
* Add every possible UNICODE punctuation to the PUNCTUATION_REGEX. See my last few commits. I ran into a funny issue here.
* Add more contstraints to database fields and scale its implementation, disallowing certain non-language inputs, if neccesary.
* Implement a frontend framework, and make it beautiful. **This is the most glaring and obvious missing piece.** The plain HTML doesn't look great, but I didn't want to over-engineer this takehome and introduce dependencies. It would be the absolute first thing I implement were I to take this project further. If given more time for this project, I would have chosen React, as that would be used in this role and I'd like to demonstrate my self-teaching capabilities. This includes making the application responsive in both desktop and mobile formats.

More "out there" solutions...

* Add a dynamic text editor, with full Word-like functionality. 
* Add user login/chat functions. Chatting with others in Pig Latin could be really fun.
* Unknown. There are no limits to the clients' desires... and we shall deliver.

## Other Documentation
* https://en.wikipedia.org/wiki/Pig_Latin
* https://web.ics.purdue.edu/~morelanj/RAO/prepare2.html
* https://regex101.com/

Thank you for reading. I appreciate the time you've spent using and testing this application. If you've come this far, go get yourself a treat.
