(defvar main-player (make-instance 'player))
(setf (player-hand main-player) (make-array `(2)))

(defvar computer-num 0)
(defvar computers (list))

(defun main ()
    (setf deck (shuffle deck))
    (princ "Welcome to Texas Hold'em!")(terpri)
    (princ "What is your name? ")
    (finish-output)(setf (player-name main-player) (read))
    (setf (player-chips main-player) 2000)
    (loop
        (princ "How many people do you want to play against? (limit 1 max 8) ")
        (finish-output)(setf computer-num (read))
        (when (and (> computer-num 0) (< computer-num 9)) (return computer-num)))
    (dotimes (i computer-num)
        (setq computers (append computers (list (make-instance 'player))))
        (setf (player-name (nth i computers)) (format nil "Computer #~d~%" i))
        (setf (player-hand (nth i computers)) (list))
        (setf (player-chips (nth i computers)) 2000)
        (dotimes (j 2)
            (setf (player-hand (nth i computers)) (append (player-hand (nth i computers)) (list (get-last deck))))
            (setf deck (remove-last deck)))))

(main)