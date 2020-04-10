(ns re-play.routes.home
  (:require
   [re-play.layout :as layout]
   [re-play.db.core :as db]
   [clojure.java.io :as io]
   [re-play.middleware :as middleware]
   [ring.util.response]
   [ring.util.http-response :as response]))

(defn home-page [request]
  (layout/render request "home.html"))

(defn home-routes []
  [""
   {:middleware [middleware/wrap-csrf
                 middleware/wrap-formats]}
   ["/" {:get home-page}]])
