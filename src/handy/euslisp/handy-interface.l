#!/usr/bin/env/ roseus

(load "handy.l")

(defclass handy-interface
  :super propertied-object
  )
(defmethod handy-interface
  (:init
   ()
   (ros::roseus "handy-controller")
   (ros::advertise "/angle_shoulder" std_msgs::float64 1)
   (ros::advertise "/angle_elbow" std_msgs::float64 1)
   (ros::advertise "/angle_wrist" std_msgs::float64 1)
   (ros::advertise "/angle_finger" std_msgs::float64 1)
   (ros::advertise "/left_wheel" std_msgs::int32 1)
   (ros::advertise "/right_wheel" std_msgs::int32 1)
   )
  (:angle-vector
   (ang-vec)
   (let* ((s-ang (instance std_msgs::float64 :init
			   :data (elt ang-vec 0)))
	  (e-ang (instance std_msgs::float64 :init
			   :data (elt ang-vec 1)))
	  (w-ang (instance std_msgs::float64 :init
			   :data (elt ang-vec 2))))
     (ros::publish "/angle_shoulder" s-ang)
     (ros::publish "/angle_elbow" e-ang)
     (ros::publish "/angle_wrist" w-ang)
     )
   )
  (:go-pos;;TODO 時間を決定する
   (x)
   (if (> x 0)
       (progn
	 (ros::publish "/left_wheel" (instance std_msgs::int32 :init :data 1))
	 (ros::publish "/right_wheel" (instance std_msgs::int32 :init :data 1))
	 (unix::usleep (/ x 3.5))
	 (ros::publish "/left_wheel" (instance std_msgs::int32 :init :data 0))
	 (ros::publish "/right_wheel" (instance std_msgs::int32 :init :data 0))
	 )
     (progn
       (ros::publish "/left_wheel" (instance std_msgs::int32 :init :data -1))
       (ros::publish "/right_wheel" (instance std_msgs::int32 :init :data -1))
       (sleep (- 0 (/ (* x 28571400) 100)))
       (ros::publish "/left_wheel" (instance std_msgs::int32 :init :data 0))
       (ros::publish "/right_wheel" (instance std_msgs::int32 :init :data 0))
       ))
   )
  (:rotate-here
   (theta)
   (if (> theta 0)
       (progn
	 (ros::publish "/left_wheel" (instance std_msgs::int32 :init :data -1))
	 (ros::publish "/right_wheel" (instance std_msgs::int32 :init :data 1))
	 (unix::usleep (/ (* theta 9200000) 180.0))
	 (ros::publish "/left_wheel" (instance std_msgs::int32 :init :data 0))
	 (ros::publish "/right_wheel" (instance std_msgs::int32 :init :data 0))
	 )
     (progn
       (ros::publish "/left_wheel" (instance std_msgs::int32 :init :data 1))
       (ros::publish "/right_wheel" (instance std_msgs::int32 :init :data -1))
       (unix::usleep (- 0 (/ (* theta 9200000) 180)))
       (ros::publish "/left_wheel" (instance std_msgs::int32 :init :data 0))
       (ros::publish "/right_wheel" (instance std_msgs::int32 :init :data 0))
       ))
   )
  (:start-grasp
   ()
   (ros::publish "/angle_finger" (instance std_msgs::float64 :init
					   :data 40))
   )
  (:stop-grasp
   ()
   (ros::publish "/angle_finger" (instance std_msgs::float64 :init
					   :data -10))
   )
  )

(defun handy-init ()
  (setq *handy* (instance handy-model :init))
  (objects (list *handy*))
  (setq *ri* (instance handy-interface :init)))
