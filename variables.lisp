(declaim (sb-ext:muffle-conditions sb-ext:compiler-note))

(defvar *main-player* nil)

(defvar *computer-num* 0)
(defvar *computers* (list))

(defvar *dealer-button-index* nil)
(defvar *current-player* nil)
(defvar *current-player-index* nil)
(defvar *greatest-better* nil)

(defvar *current-bet* 10)
(defvar *pot-amount* 15)