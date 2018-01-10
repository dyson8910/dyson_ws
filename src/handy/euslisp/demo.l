#!/usr/bin/env roseus

(load "handy-interface.l")
(handy-init)

(send *ri* :rotate-here 60)
(unix::sleep 1)
(send *ri* :rotate-here -60)
(unix::sleep 1)

(send *ri* :go-x -30)
(unix::sleep 1)
(send *ri* :go-x 80)
(unix::sleep 1)

;;TODO反復でゆっくり動かしていく



(send *ri* :start-grasp)

;;TODO反復


(send *ri* :stop-grasp)
