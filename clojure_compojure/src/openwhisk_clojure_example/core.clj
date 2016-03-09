(ns openwhisk-clojure-example.core
  (:require [compojure.core          :refer [defroutes POST]]
            [clojure.data.json       :as    json]
            [ring.adapter.jetty      :refer [run-jetty]]
            [ring.middleware.params  :refer [wrap-params]]
            [ring.middleware.json    :refer [wrap-json-params]]))

(defn hello [params]
  (let [name (get params "name" "world")]
    {:status 200
     :headers {"Content-Type" "application/json"}
     :body (json/write-str{"result" {"msg" (str "Hello, " name)}})}))

(defroutes routes
  (POST "/init" [] "")
  (POST "/run" [value] (hello value)))

(def app
  (-> routes
    (wrap-params)
    (wrap-json-params)))

(defn -main []
  (run-jetty app {:port 8080}))
