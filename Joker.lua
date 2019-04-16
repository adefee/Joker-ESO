Joker = {
    name            = "Joker",           -- Matches folder and Manifest file names.
    version         = "1.1.3",                -- A nuisance to match to the Manifest.
    author          = "Lent (@CallMeLent, Github @adefee)",
    color           = "DDFFEE",             -- Used in menu titles and so on.
    menuName        = "Joker - Best Enjoyed with Skooma!", -- A UNIQUE identifier for menu object.
    -- Default settings.
    savedVariables = {
        FirstLoad = true      -- First time the addon is loaded ever.
    },
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
    "Why did Dwemers disappear? Because they were so deep on one could understand them.",
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
-- Wraps text with a color.
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

-- AnyJoke()
-- Display; Randomly chooses a type of joke, returns. Optionals passed along as needed.
function Joker.AnyJoke(target)
  local jokeSources = {
    "Norris",
    "ESO"
  }
  local random = math.random() * #jokeSources
  local index = 1 + math.floor(random)
  local jokeSource = jokeSources[index]

  if jokeSource == 'Norris' then
    local joke = Joker.Norris(target)
  elseif jokeSource == 'ESO' then
    local joke = Joker.ESO()
  end

  -- d(joke) -- Echo out debug during dev
  StartChatInput(joke, CHAT_CHANNEL)
end

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
    SLASH_COMMANDS["/norris"] = Joker.Norris
    SLASH_COMMANDS["/joke"] = Joker.AnyJoke
    SLASH_COMMANDS["/joke-eso"] = Joker.ESO
    -- SLASH_COMMANDS["/riddle"] = d('Riddles coming soon! Thanks for using Joker!')
    -- SLASH_COMMANDS["/got"] = d('Game of Thrones jokes coming soon! Thanks for using Joker!')

    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
end
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_ADD_ON_LOADED, Joker.OnAddOnLoaded)
