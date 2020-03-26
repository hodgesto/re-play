(ns re-play.env
  (:require
    [selmer.parser :as parser]
    [clojure.tools.logging :as log]
    [re-play.dev-middleware :refer [wrap-dev]]))

(def defaults
  {:init
   (fn []
     (parser/cache-off!)
     (log/info "\n-=[re-play started successfully using the development profile]=-"))
   :stop
   (fn []
     (log/info "\n-=[re-play has shut down successfully]=-"))
   :middleware wrap-dev})
