;;; -*- lexical-binding: t -*-

(require 'p-evil)

(p-require-package 'gptel)

(with-eval-after-load 'gptel



  (setq
   o3-mini-model '(o3-mini-2025-01-14
                   :description "Reasoning model designed to solve hard problems across domains"
                   :context-window 128
                   :input-cost 15
                   :output-cost 60
                   :cutoff-date "2023-10"
                   :capabilities (nosystem)
                   :request-params (:stream :json-false))

   p-gptel-o3-backend (gptel-make-openai "O3"
                        :stream t
                        :models (list o3-mini-model)
                        :key p-openai-yc-key)
   p-gptel-claude-backend (gptel-make-anthropic "Claude"
                            :stream t
                            :key p-anthropic-yc-key)
   gptel-model 'claude-3-5-sonnet-20241022
   ;; gptel-model 'o3-mini-2025-01-14
   gptel-backend p-gptel-claude-backend
   gptel-default-mode 'org-mode))

(p-set-leader-key
  "C" 'gptel)

(provide 'p-gptel)

;;; p-gptel.el ends here
