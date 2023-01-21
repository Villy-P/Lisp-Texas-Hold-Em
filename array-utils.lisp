(defun remove-last (sequence)
    (reverse (cdr (reverse sequence))))

(defun get-last (sequence)
    (car (last sequence)))

(defun get-second-last (sequence)
    (nth (- (length sequence) 2) sequence))