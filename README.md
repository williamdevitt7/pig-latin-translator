# Pig Latin Translator for a Cool Engineering Team
Hey Mike & Team - here's a simple English to Pig Latin translator for you. It handles all provided tests, and looks nice on mobile.
My email: **will.devitt759@gmail.com**

## Installation & Running the Project
* << PROJECT SITE LINK >>
I've deployed the application to Heroku for your conveinence. See the link above.

However, if you desire to run the project on your local machine, follow these steps (assuming clean setup, no Ruby or Rails.) In your terminal...

* 1: Clone the project to your local machine. Install git if neccessary. 
* 2: Install RVM by following the instructions in this StackOverflow post. https://tinyurl.com/3c8scf7k
* 3: Install ruby-3.0.0 using "rvm install ruby-3.0.0"
* 4: Install Rails with "gem install rails"
* 5: Run "bundle install" to install all project dependencies. 
* 6: Check that your versions are correctly installed with "ruby -v", "rvm -v" and "rails -v".
Please feel free to email me if you have any problems whatsoever. I've included my email at the head of this file.

### Launching the Server
From the project directory, run **bin/rails server**, **rails server** or just **rails s**.

### Testing 
I decided to use the built-in Rails tests in this project in the interest of simplicity and speed.

To run all available tests, in the project directory, run **bin/rails test**,  **rails test** or just **rails t**. As this project is small, you'll find the tests under **test/controllers** and **test/models**.

### Assumptions & Rules
* Vowels are A, E, I, O, U and sometimes Y. If the first letter is a Y, we consider it a vowel - as given in the example test "yellow". It is slightly more nuanced than this, but for the sake of time, this is how my code is implemented. All other rules are taken from the provided Wikipedia link, **https://en.wikipedia.org/wiki/Pig_Latin**.
* I've also assumed some things in regards to capitalization - the implementation of which isn't perfect. I've attempted to maintain correct capitalization, e.g. "Hello" => "Ellohay", by tracking the indicies of the capital letters.
* When determining if the suffix ("ay" or "way") should be capitalized, I considered a few approaches. I considered capitalizing the suffix if more than half of the characters in the input string were capitalized, but that seemed odd. I ended up assuming that if the last letter is capitalized, the suffix should be too - this is a simple continuation pattern that feels right - there's no set rule on this matter, I believe. Feel free to quuestion this!

### Technology & Versioning
* Ruby - 3.0.0
* Rails - 7.0.4
* RVM - 1.29.12
* Sqlite3 - built in.
To see the next steps I'd take with this project, including technology-wise, read further. This is dead-simple for now.

## Design and Implementation Process (for the Dev team!)
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
* Group 1: every character before the first vowel.
* Group 2: every remaining character after that first vowel.
* We then modify the string, returning "Group 2" + "Group 1". Lastly, we simply add the suffix and punctuation (if applicable.)
This code is found in models/translation.rb, in the "translate" function on line 29.
String operations are generally faster than Regex, but this is easier to read and scale. It handles the simple task of, essentially, swapping characters extremely well. The "Pig Latinization" of any given word comes down to one line, after cleaning it up - and plugging it into regex101.com unpacks every bit of logic needed. 

### Edge Cases Handled & Considered
This program handles every edge case presented in the required tests - namely punctuation, capitalization, and the "qu" sound. Other cases I considered are as follows:

* Input is the empty string (validations don't allow this)
* Input is nil (validations don't allow this either)
* String has inconsistent spacing (do I need to account for this?)
* Word contains non-letters
* word contains non-normal amounts of whitespace (trim it???)

I also considered checking against the maximum string size allowed in memory - but decided this was out of scope. 

### Reusability, Extendability
I've added a "Language" column to my Translation table. It's overkill right now, adding some extra verbosity to my code, but makes the Translation class extendable in the future to handle translations of many different languages, if our app should require it. I've also added and implemented the appropriate scopes and function names in my model, preparing it for extension to many other kinds of languages, as far as the client's imagination could take them. I've made the code in the model modular and made sure the functions follow the single responsibility principle.
### Performance
TODO!!!!!!!
### Next Steps:
Some next steps I'd take to improve this project:
* Implement a frontend framework, and make it beautiful.
* Add more contstraints to database fields.
* TODO: CHECK PHONE FOR OTHER THOUGHTS!!!

### Other Documentation
* https://web.ics.purdue.edu/~morelanj/RAO/prepare2.html
* https://en.wikipedia.org/wiki/Pig_Latin
* https://regex101.com/

Thank you for reading. If you've come this far, go get yourself a treat.
