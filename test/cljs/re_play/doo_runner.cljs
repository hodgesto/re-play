(ns re-play.doo-runner
  (:require [doo.runner :refer-macros [doo-tests]]
            [re-play.core-test]))

(doo-tests 're-play.core-test)

