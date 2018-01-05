#!/usr/bin/env/ roseus

(defclass handy-interface
  :super
  :slots
  )
(defmethod handy-interface
  (:init
   ()
   )
  (:angle-vector
   (arg-vec)
   )
  (:go-pos
   (x y theta)
   )
  (:go-velocity
   (x theta &optional time)
   )
  )

(defun handy-init ()
  (ros::roseus "handy-controller")
  (setq *handy* (instance handy-model :init))
  (objests (list *handy*))
  (setq *ri* (instance handy-interface :init)))
