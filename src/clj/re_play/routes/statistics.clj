(ns re-play.routes.statistics
  (:require
   [re-play.layout :as layout]
   [re-play.db.core :as db]
   [clojure.java.io :as io]
   [re-play.middleware :as middleware]
   [ring.util.response]
   [ring.util.http-response :as response]))

(defn statistics-page [request]
  (layout/render request "statistics.html"))

(defn statistics-routes []
  [""
   {:middleware [middleware/wrap-csrf
                 middleware/wrap-formats]}
   ["/statistics" {:get statistics-page}]])
