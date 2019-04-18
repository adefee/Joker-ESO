Joker = {
    name            = "Joker",           -- Matches folder and Manifest file names.
    version         = "1.2.1",                -- A nuisance to match to the Manifest.
    author          = "Lent (@CallMeLent, Github @adefee)",
    color           = "DDFFEE",             -- Used in menu titles and so on.
    menuName        = "Joker - Best Enjoyed with Skooma!", -- A UNIQUE identifier for menu object.
    -- Default settings.
    savedVariables = {
      FirstLoad = true,      -- First time the addon is loaded ever.
      FirstEdgy = true,      -- First time an edgy joke has been requested, show warning
      FirstDad = true,       -- First Dad joke, show info
      FirstNorris = true    -- First Norris joke, show info
    }
}

-- isempty()
-- Utility; Checks if given string is empty/nil
function Joker.isempty(s)
  return s == nil or s == ''
end

-- split()
-- Utility; Splits given string after X chars
function Joker.split(str, max_line_length)
  local lines = {}
  local line
  str:gsub('(%s*)(%S+)', 
     function(spc, word) 
        if not line or #line + #spc + #word > max_line_length then
           table.insert(lines, line)
           line = word
        else
           line = line..spc..word
        end
     end
  )
  table.insert(lines, line)
  return lines
end

--[[
  ** Data Grabs
  PURPOSE: These functions just return data
]]

-- GetDadl()
-- Data; Returns random, dad joke
function Joker.GetDad()
  local dadJokes = {
    "I used to just crastinate, but then I was so good I became pro at it. -- @manavortex",
    "Employee of the month is a good example of how somebody can be both a winner and a loser at the same time. -- Demetri Martin",
    "It’s not that I’m afraid to die, I just don’t want to be there when it happens. -- Woody Allen",
    "When I was a boy, I laid in my twin sized bed and wondered where my brother was. -- Mitch Hedberg",
    "My drug test came back negative. My dealer sure has some explaining to do.",
    "I think it’s wrong that only one company makes the game Monopoly. -- Steven Wright",
    "The worst time to have a heart attack is during a game of charades. -- Demetri Martin",
    "I have the world's largest collection of seashells, you may have seen it, I keep it scattered on beaches all over.",
    "I want to die peacefully in my sleep, like my grandfather.. Not screaming and yelling like the passengers in his car.",
    "When life gives you melons, you might be dyslexic.",
    "I don’t want to be part of a club that would have me as a member. -- Groucho Marx",
    "Last night, I played poker with Tarot cards … got a full house and 4 people died. -- Steven Wright",
    "My father has schizophrenia, but he’s good people. -- Stewart Francis",
    "Does my wife think I'm a control freak? I haven't decided yet. -- Stewart Francis",
    "I'm on a whisky diet... I've lost three days already! -- Tommmy Cooper",
    "Honesty may be the best policy, but it’s important to remember that apparently, by elimination, dishonesty is the second-best policy. -- George Carlin",
    "Starbucks says they are going to start putting religious quotes on cups. The very first one will say, 'Jesus! This cup is expensive!' -- Conan O'Brien",
    "I had a wonderful childhood, which is tough because it's hard to adjust to a miserable adulthood -- Larry David",
    "Did you hear about the crook who stole a calendar? He got twelve months.",
    "R.I.P boiled water. You will be mist.",
    "What's the difference between a northern fairytale and a southern fairytale? A northern fairytale begins 'Once upon a time ...' A southern fairytale begins 'Y'all ain't gonna believe this shit ...'",
    "Nurse: 'Doctor, there's a patient on line 1 that says he's invisible'. Doctor: 'Well, tell him I can't see him right now.'",
    "Intelligence is like underwear. It is important that you have it, but not necessary that you show it off.",
    "The older I get, the earlier it gets late.",
    "My girlfriend is always stealing my t-shirts and sweaters... But if I take one of her dresses, suddenly 'we need to talk'.",
    "Last night in my dream I was peeing in bed. Dreams do come true, I realized in the morning.",
    "Smoking will kill you... Bacon will kill you... But,smoking bacon will cure it.",
    "Thanks for explaining the word 'many' to me, it means a lot.",
    "Moses had the first tablet that could connect to the cloud.",
    "About a month before he died, my uncle had his back covered in lard. After that, he went down hill fast.",
    "The first computer dates back to Adam and Eve. It was an Apple with limited memory, just one byte. And then everything crashed.",
    "I'm not saying your perfume is too strong. I'm just saying the canary was alive before you got here.",
    "I grew a beard thinking it would say 'Distinguished Gentleman.' Instead, turns out it says, 'Senior Discount, Please!'",
    "At what age is it appropriate to tell my dog that he's adopted?",
    "I tried to explain to my 4-year-old son that it's perfectly normal to accidentally poop your pants, but he's still making fun of me.",
    "I like having conversations with kids. Grownups never ask me what my third favorite reptile is.",
    "Today a man knocked on my door and asked for a small donation towards the local swimming pool. I gave him a glass of water.",
    "I just read that 5,677,145 people got married last year, not to cause any trouble but shouldn't that be an even number?",
    "I think my neighbor is stalking me as she's been googling my name on her computer. I saw it through my telescope last night.",
    "Feeling pretty proud of myself. The Sesame Street puzzle I bought said 3-5 years, but I finished it in 18 months.",
    "My mom said that if I don't get off my computer and do my homework she'll slam my head on the keyboard, but I think she's jokinfjreoiwjrtwe4to8rkljreun8f4ny84c8y4",
    "Before I criticize a man, I like to walk a mile in his shoes. That way, when I do criticize him, I'm a mile away and I have his shoes.",
    "My wife just found out I replaced our bed with a trampoline; she hit the roof.",
    "I just asked my husband if he remembers what today is... Scaring men is easy.",
    "The question isn't at what age I want to retire, it's at what income.",
    "eBay is so useless. I tried to look up lighters and all they had was 13,749 matches.",
    "My dad died when we couldn't remember his blood type. As he died, he kept insisting for us to 'be positive,' but it's hard without him.",
    "I started out with nothing, and I still have most of it.",
    "I always feel better when my doctor says something is normal for my age but then think dying will also be normal for my age at some point.",
    "I would request a last meal of soda and pop rocks so I could die on my own terms.",
    "She wanted a puppy. But I didn't want a puppy. So we compromised and got a puppy.",
    "Did you know that dolphins are so smart that within a few weeks of captivity, they can train people to stand on the very edge of the pool and throw them fish?",
    "People used to laugh at me when I would say 'I want to be a comedian', well nobody's laughing now.",
    "I changed my password to 'incorrect'. So whenever I forget what it is the computer will say 'Your password is incorrect'.",
    "To this day, the boy that used to bully me at school still takes my lunch money. On the plus side, he makes great Subway sandwiches.",
    "When I told the doctor about my loss of memory, he made me pay in advance.",
    "Artificial intelligence is no match for natural stupidity.",
    "TRUE FRIENDSHIP: Walking into a persons house and your wifi connects automatically.",
    "A computer once beat me at chess, but it was no match for me at kick boxing.",
    "I think we should get rid of democracy. All in favor: raise your hand.",
    "That awkward moment when you leave a store without buying anything and all you can think is 'act natural, you're innocent'.",
    "If you're not supposed to eat at night, why is there a light bulb in the refrigerator?",
    "Math Teacher: 'If I have 5 bottles in one hand and 6 in the other hand, what do I have?' Student: 'A drinking problem.'",
    "Light travels faster than sound. This is why some people appear bright until you hear them speak.",
    "I hate people who use big words just to make themselves look perspicacious.",
    "I named my dog 6 miles so I can tell people that I walk 6 miles every single day.",
    "I used to think I was indecisive, but now I'm not too sure.",
    "We just got a fax. At work. We didn't know we had a fax machine. The entire department just stared at it. I poked it with a stick.",
    "One day you're the best thing since sliced bread. The next, you're toast.",
    "Just burned 2,000 calories. That's the last time I leave brownies in the oven while I nap.",
    "I didn't say it was your fault, I said I was blaming you.",
    "Don't you hate it when someone answers their own questions? I do.",
    "I won $3 million on the lottery this weekend so I decided to donate a quarter of it to charity. Now I have $2,999,999.75.",
    "Scientists say the universe is made up of Protons, Neutrons, and Electrons. They forgot to mention Morons.",
    "My email password has been hacked. That's the third time I've had to rename the cat.",
    "I didn't fight my way to the top of the food chain to be a vegetarian.",
    "Life is all about perspective. The sinking of the Titanic was a miracle to the lobsters in the ship's kitchen.",
    "You can make a water-bed more bouncy by using spring water.",
    "Team work is important; it helps to put the blame on someone else.",
    "The man who created autocorrect has died. Resturant in Peacce.",
    "Don't trust atoms, they make up everything.",
    "Did you hear about the semi-colon that broke the law? He was given two consecutive sentences.",
    "To the mathematicians who thought of the idea of zero, thanks for nothing!",
    "Claustrophobic people are more productive thinking out of the box.",
    "Spoiler alert! The milk has been in the fridge for three weeks.",
    "What do you get when you cross a joke with a rhetorical question?",
    "A pun, a play on words, and a limerick walk into a bar. No joke.",
    "Did you hear about the mathematician who's afraid of negative numbers? He will stop at nothing to avoid them!",
    "Why did Beethoven get rid of all his chickens? All they said was 'Bach, Bach Bach'!",
    "C, E-flat, and G walk into a bar. The bartender shows them the door, saying 'Sorry, we don't serve minors!'",
    "A sign at a music shop: 'Gone Chopin, be Back in a minuet!'",
    "What was Beethoven's favorite fruit? Ba-na-na-naaaaaaa!",
    "A photon is going through security. The TSA agent asks if he has any luggage. The photo cooly replies, 'No, I'm traveling light!'",
    "The bartender says 'Sorry, we don't server time travelers here'. A time traveler walks into a bar.",
    "What did the Buddhist say to the hot dog vendor? 'Make me one with everything.'",
    "If you jumped off the bridge in Paris, you'd be in Seine.",
    "A German walks into a bar and asks for a martini. The bartender asks, 'Dry?' The German replies, 'Nein, just one.'",
    "Did you hear about the weekly poker game with Vasco da Gama, Columbus, Erikson, & Pizzaro? They can never seem to beat the straights of Magellan.",
    "If you're American when you go in the bathroom and American when you come out, what are you in the bathroom? European.",
    "What do you call a fish with no eyes? A fsh.",
    "What do you call a can opener that doesn't work? A can't opener!",
    "There are three types of people in the world: those who can count, and those who can't.",
    "Did you hear about the Italian chef who died? He pasta-way.",
    "I sold my vacuum the other day. All it was doing was collecting dust.",
    "What is Forrest Gump's email password? 1forrest1",
    "Two windmills are standing in a wind farm. One asks, 'What's your favorite music genre?' The other replies, 'I'm a big metal fan.'",
    "Did you hear about the guy who invented the knock knock joke? He won the no-bell prize.",
    "I like elephants. Everythign else is irrelephant.",
    "What's red and bad for your teeth? A brick.",
    "Why does Snoop Dogg use an umbrella? For drizzle.",
    "The astronaut was claustrophobic; he just needed some space.",
    "Noses can't be more than 11 inches long, because then they'd be a foot.",
    "My wedding was so beautiful, even the cake was in tiers!",
    "A dyslexic man walks into a bra...",
    "What do you call a fly with no wings? A walk.",
    "What did the janitor yell when he jumped out of the closet? 'Supplies!'",
    "It's not appropriate to make a 'dad joke' if you are not a dad. It's a faux pa.",
    "What's the most terrifying word in nuclear physics? 'Oops!'",
    "I'm writing a horror screenplay. It starts off with a ringing phone. The person answers, and it's their relative saying 'I have a computer question.'",
    "The other day, my wife asked me to pass her lipstick but I accidentally passed her a glue stick. She still isn't talking to me.",
    "It’s important to have a good vocabulary. If I had known the difference between the words 'antidote' and 'anecdote,' one of my good friends would still be alive.",
    "When ordering food at a restaurant, I asked the waiter how they prepare their chicken. 'Nothing special,' he explained. 'We just tell them they're going to die.'",
    "What's the last thing to go through a fly's head as it hits the windshield of a car going 70mph? Its butt.",
    "What did the fish say when it hit the wall? Dam.",
    "How do you make a tissue dance? You put a little boogie on it.",
    "What's Forrest Gump's password? 1Forrest1",
    "What do you call a belt made out of watches? A waist of time.",
    "Why can't bicycles stand on their own? They are two tired",
    "How does a train eat? It goes chew, chew",
    "What do you call a singing Laptop A Dell",
    "How many lips does a flower have? Tulips",
    "How do you organize an outer space party? You planet",
    "What kind of shoes does a thief wear? Sneakers",
    "What's the best time to go to the dentist? Tooth hurty.",
    "Knock knock. Who's there? A broken pencil. A broken pencil who? Never mind. It's pointless.",
    "Knock knock. Who's there? Cows go. Cows go who? No, cows go moo.",
    "Knock knock. Who's there? Little old lady. Little old lady who? I didn't know you could yodel!",
    "What's the best thing about a Boolean? Even if you're wrong, you're only off by a bit.",
    "What's the object-oriented way to become wealthy? Inheritance",
    "Where do programmers like to hangout? The Foo Bar.",
    "Why did the programmer quit his job? Because he didn't get arrays.",
    "Did you hear about the two silk worms in a race? It ended in a tie.",
    "What do you call a laughing motorcycle? A Yamahahahaha.",
    "A termite walks into a bar and says... 'Where is the bar tended?'",
    "What does C.S. Lewis keep at the back of his wardrobe? Narnia business!",
    "Why do programmers always mix up Halloween and Christmas? Because Oct 31 == Dec 25",
    "A SQL query walks into a bar, walks up to two tables and asks... 'Can I join you?'",
    "How many programmers does it take to change a lightbulb? None that's a hardware problem",
    "If you put a million monkeys at a million keyboards, one of them will eventually write a Java program the rest of them will write Perl",
    "['hip', 'hip'] (hip hip array)",
    "To understand what recursion is... You must first understand what recursion is",
    "There are 10 types of people in this world... Those who understand binary and those who don't",
    "What did the duck say when he bought lipstick? Put it on my bill",
    "What happens to a frog's car when it breaks down? It gets toad away",
    "did you know the first French fries weren't cooked in France? they were cooked in Greece",
    "Which song would an exception sing? Can't catch me - Avicii",
    "Knock knock. Who's there? Opportunity. That is impossible. Opportunity doesn’t come knocking twice!",
    "Why do Java programmers wear glasses? Because they don't C#",
    "Why did the mushroom get invited to the party? Because he was a fungi.",
    "I'm reading a book about anti-gravity... It's impossible to put down",
    "If you're American when you go into the bathroom, and American when you come out, what are you when you're in there? European",
    "Want to hear a joke about a piece of paper? Never mind...it's tearable",
    "I just watched a documentary about beavers. It was the best dam show I ever saw",
    "If you see a robbery at an Apple Store... Does that make you an iWitness?",
    "A ham sandwhich walks into a bar and orders a beer. The bartender says... I'm sorry, we don't serve food here",
    "Why did the Clydesdale give the pony a glass of water? Because he was a little horse",
    "If you boil a clown... Do you get a laughing stock?",
    "Finally realized why my plant sits around doing nothing all day... He loves his pot.",
    "Don't look at the eclipse through a colander. You'll strain your eyes.",
    "I bought some shoes from a drug dealer. I don't know what he laced them with, but I was tripping all day!",
    "Why do chicken coops only have two doors? Because if they had four, they would be chicken sedans",
    "What do you call a factory that sells passable products? A satisfactory",
    "When a dad drives past a graveyard: Did you know that's a popular cemetery? Yep, people are just dying to get in there",
    "Why did the invisible man turn down the job offer? He couldn't see himself doing it",
    "How do you make holy water? You boil the hell out of it",
    "I had a dream that I was a muffler last night. I woke up exhausted!",
    "Why is peter pan always flying? Because he neverlands",
    "How do you check if a webpage is HTML5? Try it out on Internet Explorer",
    "What do you call a cow with no legs? Ground beef!",
    "I dropped a pear in my car this morning. You should drop another one, then you would have a pair.",
    "A user interface is like a joke. If you have to explain it then it is not that good.",
    "Knock knock. Who's there? Hatch. Hatch who? Bless you!",
    "What do you call sad coffee? Despresso.",
    "Why did the butcher work extra hours at the shop? To make ends meat.",
    "Did you hear about the hungry clock? It went back four seconds.",
    "Well... That’s a deep subject.",
    "Did You Hear The Story About The Cheese That Saved The World? It was legend dairy.",
    "Did You Watch The New Comic Book Movie? It was very graphic!",
    "I Started A New Business Making Yachts In My Attic This Year... The sails are going through the roof.",
    "I Got Hit In the Head By A Soda Can, But It Didn't Hurt That Much... It was a soft drink.",
    "I Can't Tell If I Like This Blender... It keeps giving me mixed results.",
    "WI Couldn't Get A Reservation At The Library... They were fully booked.",
    "I was gonna tell you a joke about UDP... ...but you might not get it.",
    "The punchline often arrives before the set-up. Do you know the problem with UDP jokes?",
    "Why do C# and Java developers keep breaking their keyboards? Because they use a strongly typed language.",
    "What do you give to a lemon in need? Lemonaid.",
    "Never take advice from electrons. They are always negative.",
    "Hey, dad, did you get a haircut? No, I got them all cut.",
    "What time is it? I don't know... it keeps changing.",
    "A weasel walks into a bar. The bartender says, 'Wow, I've never served a weasel before. What can I get for you?' Pop,goes the weasel.",
    "Bad at golf? Join the club.",
    "Can a kangaroo jump higher than the Empire State Building? Of course. The Empire State Building can't jump.",
    "Can February march? No, but April may.",
    "Can I watch the TV? Yes, but don’t turn it on.",
    "Dad, can you put my shoes on? I don't think they'll fit me.",
    "Did you hear about the bread factory burning down? They say the business is toast.",
    "Did you hear about the chameleon who couldn't change color? They had a reptile dysfunction.",
    "Did you hear about the cheese factory that exploded in France? There was nothing left but de Brie.",
    "Did you hear about the cow who jumped over the barbed wire fence? It was udder destruction.",
    "Did you hear about the guy who invented Lifesavers? They say he made a mint.",
    "Did you hear about the guy whose whole left side was cut off? He's all right now.",
    "Did you hear about the kidnapping at school? It's ok, he woke up.",
    "Did you hear about the Mexican train killer? He had loco motives",
    "Did you hear about the new restaurant on the moon? The food is great, but there’s just no atmosphere.",
    "Did you hear about the runner who was criticized? He just took it in stride",
    "Did you hear about the scientist who was lab partners with a pot of boiling water? He had a very esteemed colleague.",
    "Did you hear about the submarine industry? It really took a dive...",
    "Did you hear that David lost his ID in prague? Now we just have to call him Dav.",
    "Did you hear that the police have a warrant out on a midget psychic ripping people off? It reads 'Small medium at large.'",
    "Did you hear the joke about the wandering nun? She was a roman catholic.",
    "Did you hear the news? FedEx and UPS are merging. They’re going to go by the name Fed-Up from now on.",
    "Did you hear the one about the guy with the broken hearing aid? Neither did he.",
    "Did you know crocodiles could grow up to 15 feet? But most just have 4.",
    "What do ghosts call their true love? Their ghoul-friend",
    "Did you know that protons have mass? I didn't even know they were catholic.",
    "Did you know you should always take an extra pair of pants golfing? Just in case you get a hole in one.",
    "Do I enjoy making courthouse puns? Guilty",
    "Do you know where you can get chicken broth in bulk? The stock market.",
    "Do you want a brief explanation of what an acorn is? In a nutshell, it's an oak tree.",
    "Ever wondered why bees hum? It's because they don't know the words.",
    "Have you ever heard of a music group called Cellophane? They mostly wrap.",
    "Have you heard of the band 1023MB? They haven't got a gig yet.",
    "Have you heard the rumor going around about butter? Never mind, I shouldn't spread it.",
    "How are false teeth like stars? They come out at night!",
    "How can you tell a vampire has a cold? They start coffin.",
    "How come a man driving a train got struck by lightning? He was a good conductor.",
    "How come the stadium got hot after the game? Because all of the fans left.",
    "How did Darth Vader know what Luke was getting for Christmas? He felt his presents.",
    "How did the hipster burn the roof of his mouth? He ate the pizza before it was cool.",
    "How do hens stay fit? They always egg-cercise!",
    "How do locomotives know where they're going? Lots of training",
    "How do the trees get on the internet? They log on.",
    "How do you find Will Smith in the snow?  Look for fresh prints.",
    "How do you fix a broken pizza? With tomato paste.",
    "How do you fix a damaged jack-o-lantern? You use a pumpkin patch.",
    "How do you get a baby alien to sleep?  You rocket.",
    "How do you get two whales in a car? Start in England and drive West.",
    "How do you know if there’s an elephant under your bed? Your head hits the ceiling!",
    "How do you make a hankie dance? Put a little boogie in it.",
    "How do you make holy water? You boil the hell out of it.",
    "How do you organize a space party? You planet.",
    "How do you steal a coat? You jacket.",
    "How do you tell the difference between a crocodile and an alligator? You will see one later and one in a while.",
    "How does a dyslexic poet write? Inverse.",
    "How does a French skeleton say hello? Bone-jour.",
    "How does a penguin build it’s house? Igloos it together.",
    "How does a scientist freshen their breath? With experi-mints!",
    "How does the moon cut his hair? Eclipse it.",
    "How many apples grow on a tree? All of them!",
    "How many bones are in the human hand? A handful of them.",
    "How many hipsters does it take to change a lightbulb? Oh, it's a really obscure number. You've probably never heard of it.",
    "How many kids with ADD does it take to change a lightbulb? Let's go ride bikes!",
    "How many optometrists does it take to change a light bulb? 1 or 2? 1... or 2?",
    "How many seconds are in a year? 12. January 2nd, February 2nd, March 2nd, April 2nd.... etc",
    "How many South Americans does it take to change a lightbulb? A Brazilian",
    "How many tickles does it take to tickle an octopus? Ten-tickles!",
    "How much does a hipster weigh? An instagram.",
    "How was the snow globe feeling after the storm? A little shaken.",
    "Is the pool safe for diving? It deep ends.",
    "Is there a hole in your shoe? No… Then how’d you get your foot in it?",
    "What did the spaghetti say to the other spaghetti? Pasta la vista, baby!",
    "What’s 50 Cent’s name in Zimbabwe? 200 Dollars.",
    "Want to hear a chimney joke? Got stacks of em! First one's on the house",
    "Want to hear a joke about construction? Nah, I'm still working on it.",
    "Want to hear my pizza joke? Never mind, it's too cheesy.",
    "What animal is always at a game of cricket? A bat.",
    "What are the strongest days of the week? Saturday and Sunday...the rest are weekdays.",
    "What biscuit does a short person like? Shortbread. ",
    "What cheese can never be yours? Nacho cheese.",
    "What creature is smarter than a talking parrot? A spelling bee.",
    "What did celery say when he broke up with his girlfriend? She wasn't right for me, so I really don't carrot all.",
    "What did Michael Jackson name his denim store?    Billy Jeans!",
    "What did one nut say as he chased another nut?  I'm a cashew!",
    "What did one plate say to the other plate? Dinner is on me!",
    "What did one snowman say to the other snow man? Do you smell carrot?",
    "What did one wall say to the other wall? I'll meet you at the corner!",
    "What did Romans use to cut pizza before the rolling cutter was invented? Lil Caesars",
    "What did the 0 say to the 8? Nice belt.",
    "What did the beaver say to the tree? It's been nice gnawing you.",
    "What did the big flower say to the littler flower? Hi, bud!",
    "What did the Buffalo say to his little boy when he dropped him off at school? Bison.",
    "What did the digital clock say to the grandfather clock? Look, no hands!",
    "What did the dog say to the two trees? Bark bark.",
    "What did the Dorito farmer say to the other Dorito farmer? Cool Ranch!",
    "What did the fish say when it swam into a wall? Damn!",
    "What did the grape do when he got stepped on? He let out a little wine.",
    "What did the judge say to the dentist? Do you swear to pull the tooth, the whole tooth and nothing but the tooth?",
    "What did the late tomato say to the early tomato? I’ll ketch up",
    "What did the left eye say to the right eye? Between us, something smells!",
    "What did the mountain climber name his son? Cliff.",
    "What did the ocean say to the beach? Thanks for all the sediment.",
    "What did the ocean say to the shore? Nothing, it just waved.",
    "Why don't you find hippopotamuses hiding in trees? They're really good at it.",
    "What did the pirate say on his 80th birthday? Aye Matey!",
    "What did the Red light say to the Green light? Don't look at me I'm changing!",
    "What did the scarf say to the hat? You go on ahead, I am going to hang around a bit longer.",
    "What did the shy pebble wish for? That she was a little boulder.",
    "What did the traffic light say to the car as it passed? Don't look I'm changing!",
    "What did the Zen Buddist say to the hotdog vendor? Make me one with everything.",
    "What do birds give out on Halloween? Tweets.",
    "What do I look like? A JOKE MACHINE!?",
    "What do prisoners use to call each other? Cell phones.",
    "What do vegetarian zombies eat? Grrrrrainnnnnssss.",
    "What do you call a bear with no teeth? A gummy bear!",
    "What do you call a bee that lives in America? A USB.",
    "What do you call a boomerang that won't come back? A stick.",
    "What do you call a careful wolf? Aware wolf.",
    "What do you call a cow on a trampoline? A milk shake!",
    "What do you call a cow with no legs? Ground beef.",
    "What do you call a cow with two legs? Lean beef.",
    "What do you call a crowd of chess players bragging about their wins in a hotel lobby? Chess nuts boasting in an open foyer.",
    "What do you call a dad that has fallen through the ice? A Popsicle.",
    "What do you call a dictionary on drugs? High definition.",
    "what do you call a dog that can do magic tricks? a labracadabrador",
    "What do you call a droid that takes the long way around? R2 detour.",
    "What do you call a duck that gets all A's? A wise quacker.",
    "What do you call a fake noodle? An impasta.",
    "What do you call a fashionable lawn statue with an excellent sense of rhythmn? A metro-gnome",
    "What do you call a fat psychic? A four-chin teller.",
    "What do you call a fly without wings? A walk.",
    "What do you call a girl between two posts? Annette.",
    "What do you call a group of disorganized cats? A cat-tastrophe.",
    "What do you call a group of killer whales playing instruments? An Orca-stra.",
    "What do you call a monkey in a mine field? A babooooom!",
    "What do you call a nervous javelin thrower? Shakespeare.",
    "What do you call a pig that knows karate? A pork chop!",
    "What do you call a pig with three eyes? Piiig",
    "What do you call a pile of cats?  A Meowtain.",
    "What do you call a sheep with no legs? A cloud.",
    "What do you call a troublesome Canadian high schooler? A poutine.",
    "What do you call an alligator in a vest? An in-vest-igator!",
    "What do you call an Argentinian with a rubber toe? Roberto",
    "What do you call an eagle who can play the piano? Talonted!",
    "What do you call an elephant that doesn’t matter? An irrelephant.",
    "What do you call an old snowman? Water.",
    "What do you call cheese by itself? Provolone.",
    "What do you call corn that joins the army? Kernel.",
    "What do you call someone with no nose? Nobody knows.",
    "What do you call two barracuda fish?  A Pairacuda!",
    "What do you do on a remote island? Try and find the TV island it belongs to.",
    "What do you do when you see a space man? Park your car, man.",
    "What do you get hanging from Apple trees? Sore arms.",
    "What do you get when you cross a bee and a sheep? A bah-humbug.",
    "What do you get when you cross a chicken with a skunk? A fowl smell!",
    "What do you get when you cross a rabbit with a water hose? Hare spray.",
    "What do you get when you cross a snowman with a vampire? Frostbite.",
    "What do you give a sick lemon? Lemonaid.",
    "What does a clock do when it's hungry? It goes back four seconds!",
    "What does a female snake use for support? A co-Bra!",
    "What does a pirate pay for his corn? A buccaneer!",
    "What does an angry pepper do? It gets jalapeño face.",
    "What happens to a frog's car when it breaks down? It gets toad.",
    "What happens when you anger a brain surgeon? They will give you a piece of your mind.",
    "What has ears but cannot hear? A field of corn.",
    "What is a centipedes's favorite Beatle song?  I want to hold your hand, hand, hand, hand...",
    "What is a tornado's favorite game to play? Twister!",
    "What is a vampire's favorite fruit? A blood orange.",
    "What is a witch's favorite subject in school? Spelling!",
    "What is red and smells like blue paint? Red paint!",
    "What is the difference between ignorance and apathy? I don't know and I don't care.",
    "What is the hardest part about sky diving? The ground.",
    "What is the leading cause of dry skin? Towels",
    "What is the least spoken language in the world? Sign Language",
    "What is the tallest building in the world? The library, it’s got the most stories!",
    "What is this movie about? It is about 2 hours long.",
    "What kind of award did the dentist receive? A little plaque.",
    "What kind of bagel can fly? A plain bagel.",
    "What kind of dinosaur loves to sleep? A stega-snore-us.",
    "What kind of dog lives in a particle accelerator? A Fermilabrador Retriever.",
    "What kind of magic do cows believe in? MOODOO.",
    "What kind of music do planets listen to? Nep-tunes.",
    "What kind of pants do ghosts wear? Boo jeans.",
    "What kind of tree fits in your hand? A palm tree!",
    "What lies at the bottom of the ocean and twitches? A nervous wreck.",
    "What musical instrument is found in the bathroom? A tuba toothpaste.",
    "What time did the man go to the dentist? Tooth hurt-y.",
    "What type of music do balloons hate? Pop music!",
    "What was a more important invention than the first telephone? The second one.",
    "What was the pumpkin’s favorite sport? Squash.",
    "What's black and white and read all over? The newspaper.",
    "What's blue and not very heavy?  Light blue.",
    "What's brown and sticky? A stick.",
    "What's orange and sounds like a parrot? A Carrot.",
    "What's red and bad for your teeth? A Brick.",
    "What's the best thing about elevator jokes? They work on so many levels.",
    "What's the difference between a guitar and a fish? You can tune a guitar but you can't 'tuna'fish!",
    "What's the difference between a hippo and a zippo? One is really heavy, the other is a little lighter.",
    "What's the difference between a seal and a sea lion? An ion! ",
    "What's the worst part about being a cross-eyed teacher? They can't control their pupils.",
    "What's the worst thing about ancient history class? The teachers tend to Babylon.",
    "What’s brown and sounds like a bell? Dung!",
    "What’s E.T. short for? He’s only got little legs.",
    "What’s Forest Gump’s Facebook password? 1forest1",
    "What’s the advantage of living in Switzerland? Well, the flag is a big plus.",
    "What’s the difference between an African elephant and an Indian elephant? About 5000 miles.",
    "When do doctors get angry? When they run out of patients.",
    "When does a joke become a dad joke? When it becomes apparent.",
    "When is a door not a door? When it's ajar.",
    "Where did you learn to make ice cream? Sunday school.",
    "Where do bees go to the bathroom?  The BP station.",
    "Where do hamburgers go to dance? The meat-ball.",
    "Where do rabbits go after they get married? On a bunny-moon.",
    "Where do sheep go to get their hair cut? The baa-baa shop.",
    "Where do you learn to make banana splits? At sundae school.",
    "Where do young cows eat lunch? In the calf-ateria.",
    "Where does batman go to the bathroom? The batroom.",
    "Where does Fonzie like to go for lunch? Chick-Fil-Eyyyyyyyy.",
    "Where does Napoleon keep his armies? In his sleevies.",
    "Where was the Declaration of Independence signed? At the bottom! ",
    "Where’s the bin? I haven’t been anywhere!",
    "Which side of the chicken has more feathers? The outside.",
    "Who did the wizard marry? His ghoul-friend",
    "Who is the coolest Doctor in the hospital? The hip Doctor!",
    "Why are fish easy to weigh? Because they have their own scales.",
    "Why are fish so smart? Because they live in schools!",
    "Why are ghosts bad liars? Because you can see right through them!",
    "Why are graveyards so noisy? Because of all the coffin.",
    "Why are mummys scared of vacation? They're afraid to unwind.",
    "Why are oranges the smartest fruit? Because they are made to concentrate. ",
    "Why are pirates called pirates? Because they arrr!",
    "Why are skeletons so calm? Because nothing gets under their skin.",
    "Why can't a bicycle stand on its own? It's two-tired.",
    "Why can't you use 'Beef stew'as a password? Because it's not stroganoff.",
    "Why can't your nose be 12 inches long? Because then it'd be a foot!",
    "Why can’t you hear a pterodactyl go to the bathroom? The p is silent.",
    "Why couldn't the kid see the pirate movie? Because it was rated arrr!",
    "Why couldn't the lifeguard save the hippie? He was too far out, man.",
    "Why did Dracula lie in the wrong coffin? He made a grave mistake.",
    "Why did Sweden start painting barcodes on the sides of their battleships? So they could Scandinavian.",
    "Why did the A go to the bathroom and come out as an E? Because he had a vowel movement.",
    "Why did the barber win the race? He took a short cut.",
    "Why did the belt go to prison? He held up a pair of pants!",
    "Why did the burglar hang his mugshot on the wall? To prove that he was framed!",
    "Why did the chicken get a penalty? For fowl play.",
    "Why did the Clydesdale give the pony a glass of water?  Because he was a little horse!",
    "Why did the coffee file a police report? It got mugged.",
    "Why did the cookie cry? Because his mother was a wafer so long",
    "Why did the cookie cry? It was feeling crumby.",
    "Why did the cowboy have a weiner dog? Somebody told him to get a long little doggy.",
    "Why did the fireman wear red, white, and blue suspenders? To hold his pants up.",
    "Why did the girl smear peanut butter on the road? To go with the traffic jam.",
    "Why did the half blind man fall in the well? Because he couldn't see that well!",
    "Why did the house go to the doctor? It was having window panes.",
    "Why did the kid cross the playground? To get to the other slide.",
    "Why did the man put his money in the freezer? He wanted cold hard cash!",
    "Why did the man run around his bed? Because he was trying to catch up on his sleep!",
    "Why did the melons plan a big wedding? Because they cantaloupe!",
    "Why did the octopus beat the shark in a fight? Because it was well armed.",
    "Why did the opera singer go sailing? They wanted to hit the high Cs.",
    "Why did the scarecrow win an award? Because he was outstanding in his field.",
    "Why did the tomato blush? Because it saw the salad dressing.",
    "Why did the tree go to the dentist? It needed a root canal.",
    "Why did the worker get fired from the orange juice factory? Lack of concentration.",
    "Why didn't the number 4 get into the nightclub? Because he is 2 square.",
    "Why didn’t the orange win the race? It ran out of juice.",
    "Why didn’t the skeleton cross the road? Because he had no guts.",
    "Why do bananas have to put on sunscreen before they go to the beach? Because they might peel!",
    "Why do bears have hairy coats? Fur protection.",
    "Why do bees have sticky hair? Because they use honey combs!",
    "Why do bees hum? Because they don't know the words.",
    "Why do birds fly south for the winter? Because it's too far to walk.",
    "Why do choirs keep buckets handy? So they can carry their tune",
    "Why do crabs never give to charity? Because they’re shellfish.",
    "Why do ducks make great detectives? They always quack the case.",
    "Why do mathematicians hate the U.S.? Because it's indivisible.",
    "Why do pirates not know the alphabet? They always get stuck at 'C'.",
    "Why do pumpkins sit on people’s porches? They have no hands to knock on the door.",
    "Why do scuba divers fall backwards into the water? Because if they fell forwards they’d still be in the boat.",
    "Why do trees seem suspicious on sunny days? Dunno, they're just a bit shady.",
    "Why do valley girls hang out in odd numbered groups? Because they can't even.",
    "Why do wizards clean their teeth three times a day? To prevent bat breath!",
    "Why do you never see elephants hiding in trees? Because they're so good at it.",
    "Why does a chicken coop only have two doors? Because if it had four doors it would be a chicken sedan.",
    "Why does a Moon-rock taste better than an Earth-rock? Because it's a little meteor.",
    "Why does it take longer to get from 1st to 2nd base, than it does to get from 2nd to 3rd base? Because there’s a Shortstop in between!",
    "Why does Norway have barcodes on their battleships? So when they get back to port, they can Scandinavian.",
    "Why does Superman get invited to dinners? Because he is a Supperhero.",
    "Why does Waldo only wear stripes? Because he doesn't want to be spotted.",
    "I'm tired of following my dreams. I'm just going to ask them where they are going and meet up with them later.",
    "Did you hear about the guy whose whole left side was cut off? He's all right now.",
    "Why didn’t the skeleton cross the road? Because he had no guts.",
    "What did one nut say as he chased another nut?  I'm a cashew!",
    "I knew I shouldn't steal a mixer from work, but it was a whisk I was willing to take.",
    "How come the stadium got hot after the game? Because all of the fans left.",
    "Why was it called the dark ages? Because of all the knights. ",
    "A steak pun is a rare medium well done.",
    "Why did the tomato blush? Because it saw the salad dressing.",
    "Did you hear the joke about the wandering nun? She was a roman catholic.",
    "What creature is smarter than a talking parrot? A spelling bee.",
    "I'll tell you what often gets over looked... garden fences.",
    "Why did the kid cross the playground? To get to the other slide.",
    "Why do birds fly south for the winter? Because it's too far to walk.",
    "What is a centipedes's favorite Beatle song?  I want to hold your hand, hand, hand, hand...",
    "My first time using an elevator was an uplifting experience. The second time let me down.",
    "To be Frank, I'd have to change my name.",
    "Slept like a log last night … woke up in the fireplace.",
    "Why does a Moon-rock taste better than an Earth-rock? Because it's a little meteor.",
    "I thought my wife was joking when she said she'd leave me if I didn't stop signing 'I'm A Believer'... Then I saw her face.",
    "Why do trees seem suspicious on sunny days? Dunno, they're just a bit shady.",
    "If at first you don't succeed, sky diving is not for you!",
    "A book just fell on my head. I only have my shelf to blame.",
    "What did the dog say to the two trees? Bark bark.",
    "Why can't your nose be 12 inches long? Because then it'd be a foot!",
    "Have you ever heard of a music group called Cellophane? They mostly wrap.",
    "What did the mountain climber name his son? Cliff.",
    "Why should you never trust a pig with a secret? Because it's bound to squeal.",
    "Why are mummys scared of vacation? They're afraid to unwind.",
    "Whiteboards ... are remarkable.",
    "What kind of dinosaur loves to sleep? A stega-snore-us.",
    "What’s Forest Gump’s Facebook password? 1forest1",
    "What kind of tree fits in your hand? A palm tree!",
    "Whenever the cashier at the grocery store asks my dad if he would like the milk in a bag he replies, ‘No, just leave it in the carton!’",
    "I used to be addicted to the hokey pokey, but I turned myself around.",
    "How many tickles does it take to tickle an octopus? Ten-tickles!",
    "Me: If humans lose the ability to hear high frequency volumes as they get older, can my 4 week old son hear a dog whistle?  Doctor: No, humans can never hear that high of a frequency no matter what age they are.  Me: Trick question... dogs can't whistle.",
    "What musical instrument is found in the bathroom? A tuba toothpaste.",
    "My boss told me to attach two pieces of wood together... I totally nailed it!",
    "What was the pumpkin’s favorite sport?  Squash.",
    "Recent survey revealed 6 out of 7 dwarf's aren't happy.",
    "What do you call corn that joins the army? Kernel.",
    "‘Put the cat out’ … ‘I didn’t realize it was on fire",
    "Is there a hole in your shoe? No… Then how’d you get your foot in it?",
    "Every night at 11:11, I make a wish that someone will come fix my broken clock.",
    "Two muffins were sitting in an oven, and the first looks over to the second, and says, “man, it’s really hot in here”. The second looks over at the first with a surprised look, and answers, “WHOA, a talking muffin!”",
    "What's the difference between a guitar and a fish? You can tune a guitar but you can't 'tuna' fish!",
    "Did you hear that the police have a warrant out on a midget psychic ripping people off? It reads “Small medium at large.”",
    "Just read a few facts about frogs. They were ribbiting.",
    "Two satellites decided to get married. The wedding wasn't much, but the reception was incredible.",
    "They tried to make a diamond shaped like a duck. It quacked under the pressure.",
    "Where’s the bin? Dad: I haven’t been anywhere!",
    "Why do bears have hairy coats? Fur protection.",
    "What do you get when you cross a bee and a sheep? A bah-humbug. ",
    "What did one snowman say to the other snow man? Do you smell carrot?",
    "Why do bees hum? Because they don't know the words.",
    "What do you call a troublesome Canadian high schooler? A poutine.",
    "A magician was driving down the street and then he turned into a driveway.",
    "Don't trust atoms. They make up everything.",
    "If you walk into a forest and cut down a tree, but the tree doesn't understand why you cut it down, do you think it's stumped?",
    "Where do bees go to the bathroom?  The BP station.",
    "Why did the tree go to the dentist? It needed a root canal.",
    "It was raining cats and dogs the other day. I almost stepped in a poodle.",
    "Why do bananas have to put on sunscreen before they go to the beach? Because they might peel!",
    "What do you call a bee that lives in America? A USB.",
    "I was wondering why the frisbee was getting bigger, then it hit me.",
    "What's the difference between a hippo and a zippo? One is really heavy, the other is a little lighter.",
    "I couldn't figure out how the seat belt worked. Then it just clicked.",
    "What do you call a dad that has fallen through the ice? A Popsicle.",
    "Two parrots are sitting on a perch. One turns to the other and asks, 'do you smell fish?'",
    "Bad at golf? Join the club.",
    "What do you call a pile of cats?  A Meowtain.",
    "How do hens stay fit? They always egg-cercise!",
    "Can a kangaroo jump higher than the Empire State Building? Of course. The Empire State Building can't jump.",
    "What do you give a sick lemon? Lemonaid.",
    "What do you call an old snowman? Water.",
    "I just got fired from a florist, apparently I took too many leaves.",
    "Why don’t skeletons ever go trick or treating? Because they have nobody to go with.",
    "What does a female snake use for support? A co-Bra!",
    "'Dad, I'm cold.' 'Go stand in the corner, I hear it's 90 degrees.'",
    "Child: Dad, make me a sandwich. Dad: Poof! You're a sandwich.",
    "Why are graveyards so noisy? Because of all the coffin.",
    "What kind of bagel can fly? A plain bagel.",
    "How many apples grow on a tree? All of them!",
    "What do you call a careful wolf? Aware wolf.",
    "I was just looking at my ceiling. Not sure if it’s the best ceiling in the world, but it’s definitely up there.",
    "Why do valley girls hang out in odd numbered groups? Because they can't even.",
    "“My Dog has no nose.” “How does he smell?” “Awful”",
    "What do you call a cow with no legs? Ground beef.",
    "Why did the half blind man fall in the well? Because he couldn't see that well!",
    "As I suspected, someone has been adding soil to my garden. The plot thickens.",
    "It’s hard to explain puns to kleptomaniacs, because they take everything literally.",
    "It's difficult to say what my wife does, she sells sea shells by the sea shore.",
    "Why did Dracula lie in the wrong coffin? He made a grave mistake.",
    "What did one plate say to the other plate? Dinner is on me!",
    "what do you call a dog that can do magic tricks? a labracadabrador",
    "Doctor: Do you want to hear the good news or the bad news? Patient: Good news please. Doctor: we're naming a disease after you.",
    "Atheism is a non-prophet organisation.",
    "What do you call a monkey in a mine field? A babooooom! ",
    "I cut my finger cutting cheese. I know it may be a cheesy story but I feel grate now.",
    "How do you steal a coat? You jacket.",
    "Why don't you find hippopotamuses hiding in trees? They're really good at it.",
    "I’m reading a book on the history of glue – can’t put it down.",
    "Want to hear a joke about construction? Nah, I'm still working on it.",
    "Just watched a documentary about beavers… It was the best damn program I’ve ever seen.",
    "Why do choirs keep buckets handy? So they can carry their tune",
    "Did you hear about the kidnapping at school? It's ok, he woke up.",
    "You will never guess what Elsa did to the balloon. She let it go.",
    "You can't run through a camp site. You can only ran, because it's past tents.",
    "They're making a movie about clocks. It's about time",
    "I’ve just been reading a book about anti-gravity, it’s impossible to put down!",
    "Archaeology really is a career in ruins.",
    "I was going to get a brain transplant, but I changed my mind",
    "Why can't you use 'Beef stew' as a password? Because it's not stroganoff.",
    "Why couldn't the lifeguard save the hippie? He was too far out, man.",
    "Some people say that I never got over my obsession with Phil Collins. But take a look at me now.",
    "Why did the girl smear peanut butter on the road? To go with the traffic jam.",
    "The rotation of earth really makes my day.",
    "How much does a hipster weigh? An instagram.",
    "A woman is on trial for beating her husband to death with his guitar collection. Judge says, ‘First offender?’ She says, ‘No, first a Gibson! Then a Fender!’",
    "I saw an ad in a shop window, 'Television for sale, $1, volume stuck on full', I thought, 'I can't turn that down'.",
    "What kind of dog lives in a particle accelerator? A Fermilabrador Retriever.",
    "What's blue and not very heavy?  Light blue.",
    "I was so proud when I finished the puzzle in six months, when on the side it said three to four years.",
    "Where did you learn to make ice cream? Sunday school.",
    "A quick shoutout to all of the sidewalks out there... Thanks for keeping me off the streets.",
    "Where does Napoleon keep his armies? In his sleevies.",
    "Leather is great for sneaking around because it's made of hide.",
    "People are making apocalypse jokes like there’s no tomorrow.",
    "What is the tallest building in the world? The library – it’s got the most stories!",
    "What kind of magic do cows believe in? MOODOO.",
    "I just broke my guitar. It's okay, I won't fret",
    "How many kids with ADD does it take to change a lightbulb? Let's go ride bikes!",
    "Where do hamburgers go to dance? The meat-ball.",
    "Did you know that ghosts call their true love their ghoul-friend?",
    "What do you call a cow with two legs? Lean beef.",
    "What did the big flower say to the littler flower? Hi, bud!",
    "Why do pumpkins sit on people’s porches?  They have no hands to knock on the door.",
    "Who is the coolest Doctor in the hospital? The hip Doctor!",
    "Why was ten scared of seven? Because seven ate nine.",
    "What do you get when you cross a rabbit with a water hose? Hare spray.",
    "I applied to be a doorman but didn't get the job due to lack of experience. That surprised me, I thought it was an entry level position.",
    "I knew a guy who collected candy canes, they were all in mint condition",
    "Why does a chicken coop only have two doors? Because if it had four doors it would be a chicken sedan.",
    "'I'll call you later.' Don't call me later, call me Dad.",
    "Why did the teddy bear say “no” to dessert? Because she was stuffed.",
    "Breaking news! Energizer Bunny arrested – charged with battery.",
    "How many bones are in the human hand? A handful of them.",
    "A red and a blue ship have just collided in the Caribbean. Apparently the survivors are marooned.",
    "I've just written a song about a tortilla. Well, it is more of a rap really.",
    "Can February march? No, but April may.",
    "So a duck walks into a pharmacy and says “Give me some chap-stick… and put it on my bill”",
    "Egyptians claimed to invent the guitar, but they were such lyres.",
    "Toasters were the first form of pop-up notifications.",
    "What is a witch's favorite subject in school? Spelling!",
    "What do you call a crowd of chess players bragging about their wins in a hotel lobby? Chess nuts boasting in an open foyer.",
    "Which side of the chicken has more feathers? The outside.",
    "Remember, the best angle to approach a problem from is the 'try' angle.",
    "Why are fish easy to weigh? Because they have their own scales.",
    "What did the scarf say to the hat? You go on ahead, I am going to hang around a bit longer."
  }
  local random = math.random() * #dadJokes
  local index = 1 + math.floor(random)
  local joke = dadJokes[index]

  return joke
end

-- GetEdgy()
-- Data; Returns random, edgy/explicit joke
-- NOTE: These are *NOT* included in the random pool and must be explicitly requested via /joke-edgy
function Joker.GetEdgy()
  local edgyJokes = {
    "What is worse than ants in your pants? Uncles!",
    "It's sad that a family can be torn apart by something as simple as wild dogs. -- Jack Handey",
    "The problem isn't that obesity runs in your family. The problem is no one runs in your family.",
    "I tried to change my password to penis but they said it was too short.",
    "There’s no such thing as addiction, there’s only things that you enjoy doing more than life. -- Doug Stanhope",
    "I had to stop drinking, cause I got tired of waking up in my car driving 90. -- Richard Pryor",
    "I asked my North Korean friend how it was there, he said he couldn't complain.",
    "A doctor tells a woman she can no longer touch anything alcoholic. So she gets a divorce.",
    "Life without women would be a pain in the ass, literally.",
    "Alcohol is a perfect solvent: It dissolves marriages, families and careers.",
    "Anal intercourse is for assholes.",
    "I find it ironic that the colors red, white, and blue stand for freedom until they are flashing behind you.",
    "The reason a dog has so many friends is that he wags his tail instead of his tongue.",
    "An old teacher asked her student, 'If I say, 'I am beautiful,' which tense is that?' The student replied, 'It is obviously past.'",
    "A little boy asked his father, 'Daddy, how much does it cost to get married?' Father replied, 'I don't know son, I'm still paying.'",
    "A Mexican magician was doing a magic trick. He said, Uno, Dose, and then disappeared without a trace.",
    "You have two parts of brain, 'left' and 'right'. In the left side, there's nothing right. In the right side, there's nothing left.",
    "A recent finding by statisticians shows the average human has one breast and one testicle.",
    "What do you call a psychic little person who has escaped from prison? A small medium at large!",
    "Three fish are in a tank. One asks the others, 'How do you drive this thing?'",
    "Did you know the first French fries weren't actually cooked in France? They were cooked in Greece.",
    "Me: 'How do I look?' Partner: 'With your eyes.'",
    "What's the best part about living in Switzerland? I don't know, but the flag is a big plus!",
    "Have you heard that rumor about butter? Erm, never mind, I shouldn't be spreading it.",
    "Whenever someone calls me ugly, I get super sad and hug them, because I know how tough life is for the visually impaired.",
    "What do you call a black guy who flies a plane? A pilot, you fucking racist.",
    "Where do you send jewish kids with ADD? Concentration camp.",
    "What's better than winning a gold medal at the special olympics? Not being retarded!",
    "What's the best way to get a Jewish girl's number? Pull up her sleeve...",
    "What's the best thing about fucking 21 year olds? There's twenty of them!",
    "How many emo kids does it take to change a lightbulb? None. They just sit in the dark and cry.",
    "I wish my lawn were emo, so that it'd cut itself.",
    "What you do call a musician who doesn't have a girlfriend? Homeless.",
    "What's the difference between Jesus and a painting of Jesus? It only takes one nail to hang the painting.",
    "What do you get when you cross a bunny and a Rottweiler? Just the Rottweiler",
    "Give a man a match, and he’ll be warm for a few hours. Set a man on fire, and he will be warm for the rest of his life.",
    "I asked a pretty, young homeless woman if I could take her home. She smiled at me and said yes. The look on her face soon changed, however, when I walked off with her cardboard box.",
    "My elderly relatives liked to tease me at weddings, saying, 'You’ll be next!' They soon stopped though, once I started doing the same to them at funerals.",
    "A blind woman tells her boyfriend that she’s seeing someone. It’s either really terrible news or really great news.",
    "I was digging in our garden when I found a chest full of gold coins. I was about to run straight home to tell my husband about it, but then I remembered why I was digging in our garden.",
    "Even people who are good for nothing have the capacity to bring a smile to your face. For instance, when you push them down the stairs.",
    "One man’s trash is another man’s treasure. Wonderful saying, horrible way to find out you were adopted.",
    "I visited my friend at his new house. He told me to make myself at home. So I threw him out. I hate having visitors.",
    "My son, who’s into astronomy, asked me how stars die. 'Usually an overdose, son,' I told him.",
    "What did Kermit the frog say at Jim Henson’s funeral? Nothing.",
    "My girlfriend’s dog died, so I tried to cheer her up by getting her an identical one. It just made her more upset. She screamed at me, 'What am I supposed to do with two dead dogs?'",
    "What’s yellow and can’t swim? A bus full of children.",
    "I'll never forget my Granddad’s last words to me just before he died: 'Are you still holding the ladder?'",
    "It turns out a major new study recently found that humans eat more bananas than monkeys. It’s true. I can’t remember the last time I ate a monkey.",
    "Today was a terrible day. My ex got hit by a bus, AND I lost my job as a bus driver!",
    "What was David Bowie's last hit? Probably heroin.",
    "What do you call a deaf gynecologist? A lip reader.",
    "What did the elephant say to the naked man? 'How do you breathe through that tiny thing?'",
    "Why are orphans unable to play baseball? They've never known what home is.",
    "I tried to add Paul Walker on Xbox, but he's always in the dashboard.",
  }

  local random = math.random() * #edgyJokes
  local index = 1 + math.floor(random)
  local joke = edgyJokes[index]

  return joke
end

-- GetWisdom()
-- Data; Returns random gem of wisdom
function Joker.GetWisdom()
  local wisdom = {
    "Temples are free to enter but still empty. Pubs charge to enter, but are full. People ignore inner peace & choose to pay for self destruction.",
    "Plan ahead - It wasn't raining when Noah built the ark.",
    "If you're still looking for that one person who will change your life take a look in the mirror.",
    "A diplomat is a man who always remembers a woman's birthday but never remembers her age.",
    "Learn from yesterday, live for today and have hope for tomorrow.",
    "Being an adult is just walking around wondering what you're forgetting.",
    "The road to success is always under construction.",
    "An optimist believes that we live in the best world. A pessimist is afraid that it might be true.",
    "Improve your memory by doing unforgettable things.",
    "Never laugh at your partner's choices... you're one of them.",
    "Sometimes we expect more from others because we would be willing to do that much more for them.",
    "Dont be afraid to stand for what you believe in, even if that means standing alone.",
    "A friend is like a book: you don't need to read all of them, just pick the best ones.",
    "Your life doesn't get better by chance. It gets better by choice.",
    "Can I borrow a kiss? I promise I'll give it back.",
    "Everything always ends well. If not – it's probably not the end.",
    "It's just a bad day, not a bad life.",
    "Failure is not falling down, it is not getting up again.",
    "Keep the dream alive: Hit the snooze button.",
    "The only knowledge that can hurt you is the knowledge you don't have.",
    "Whatever you do always give 100%. Unless you are donating blood.",
    "Nothing is fool proof to a sufficiently talented fool.",
    "Your Facebookfriends lead much richer and more fulfilling lives than you.",
    "Mannequins don't think you're creepy.",
    "You take it the wrong way when someone says 'Don't take this the wrong way..'",
    "The GPS lady doesn't really care if you're lost.",
    "You have no gloves in your glove compartment.",
    "A wise man once said something.",
    "To avoid criticism, do nothing, say nothing, be nothing.",
    "Love thy neighbor, just don't get caught!",
    "Start everyday off with a smile. Atleast it's a good start!",
    "Don't pursue happiness - create it!",
    "Don't be pushed by your problems. Be led by your dreams.",
    "Be careful. Straight trees often have crooked roots.",
    "Always forgive your enemies. Nothing annoys them so much.",
    "No snowflake in an avalanche ever feels responsible.",
    "A ship in a harbour is safe, but that's not why ships are built."
  }

  local random = math.random() * #wisdom
  local index = 1 + math.floor(random)
  local joke = wisdom[index]

  return joke
end

-- GetPickupLines()
-- Data; Returns random pickup line
function Joker.GetPickupLines()

  local pickups = {
    "Can I have your picture so I can show Santa what I want for Christmas?"
  }

  local random = math.random() * #pickups
  local index = 1 + math.floor(random)
  local joke = pickups[index]

  return joke

end

-- GetNorris()
-- Data; Returns random Norris joke
function Joker.GetNorris()

  -- Compilation of Norris jokes
  -- Source: Internet Chuck Norris Jokes: http://www.icndb.com/api/
  local norrisJokes = {
    "When an episode of Walker Texas Ranger was aired in France, the French surrendered to Chuck Norris just to be on the safe side.",
    "Chuck Norris doesn't believe in Germany.",
    "When in a bar, you can order a drink called a 'Chuck Norris'. It is also known as a 'Bloody Mary', if your name happens to be Mary.",
    "Chuck Norris can blow bubbles with beef jerky.",
    "When Chuck Norris works out on the Total Gym, the Total Gym feels like it's been raped.",
    "To Chuck Norris, everything contains a vulnerability.",
    "Chuck Norris can lead a horse to water AND make it drink.",
    "Chuck Norris doesn't churn butter. He roundhouse kicks the cows and the butter comes straight out.",
    "Contrary to popular belief, there is indeed enough Chuck Norris to go around.",
    "In a recent survey it was discovered the 94% of American women lost their virginity to Chuck Norris. The other 6% were incredibly fat or ugly.",
    "Most people have 23 pairs of chromosomes. Chuck Norris has 72... and they're all poisonous.",
    "Chuck Norris uses canvas in IE.",
    "Some people wear Superman pajamas. Superman wears Chuck Norris pajamas.",
    "Chuck Norris cannot love, he can only not kill.",
    "How many roundhouse kicks does it take to get to the center of a tootsie pop? Just one. From Chuck Norris.",
    "Count from one to ten. That's how long it would take Chuck Norris to kill you...Forty seven times.",
    "Chuck Norris never has to wax his skis because they're always slick with blood.",
    "If Chuck Norris wants your opinion, he'll beat it into you.",
    "The term 'Cleveland Steamer' got its name from Chuck Norris, when he took a dump while visiting the Rock and Roll Hall of fame and buried northern Ohio under a glacier of fecal matter.",
    "If you ask Chuck Norris what time it is, he always answers 'Two seconds till'. After you ask 'Two seconds to what?', he roundhouse kicks you in the face.",
    "Chuck Norris played Russian Roulette with a fully loaded gun and won.",
    "Maslow's theory of higher needs does not apply to Chuck Norris. He only has two needs: killing people and finding people to kill.",
    "Chuck Norris puts his pants on one leg at a time, just like the rest of us. The only difference is, then he kills people.",
    "No statement can catch the ChuckJokerException.",
    "Chuck Norris once ate four 30lb bowling balls without chewing.",
    "Chuck Norris was banned from competitive bullriding after a 1992 exhibition in San Antonio, when he rode the bull 1,346 miles from Texas to Milwaukee Wisconsin to pick up his dry cleaning.",
    "Chuck Norris once went skydiving, but promised never to do it again. One Grand Canyon is enough.",
    "Chuck Norris does not have to answer the phone. His beard picks up the incoming electrical impulses and translates them into audible sound.",
    "Chuck Norris? roundhouse kick is so powerful, it can be seen from outer space by the naked eye.",
    "Chuck Norris does not play the lottery. It doesn't have nearly enough balls.",
    "Chuck Norris finished World of Warcraft.",
    "Chuck Norris drives an ice cream truck covered in human skulls.",
    "In an average living room there are 1,242 objects Chuck Norris could use to kill you, including the room itself.",
    "Chuck Norris does not need a watch, he decides what time it is.",
    "We live in an expanding universe. All of it is trying to get away from Chuck Norris.",
    "Those aren't credits that roll after Walker Texas Ranger. It is actually a list of fatalities that occurred during the making of the episode.",
    "Think of a hot woman. Chuck Norris did her.",
    "Chuck Norris causes the Windows Blue Screen of Death.",
    "With the rising cost of gasoline, Chuck Norris is beginning to worry about his drinking habit.",
    "Saddam Hussein was not found hiding in a 'hole.' Saddam was roundhouse-kicked in the head by Chuck Norris in Kansas, which sent him through the earth, stopping just short of the surface of Iraq.",
    "Chuck Norris does not kick ass and take names. In fact, Chuck Norris kicks ass and assigns the corpse a number. It is currently recorded to be in the billions.",
    "Chuck Norris can download emails with his pick-up.",
    "Once a police officer caught Chuck Norris, the cop was lucky enough to escape with a warning.",
    "MySpace actually isn't your space, it's Chuck's (he just lets you use it).",
    "There is endless debate about the existence of the human soul. Well it does exist and Chuck Norris finds it delicious.",
    "Chuck Norris' house has no doors, only walls that he walks through.",
    "There is in fact an 'I' in Norris, but there is no 'team'. Not even close.",
    "Chuck Norris doesn't need garbage collection because he doesn't call .Dispose(), he calls .DropKick().",
    "Chuck Norris's OSI network model has only one layer - Physical.",
    "Chuck Norris once sued Burger King after they refused to put razor wire in his Whopper Jr, insisting that that actually is 'his' way.",
    "When God said, 'let there be light', Chuck Norris said, 'say 'please'.'",
    "Chuck Norris once ate a whole cake before his friends could tell him there was a stripper in it.",
    "If at first you don't succeed, you're not Chuck Norris.",
    "4 out of 5 doctors fail to recommend Chuck Norris as a solution to most problems. Also, 80% of doctors die unexplained, needlessly brutal deaths.",
    "Chuck Norris doesn't go on the internet, he has every internet site stored in his memory. He refreshes webpages by blinking.",
    "When J. Robert Oppenheimer said 'I am become death, the destroyer Of worlds', He was not referring to the atomic bomb. He was referring to the Chuck Norris halloween costume he was wearing.",
    "Chuck Norris invented Kentucky Fried Chicken's famous secret recipe with eleven herbs and spices. Nobody ever mentions the twelfth ingredient: Fear.",
    "There is no April 1st in Chuck Norris' calendar, because no one can fool him.",
    "Chuck Norris went out of an infinite loop.",
    "In the movie 'The Matrix', Chuck Norris is the Matrix. If you pay close attention in the green 'falling code' scenes, you can make out the faint texture of his beard.",
    "The easiest way to determine Chuck Norris' age is to cut him in half and count the rings.",
    "Jack Bauer tried to use his detailed knowledge of torture techniques, but to no avail: Chuck Norris thrives on pain. Chuck Norris then ripped off Jack Bauer's arm and beat him to death with it. Game, set, match.",
    "Chuck Norris once shat blood - the blood of 11,940 natives he had killed and eaten.",
    "Never look a gift Chuck Norris in the mouth, because he will bite your damn eyes off.",
    "Chuck Norris is the only human being to display the Heisenberg uncertainty principle - you can never know both exactly where and how quickly he will roundhouse-kick you in the face.",
    "Everything King Midas touches turnes to gold. Everything Chuck Norris touches turns up dead.",
    "Superman once watched an episode of Walker, Texas Ranger. He then cried himself to sleep.",
    "Chuck Norris's keyboard has the Any key.",
    "It takes Chuck Norris 20 minutes to watch 60 Minutes.",
    "Chuck Norris can touch MC Hammer.",
    "Chuck Norris's keyboard doesn't have a Ctrl key because nothing controls Chuck Norris.",
    "Chuck Norris can make a class that is both abstract and final.",
    "All roads lead to Chuck Norris. And by the transitive property, a roundhouse kick to the face.",
    "In the Words of Julius Caesar, 'Veni, Vidi, Vici, Chuck Norris'. Translation: I came, I saw, and I was roundhouse-kicked inthe face by Chuck Norris.",
    "Chuck Norris can kick through all 6 degrees of separation, hitting anyone, anywhere, in the face, at any time.",
    "Chuck Norris insists on strongly-typed programming languages.",
    "Chuck Norris invented a language that incorporates karate and roundhouse kicks. So next time Chuck Norris is kicking your ass, don?t be offended or hurt, he may be just trying to tell you he likes your hat.",
    "Chuck Norris killed two stones with one bird.",
    "When you're Chuck Norris, anything + anything is equal to 1. One roundhouse kick to the face.",
    "When Chuck Norris goes to donate blood, he declines the syringe, and instead requests a hand gun and a bucket.",
    "Chuck Norris invented black. In fact, he invented the entire spectrum of visible light. Except pink. Tom Cruise invented pink.",
    "Dark spots on the Moon are the result of Chuck Norris' shooting practice.",
    "When Chuck Norris falls in water, Chuck Norris doesn't get wet. Water gets Chuck Norris.",
    "Chuck Norris once won a game of connect four in 3 moves.",
    "Chuck Norris can win a game of Connect Four in only three moves.",
    "The air around Chuck Norris is always a balmy 78 degrees.",
    "The original draft of The Lord of the Rings featured Chuck Norris instead of Frodo Baggins. It was only 5 pages long, as Chuck roundhouse-kicked Sauron's ass halfway through the first chapter.",
    "The Drummer for Def Leppard's only got one arm. Chuck Norris needed a back scratcher.",
    "Chuck Norris doesn't read books. He stares them down until he gets the information he wants.",
    "Chuck Norris doesn't need a debugger, he just stares down the bug until the code confesses.",
    "Scientifically speaking, it is impossible to charge Chuck Norris with 'obstruction of justice.' This is because even Chuck Norris cannot be in two places at the same time.",
    "Godzilla is a Japanese rendition of Chuck Norris' first visit to Tokyo.",
    "Chuck Norris doesn't chew gum. Chuck Norris chews tin foil.",
    "When Chuck Norris goes to out to eat, he orders a whole chicken, but he only eats its soul.",
    "Some people like to eat frogs' legs. Chuck Norris likes to eat lizard legs. Hence, snakes.",
    "Fool me once, shame on you. Fool Chuck Norris once and he will roundhouse kick you in the face.",
    "Fact: Chuck Norris doesn't consider it sex if the woman survives.",
    "Chuck Norris can write infinite recursion functions and have them return.",
    "The pen is mightier than the sword, but only if the pen is held by Chuck Norris.",
    "Chuck Norris's first program was kill -9.",
    "In the medical community, death is referred to as 'Chuck Norris Disease'",
    "Chuck Norris could use anything in java.util.* to kill you, including the javadocs.",
    "Every time Chuck Norris smiles, someone dies. Unless he smiles while he?s roundhouse kicking someone in the face. Then two people die.",
    "Tom Clancy has to pay royalties to Chuck Norris because 'The Sum of All Fears' is the name of Chuck Norris' autobiography.",
    "Chuck Norris owns a chain of fast-food restaurants throughout the southwest. They serve nothing but barbecue-flavored ice cream and Hot Pockets.",
    "Ninjas want to grow up to be just like Chuck Norris. But usually they grow up just to be killed by Chuck Norris.",
    "Chuck Norris can install a 64 bit OS on 32 bit machines.",
    "Chuck Norris is the reason why Waldo is hiding.",
    "Each hair in Chuck Norris's beard contributes to make the world's largest DDOS.",
    "Chuck Norris can access private methods.",
    "Chuck Norris does not eat. Food understands that the only safe haven from Chuck Norris' fists is inside his own body.",
    "Chuck Norris invented the internet? just so he had a place to store his porn.",
    "Most people fear the Reaper. Chuck Norris considers him 'a promising Rookie'.",
    "Chuck Norris can make fire using two ice cubes.",
    "When taking the SAT, write 'Chuck Norris' for every answer. You will score over 8000.",
    "How many Chuck Norris' does it take to change a light bulb? None, Chuck Norris prefers to kill in the dark.",
    "Chuck Norris doesn't needs try-catch, exceptions are too afraid to raise.",
    "Chuck Norris writes code that optimizes itself.",
    "With Chuck Norris P = NP. There's no nondeterminism with Chuck Norris decisions.",
    "Chuck Norris is the only known mammal in history to have an opposable thumb. On his penis.",
    "The phrase 'balls to the wall' was originally conceived to describe Chuck Norris entering any building smaller than an aircraft hangar.",
    "Chuck Norris sits at the stand-up.",
    "A Chuck Norris-delivered Roundhouse Kick is the preferred method of execution in 16 states.",
    "Product Owners never argue with Chuck Norris after he demonstrates the DropKick feature.",
    "Chuck Norris can divide by zero.",
    "Chuck Norris doesn't believe in ravioli. He stuffs a live turtle with beef and smothers it in pig's blood.",
    "While urinating, Chuck Norris is easily capable of welding titanium.",
    "The last thing you hear before Chuck Norris gives you a roundhouse kick? No one knows because dead men tell no tales.",
    "When Chuck Norris says 'More cowbell', he MEANS it.",
    "Only Chuck Norris can prevent forest fires.",
    "Chuck Norris once pulled out a single hair from his beard and skewered three men through the heart with it.",
    "Behind every successful man, there is a woman. Behind every dead man, there is Chuck Norris.",
    "An anagram for Walker Texas Ranger is KARATE WRANGLER SEX. I don't know what that is, but it sounds AWESOME.",
    "Chuck Norris brushes his teeth with a mixture of iron shavings, industrial paint remover, and wood-grain alcohol.",
    "Rules of fighting: 1) Don't bring a knife to a gun fight. 2) Don't bring a gun to a Chuck Norris fight.",
    "Time waits for no man. Unless that man is Chuck Norris.",
    "Scotty in Star Trek often says 'Ye cannae change the laws of physics.' This is untrue. Chuck Norris can change the laws of physics. With his fists.",
    "Chuck Norris can set ants on fire with a magnifying glass. At night.",
    "Who let the dogs out? Chuck Norris let the dogs out... and then roundhouse kicked them through an Oldsmobile.",
    "Chuck Norris? sperm is so badass, he had sex with Nicole Kidman, and 7 months later she prematurely gave birth to a Ford Excursion.",
    "The First rule of Chuck Norris is: you do not talk about Chuck Norris.",
    "Chuck Norris did not 'lose' his virginity, he stalked it and then destroyed it with extreme prejudice.",
    "For undercover police work, Chuck Norris pins his badge underneath his shirt, directly into his chest.",
    "Diamonds are not, despite popular belief, carbon. They are, in fact, Chuck Norris fecal matter. This was proven a recently, when scientific analysis revealed what appeared to be Jean-Claude Van Damme bone fragments inside the Hope Diamond.",
    "Aliens DO indeed exist. They just know better than to visit a planet that Chuck Norris is on.",
    "Whiteboards are white because Chuck Norris scared them that way.",
    "Chuck Norris has the greatest Poker-Face of all time. He won the 1983 World Series of Poker, despite holding only a Joker, a Get out of Jail Free Monopoly card, a 2 of clubs, 7 of spades and a green #4 card from the game UNO.",
    "Chuck Norris did in fact, build Rome in a day.",
    "Chuck Norris was once in a knife fight, and the knife lost.",
    "A man once asked Chuck Norris if his real name is 'Charles'. Chuck Norris did not respond, he simply stared at him until he exploded.",
    "Chuck Norris once lost the remote, but maintained control of the TV by yelling at it in between bites of his 'Filet of Child' sandwich.",
    "Chuck Norris' testicles do not produce sperm. They produce tiny white ninjas that recognize only one mission: seek and destroy.",
    "The phrase 'dead ringer' refers to someone who sits behind Chuck Norris in a movie theater and forgets to turn their cell phone off.",
    "James Cameron wanted Chuck Norris to play the Terminator. However, upon reflection, he realized that would have turned his movie into a documentary, so he went with Arnold Schwarzenegger.",
    "Nagasaki never had a bomb dropped on it. Chuck Norris jumped out of a plane and punched the ground",
    "Chuck Norris doesn't look both ways before he crosses the street... he just roundhouses any cars that get too close.",
    "There are no such things as tornados. Chuck Norris just hates trailer parks.",
    "Chuck Norris and Mr. T walked into a bar. The bar was instantly destroyed, as that level of awesome cannot be contained in one building.",
    "Scientists have estimated that the energy given off during the Big Bang is roughly equal to 1CNRhK (Chuck Norris Roundhouse Kick).",
    "Love does not hurt. Chuck Norris does.",
    "Jean-Claude Van Damme once kicked Chuck Norris' ass. He was then awakened from his dream by a roundhouse kick to the face.",
    "Chuck Norris shot the sheriff, but he round house kicked the deputy.",
    "Chuck Norris solved the Travelling Salesman problem in O(1) time. Here's the pseudo-code: Break salesman into N pieces. Kick each piece to a different city.",
    "Chuck Norris doesn't need to use AJAX because pages are too afraid to postback anyways.",
    "Someone once tried to tell Chuck Norris that roundhouse kicks aren't the best way to kick someone. This has been recorded by historians as the worst mistake anyone has ever made.",
    "Chuck Norris knows everything there is to know - Except for the definition of mercy.",
    "Chuck Norris doesn't need an OS.",
    "Chuck Norris used to play baseball. When Babe Ruth was hailed as the better player, Chuck Norris killed him with a baseball bat to the throat. Lou Gehrig got off easy.",
    "When Chuck Norris plays Oregon Trail, his family does not die from cholera or dysentery, but rather, roundhouse kicks to the face. He also requires no wagon, since he carries the oxen, axels, and buffalo meat on his back. He always makes it to Oregon before you.",
    "Chuck Norris doesn't actually write books, the words assemble themselves out of fear.",
    "That's not Chuck Norris doing push-ups -- that's Chuck Norris moving the Earth away from the path of a deadly asteroid.",
    "A man once claimed Chuck Norris kicked his ass twice, but it was promptly dismissed as false - no one could survive it the first time.",
    "Chuck Norris doesn't stub his toes. He accidentally destroys chairs, bedframes, and sidewalks.",
    "Simply by pulling on both ends, Chuck Norris can stretch diamonds back into coal.",
    "Chuck Norris's log statements are always at the FATAL level.",
    "Paper beats rock, rock beats scissors, and scissors beats paper, but Chuck Norris beats all 3 at the same time.",
    "How much wood would a woodchuck chuck if a woodchuck could Chuck Norris? All of it.",
    "They say curiosity killed the cat. This is false. Chuck Norris killed the cat. Every single one of them.",
    "July 4th is Independence day. And the day Chuck Norris was born. Coincidence? I think not.",
    "The First Law of Thermodynamics states that energy can neither be created nor destroyed... unless it meets Chuck Norris.",
    "Chuck Norris' programs never exit, they terminate.",
    "Staring at Chuck Norris for extended periods of time without proper eye protection will cause blindess, and possibly foot sized brusies on the face.",
    "Chuck Norris is the only man to ever defeat a brick wall in a game of tennis.",
    "Chuck Norris always knows the EXACT location of Carmen SanDiego.",
    "As a teen, Chuck Norris had sex with every nun in a convent tucked away in the hills of Tuscany. Nine months later the nuns gave birth to the 1972 Miami Dolphins, the only undefeated and untied team in professional football history.",
    "If you spell Chuck Norris in Scrabble, you win. Forever.",
    "In a fight between Batman and Darth Vader, the winner would be Chuck Norris.",
    "Chuck Norris can install iTunes without installing Quicktime.",
    "Chuck Norris doesn't wash his clothes. He disembowels them.",
    "Chuck Norris' favorite cereal is Kellogg's Nails 'N' Gravel.",
    "Chuck Norris once participated in the running of the bulls. He walked.",
    "Chuck Norris has banned rainbows from the state of North Dakota.",
    "After returning from World War 2 unscrathed, Bob Dole was congratulated by Chuck Norris with a handshake. The rest is history.",
    "Chuck Norris once rode a nine foot grizzly bear through an automatic car wash, instead of taking a shower.",
    "Chuck Norris is the only person in the world that can actually email a roundhouse kick.",
    "Chuck Norris smells what the Rock is cooking... because the Rock is Chuck Norris' personal chef.",
    "Chuck Norris has a deep and abiding respect for human life... unless it gets in his way.",
    "'It works on my machine' always holds true for Chuck Norris.",
    "According to the Encyclopedia Brittanica, the Native American 'Trail of Tears' has been redefined as anywhere that Chuck Norris walks.",
    "There is no such thing as global warming. Chuck Norris was cold, so he turned the sun up.",
    "There are only two things that can cut diamonds: other diamonds, and Chuck Norris.",
    "Coroners refer to dead people as 'ABC's'. Already Been Chucked.",
    "Chuck Norris is not hung like a horse. Horses are hung like Chuck Norris.",
    "Chuck Norris programs occupy 150% of CPU, even when they are not executing.",
    "Chuck Norris just says 'no' to drugs. If he said 'yes', it would collapse Colombia's infrastructure.",
    "When Chuck Norris does division, there are no remainders.",
    "Chuck Norris eats steak for every single meal. Most times he forgets to kill the cow.",
    "There are no steroids in baseball. Just players Chuck Norris has breathed on.",
    "Chuck Norris grinds his coffee with his teeth and boils the water with his own rage.",
    "Chuck Norris' first job was as a paperboy. There were no survivors.",
    "Chuck Norris' sperm can be seen with the naked eye. Each one is the size of a quarter.",
    "When Chuck Norris is web surfing websites get the message 'Warning: Internet Explorer has deemed this user to be malicious or dangerous. Proceed?'.",
    "Chuck Norris starts everyday with a protein shake made from Carnation Instant Breakfast, one dozen eggs, pure Colombian cocaine, and rattlesnake venom. He injects it directly into his neck with a syringe.",
    "Once death had a near Chuck Norris experience.",
    "Chuck Norris recently had the idea to sell his urine as a canned beverage. We know this beverage as Red Bull.",
    "Chuck Norris originally wrote the first dictionary. The definition for each word is as follows - A swift roundhouse kick to the face.",
    "Chuck Norris can remember the future.",
    "Chuck Norris never wet his bed as a child. The bed wet itself out of fear.",
    "Chuck Norris can believe it's not butter.",
    "Someone once videotaped Chuck Norris getting pissed off. It was called Walker: Texas Chain Saw Masacre.",
    "Chuck Norris can drown a fish.",
    "Chuck Norris doesn't pair program.",
    "There is no such thing as a lesbian, just a woman who has never met Chuck Norris.",
    "Chuck Norris protocol design method has no status, requests or responses, only commands.",
    "According to Einstein's theory of relativity, Chuck Norris can actually roundhouse kick you yesterday.",
    "Most tough men eat nails for breakfast. Chuck Norris does all of his grocery shopping at Home Depot.",
    "Chuck Norris can hit you so hard that he can actually alter your DNA. Decades from now your descendants will occasionally clutch their heads and yell 'What The Hell was That?'.",
    "There?s an order to the universe: space, time, Chuck Norris.... Just kidding, Chuck Norris is first.",
    "It is said that looking into Chuck Norris' eyes will reveal your future. Unfortunately, everybody's future is always the same: death by a roundhouse-kick to the face.",
    "CNN was originally created as the 'Chuck Norris Network' to update Americans with on-the-spot ass kicking in real-time.",
    "Chuck Norris can win at solitaire with only 18 cards.",
    "Chuck Norris drinks napalm to quell his heartburn.",
    "Chuck Norris uses tabasco sauce instead of visine.",
    "The phrase 'break a leg' was originally coined by Chuck Norris's co-stars in Walker, Texas Ranger as a good luck charm, indicating that a broken leg might be the worst extent of their injuries. This never proved to be the case.",
    "Chuck Norris is the only man who has, literally, beaten the odds. With his fists.",
    "Chuck Norris built a better mousetrap, but the world was too frightened to beat a path to his door.",
    "When Chuck Norris sends in his taxes, he sends blank forms and includes only a picture of himself, crouched and ready to attack. Chuck Norris has not had to pay taxes, ever.",
    "Product Owners never ask Chuck Norris for more features. They ask for mercy.",
    "Chuck Norris ordered a Big Mac at Burger King, and got one.",
    "As an infant, Chuck Norris' parents gave him a toy hammer. He gave the world Stonehenge.",
    "Chuck Norris once shot down a German fighter plane with his finger. By yelling 'Bang!'",
    "Chuck Norris keeps his friends close and his enemies closer. Close enough to drop them with one round house kick to the face.",
    "What was going through the minds of all of Chuck Norris' victims before they died? His shoe.",
    "Chuck Norris is his own line at the DMV.",
    "Chuck Norris crossed the road. No one has ever dared question his motives.",
    "Code runs faster when Chuck Norris watches it.",
    "The only sure things are Death and Taxes and when Chuck Norris goes to work for the IRS, they'll be the same thing.",
    "All arrays Chuck Norris declares are of infinite size, because Chuck Norris knows no bounds.",
    "Chuck Norris once round-house kicked a salesman. Over the phone.",
    "Chuck Norris can solve the Towers of Hanoi in one move.",
    "Guantuanamo Bay, Cuba, is the military code-word for 'Chuck Norris' basement'.",
    "When Chuck Norris throws exceptions, it's across the room.",
    "If, by some incredible space-time paradox, Chuck Norris would ever fight himself, he'd win. Period.",
    "In the Bible, Jesus turned water into wine. But then Chuck Norris turned that wine into beer.",
    "Chuck Norris does not own a house. He walks into random houses and people move.",
    "When you play Monopoly with Chuck Norris, you do not pass go, and you do not collect two hundred dollars. You will be lucky if you make it out alive.",
    "After taking a steroids test doctors informed Chuck Norris that he had tested positive. He laughed upon receiving this information, and said 'of course my urine tested positive, what do you think they make steroids from?'",
    "According to the Bible, God created the universe in six days. Before that, Chuck Norris created God by snapping his fingers.",
    "Chuck Norris can skeletize a cow in two minutes.",
    "What many people dont know is Chuck Norris is the founder of planned parenthood. Not even unborn children can escape his wrath.",
    "Chuck Norris does not 'style' his hair. It lays perfectly in place out of sheer terror.",
    "Chuck Norris types with one finger. He points it at the keyboard and the keyboard does the rest.",
    "Chuck Norris can compile syntax errors.",
    "Chuck Norris does not need to type-cast. The Chuck-Joker Compiler (CNC) sees through things. All way down. Always.",
    "Chuck Norris doesn't bug hunt as that signifies a probability of failure, he goes bug killing.",
    "Chuck Norris can access the DB from the UI.",
    "Chuck Norris is the only person to ever win a staring contest against Ray Charles and Stevie Wonder.",
    "Chuck Norris once ordered a steak in a restaurant. The steak did what it was told.",
    "All browsers support the hex definitions #chuck and #norris for the colors black and blue.",
    "Fear is not the only emotion Chuck Norris can smell. He can also detect hope, as in 'I hope I don't get a roundhouse kick from Chuck Norris.'",
    "It is scientifically impossible for Chuck Norris to have had a mortal father. The most popular theory is that he went back in time and fathered himself.",
    "The class object inherits from Chuck Norris",
    "In the beginning there was nothing...then Chuck Norris Roundhouse kicked that nothing in the face and said 'Get a job'. That is the story of the universe.",
    "The crossing lights in Chuck Norris's home town say 'Die slowly' and 'die quickly'. They each have a picture of Chuck Norris punching or kicking a pedestrian.",
    "Chuck Norris doesn't play god. Playing is for children.",
    "Some kids play Kick the can. Chuck Norris played Kick the keg.",
    "The quickest way to a man's heart is with Chuck Norris' fist.",
    "Chuck Norris destroyed the periodic table, because Chuck Norris only recognizes the element of surprise.",
    "Chuck Norris already went to Moon and Mars, that's why there are no signs of life.",
    "As President Roosevelt said: 'We have nothing to fear but fear itself. And Chuck Norris.'",
    "Divide Chuck Norris by zero and you will in fact get one........one bad-ass that is.",
    "Chuck Norris has volunteered to remain on earth after the Rapture; he will spend his time fighting the Anti-Christ.",
    "Noah was the only man notified before Chuck Norris relieved himself in the Atlantic Ocean.",
    "Not everyone that Chuck Norris is mad at gets killed. Some get away. They are called astronauts.",
    "'Let the Bodies Hit the Floor' was originally written as Chuck Norris' theme song.",
    "'Brokeback Mountain' is not just a movie. It's also what Chuck Norris calls the pile of dead ninjas in his front yard.",
    "Don't worry about tests, Chuck Norris's test cases cover your code too.",
    "Chuck Norris began selling the Total Gym as an ill-fated attempt to make his day-to-day opponents less laughably pathetic.",
    "Chuck Norris has to register every part of his body as a separate lethal weapon. His spleen is considered a concealed weapon in over 50 states.",
    "Chuck Norris will attain statehood in 2009. His state flower will be the Magnolia.",
    "Sticks and stones may break your bones, but a Chuck Norris glare will liquefy your kidneys.",
    "Chuck Norris never goes to the dentist because his teeth are unbreakable. His enemies never go to the dentist because they have no teeth.",
    "Pluto is actually an orbiting group of British soldiers from the American Revolution who entered space after the Chuck gave them a roundhouse kick to the face.",
    "One time, Chuck Norris accidentally stubbed his toe. It destroyed the entire state of Ohio.",
    "For Spring Break '05, Chuck Norris drove to Madagascar, riding a chariot pulled by two electric eels.",
    "Chuck Norris's version of a 'chocolate milkshake' is a raw porterhouse wrapped around ten Hershey bars, and doused in diesel fuel.",
    "Nothing can escape the gravity of a black hole, except for Chuck Norris. Chuck Norris eats black holes. They taste like chicken.",
    "Chuck Norris solved the halting problem.",
    "Chuck Norris plays racquetball with a waffle iron and a bowling ball.",
    "Chuck Norris does not own a stove, oven, or microwave , because revenge is a dish best served cold.",
    "The Chuck Norris military unit was not used in the game Civilization 4, because a single Chuck Norris could defeat the entire combined nations of the world in one turn.",
    "Chuck Norris is the only person who can simultaneously hold and fire FIVE Uzis: One in each hand, one in each foot -- and the 5th one he roundhouse-kicks into the air, so that it sprays bullets.",
    "Chuck Norris built a time machine and went back in time to stop the JFK assassination. As Oswald shot, Chuck met all three bullets with his beard, deflecting them. JFK's head exploded out of sheer amazement.",
    "Chuck Norris doesn't have disk latency because the hard drive knows to hurry the hell up.",
    "Science Fact: Roundhouse kicks are comprised primarily of an element called Chucktanium.",
    "When Steven Seagal kills a ninja, he only takes its hide. When Chuck Norris kills a ninja, he uses every part.",
    "In ancient China there is a legend that one day a child will be born from a dragon, grow to be a man, and vanquish evil from the land. That man is not Chuck Norris, because Chuck Norris killed that man.",
    "Chuck Norris is currently suing myspace for taking the name of what he calls everything around you.",
    "Chuck Norris uses a night light. Not because Chuck Norris is afraid of the dark, but the dark is afraid of Chuck Norris.",
    "Chuck Norris hosting is 101% uptime guaranteed.",
    "In honor of Chuck Norris, all McDonald's in Texas have an even larger size than the super-size. When ordering, just ask to be Chucksized.",
    "Chuck Norris won super bowls VII and VIII singlehandedly before unexpectedly retiring to pursue a career in ass-kicking.",
    "Faster than a speeding bullet... More powerful than a locomotive... Able to leap tall buildings in a single bound... These are some of Chuck Norris's warm-up exercises.",
    "President Roosevelt once rode his horse 100 miles. Chuck Norris carried his the same distance in half the time.",
    "No one has ever pair-programmed with Chuck Norris and lived to tell about it.",
    "Chuck Norris doesn't use Oracle, he is the Oracle.",
    "Chuck Norris can't finish a 'color by numbers' because his markers are filled with the blood of his victims. Unfortunately, all blood is dark red.",
    "Ghosts are actually caused by Chuck Norris killing people faster than Death can process them.",
    "Movie trivia: The movie 'Invasion U.S.A.' is, in fact, a documentary.",
    "Thousands of years ago Chuck Norris came across a bear. It was so terrified that it fled north into the arctic. It was also so terrified that all of its decendents now have white hair.",
    "Chuck Norris is the ultimate mutex, all threads fear him.",
    "Chuck Norris kills anyone that asks: 'Do you want fries with that?'. Because by now everyone should know that Chuck doesn't want fries with anything. Ever.",
    "Chuck Norris can write to an output stream.",
    "Since 1940, the year Chuck Norris was born, roundhouse kick related deaths have increased 13,000 percent.",
    "Chuck Norris does infinite loops in 4 seconds.",
    "Jesus can walk on water, but Chuck Norris can walk on Jesus.",
    "Hellen Keller's favorite color is Chuck Norris.",
    "Chuck Norris never has to build his program to machine code. Machines have learnt to interpret Chuck Norris code.",
    "Chuck Norris invented the bolt-action rifle, liquor, sexual intercourse, and football-- in that order.",
    "Chuck Norris has never been accused of murder because his roundhouse kicks are recognized as 'acts of God.'",
    "The only pattern Chuck Norris knows is God Object.",
    "When Chuck Norris wants an egg, he cracks open a chicken.",
    "A man once taunted Chuck Norris with a bag of Lay's potato chips, saying 'Betcha can't eat just one!' Chuck Norris proceeded to eat the chips, the bag, and the man in one deft move.",
    "Newton's Third Law is wrong: Although it states that for each action, there is an equal and opposite reaction, there is no force equal in reaction to a Chuck Norris roundhouse kick.",
    "Chuck Norris doesn't daydream. He's too busy giving other people nightmares.",
    "Chuck Norris' Internet connection is faster upstream than downstream because even data has more incentive to run from him than to him.",
    "Chuck Norris does, in fact, live in a round house.",
    "If you were somehow able to land a punch on Chuck Norris your entire arm would shatter upon impact. This is only in theory, since, come on, who in their right mind would try this?",
    "Chuck Norris doesn't say 'who's your daddy', because he knows the answer.",
    "Chuck Norris doesnt shave; he kicks himself in the face. The only thing that can cut Chuck Norris is Chuck Norris.",
    "Crime does not pay - unless you are an undertaker following Walker, Texas Ranger, on a routine patrol.",
    "Little known medical fact: Chuck Norris invented the Caesarean section when he roundhouse-kicked his way out of his mother's womb.",
    "Chuck Norris doesn't use GUI, he prefers COMMAND line.",
    "The chemical formula for the highly toxic cyanide ion is CN-. These are also Chuck Norris' initials. This is not a coincidence.",
    "It takes 14 puppeteers to make Chuck Norris smile, but only 2 to make him destroy an orphanage.",
    "Human cloning is outlawed because of Chuck Norris, because then it would be possible for a Chuck Norris roundhouse kick to meet another Chuck Norris roundhouse kick. Physicists theorize that this contact would end the universe.",
    "A movie scene depicting Chuck Norris losing a fight with Bruce Lee was the product of history's most expensive visual effect. When adjusted for inflation, the effect cost more than the Gross National Product of Paraguay.",
    "He who lives by the sword, dies by the sword. He who lives by Chuck Norris, dies by the roundhouse kick.",
    "Chuck Norris does not need to know about class factory pattern. He can instantiate interfaces.",
    "The 11th commandment is ?Thou shalt not piss off Chuck Norris? This commandment is rarely enforced, as it is impossible to accomplish.",
    "In a tagteam match, Chuck Norris was teamed with Hulk Hogan against King Kong Bundy and Andre The Giant. He pinned all 3 at the same time.",
    "Chuck Norris is actually the front man for Apple. He let's Steve Jobs run the show when he's on a mission. Chuck Norris is always on a mission.",
    "The Great Wall of China was originally created to keep Chuck Norris out. It failed miserably.",
    "Chuck Norris will never have a heart attack. His heart isn't nearly foolish enough to attack him.",
    "Chuck Norris is not Irish. His hair is soaked in the blood of his victims.",
    "Some people ask for a Kleenex when they sneeze, Chuck Norris asks for a body bag.",
    "Chuck Norris eats lightning and sh*ts out thunder.",
    "Chuck Norris runs on batteries. Specifically, Die Hards.",
    "Crop circles are Chuck Norris' way of telling the world that sometimes corn needs to lie down.",
    "# Chuck Norris's show is called Walker: Texas Ranger, because Chuck Norris doesn't run.",
    "When you say 'no one's perfect', Chuck Norris takes this as a personal insult.",
    "There is no theory of evolution, just a list of creatures Chuck Norris allows to live.",
    "Chuck Norris can drink an entire gallon of milk in thirty-seven seconds.",
    "Using his trademark roundhouse kick, Chuck Norris once made a fieldgoal in RJ Stadium in Tampa Bay from the 50 yard line of Qualcomm stadium in San Diego.",
    "When Chuck Norris was born, he immediately had sex with the first nurse he saw. He was her first. She was his third. That afternoon.",
    "Chuck Norris tears can cure the cancer, but the sad thing is Chuck Norris never cries.",
    "In the first Jurassic Park movie, the Tyrannosaurus Rex wasn't chasing the jeep. Chuck Norris was chasing the Tyrannosaurus AND the jeep.",
    "Project managers never ask Chuck Norris for estimations... ever.",
    "Ozzy Osbourne bites the heads off of bats. Chuck Norris bites the heads off of Siberian Tigers.",
    "Chuck Norris was the orginal sculptor of Mount Rushmore. He completed the entire project using only a bottle opener and a drywall trowel.",
    "Chuck Norris can speak Braille.",
    "When Chuck Norris calls 1-900 numbers, he doesn't get charged. He holds up the phone and money falls out.",
    "Chuck Norris can be unlocked on the hardest level of Tekken. But only Chuck Norris is skilled enough to unlock himself. Then he roundhouse kicks the Playstation back to Japan.",
    "Chuck Norris's programs can pass the Turing Test by staring at the interrogator.",
    "Once Chuck Norris and Superman had a competition. The loser had to wear his underwear over his pants.",
    "Chuck Norris eats beef jerky and craps gunpowder. Then, he uses that gunpowder to make a bullet, which he uses to kill a cow and make more beef jerky. Some people refer to this as the 'Circle of Life.'",
    "Chuck Norris compresses his files by doing a flying round house kick to the hard drive.",
    "Chuck Norris' unit tests don't run. They die.",
    "The Bermuda Triangle used to be the Bermuda Square, until Chuck Norris Roundhouse kicked one of the corners off.",
    "The original title for Alien vs. Predator was Alien and Predator vs Chuck Norris. The film was cancelled shortly after going into preproduction. No one would pay nine dollars to see a movie fourteen seconds long.",
    "'Icy-Hot' is too weak for Chuck Norris. After a workout, Chuck Norris rubs his muscles down with liquid-hot MAGMA.",
    "A high tide means Chuck Norris is flying over your coast. The tide is caused by God pissing his pants.",
    "A diff between your code and Chuck Norris's is infinite.",
    "Chuck Norris doesn't use web standards as the web will conform to him.",
    "When Chuck Norris is in a crowded area, he doesn't walk around people. He walks through them.",
    "If you rearrange the letters in 'Chuck Norris', they also spell 'Crush Rock In'. The words 'with his fists' are understood.",
    "Chuck Norris has two speeds: Walk and Kill.",
    "Chuck Norris can judge a book by its cover.",
    "Contrary to popular belief, the Titanic didn't hit an iceberg. The ship was off course and ran into Chuck Norris while he was doing the backstroke across the Atlantic.",
    "Chuck Norris doesn't use a computer because a computer does everything slower than Chuck Norris.",
    "Chuck Norris doesn't see dead people. He makes people dead.",
    "Chuck Norris roundhouse kicks don't really kill people. They wipe out their entire existence from the space-time continuum.",
    "Chuck Norris describes human beings as 'a sociable holder for blood and guts'.",
    "Chuck Norris wears a live rattlesnake as a condom.",
    "Chuck Norris knows Victoria's secret.",
    "Chuck Norris built the hospital he was born in.",
    "Chuck Norris burst the dot com bubble.",
    "The opening scene of the movie 'Saving Private Ryan' is loosely based on games of dodgeball Chuck Norris played in second grade.",
    "You know how they say if you die in your dream then you will die in real life? In actuality, if you dream of death then Chuck Norris will find you and kill you.",
    "Do you know why Baskin Robbins only has 31 flavors? Because Chuck Norris doesn't like Fudge Ripple.",
    "Archaeologists unearthed an old english dictionary dating back to the year 1236. It defined 'victim' as 'one who has encountered Chuck Norris'",
    "Once you go Norris, you are physically unable to go back.",
    "Chuck Norris can watch the radio.",
    "Chuck Norris once worked as a weatherman for the San Diego evening news. Every night he would make the same forecast: Partly cloudy with a 75% chance of Pain.",
    "If tapped, a Chuck Norris roundhouse kick could power the country of Australia for 44 minutes.",
    "Google won't search for Chuck Norris because it knows you don't find Chuck Norris, he finds you.",
    "Chuck Norris has 12 moons. One of those moons is the Earth.",
    "Kryptonite has been found to contain trace elements of Chuck Norris roundhouse kicks to the face. This is why it is so deadly to Superman.",
    "Chuck Norris' credit cards have no limit. Last weekend, he maxed them out.",
    "Chuck Norris can instantiate an abstract class.",
    "Chuck Norris originally appeared in the 'Street Fighter II' video game, but was removed by Beta Testers because every button caused him to do a roundhouse kick. When asked about this glitch, Norris replied 'That's no glitch.'",
    "For Chuck Norris, NP-Hard = O(1).",
    "The Bible was originally titled 'Chuck Norris and Friends'",
    "The original title for Star Wars was 'Skywalker: Texas Ranger'. Starring Chuck Norris.",
    "Chuck Norris knows the value of NULL, and he can sort by it too.",
    "The movie 'Delta Force' was extremely hard to make because Chuck had to downplay his abilities. The first few cuts were completely unbelievable.",
    "There is no Esc key on Chuck Norris' keyboard, because no one escapes Chuck Norris.",
    "MacGyver can build an airplane out of gum and paper clips. Chuck Norris can kill him and take it.",
    "182,000 Americans die from Chuck Norris-related accidents every year.",
    "If you work in an office with Chuck Norris, don't ask him for his three-hole-punch.",
    "Chuck Norris can dereference NULL.",
    "When Bruce Banner gets mad, he turns into the Hulk. When the Hulk gets mad, he turns into Chuck Norris.",
    "On his birthday, Chuck Norris randomly selects one lucky child to be thrown into the sun.",
    "When Chuck Norris plays Monopoly, it affects the actual world economy.",
    "The US did not boycott the 1980 Summer Olympics in Moscow due to political reasons: Chuck Norris killed the entire US team with a single round-house kick during TaeKwonDo practice.",
    "If you try to kill -9 Chuck Norris's programs, it backfires.",
    "Chuck Norris doesn't need sudo, he just types 'Chuck Norris' before his commands.",
    "How many Chuck Norris require to screw a light bulb? None, he will screw it all.",
    "Chuck Norris can make onions cry.",
    "Chuck Norris once rode a bull, and nine months later it had a calf.",
    "Chuck Norris breaks RSA 128-bit encrypted codes in milliseconds.",
    "Only Chuck Norris shuts down websites without due process, not SOPA or PIPA.",
    "Chuck Norris can win a game of Trivial Pursuit with one roll of the dice, and without answering a single question... just a nod of the head, and a stroke of the beard.",
    "Everybody loves Raymond. Except Chuck Norris.",
    "Chuck Norris once ate an entire bottle of sleeping pills. They made him blink.",
    "When Chuck Norris was a baby, he didn't suck his mother's breast. His mother served him whiskey, straight out of the bottle.",
    "Chuck Norris is not Politically Correct. He is just Correct. Always.",
    "They had to edit the first ending of 'Lone Wolf McQuade' after Chuck Norris kicked David Carradine's ass, then proceeded to barbecue and eat him.",
    "Police label anyone attacking Chuck Norris as a Code 45-11.... A suicide.",
    "Chuck Norris uses 8'x10' sheets of plywood as toilet paper.",
    "A handicapped parking sign does not signify that this spot is for handicapped people. It is actually in fact a warning, that the spot belongs to Chuck Norris and that you will be handicapped if you park there.",
    "Chuck Norris sleeps with a pillow under his gun.",
    "'Sweating bullets' is literally what happens when Chuck Norris gets too hot.",
    "Chuck Norris doesn't cheat death. He wins fair and square.",
    "No one has ever spoken during review of Chuck Norris' code and lived to tell about it.",
    "The best-laid plans of mice and men often go awry. Even the worst-laid plans of Chuck Norris come off without a hitch.",
    "When Chuck Norris makes a burrito, its main ingredient is real toes.",
    "Chuck Norris programs do not accept input.",
    "When Chuck Norris does a pushup, he isn't lifting himself up, he's pushing the Earth down.",
    "The 1972 Miami Dolphins lost one game, it was a game vs. Chuck Norris and three seven year old girls. Chuck Norris won with a roundhouse-kick to the face in overtime.",
    "To be or not to be? That is the question. The answer? Chuck Norris.",
    "Chuck Norris does not follow fashion trends, they follow him. But then he turns around and kicks their ass. Nobody follows Chuck Norris.",
    "Chuck Norris can read from an input stream.",
    "When Arnold says 'I'll be back' in Terminator movie it is implied that he's going to ask Chuck Norris for help.",
    "When Chuck Norris break the build, you can't fix it, because there is not a single line of code left.",
    "Two wrongs don't make a right. Unless you're Chuck Norris. Then two wrongs make a roundhouse kick to the face.",
    "There are no races, only countries of people Chuck Norris has beaten to different shades of black and blue.",
    "Chuck Norris knows the last digit of pi.",
    "Chuck Norris's brain waves are suspected to be harmful to cell phones.",
    "On the set of Walker Texas Ranger Chuck Norris brought a dying lamb back to life by nuzzling it with his beard. As the onlookers gathered, the lamb sprang to life. Chuck Norris then roundhouse kicked it, killing it instantly. This was just to prove that the good Chuck givet",
    "Chuck Norris doesn't use reflection, reflection asks politely for his help.",
    "If you Google search 'Chuck Norris getting his ass kicked' you will generate zero results. It just doesn't happen.",
    "Chuck Norris has never won an Academy Award for acting... because he's not acting.",
    "They once made a Chuck Norris toilet paper, but there was a problem-- It wouldn't take sh*t from anybody.",
    "Industrial logging isn't the cause of deforestation. Chuck Norris needs toothpicks.",
    "Chuck Norris was what Willis was talkin' about.",
    "Nobody doesn't like Sara Lee. Except Chuck Norris.",
    "Chuck Norris doesn't bowl strikes, he just knocks down one pin and the other nine faint.",
    "A study showed the leading causes of death in the United States are: 1. Heart disease, 2. Chuck Norris, 3. Cancer",
    "Chuck Norris doesn't need an account. He just logs in.",
    "The Manhattan Project was not intended to create nuclear weapons, it was meant to recreate the destructive power in a Chuck Norris Roundhouse Kick. They didn't even come close.",
    "If Chuck Norris were a calendar, every month would be named Chucktober, and every day he'd kick your ass.",
    "It is better to give than to receive. This is especially true of a Chuck Norris roundhouse kick.",
    "Chuck Norris doesn't do Burn Down charts, he does Smack Down charts.",
    "Chuck Norris can taste lies.",
    "The word 'Kill' was invented by Chuck Norris. Other words were 'Die', 'Beer', and 'What'.",
    "In the X-Men movies, none of the X-Men super-powers are done with special effects. Chuck Norris is the stuntman for every character.",
    "Chuck Norris doesn't shower, he only takes blood baths.",
    "Chuck Norris can do a roundhouse kick faster than the speed of light. This means that if you turn on a light switch, you will be dead before the lightbulb turns on.",
    "In an act of great philanthropy, Chuck made a generous donation to the American Cancer Society. He donated 6,000 dead bodies for scientific research.",
    "Chuck Norris proved that we are alone in the universe. We weren't before his first space expedition.",
    "Chuck Norris once roundhouse kicked someone so hard that his foot broke the speed of light, went back in time, and killed Amelia Earhart while she was flying over the Pacific Ocean.",
    "Chuck Norris wipes his ass with chain mail and sandpaper.",
    "Chuck Norris is widely predicted to be first black president. If you're thinking to yourself, 'But Chuck Norris isn't black', then you are dead wrong. And stop being a racist.",
    "The pie scene in 'American Pie' is based on a dare Chuck Norris took when he was younger. However, in Chuck Norris' case, the 'pie' was the molten crater of an active volcano.",
    "Chuck Norris' Penis is a third degree blackbelt, and an honorable 32nd-degree mason.",
    "MacGyver immediately tried to make a bomb out of some Q-Tips and Gatorade, but Chuck Norris roundhouse-kicked him in the solar plexus. MacGyver promptly threw up his own heart.",
    "When Chuck Norris talks, everybody listens. And dies.",
    "Chuck Norris? favourite cut of meat is the roundhouse.",
    "Chuck Norris does not code in cycles, he codes in strikes.",
    "Chuck Norris doesn't throw up if he drinks too much. Chuck Norris throws down!",
    "Wo hu cang long. The translation from Mandarin Chinese reads: 'Crouching Chuck, Hidden Norris'",
    "Chuck Norris likes his ice like he likes his skulls: crushed.",
    "Chuck Norris can overflow your stack just by looking at it.",
    "Chuck Norris doesn't step on toes. Chuck Norris steps on necks.",
    "Every SQL statement that Chuck Norris codes has an implicit 'COMMIT' in its end.",
    "It is believed dinosaurs are extinct due to a giant meteor. That's true if you want to call Chuck Norris a giant meteor.",
    "Chuck Norris is responsible for China's over-population. He hosted a Karate tournament in Beijing and all women within 1,000 miles became pregnant instantly.",
    "Chuck Norris had to stop washing his clothes in the ocean. The tsunamis were killing people.",
    "Little Miss Muffet sat on her tuffet, until Chuck Norris roundhouse kicked her into a glacier.",
    "If Chuck Norris writes code with bugs, the bugs fix themselves.",
    "Chuck Norris qualified with a top speed of 324 mph at the Daytona 500, without a car.",
    "Chuck Norris's database has only one table, 'Kick', which he DROPs frequently.",
    "Chuck Norris got his drivers license at the age of 16. Seconds.",
    "Chuck Norris invented his own type of karate. It's called Chuck-Will-Kill.",
    "The square root of Chuck Norris is pain. Do not try to square Chuck Norris, the result is death.",
    "Chuck Norris can spawn threads that complete before they are started.",
    "Teenage Mutant Ninja Turtles is based on a true story: Chuck Norris once swallowed a turtle whole, and when he crapped it out, the turtle was six feet tall and had learned karate.",
    "Chuck Norris has never been in a fight, ever. Do you call one roundhouse kick to the face a fight?",
    "It's widely believed that Jesus was Chuck Norris' stunt double for crucifixion due to the fact that it is impossible for nails to pierce Chuck Norris' skin.",
    "Wilt Chamberlain claims to have slept with more than 20,000 women in his lifetime. Chuck Norris calls this 'a slow Tuesday.'",
    "MacGyver can build an airplane out of gum and paper clips, but Chuck Norris can roundhouse-kick his head through a wall and take it.",
    "Chuck Norris is ten feet tall, weighs two-tons, breathes fire, and could eat a hammer and take a shotgun blast standing.",
    "Chuck Norris likes his coffee half and half: half coffee grounds, half wood-grain alcohol.",
    "Chuck Norris can write multi-threaded applications with a single thread.",
    "Chuck Norris can binary search unsorted data.",
    "Chuck Norris does not wear a condom. Because there is no such thing as protection from Chuck Norris.",
    "TNT was originally developed by Chuck Norris to cure indigestion.",
    "One time, at band camp, Chuck Norris ate a percussionist.",
    "There are two types of people in the world... people that suck, and Chuck Norris.",
    "Chuck Norris can delete the Recycling Bin.",
    "Chuck Norris sheds his skin twice a year.",
    "Chuck Norris can do a wheelie on a unicycle.",
    "Chuck Norris can slam a revolving door.",
    "Chuck Norris doesnt wear a watch, HE decides what time it is.",
    "The show Survivor had the original premise of putting people on an island with Chuck Norris. There were no survivors, and nobody is brave enough to go to the island to retrieve the footage.",
    "When Chuck Norris was denied an Egg McMuffin at McDonald's because it was 10:35, he roundhouse kicked the store so hard it became a Wendy's.",
    "Chuck Norris once kicked a horse in the chin. Its descendants are known today as Giraffes.",
    "Mr. T pities the fool. Chuck Norris rips the fool's head off.",
    "Once Chuck Norris signed a cheque and the bank bounced.",
    "The grass is always greener on the other side, unless Chuck Norris has been there. In that case the grass is most likely soaked in blood and tears.",
    "Chuck Norris can retrieve anything from /dev/null.",
    "Most boots are made for walkin'. Chuck Norris' boots ain't that merciful.",
    "Chuck Norris's beard can type 140 wpm.",
    "Chuck Norris died before 20 years, Death doesn't have the courage to tell him yet.",
    "Chuck Norris can over-write a locked variable.",
    "Every time someone uses the word 'intense', Chuck Norris always replies 'you know what else is intense?' followed by a roundhouse kick to the face.",
    "Bill Gates thinks he's Chuck Norris. Chuck Norris actually laughed. Once.",
    "Along with his black belt, Chuck Norris often chooses to wear brown shoes. No one has DARED call him on it. Ever.",
    "Chuck Norris can't test for equality because he has no equal.",
    "Chuck Norris can unit test entire applications with a single assert.",
    "Jesus can walk on water, but Chuck Norris can swim through land.",
    "The Chuck Norris Eclipse plugin made alien contact.",
    "Chuck Norris doesn't age, because time cannot keep up with him.",
    "Chuck Norris can win in a game of Russian roulette with a fully loaded gun.",
    "The truth will set you free. Unless Chuck Norris has you, in which case, forget it buddy!"
  }
  
  local random = math.random() * #norrisJokes
  local index = 1 + math.floor(random)
  local joke = norrisJokes[index]

  return joke
end

-- GetESO()
-- Data; Returns random ESO joke
function Joker.GetESO()

  -- Compilation of ESO jokes
  -- Source: ESO Lexicon (MIT License): https://github.com/esoui/lexicon/blob/master/lexicon/joke/joke.go
  local esoJokes = {
    "What does a new Sentinel private learn first as a combat technique? How to retreat.",
    "You know, you might be a Nord if it's impossible to see food stains on your armor",
    "A Nord decides to cut down a tree. What does he tell it? 'You will die where ya stand!'",
    "What do a Nords and a bottle of port have in common? They're both empty from the neck up!",
    "What do you call a Bosmer everyone likes? Dead",
    "What do you say to a Dunmer woman to convince her to go to bed with you? Have another ale!",
    "I won't eat anything that has intelligent life, but I will happily eat a politician or a .",
    "Why did the shoe store go out of business? It was in Argonia.",
    "A Dark Elf woman was being shown around Daggerfall. When she was shown the magnificent Castle Daggerfall, she smiled sweetly to her guide and whispered, 'It reminds me of sex.' 'That's odd,' said her guide. 'Why does our Castle Daggerfall remind you of sex?' The Dark Elf sighed, 'Everything does.'",
    "During the War of Betony, the Bretons in the Isle of Craghold were under siege for several days. After the island was liberated, Lord Bridwell found the ruins of the castle where a crowd of survivors were hidden away in the dark. It was going to be a difficult job freeing them, as part of the roof had collapsed trapping them all within. Bridwell stuck his head in the only opening and shouted to the Bretons below: 'Are there any expectant mothers down there?' 'It's hard to say, your Lordship,' said a young woman. 'We've only been down here for a few days.'",
    "A Khajiit walks into a bar and the bar tender says, 'Why the long face?'",
    "Did you hear there are a couple dyslexics at the Temple of the Divines? They're always arguing about the existence of Dog.",
    "What a Orc lacks in intelligence, he makes up for in stupidity.",
    "What do a smart Orc and an orcoblin have in common? They're both extinct!",
    "Altmer asks Dunmer: Do you know how to save 5 drowning Bosmer? Dunmer answers: No. Altmer says: Good.",
    "What's the best way to convince even the most pompous Altmer that you have a good point? Stab them in the chest with it.",
    "Yelithah told Vathysah that she was having dinner with a Dark Elf named Morleth that night. 'I hear he's an animal,' said Vathysah. 'He'll rip your dress right off you.' 'Thank you for telling me,' said Yelithah, 'I'll be sure to wear an old dress.'",
    "What do you get when you cross a Nord, a Dunmer, and an Argonian? Violently Murdered! Blood for the Pact!",
    "How do you make a Nord laugh on Morndas? Tell him a joke on Fredas!",
    "Two mudcrabs are eating a dead Argonian. One says 'I hate sea food.' The other says 'OH MY GOSH! A TALKING MUDCRAB!'",
    "A Nord, Dunmer, and Khajiit walk up to the local tavern. The Nord and Dunmer walk in. Slaves stay outside.",
    "Why did the Nord put the letters 'T.G.I.F.' on his boots? To remind himself - Toes Go In First!",
    "How many Nords does it take to change a lantern? Six. One to hold the lantern and the other five to drink till the room spins.",
    "A pair of fair-haired Breton lasses decided to make a pilgrimage to the capitol of Cyrodiil. Near the end of the journey they happened upon a fork in the road with a sign that read: ~Imperial City Left~. Disheartened, they turned around and went home.",
    "An Orc walks into a bar in Cyrodiil with an ugly, one eyed, mangled parrot on his shoulder. The barkeeper looks up, jumps back, and proclaims, 'God what an ugly thing. Where did you get it?' The parrot responded, 'Orsinium. They are all over the #$%&# place.'",
    "An elderly Breton met with a contemporary of his at a guild meeting. 'Harryston, old man, I wanted to express my sympathy. I hear that you buried your wife last week.' 'Had to, old boy,' replied Harryston. 'Dead, you know.'",
    "What did the Nord woman say after she was told she was pregnant? 'Is it mine?'!",
    "What did the Nord girl say after someone blew in her ear? 'Thanks for the refill!'",
    "How many Altmer does it take to change a lantern? None. The humans burned the lantern out, let THEM change it!",
    "What makes Sheogorath stand out above the other Daedra? A ladder.",
    "You know, lots of people say that Telvanni kids procrastinate too much. Well, just you wait.",
    "An Altmer, a Nord and an Imperial were passengers on a boat. The weather got real bad, it was Clear the boat was in big trouble. 'We're overloaded!' the captain shouted. 'There's only one solution: One of you must jump overboard!' 'I do this for the Aldmeri Dominion!' the Altmer shouted, and threw himself overboard. It helped for a while, but then the captain informed that the boat was still overloaded, there was nothing else to do, one more passenger needed to jump. 'I do this for Skyrim!' the Nord shouted, and threw the Imperial overboard.",
    "Most Altmer family trees don't fork!",
    "A Dark Elf man killed his wife after catching her making love with another man. When the magistrate asked him why he killed her instead of her lover, the man replied, 'I considered it better to kill one woman than a different man every week.'",
    "How do you separate sailors in the Khajiiti navy? With a hammer and tongs.",
    "How many Dunmer does it take to change a lantern? Just the one.... but in the great old days, hundreds of slaves would change thousands of lanterns, at their every whim!",
    "Why does Dagoth Ur always carry asprin with him? To help in case of a heart attack.",
    "What is the first thing a Dunmer woman does in the morning? Walk home!",
    "What do you call an Orc with half a brain? Gifted!",
    "A group of three Nords are exploring Valenwood when they are captured by some Bosmer. They are brought before the King, who tells them they are to be cooked and eaten for an upcoming feast. The men are tied up and lowered into a giant pot of water. Two of the Nords start screaming and shouting, but the third starts laughing hysterically. His friends ask him, 'What is so funny? We're about to be boiled alive, you know!'. The laughing Nord grins and says, 'I just crapped in their soup!'",
    "'I keep seeing spots before my eyes.' 'Have you seen a healer?' 'No, just spots.'",
    "A big Nord named Julgen was set on by a gang of thieves. He fought them furiously, but in the end, they beat him into semiconsciousness. They searched his pockets and discovered that he only had three gold pieces on him. 'Do you mean to tell us you fought us like a mad lupe for three lousy gold pieces?' sneered one of the thieves. 'No,' answered Julgen. 'I was afraid you were after the four hundred gold pieces in my boot.'",
    "What is the thinnest book in the world? Redguard Heroes of the War of Betony.",
    "How can you tell if a Khajiit is lying? His lips are moving!",
    "Argonian in Morrowind: 'All I wanted was a pair of boots.'",
    "Why was the Sentinel army so useless during the War of Betony? The cannons were too heavy, so all three garbage scows sunk.",
    "What do you call a Wood Elf who doesn't lie or cheat or steal? A dead Wood Elf.",
    "How do you get a Nord's eyes to sparkle? Put a torch in his ear!",
    "A blind Dunmer is sitting in a tavern when he suddenly pipes up. 'Hey, anyone wanna hear a joke about a dumb Nord?' The man next to the blind Dunmer speaks up, 'Before you tell this joke, there's a few things you need to know.' 'Sure,' says the Dunmer, 'What's that?' 'Well, for one thing, the bartender is a Nord.' the man says, 'And so is the doorman. And the man next to you, he's a Nord, too. And the two very large men in the corner by the door, they're Nords, as well. In fact, I'm a Nord, too.' The man leans in really closely to the blind Dunmer. 'So, you still want to tell that joke about a dumb Nord?' The blind Dunmer cleared his throat and smiled, 'Nah... not if I'm going to have to explain it 6 fetchin' times!'",
    "Why do Khajiit lick their butts? To get the taste of Khajiit cooking out of their mouths!",
    "What do you wear to dinner in Vallenwood? Barbeque Sauce.",
    "What is a Nord doing when he holds his hands tight over his ears? Trying to hold a thought!",
    "A Nord was standing in the woods, wondering why an arrow seemed to be getting bigger and bigger. And then it hit him.",
    "Why did the Bosmer fall out of the tree? Because he was dead.",
    "Two Bosmer try chicken for the first time. Says the one: 'Tastes like human.'",
    "What do you call a Nord with two brain cells? Pregnant.",
    "Why did Dwemers disappear? Because they were so deep no one could understand them.",
    "I once met an aquaphobic Argonian.",
    "A Nord is taking his family to Ebonheart. As they travel down the road, they reach a sign that says 'Ebonheart: Left', so the Nord turned his family around and went back home.",
    "How does the Dragonborn like to view his photos? Thu'umnails",
    "A Khajiit cub walked into a bar, and asked if the bartender had seen his family. The bartender apologized, 'Sorry, you'll have to look Elsweyr'.",
    "Why do Bosmer women wear undergarments? To keep their ankles warm!",
    "'This orchard has sentimental value to me,' said Mojhad, the Khajiit, to his friend, Hasillid. 'Under that tree, for example, is where I first made love. And that tree, is where her mother stood, watching us.' 'She watched you while you made love to her daughter?' said Hasillid, clearly impressed. 'Didn't she say anything?' 'Meow.'",
    "What do you call a basement with more than one Breton? A WHINE cellar!",
    "What does an Imperial Guard recruit do for fun? Himself.",
    "You know, you might be a Argonian if you have grease under your toenails",
    "'How is your wife,' asked Zalither. 'She's in bed with laryngitis,' replied Harlyth. 'Is that Argonian bastard back in town again?'",
    "Why does Fargoth smell? So blind people can hate him too.",
    "You know, it only takes one drink to get a Nord drunk. I can't remember if it's the thirteenth or the fourteenth.",
  }

  local random = math.random() * #esoJokes
  local index = 1 + math.floor(random)
  local joke = esoJokes[index]

  return joke
end


--[[
  ** Data Displays
  PURPOSE: These functions parse and init data display
]]

-- Colorize()
-- Display; Wraps text with a color.
function Joker.Colorize(text, color)
  -- Default to addon's .color.
  if not color then color = Joker.color end
  text = "|c" .. color .. text .. "|r"
  return text
end

-- Norris()
-- Display; Returns Norris joke, allows for optional given <me> or <target>
function Joker.Norris(target)
  local joke = ""

   -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
   repeat
    joke = Joker.GetNorris()
    jokeLength = string.len(joke)
    -- d('Got joke with ' .. jokeLength .. 'chars...')
  until (jokeLength < 350)

  if target == 'me' then
    joke = string.gsub(joke, "Chuck Norris", GetUnitName("player"))
  elseif not Joker.isempty(target) then
    joke = string.gsub(joke, "Chuck Norris", target)
  end

  if Joker.savedVariables.FirstNorris then
    Joker.savedVariables.FirstNorris = false
    d('NOTE: Roundhouse kick! Like these types of jokes? Get more with /joke-norris or just /norris! This message only displays on your first usage.')
  end

  -- d(joke) -- Echo out debug during dev
  StartChatInput(joke, CHAT_CHANNEL) -- Paste into chatbox
end

-- ESO()
-- Display; Returns ESO joke. For now, no optionals handled
function Joker.ESO()
  local joke = ""
  local jokeLength = 350 -- Max length for a chat message

  -- Split every 300 chars, then paste to chatbox. Leaving for reference in future.
  -- joke = Joker.split(joke, 300)
  -- d(joke)
  -- for _, line in ipairs(joke) do
  --   if not Joker.isempty(line) then
  --     zo_callLater(function() StartChatInput(line, CHAT_CHANNEL) end, 1000)
  --   end
  -- end

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetESO()
    jokeLength = string.len(joke)
    -- d('Got joke with ' .. jokeLength .. 'chars...')
  until (jokeLength < 350)

  StartChatInput(joke, CHAT_CHANNEL) -- Paste into chatbox
end

-- Dad()
-- Display; Returns Dad joke. For now, no optionals handled
function Joker.Dad()
  local joke = ""
  local jokeLength = 350 -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetDad()
    jokeLength = string.len(joke)
  until (jokeLength < 350)

  if Joker.savedVariables.FirstDad then
    Joker.savedVariables.FirstDad = false
    d('NOTE: Hi, Dad! Like these types of jokes? Get more with /joke-dad or just /dad! This message only displays on your first usage.')
  end

  StartChatInput(joke, CHAT_CHANNEL) -- Paste into chatbox
end

-- Wisdom()
-- Display; Returns Wisdom tidbit. For now, no optionals handled
function Joker.Wisdom()
  local joke = ""
  local jokeLength = 350 -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetWisdom()
    jokeLength = string.len(joke)
  until (jokeLength < 350)

  StartChatInput(joke, CHAT_CHANNEL) -- Paste into chatbox
end

-- Edgy()
-- Display; Returns Edgy/Explicit joke. For now, no optionals handled
function Joker.Edgy()
  local joke = ""
  local jokeLength = 350 -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetEdgy()
    jokeLength = string.len(joke)
  until (jokeLength < 350)

  if Joker.savedVariables.FirstEdgy then
    Joker.savedVariables.FirstEdgy = false
    d('NOTE: Edgy jokes have been flagged as particularly inappropriate, edgy, or explicit and may not be suitable for all audiences. Please be considerate in your usage. This message only displays on your first usage.')
  end

  

  StartChatInput(joke, CHAT_CHANNEL) -- Paste into chatbox
end

-- PickupLines()
-- Display; Returns cheesy pickup line. For now, no optionals handled
function Joker.PickupLines()
  local joke = ""
  local jokeLength = 350 -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetPickupLines()
    jokeLength = string.len(joke)
  until (jokeLength < 350)

  StartChatInput(joke, CHAT_CHANNEL) -- Paste into chatbox
end

-- eightBall()
-- Display; Show a yes, no, neutral status
function Joker.eightBall(question)
  local yesAnswers = {
    "Signs point to yes!",
    "The outlook is good!",
    "Don't count on it!",
    "Yes!",
    "It is certain.",
    "Without a doubt!",
    "Duh!",
    "Mhm.",
    "Fk yeah! ('Murica)",
    "It is decidedly so.",
  }

  local noAnswers = {
    "My sources say 'no'.",
    "As I see it, no.",
    "You aren't going to like this, but ... no.",
    "Very doubtful.",
    "What?!? No! Are you crazy?",
    "Awwwww, hell naw!",
    "Nah.",
    "Unlikely.",
  }

  local neutAnswers = {
    "I'm neutral, try again.",
    "I dunno.",
    "Ask later.",
    "Reply is a bit hazy, try again!",
    "Hmm, better not tell you now...",
    "Can't predict that right now, sorry. Try again.",
  }

  -- Decide how to answer
  local random = math.random(0, 2)
  local random2 = math.random() * #yesAnswers
  local index = 1 + math.floor(random2)
  local answer = yesAnswers[index]

  if random == 0 then
    answerType = "yes"
  elseif random == 1 then
    answerType = "no"
    random2 = math.random() * #noAnswers
    index = 1 + math.floor(random2)
    answer = noAnswers[index]
  elseif random == 2 then
    answerType = "neut"
    random2 = math.random() * #neutAnswers
    index = 1 + math.floor(random2)
    answer = neutAnswers[index]
  end
  local prefix = "8ball says: "

  if not Joker.isempty(question) then
    d('You asked: "' .. question ..'" ...')
  end

  d(prefix .. answer)

end

-- --------------
-- AnyJoke()
-- Display; Randomly chooses a type of joke, returns. Optionals passed along as needed.
function Joker.AnyJoke(target)
  local jokeSources = { -- Includes most, but not all, topics. Edgy/explicit not included
    "Norris",
    "ESO",
    "Dad",
    "Wisdom"
  }
  local random = math.random(0, 500)

  if random < 180 then
    local joke = Joker.Norris(target)
  elseif random >= 180 and random < 300 then
    local joke = Joker.ESO()
  elseif random >= 300 and random < 450 then
    local joke = Joker.Dad()
  elseif random >= 450 and random <=  500 then
    local joke = Joker.Wisdom()
  end

  -- d(joke) -- Echo out debug during dev
  StartChatInput(joke, CHAT_CHANNEL)
end

-- --------------

-- Only show the loading message on first load ever. Displays a random message
function Joker.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED)

    if Joker.savedVariables.FirstLoad then
        Joker.savedVariables.FirstLoad = false

        d(Joker.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Prints to chat.

        ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
            Joker.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.

        -- Animate the xml UI center text, after a delay.
        zo_callLater(Joker.Get, 3000)
    end
end

-- When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED, Joker.Activated)

function Joker.OnAddOnLoaded(event, addonName)
    if addonName ~= Joker.name then return end
    EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_ADD_ON_LOADED)

    Joker.savedVariables = ZO_SavedVars:New("JokerSavedVariables", 1, nil, Joker.savedVariables)

    -- Settings menu in Settings.lua.
    Joker.LoadSettings()

    -- NOTE: Slash commands must be lowercase!
    SLASH_COMMANDS["/joke"] = Joker.AnyJoke -- Does not include edgy or pickup lines!
    SLASH_COMMANDS["/joke-norris"] = Joker.Norris
    SLASH_COMMANDS["/joke-eso"] = Joker.ESO
    SLASH_COMMANDS["/joke-dad"] = Joker.Dad
    SLASH_COMMANDS["/joke-edgy"] = Joker.Edgy
    SLASH_COMMANDS["/joke-wisdom"] = Joker.Wisdom
    -- Other joke command aliases:
    SLASH_COMMANDS["/wisdom"] = Joker.Wisdom
    SLASH_COMMANDS["/dad"] = Joker.Dad
    SLASH_COMMANDS["/norris"] = Joker.Norris
    SLASH_COMMANDS["/8ball"] = Joker.eightBall

    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
end
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_ADD_ON_LOADED, Joker.OnAddOnLoaded)
