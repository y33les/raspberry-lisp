;; ch2.lisp

;; gpl disclaimer
;; by phil yeeles, etc.

;; Chapter 2: `Creating Your First Lisp Program'

;; Barski begins with a simple game of `Guess My Number'.  This game
;; requires the computer to make a series of guesses to determine the
;; number that the user is thinking of.  With each incorrect guess,
;; the user specifies whether their number is less or greater than the
;; number guessed, using two functions: (smaller) and (bigger).

;; To implement this game, we need to consider _how_ the computer will
;; go about improving its guesses.  Barski describes a method known
;; as `binary search', in which a range of numbers is repeatedly
;; subdivided until a target is reached.
