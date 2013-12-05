;;
;; This file is a generated file. Don't edit this file.
;;
;; For more details please visit the project home page
;;   https://github.com/icy/myquartz-scim2uim
;;   https://github.com/TheSLinux-forks/myquartz-scim2uim
;;
;; This work is distributed under the license GPL (v2).
;; You must read and accept the license if you want to
;; use, distribute, modify this work, and/or to create
;; any derivative work. The license can be found at
;;   http://www.gnu.org/licenses/gpl-2.0.html
;;
(require "generic.scm")
(define xvni-ipa-rule
  '(
((("A" ))("A"))
  ))
(define xvni-ipa-init-handler
  (lambda (id im arg)
    (generic-context-new id im xvni-ipa-rule #f)))

(generic-register-im
  'xvni-ipa
  "vi"
  "UTF-8"
  (N_ "XVNI-IPA")
  (N_ "Big table of predefined words for Vietnamese VNI-IPA users")
  xvni-ipa-init-handler)
