(defmethod isflush (sorted-full-hand)
    (loop for i from 0 to 2 by 1 do
        (when (all-in-suit (sublist sorted-full-hand i 5))
            (return-from isflush t)))
    (return-from isflush nil))

(defmethod is-royal-flush (sorted-full-hand)
    (when (not (isflush sorted-full-hand)) (return-from isflush nil))
    (let ((last-list (sublist sorted-full-hand 2 nil)))
        (when (and (is-in-order last-list) (eql 14 (card-value (get-last last-list))))
            (return-from is-royal-flush t)))
    (return-from is-royal-flush nil))