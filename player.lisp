(defclass player ()
    ((name :accessor player-name)
     (hand :accessor player-hand)
     (chips :accessor player-chips)))