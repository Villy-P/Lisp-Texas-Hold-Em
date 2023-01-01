; SUITS AND RANKS
(defvar suits (make-array `(4)
    :initial-contents `("Clubs" "Diamonds" "Hearts" "Spades")))
(defvar ranks (make-array `(13)
    :initial-contents `("2" "3" "4" "5" "6" "7" "8" "9" "10"
                        "J" "Q" "K" "A")))

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