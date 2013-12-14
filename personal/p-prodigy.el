(p-require-package 'prodigy 'melpa)

(require 'prodigy)

(prodigy-define-service
  :name "redis"
  :command "redis-server"
  :cwd "~/src/coupa/coupa_development"
  :args '("config/redis.conf.sample"))

(provide 'p-prodigy)

;;; p-prodigy.el ends here
