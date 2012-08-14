;; ch2.lisp

;; gpl disclaimer
;; by phil yeeles, etc.

;; Chapter 2: `Creating Your First Lisp Program'

;; Barski begins with a simple game of `Guess My Number'.  This game
;; requires the computer to make a series of guesses to determine the
;; number that the user is thinking of.  With each incorrect guess,
;; the user specifies whether their number is less or greater than the
;; number guessed using two functions, which we will call `smaller'
;; and `bigger'.  These will be used in another function which will
;; define the game, which we will call `guess-my-number'.

;; To implement this game, we need to consider _how_ the computer will
;; go about improving its guesses.  Barski describes a method known
;; as `binary search', in which a range of numbers is repeatedly
;; subdivided until a target is reached.  Given a lower and upper
;; limit, we guess a number between the two.  If the target is
;; smaller, we lower the upper limit.  If the target is greater, we
;; raise the lower limit, until eventually the to limits converge.

;; Before we begin coding proper, we must first consider what Lisp
;; code actually looks like, and how valid expressions are formed.
;; In Lisp, we use `S-expressions' -- lists surrounded by brackets,
;; containing a function followed by its arguments.  This applies to
;; all functions in Lisp, even ones that we would normally write in
;; an infix fashion, such as +.  Try to determine the value of each
;; of the following expressions yourself, before evaluating them in
;; SLIME by pressing C-x C-e at the end of each line (or just copy
;; them into a REPL, minus the leading ";;", if you're not using
;; SLIME).

;; (+ 3 3)
;; (* 2 8 3 4)
;; (- 10 (* 2 4))
;; (* (+ (* 2 5) 7 (- 9 1)) (/ 4 2))
;; (+        2            2                         )

;; Note how S-expressions can take other S-expressions as arguments,
;; and also how the arithmetic functions can take any number of
;; arguments, now just the two we are used to using their infix
;; forms.  Finally, note how whitespace (spaces and line breaks)
;; between the elements of an S-expression does not affect its
;; evaluation.

;; Let us return to the `Guess My Number' task.  We begin by defining
;; the limits as global (or `special', or `dynamic') variables, using
;; the defparameter function. defparameter takes two arguments: a
;; variable name and a value.

(defparameter *small* 1) ;; lower limit
(defparameter *big* 100) ;; upper limit

;; Although asterisks are not technically required when naming global
;; variables, it is common practice to use them.  As Barski puts it:
;; "I cannot vouch for your safety [in a Lisp newsgroup if] your
;; global variables are missing their earmuffs".

;; Values set by defparameter can be overwritten by using
;; defparameter again.  Evaluate the following code to demonstrate
;; this.

;; (defparameter *foo* 1234)
;; *foo*
;; (defparameter *foo* 5768)
;; *foo*

;; An alternative function used for the definition of global
;; variables is defvar, which takes the same arguments as
;; defparameter, but will not overwrite the values of existing global
;; variables.  Evaluate the following code to see this in action.

;; (defvar *bar* 1337)
;; *bar*
;; (defvar *bar* 666)
;; *bar*

;; We now need to define the functions that our game will use.  This
;; can be accomplished using the defun function, which takes as its
;; arguments a function name, a list of arguments and the function
;; that will be applied to the arguments.  Firstly, we define the
;; `guess-my-number' function used to start the game, and to make
;; guesses at the number the user is currently thinking of.

(defun guess-my-number ()
  (ash (+ *small* *big*) -1))

;; As you can see, we have defined a function called `guess-my-
;; number' that takes no arguments and performs the function
;; (ash (+ *small *big*) -1) when called.  The function (ash x y)
;; shifts the bits of x by y places, and (ash (+ *small* *big*) -1)
;; calculates the average of *small* and *big*.  We choose to shift
;; the sum of small* and *big* one place to the right, rather than
;; simply dividing by two, so that the answer obtained is an integer,
;; rather than potentially a ratio, as would be the case if the sum
;; was odd.

;; As an interesting side note, evaluate the following code.

;; (/ 3 2)
;; (/ 3.0 2)
;; (/ 3 2.0)
;; (/ 3.0 2.0)

;; Note that dividing two integers returns a ratio, 3/2, whereas
;; introducing at least one real number into the expression causes
;; another real number to be returned., in this case 1.5.

;; To test guess-my-number, evaluate the following code.

;; (guess-my-number)

;; If everything is working correctly, (guess-my-number) should
;; return 50, being half of the sum of *small* and *big*, which
;; currently have the values of 1 and 100 respectively.

;; Next, we need to define our `smaller' and `bigger' functions.
;; Just as we did previously, we will be using defun.

(defun smaller ()
  (setf *big* (1- (guess-my-number)))
  (guess-my-number))

(defun bigger ()
  (setf *small* (1+ (guess-my-number)))
  (guess-my-number))

;; smaller is a function that takes no arguments.  First, it uses the
;; setf function to change the value of *big* to the computer's
;; current guess (that is, the value returned by (guess-my-number)),
;; decremented by 1 (using the mildly confusingly-named function 1-).
;; It then calls (guess-my-number) again, returning the computer's
;; revised guess at the user's number, given he new value of *small*
;; and *big*.  bigger works similarly, though it modifies *small*
;; rather than *big*, and uses the function 1+ to increment the value
;; returned by (guess-my-number) by 1.

;; We now have a functioning game of `Guess My Number'!  Try it
;; yourself now.  Evaluate the following code, calling
;; (guess-my-number) to start the game, and calling (smaller) and
;; (bigger) as appropriate until the correct value is determined.

;; (guess-my-number)
;; (smaller)
;; (bigger)

;; Finally, to add a bit of polish, we shall define a `start-over'
;; function to reinitialise the game, ready for another round.

(defun start-over ()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess-my-number))

;; Calling (start-over) resets the values of *small* and *big* to 1
;; and 100 respectively, then calls (guess-my-number) again to start
;; a new game.  Try it now.

;; (start-over)

;; Congratulations!  You've successfully implemented a simple game of
;; `Guess My Number'.  In the next instalment, we'll move on to
;; examine Lisp syntax in a bit more detail.

;; Thanks for reading, and happy hacking!
