poker-croupier
==============

[![Build Status](https://travis-ci.org/devill/poker-croupier.png?branch=master)](https://travis-ci.org/devill/poker-croupier)

Robot poker croupier for poker retreats. The project is incomplete, and we are looking for contributors.

# What is a poker retreat

A poker retreat is a planned event much like a coderetreat, but with a slightly different format and purpose. 

## The purpose

A poker retreat's aim is for participiants to practice concepts related to lean startups and continous depolyment. A poker team is a small group of developers (ideally 4 people forming 2 pairs) whose aim is to incrementally build a highly heuristic algorithm within a one day timeframe that is just smart enough to beat the other robots. Professional poker robots are developed for years, so the purpose is definetly not to come up with something really smart, but to be the smartest among the current competitors. With this in mind teams can come up with simple to implement heuristics, examine their effect on game play during training rounds, and than improve their algorithm in a similar lean fashion.

## The format

Since no poker retreats have been organized yet the format has not been finalized. Everything below is more of a draft. Pleae feel free to contribute your thoughts.

One possibilty is that 45 minute coding sessions are followed by sit-n-go games played by the robots, and a short break. In this case only the last sit-n-go round counts when we determine the winner. Other rounds are just for training from which teams can deduce hypotesises, and test them in subsequent traing rounds.

Another way to do it would concentrate a bit more on the continuous delivery aspect. In this case each team has infinite chips they can use to rebuy into the game any time they lost all their chips. The game is played continuously, but each team has a small timeframe between rounds for deploying a new version of their robot. The croupier would enforce an SLA. If a player is away from the table for a certain amount of time a penalty has to be payed before the next rebuy. This version lets teams do more experiments, and also forces them to be careful with their deployments. 

## The rules

There are not many rules, but please keep them in mind. All rules of no limit texas hold'em apply.

One of the most important rules is that there is no explicit prize for the winner (the other teams however are free to invite them for a beer after the event). Poker retreats - although they have a competitive feel to them - are not competitions. The emphasis should be on practice.

Another important rule is fair play: no one should try to exploit weekneses of the framework, or deliberately inject backdoors into its source code. Also no team should use any pre-written code. Only the language's standard library, and general purpose opensource libraries are allowed. 

As always with any coderetreat like events: free lunch but avoid pizza.

# How to get started as a contributor

Our [story board](https://trello.com/b/IqfZyfzl) is on Trello. If you would like to contribute, please request an access from [DeVill](https://github.com/devill). To [get started](https://github.com/devill/poker-croupier/wiki/Architectural-guide) as a contributor, read the [architectural guide](https://github.com/devill/poker-croupier/wiki/Architectural-guide).

When implementing rules consult the [Texas Hold'em rules](http://www.pokerstars.com/poker/games/texas-holdem/) and [poker hand ranks](http://www.pokerstars.com/poker/games/rules/hand-rankings/) pages on PokerStars. We wish to play sit-n-go tournaments of No Limit Texas Hold'em.
