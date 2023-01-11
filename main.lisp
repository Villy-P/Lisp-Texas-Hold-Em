(defvar main-player (make-instance 'player))

(defvar computer-num 0)
(defvar computers (list))

(defvar dealer-button-index nil)

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
        (setf (player-has-button (nth i computers)) nil))

    ; 0 is main-player any other is index + 1 of computer-num
    (setq dealer-button-index (random-from-range 0 computer-num))
    
    (terpri)
    (if (eq dealer-button-index 0)
        (progn  
            (setf (player-has-button main-player) t)
            (princ "You got the dealer button")(terpri)
            (princ (format nil 
                "~s put down 1 chip as the Small Blind and ~s put down 2 chips as the Big Blind"
                (player-name (get-last computers)) (player-name (nth (- computer-num 2) computers))))
            (setf (player-chips (get-last computers)) (- (player-chips (get-last computers)) 1))
            (setf (player-chips (nth (- computer-num 2) computers)) 
                (- (player-chips (nth (- computer-num 2) computers)) 1)))
        (progn
            (setf (player-has-button (nth (- dealer-button-index 1) computers)) t)
            (princ (format nil "~s got the dealer button" 
                (player-name (nth (- dealer-button-index 1) computers))))
            (terpri)
            (if (eq dealer-button-index 1)
                (progn
                    (princ (format nil 
                        "~s put down 1 chip as the Small Blind and ~s put down 2 chips as the Big Blind"
                        (player-name main-player) (player-name (get-last computers))))
                    (setf (player-chips main-player) (- (player-chips main-player) 1))
                    (setf (player-chips (get-last computers)) (- (player-chips (get-last computers)) 2)))
                (if (eq dealer-button-index computer-num)
                    (progn
                        (princ (format nil 
                            "~s put down 1 chip as the Small Blind and ~s put down 2 chips as the Big Blind"
                            (player-name (nth (- computer-num 2) computers)) 
                                (player-name (nth (- computer-num 1) computers))))
                        (setf (player-chips (nth (- computer-num 2) computers))
                            (- (player-chips (nth (- computer-num 2) computers)) 1))
                        (setf (player-chips (nth (- computer-num 1) computers)) 
                            (- (player-chips (nth (- computer-num 1) computers)) 2)))
                    (if (eq dealer-button-index 2)
                        (progn
                            (princ (format nil 
                                "~s put down 1 chip as the Small Blind and ~s put down 2 chips as the Big Blind"
                                (player-name (nth 1 computers)) 
                                    (player-name main-player)))
                            (setf (player-chips (nth 1 computers))
                                (- (player-chips (nth 1 computers)) 1))
                            (setf (player-chips main-player) 
                                (- (player-chips main-player) 2))))))
                        (progn
                            (princ (format nil 
                                "~s put down 1 chip as the Small Blind and ~s put down 2 chips as the Big Blind"
                                (player-name (nth (- dealer-button-index 2) computers)) (player-name (nth (- dealer-button-index 3) computers))))
                            (setf (player-chips (nth (- dealer-button-index 2) computers))
                                (- (player-chips (nth (- dealer-button-index 2) computers)) 1))
                            (setf (player-chips (nth (- dealer-button-index 3) computers))
                                (- (player-chips (nth (- dealer-button-index 3) computers)) 2)))))
    (terpri)

    (dotimes (i computer-num)
        (if (eq (player-has-button (nth i computers)) nil) 
            (give-player-cards (nth i computers) 2)))

    (terpri)(princ "The dealer hands you and the computers each two cards.")
    (give-player-cards main-player 2)
    (terpri)(princ "You got:")(terpri)
    (print-player-cards main-player)


    (finish-output))

(main)