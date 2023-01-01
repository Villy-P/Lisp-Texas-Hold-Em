; PLAYER CLASS
(defclass player ()
    ((name :accessor player-name)
     (hand :accessor player-hand)))

; ARRAY UTILITIES
(defun remove-last (sequence)
    (reverse (cdr (reverse sequence))))

(defun get-last (sequence)
    (first (last sequence)))

; SUITS AND RANKS
(defvar suits (make-array `(4)
    :initial-contents `("Clubs" "Diamonds" "Hearts" "Spades")))
(defvar ranks (make-array `(13)
    :initial-contents `("2" "3" "4" "5" "6" "7" "8" "9" "10"
                        "J" "Q" "K" "A")))

; CARD CLASS
(defclass card ()
    ((rank :accessor card-rank)
     (suit :accessor card-suit)))

; ; DECK
(defvar deck (make-array `(52)))

; CREATE DECK
(dotimes (i 13)
    (dotimes (j 4)
        (setf (aref deck (+ (* 4 i) j)) (make-instance 'card))
        (setf (card-rank (aref deck (+ (* 4 i) j))) (aref ranks i))
        (setf (card-suit (aref deck (+ (* 4 i) j))) (aref suits j))))

; SHUFFLE DECK
(defun shuffle (sequence)
    (loop for i from (length sequence) downto 2 do 
        (rotatef (elt sequence (random i))
            (elt sequence (1- i))))
    sequence)

(setf deck (shuffle deck))

; GLOBAL VARS
(defvar main-player (make-instance 'player))
(setf (player-hand main-player) (make-array `(2)))

(defvar computer-num 0)
(defvar computers (make-array '(8)))

; MAIN FUNCTION
(defun main ()
    (princ "Welcome to Texas Hold'em!")(terpri)
    (princ "What is your name? ")
    (finish-output)(setf (player-name main-player) (read))
    (loop
        (princ "How many people do you want to play against? (limit 1 max 8) ")
        (finish-output)(setf computer-num (read))
        (when (and (> computer-num 0) (< computer-num 9)) (return computer-num)))
    (dotimes (i computer-num)
        (setf (aref computers i) (make-instance 'player))
        (setf (player-name (aref computers i)) (format nil "Computer #~d~%" i))
        (setf (player-hand (aref computers i)) (make-array `(2)))))

(main)