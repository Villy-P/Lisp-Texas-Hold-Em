(defun remove-last (sequence)
    (reverse (cdr (reverse sequence))))

(defun get-last (sequence)
    (car (last sequence)))

(defun get-second-last (sequence)
    (nth (- (length sequence) 2) sequence))

(defun concat-lists (seq1 seq2)
    (if (null seq1)
        seq2
        (cons (car seq1) (concat-lists (cdr seq1) seq2))))

(defun selection-sort (full-hand)
    (let ((new-list (copy-list full-hand)))
        (dotimes (i (- (length full-hand) 1))
            (let ((min-index i))
                (loop for j from (+ i 1) to (length full-hand) by 1 do
                    (when (< (card-value (nth j new-list)) (card-value (nth min-index new-list)))
                        (setf min-index j)))
        (let ((temp (nth min-index new-list)))
            (setf (nth min-index new-list) (nth i new-list))
            (setf (nth i new-list) temp))))
    (return-from selection-sort new-list)))

(defun is-in-order (hand)
    (loop for i from 1 to (length hand) by 1 do
        (when (not (eql (card-value (nth i hand)) (+ (card-value (nth (- i 1) hand)) 1)))
            (return-from is-in-order nil)))
    (return-from is-in-order t))