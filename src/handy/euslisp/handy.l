(defun make-hand nil
  (let (b)
    (setq b (make-cube 50 75 110))
    (send b :locate #f(-5 1.5 35))
    (send b :set-color :gray20)
    b))

(defun make-arm1 nil
  (let (b)
    (setq b (make-cube 40 40 247))
    (send b :locate #f(0 0 98.5))
    b))

(defun make-arm2 nil
  (let (b)
    (setq b (make-cube 60 50 275))
    (send b :locate #f(0 9 107.5))
    b))

(defun make-body nil
  (let (a b)
    (setq a (make-cube 30 70 80))
    (send a :locate #f(0 35 -15))
    (setq b (make-cube 210 160 130))
    (send b :locate #f(-5 35 -110))
    (setq a (body+ a b))
    a))

(defclass handy-model
  :super cascaded-link
  :slots (end-coords l1 l2 l3 l4 j1 j2 j3)
  )
(defmethod handy-model
  (:init
   ()
   (let (h a1 a2 b)
     (send-super :init)
     (setq h (make-cube 10 10 10))
     (setq h (make-hand))
     (setq a1 (make-arm1))
     (setq a2 (make-arm2))
     (setq b (make-body))
     (setq l1 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
     (setq l2 (instance bodyset-link :init (make-cascoords) :bodies (list a2)))
     (setq l3 (instance bodyset-link :init (make-cascoords) :bodies (list a1)))
     (setq l4 (instance bodyset-link :init (make-cascoords) :bodies (list h)))

     (setq end-coords (make-cascoords :pos #f(50 0 60)))
     (send l4 :assoc end-coords)
     
     (send l4 :locate #f(0 10 210))
     (send l3 :assoc l4)

     (send l3 :locate #f(0 31 225))
     (send l2 :assoc l3)

     (send l2 :locate #f(0 0 0))
     (send l1 :assoc l2)

     (send l1 :locate #f(83 -35 175))
     (send self :assoc l1)
     (setq j1 (instance rotational-joint
			:init :name 'j1
			:parent-link l1 :child-link l2
			:axis :y)
	   j2 (instance rotational-joint
			:init :name 'j2
			:parent-link l2 :child-link l3
			:axis :y)
	   j3 (instance rotational-joint
			:init :name 'j3
			:parent-link l3 :child-link l4
			:axis :y))
     (setq links (list l1 l2 l3 l4))
     (setq joint-list (list j1 j2 j3))
     (send self :init-ending)
     )
   )
  (:end-coords (&rest args) (forward-message-to end-coords args))
  (:reset-pose
   ()
   (send self :angle-vector
	 (float-vector 0 0 0)
	 )
   )
  )
