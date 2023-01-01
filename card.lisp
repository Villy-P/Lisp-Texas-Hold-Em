; CARD CLASS
(defclass card ()
    ((rank :accessor card-rank)
     (suit :accessor card-suit)))