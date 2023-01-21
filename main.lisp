(declaim (sb-ext:muffle-conditions sb-ext:compiler-note))

(defvar main-player (make-instance 'player))

(defvar computer-num 0)
(defvar computers (list))

(defvar dealer-button-index nil)
(defvar current-player nil)

(defvar current-bet 10)

(defun getLeft (i)
    (when (eq i 0) (return-from getLeft (get-last computers)))
    (when (eq i 1) (return-from getLeft main-player))
    (nth (- i 2) computers))

(defun getLeftNum (i)
    (when (eq i 0) (return-from getLeftNum computer-num))
    (when (eq i 1) (return-from getLeftNum 0))
    (- i 1))

(defun getTwoLeft (i)
    (when (eq i 0) (return-from getTwoLeft (get-second-last computers)))
    (when (eq i 1) (return-from getTwoLeft (get-last computers)))
    (when (eq i 2) (return-from getTwoLeft main-player))
    (nth (- i 3) computers))

(defun getCurrent (i)
    (when (eq i 0) (return-from getCurrent main-player))
    (nth (- i 1) computers))

(defun main ()
    (setf *random-state* (make-random-state t))
    (setf deck (shuffle deck))
    (princ "Welcome to Texas Hold'em!")(terpri)
    (princ "What is your name? ")
    (finish-output)
    (setf (player-name main-player) (read))
    (setf (player-hand main-player) (list))
    (setf (player-chips main-player) 2000)
    (setf (player-has-button main-player) nil)
    (loop
        (princ "How many people do you want to play against? (limit 2 max 8) ")
        (finish-output)(setf computer-num (read))
        (when (and (> computer-num 1) (< computer-num 9)) (return computer-num)))
    (dotimes (i computer-num)
        (setq computers (append computers (list (make-instance 'player))))
        (setf (player-name (nth i computers)) (format nil "Computer #~d" i))
        (setf (player-hand (nth i computers)) (list))
        (setf (player-chips (nth i computers)) 2000)
        (setf (player-has-button (nth i computers)) nil)
        (give-player-cards (nth i computers) 2))

    ; 0 is main-player any other is index + 1 of computer-num
    (setq dealer-button-index (random-from-range 0 computer-num))
    (setq current-player (getLeft (getLeftNum (getLeftNum dealer-button-index))))
    
    (terpri)
    (setf (player-has-button (getCurrent dealer-button-index)) t)
    (princ (format nil "~s got the dealer button" (player-name (getCurrent dealer-button-index))))
    (terpri)(princ (format nil 
        "~s put down 1 chip as the Small Blind and ~s put down 2 chips as the Big Blind"
        (player-name (getLeft dealer-button-index)) (player-name (getTwoLeft dealer-button-index))))
    (setf (player-chips (getLeft dealer-button-index)) (- (player-chips (getLeft dealer-button-index)) 5))
    (setf (player-chips (getTwoLeft dealer-button-index)) (- (player-chips (getTwoLeft dealer-button-index)) 10))
    (terpri)

    (terpri)(princ "The dealer hands you and the computers each two cards.")
    (give-player-cards main-player 2)
    (terpri)(princ "You got:")(terpri)
    (print-player-cards main-player)


    (finish-output))

(main)