(ns re-play.env
  (:require [clojure.tools.logging :as log]))

(def defaults
  {:init
   (fn []
     (log/info "\n-=[re-play started successfully]=-"))
   :stop
   (fn []
     (log/info "\n-=[re-play has shut down successfully]=-"))
   :middleware identity})
