(defclass player ()
    ((name :accessor player-name)
     (hand :accessor player-hand)
     (chips :accessor player-chips)
     (has-button :accessor player-has-button)))

(defmethod print-player-cards ((object player))
    (dotimes (i (length (player-hand object)))
        (princ (format nil "A ~s of ~s" 
            (card-rank (nth i (player-hand object))) 
            (card-suit (nth i (player-hand object)))))(terpri)))

(defmethod give-player-cards ((object player) num)
    (dotimes (i num)
        (setf (player-hand object) 
            (append (player-hand object) (list (get-last deck))))
        (setf deck (remove-last deck))))