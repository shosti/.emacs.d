;;; -*- lexical-binding: t -*-

(p-require-package 'sql-indent)

(require 'sql-indent)

(add-to-list 'sql-mysql-options "-A")
(add-to-list 'sql-mysql-login-params 'port t)

(provide 'p-sql)

;;; p-sql.el ends here
