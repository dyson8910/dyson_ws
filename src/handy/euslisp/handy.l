#!/usr/bin/env roseus

(defclass handy-model
  :super cascaded-link)

(defmethod handy-model
  (:init
   ()
   (let (hand arm1 arm2 body l1 l2 l3 l4)
     (send-super :init)
     (setq hand (make-cube))
     (setq arm1 (make-cube))
     (setq arm2 (make-cube))
     (setq body ())
     (setq l1 (instance bodyset-link :init (make-cascoords) :bodies (list body)))
     (setq l2 (instance bodyset-link :init (make-casccords) :bodies (list arm2)))
     (setq l3 (instance bodyset-link :init (make-cascoords) :bodies (list arm1)))
     (setq l4 (instance bodyset-link :init (make-cascoords) :bodies (list hand)))

     (setq joint-list
	   (list (instance rotational-joint
			   :init :parent-link l1 :child-link l2
			   :axis :)
		 (instance rotational-joint
			   :init :parent-link l2 :child-link l3
			   :axis :)
		 (instance rotational-joint
			   :init :parent-link l3 :child-link l4
			   :axis :)))
     (setq links (list l1 l2 l3 l4))
     (send self :init-ending)
     )
   )
  (:reset-pose (arg)
	       )
  
  )
