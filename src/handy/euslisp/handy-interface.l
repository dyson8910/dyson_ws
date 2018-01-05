#!/usr/bin/env/ roseus

(defclass handy-interface
  :super
  :slots
  )
(defmethod handy-interface
  (:init
   ()
   (ros::roseus "handy-controller")
   (ros::advertise "/angle-shoulder" )
   (ros::advertise "/angle-elbow" )
   (ros::advertise "/angle-wrist" )
   (ros::advertise "/angle-finger" )
   )
  (:angle-vector
   (arg-vec)
   (let* ((s-ang (elt ang-vec 0))
	  (e-ang (elt ang-vec 1))
	  (w-ang (elt ang-vec 2)))
     (ros::publish "/angle-shoulder" s-ang)
     (ros::publish "/angle-elbow" e-ang)
     (ros::publish "/angle-wrist" w-ang)
     )
   )
  (:go-pos
   (x y theta)
   )
  (:go-velocity
   (x theta &optional time)
   )
  (:start-grasp
   ()
   )
  (:stop-grasp
   ()
   )
  )

(defun handy-init ()
  (setq *handy* (instance handy-model :init))
  (objests (list *handy*))
  (setq *ri* (instance handy-interface :init)))
