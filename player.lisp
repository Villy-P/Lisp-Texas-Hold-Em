; PLAYER CLASS
(defclass player ()
    ((name :accessor player-name)
     (hand :accessor player-hand)))