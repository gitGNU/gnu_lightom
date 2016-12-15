;;; This file is part of Lightom.
;;;
;;; Lightom is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; Lightom is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with Lightom. If not, see <http://www.gnu.org/licenses/>.
;;;
;;; Author: Daniel Pimentel <d4n1@d4n1.org>

(define led (output 13))

(define (loop)
	(toggle led)
	(pause 1000))

(forever loop)
