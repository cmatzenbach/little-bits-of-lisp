(ql:quickload :draw-cons-tree)
(make-package :list-trees
              (:use :cl)
							(:use :draw-cons-tree))
(draw-cons-tree:draw-tree '(1 2 3 4 5))
