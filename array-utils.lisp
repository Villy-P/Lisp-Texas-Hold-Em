; ARRAY UTILITIES
(defun remove-last (sequence)
    (reverse (cdr (reverse sequence))))

(defun get-last (sequence)
    (first (last sequence)))