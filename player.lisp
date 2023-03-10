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
     (has-folded :accessor player-has-folded)
     (has-checked :accessor player-has-checked)))

(defmethod end-game-text ((object player))
    (return-from end-game-text (format nil "~s has won!" (player-name object))))

(defmethod has-royal-flush ((object player))
    (let ((full-cards (return-full-cards object)))
        (when 
            (and (eql (nth 6 full-cards) 14)) 
            (and (eql (nth 5 full-cards) 13)) 
            (and (eql (nth 4 full-cards) 12)) 
            (and (eql (nth 3 full-cards) 11)) 
            (and (eql (nth 2 full-cards) 10))
            (return-from has-royal-flush t)))
    (return-from has-royal-flush nil))

(defmethod return-full-cards ((object player))
    (let ((full-cards `()))
        (dotimes (i 5)
            (setq full-cards (append full-cards (list (card-value (nth i *middle-cards*))))))
        (setq full-cards (append full-cards (list (card-value (nth 0 (player-hand object))))))
        (setq full-cards (append full-cards (list (card-value (nth 1 (player-hand object))))))
        (return-from return-full-cards (sort full-cards #'<))))

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

(defmethod check ((object player))
    (when *last-player-called*
        (princ (format nil "~s checked." (player-name object)))
        (setf (player-has-checked object) t)
        (setf *last-player-called* t))
    (when (not *last-player-called*)
        (princ "You cannot check.")))

(defmethod pre-game-computer ((object player))
    (if (< (player-chips object) *current-bet*) 
        (fold object)
        (call object)))

(defmethod post-flop-computer ((object player))
    (if (and (< (player-chips object) *current-bet*) *last-player-called*) (check object))
    (if (and (< (player-chips object) *current-bet*) (not *last-player-called*)) (fold object))
    (if (not (< (player-chips object) *current-bet*)) (call object)))

(defmethod raise-player ((object player))
    (let ((choice 0))
    (loop
        (princ "How much more do you want to raise? >>> ")
        (finish-output)(setf choice (read))
        (when (and (> choice 0) (< choice (player-chips object))) (return choice)))
    (setf *greatest-better* object)
    (setf *current-bet* (+ *current-bet* choice))
    (setf *pot-amount* (+ *pot-amount* *current-bet*))
    (setf (player-chips object) (- (player-chips object) *current-bet*))))

(defmethod computer-play ((object player) turn)
    (when (eql turn 0) (pre-game-computer object))
    (when (eql turn 1) (post-flop-computer object))
    (terpri)
    (princ (format nil "~s is left with ~s chips." (player-name object) (player-chips object))))

(defmethod pre-game-player ((object player))
    (let ((choice 0))
    (princ (format nil "You have ~s chips." (player-chips object)))(terpri)
    (terpri)(princ (format nil "The current bet is ~s chips." *current-bet*))
    (terpri)(princ "You have these cards:")(terpri)
    (print-player-cards *main-player*)
    (princ "1: CALL")(terpri)
    (princ "2: FOLD")(terpri)
    (princ "3: RAISE")(terpri)
    (loop
        (princ ">>> ")
        (finish-output)(setf choice (read))
        (when (and (> choice 0) (< choice 4)) (return choice)))
    (when (eql choice 1) (call object))
    (when (eql choice 2) (fold object))
    (when (and (eql choice 3)) (raise-player object))))

(defmethod post-flop-player ((object player))
    (let ((choice 0))
    (princ (format nil "You have ~s chips." (player-chips object)))(terpri)
    (terpri)(princ (format nil "The current bet is ~s chips." *current-bet*))
    (terpri)(princ "You have these cards:")(terpri)
    (print-player-cards *main-player*)
    (princ "1: CALL")(terpri)
    (princ "2: FOLD")(terpri)
    (princ "3: RAISE")(terpri)
    (princ "4: CHECK")(terpri)
    (loop
        (princ ">>> ")
        (finish-output)(setf choice (read))
        (when (and (> choice 0) (< choice 5)) (return choice)))
    (when (eql choice 1) (call object))
    (when (eql choice 2) (fold object))
    (when (eql choice 3) (raise-player object))))

(defmethod player-play ((object player) turn)
    (when (eql turn 0) (pre-game-player object))
    (when (eql turn 1) (post-flop-player object)))