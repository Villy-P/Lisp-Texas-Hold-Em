(defmethod end-game ())

(defmethod all-folded ()
    (let ((total 0))
    (when (player-has-folded *main-player*) (setf total (+ total 1)))
    (dotimes (i (length *computers*))
        (when (player-has-folded (nth i *computers*)) (setf total (+ total 1))))
    (when (eql total (length *computers*)) (end-game))))

(defclass player ()
    ((name :accessor player-name)
     (hand :accessor player-hand)
     (chips :accessor player-chips)
     (is-comp :accessor player-is-comp)
     (has-button :accessor player-has-button)
     (has-folded :accessor player-has-folded)))

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

(defmethod fold ((object player))
    (princ (format nil "~s folded." (player-name object)))
    (setf (player-has-folded object) t)
    (all-folded))

(defmethod call ((object player))
    (princ (format nil "~s called." (player-name object)))
    (setf *pot-amount* (+ *pot-amount* *current-bet*))
    (setf (player-chips object) (- (player-chips object) *current-bet*))
    (all-folded))

(defmethod pre-game-computer ((object player))
    (if (< (player-chips object) *current-bet*) 
        (fold object)
        (call object)))

(defmethod computer-play ((object player) turn)
    (when (eql turn 0) (pre-game-computer object)))