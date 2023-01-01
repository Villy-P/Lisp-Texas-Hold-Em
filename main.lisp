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