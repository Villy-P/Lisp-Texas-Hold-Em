(defclass Player ()
    ((name :accessor player-name)))

(defvar mainPlayer (make-instance 'Player))

(defun main ()
    (write "What is your name?")
    (setf (player-name mainPlayer) (read))
    (format t "Player Name is ~s~%" (player-name mainPlayer)))

(main)