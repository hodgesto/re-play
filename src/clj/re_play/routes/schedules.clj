(ns re-play.routes.schedules
  (:require
   [re-play.layout :as layout]
   [re-play.db.core :as db]
   [clojure.java.io :as io]
   [re-play.middleware :as middleware]
   [ring.util.response]
   [ring.util.http-response :as response]))

(defn schedules-page [request]
  (layout/render request "schedules.html"))

(defn schedules-routes []
  [""
   {:middleware [middleware/wrap-csrf
                 middleware/wrap-formats]}
   ["/schedules" {:get schedules-page}]])
