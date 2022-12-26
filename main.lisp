(defclass Player ()
    ((name :accessor player-name)))

(defvar main-player (make-instance 'Player))
(defvar computer-num 0)
(defvar computers (make-array '(8)))

(defun main ()
    (princ "Welcome to Texas Hold'em!")(terpri)
    (princ "What is your name? ")
    (finish-output)(setf (player-name main-player) (read))
    (loop
        (princ "How many people do you want to play against? (limit 1 max 8) ")
        (finish-output)(setf computer-num (read))
        (when (and (> computer-num 0) (< computer-num 9)) (return computer-num)))
    (dotimes (i computer-num)
        (setf (aref computers i) (make-instance 'Player))
        (setf (player-name (aref computers i)) (format nil "Computer #~d~%" i)))
        
(main)