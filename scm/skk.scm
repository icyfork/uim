;;;
;;; Copyright (c) 2003-2005 uim Project http://uim.freedesktop.org/
;;;
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;; 1. Redistributions of source code must retain the above copyright
;;;    notice, this list of conditions and the following disclaimer.
;;; 2. Redistributions in binary form must reproduce the above copyright
;;;    notice, this list of conditions and the following disclaimer in the
;;;    documentation and/or other materials provided with the distribution.
;;; 3. Neither the name of authors nor the names of its contributors
;;;    may be used to endorse or promote products derived from this software
;;;    without specific prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
;;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
;;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;;; OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;;; LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;;; OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;;; SUCH DAMAGE.
;;;;

;; SKK is a Japanese input method
;;
;; EUC-JP
;;
;; SKKの入力は下記の状態で構成される
;; Following is list of SKK input state
;;  直接入力 direct
;;  漢字入力 kanji
;;  見出し語補完 completion
;;  変換中 converting
;;  送りがな okuri
;;  英数 latin
;;  全角英数 wide-latin
;;
;;
(require "japanese.scm")
(require-custom "generic-key-custom.scm")
(require-custom "skk-custom.scm")
;;(require-custom "skk-key-custom.scm")


;; key defs
(define-key skk-latin-key? '("l" generic-off-key?))
(define-key skk-wide-latin-key? "L")
(define-key skk-begin-conv-key? 'generic-begin-conv-key?)
(define-key skk-begin-completion-key? '("tab" "<Control>i" "<Control>I"))
(define-key skk-next-completion-key? '("." skk-begin-completion-key?))
(define-key skk-prev-completion-key? ",")
(define-key skk-on-key? '("<Control>j" "<Control>J" generic-on-key?))
(define-key skk-hankaku-kana-key? '("<Control>q" "<Control>Q"))
(define-key skk-return-key? 'generic-return-key?)
(define-key skk-commit-key? '("<Control>j" "<Control>J"))
(define-key skk-next-candidate-key? 'generic-next-candidate-key?)
(define-key skk-prev-candidate-key? '("x" generic-prev-candidate-key?))
(define-key skk-next-page-key? 'generic-next-page-key?)
(define-key skk-prev-page-key? 'generic-prev-page-key?)
(define-key skk-kana-toggle-key? "q")
(define-key skk-cancel-key? 'generic-cancel-key?)
(define-key skk-backspace-key? 'generic-backspace-key?)
(define-key skk-go-left-key? 'generic-go-left-key?)
(define-key skk-go-right-key? 'generic-go-right-key?)
(define-key skk-latin-conv-key? "/")
(define-key skk-kanji-mode-key? "Q")
(define-key skk-special-midashi-key? '(">" "<" "?"))
(define-key skk-conv-wide-latin-key? '("<Control>q" "<Control>Q"))
(define-key skk-plain-space-key? " ")  ;; should not be changed
(define-key skk-vi-escape-key? '("escape" "<Control>["))
(define-key skk-state-direct-no-preedit-nop-key? '("<Control>j" "<Control>J"))

(define skk-auto-start-henkan-keyword-list '("を" "、" "。" "．" "，" "？" "」" "！" "；" "：" ")" ";" ":" "）" "”" "】" "』" "》" "〉" "｝" "］" "〕" "}" "]" "?" "." "," "!"))

;; style specification
(define skk-style-spec
  '(;; (style-element-name . validator)
    (skk-preedit-attr-mode-mark		   . preedit-attr?)
    (skk-preedit-attr-head		   . preedit-attr?)
    (skk-preedit-attr-okuri		   . preedit-attr?)
    (skk-preedit-attr-pending-rk	   . preedit-attr?)
    (skk-preedit-attr-conv-body		   . preedit-attr?)
    (skk-preedit-attr-conv-okuri	   . preedit-attr?)
    (skk-preedit-attr-direct-pending-rk    . preedit-attr?)
    (skk-preedit-attr-child-beginning-mark . preedit-attr?)
    (skk-preedit-attr-child-end-mark       . preedit-attr?)
    (skk-preedit-attr-child-committed      . preedit-attr?)
    (skk-child-context-beginning-mark      . string?)
    (skk-child-context-end-mark		   . string?)
    (skk-show-cursor-on-preedit?	   . boolean?)
    (skk-show-candidates-with-okuri?       . boolean?)))
;; predefined styles
(define skk-style-uim
  '((skk-preedit-attr-mode-mark		   . preedit-reverse)
    (skk-preedit-attr-head		   . preedit-reverse)
    (skk-preedit-attr-okuri		   . preedit-reverse)
    (skk-preedit-attr-pending-rk	   . preedit-reverse)
    (skk-preedit-attr-conv-body		   . preedit-reverse)
    (skk-preedit-attr-conv-okuri	   . preedit-reverse)
    (skk-preedit-attr-direct-pending-rk    . preedit-underline)
    (skk-preedit-attr-child-beginning-mark . preedit-reverse)
    (skk-preedit-attr-child-end-mark       . preedit-reverse)
    (skk-preedit-attr-child-committed      . preedit-reverse)
    (skk-child-context-beginning-mark      . "[")
    (skk-child-context-end-mark		   . "]")
    (skk-show-cursor-on-preedit?	   . #f)
    (skk-show-candidates-with-okuri?       . #t)))
(define skk-style-ddskk-like
  '((skk-preedit-attr-mode-mark		   . preedit-underline)
    (skk-preedit-attr-head		   . preedit-underline)
    (skk-preedit-attr-okuri		   . preedit-underline)
    (skk-preedit-attr-pending-rk	   . preedit-underline)
    (skk-preedit-attr-conv-body		   . preedit-reverse)
    (skk-preedit-attr-conv-okuri	   . preedit-underline)
    (skk-preedit-attr-direct-pending-rk    . preedit-underline)
    (skk-preedit-attr-child-beginning-mark . preedit-underline)
    (skk-preedit-attr-child-end-mark       . preedit-underline)
    (skk-preedit-attr-child-committed      . preedit-underline)
    (skk-child-context-beginning-mark      . "【")
    (skk-child-context-end-mark		   . "】")
    (skk-show-cursor-on-preedit?	   . #t)
    (skk-show-candidates-with-okuri?       . #f)))

;; widgets and actions

;; skk-widgets which controls:
;; - what widgets will be shown for user
;; - shown in what order
(define skk-widgets '(widget_skk_input_mode))

;; default activity for each widgets
(define default-widget_skk_input_mode 'action_skk_latin)

;; actions of widget_skk_input_mode
(define skk-input-mode-actions
  '(action_skk_latin
    action_skk_hiragana
    action_skk_katakana
    action_skk_hankana
    action_skk_wide_latin))


;;; implementations

(define skk-type-hiragana 0)
(define skk-type-katakana 1)
(define skk-type-hankana 2)

;; style elements
(define skk-preedit-attr-mode-mark #f)
(define skk-preedit-attr-head #f)
(define skk-preedit-attr-okuri #f)
(define skk-preedit-attr-pending-rk #f)
(define skk-preedit-attr-conv-body #f)
(define skk-preedit-attr-conv-okuri #f)
(define skk-preedit-attr-direct-pending-rk #f)
(define skk-preedit-attr-child-beginning-mark #f)
(define skk-preedit-attr-child-end-mark #f)
(define skk-preedit-attr-child-committed #f)
(define skk-child-context-beginning-mark #f)
(define skk-child-context-end-mark #f)
(define skk-show-cursor-on-preedit? #f)
(define skk-show-candidates-with-okuri? #f)

(define skk-dic-init #f)

(define skk-prepare-activation
  (lambda (sc)
    (skk-flush sc)
    (skk-update-preedit sc)))

(register-action 'action_skk_hiragana
		 (lambda (sc)
		   '(figure_ja_hiragana
		     "え"
		     "ひらがな"
		     "ひらがな入力モード"))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (and (not (skk-latin-state? dsc))
			  (= (skk-context-kana-mode dsc)
			     skk-type-hiragana))))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (skk-prepare-activation dsc)
		     (skk-context-set-state! dsc 'skk-state-direct)
		     (skk-context-set-kana-mode! dsc skk-type-hiragana))))

(register-action 'action_skk_katakana
		 (lambda (sc)
		   '(figure_ja_katakana
		     "エ"
		     "カタカナ"
		     "カタカナ入力モード"))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (and (not (skk-latin-state? dsc))
			  (= (skk-context-kana-mode dsc)
			     skk-type-katakana))))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (skk-prepare-activation dsc)
		     (skk-context-set-state! dsc 'skk-state-direct)
		     (skk-context-set-kana-mode! dsc skk-type-katakana))))

(register-action 'action_skk_hankana
		 (lambda (sc)
		   '(figure_ja_hankana
		     "ｴ"
		     "半角カタカナ"
		     "半角カタカナ入力モード"))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (and (not (skk-latin-state? dsc))
			  (= (skk-context-kana-mode dsc)
			     skk-type-hankana))))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (skk-prepare-activation dsc)
		     (skk-context-set-state! dsc 'skk-state-direct)
		     (skk-context-set-kana-mode! dsc skk-type-hankana))))

(register-action 'action_skk_latin
		 (lambda (sc)
		   '(figure_ja_latin
		     "s"
		     "直接入力"
		     "直接(無変換)入力モード"))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (= (skk-context-state dsc)
			'skk-state-latin)))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (skk-prepare-activation dsc)
		     (skk-context-set-state! dsc 'skk-state-latin))))

(register-action 'action_skk_wide_latin
		 (lambda (sc)
		   '(figure_ja_wide_latin
		     "Ｓ"
		     "全角英数"
		     "全角英数入力モード"))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (= (skk-context-state dsc)
			'skk-state-wide-latin)))
		 (lambda (sc)
		   (let ((dsc (skk-find-descendant-context sc)))
		     (skk-prepare-activation dsc)
		     (skk-context-set-state! dsc 'skk-state-wide-latin))))

;; Update widget definitions based on action configurations. The
;; procedure is needed for on-the-fly reconfiguration involving the
;; custom API
(define skk-configure-widgets
  (lambda ()
    (register-widget 'widget_skk_input_mode
		     (activity-indicator-new skk-input-mode-actions)
		     (actions-new skk-input-mode-actions))))

(define skk-context-rec-spec
  (append
   context-rec-spec
   (list
    (list 'state	      'skk-state-latin)
    (list 'kana-mode	      skk-type-hiragana)
    (list 'head		      '())
    (list 'okuri-head	      "")
    (list 'okuri	      '())
    ;(list 'candidates	      '())
    (list 'nth		      0)
    (list 'nr-candidates      0)
    (list 'rk-context	      '())
    (list 'candidate-op-count 0)
    (list 'candidate-window   #f)
    (list 'child-context      '())
    (list 'parent-context     '())
    (list 'editor	      '())
    (list 'latin-conv	      #f)
    (list 'commit-raw	      #f)
    (list 'completion-nth     0))))
(define-record 'skk-context skk-context-rec-spec)
(define skk-context-new-internal skk-context-new)

(define skk-find-root-context
  (lambda (sc)
    (let ((pc (skk-context-parent-context sc)))
      (if (not (null? pc))
	  (skk-find-root-context pc)
	  sc))))

(define skk-find-descendant-context
  (lambda (sc)
    (let ((csc (skk-context-child-context sc)))
      (if (not (null? csc))
	  (skk-find-descendant-context csc)
	  sc))))

(define skk-read-personal-dictionary
  (lambda ()
    (or (skk-lib-read-personal-dictionary skk-uim-personal-dic-filename)
	(skk-lib-read-personal-dictionary skk-personal-dic-filename))))

(define skk-save-personal-dictionary
  (lambda ()
    (skk-lib-save-personal-dictionary skk-uim-personal-dic-filename)))

(define skk-flush
  (lambda (sc)
    (rk-flush (skk-context-rk-context sc))
    (if skk-use-recursive-learning?
	(skk-editor-flush (skk-context-editor sc)))
    (skk-context-set-state! sc 'skk-state-direct)
    (skk-context-set-head! sc '())
    (skk-context-set-okuri-head! sc "")
    (skk-context-set-okuri! sc '())
    (skk-reset-candidate-window sc)
    (skk-context-set-latin-conv! sc #f)))

(define skk-context-new
  (lambda (id im)
    (if (not skk-dic-init)
	(begin
	  (set! skk-dic-init #t)
	  (if skk-use-recursive-learning?
	   (require "skk-editor.scm"))
	  (skk-lib-dic-open skk-dic-file-name)
	  (skk-read-personal-dictionary)))
    (let ((sc (skk-context-new-internal id im))
	  (rkc (rk-context-new ja-rk-rule #t #f)))
      (skk-context-set-widgets! sc skk-widgets)
      (skk-context-set-head! sc '())
      (skk-context-set-rk-context! sc rkc)
      (skk-context-set-child-context! sc '())
      (skk-context-set-parent-context! sc '())
      (if skk-use-recursive-learning?
	  (skk-context-set-editor! sc (skk-editor-new sc)))
      (skk-flush sc)
      (skk-context-set-state! sc 'skk-state-latin)
      sc)))

(define skk-latin-state?
  (lambda (sc)
    (case (skk-context-state sc)
      ((skk-state-latin skk-state-wide-latin) #t)
      (else #f))))

(define skk-make-string
  (lambda (sl kana)
    (let ((get-str-by-type 
	   (lambda (l)
	     (cond
	      ((= kana skk-type-hiragana)
	       (caar l))
	      ((= kana skk-type-katakana)
	       (car (cdar l)))
	      ((= kana skk-type-hankana)
	       (cadr (cdar l)))))))
    (if (not (null? sl))
	(string-append (skk-make-string (cdr sl) kana)
		       (get-str-by-type sl))
	""))))

(define skk-conv-wide-latin
  (lambda (sl)
    (let ((get-wide-latin-str
	   (lambda (l)
	     (ja-wide (caar l)))))
    (if (not (null? sl))
	(string-append (skk-conv-wide-latin (cdr sl))
		       (get-wide-latin-str sl))
	""))))

(define skk-opposite-kana
  (lambda (kana)
    (cond
     ((= kana skk-type-hiragana)
      skk-type-katakana)
     ((= kana skk-type-katakana)
      skk-type-hiragana)
     ((= kana skk-type-hankana)
      skk-type-hiragana))))  ; different to ddskk's behavior

(define skk-context-kana-toggle
  (lambda (sc)
    (let* ((kana (skk-context-kana-mode sc))
	   (opposite-kana (skk-opposite-kana kana)))
      (skk-context-set-kana-mode! sc opposite-kana))))

(define skk-get-string-mode-part
  (lambda (sc res type)
    (let ((get-str-by-type 
	   (lambda (l)
	     (cond
	      ((= type skk-type-hiragana)
	       (car l))
	      ((= type skk-type-katakana)
	       (car (cdr l)))
	      ((= type skk-type-hankana)
	       (cadr (cdr l)))))))
      (get-str-by-type res))))

(define skk-do-get-string
  (lambda (sc str kana)
    (if str
	(if (string? (car str))
	    (skk-get-string-mode-part sc str kana)
	    (string-append
	     (skk-do-get-string sc (car str) kana)
	     (skk-do-get-string sc (cdr str) kana)))
	"")))

(define skk-get-string
  (lambda (sc str kana)
    (let ((res (skk-do-get-string sc str kana)))
      (if (and res (> (length res) 0))
	  res
	  #f))))

(define skk-get-string-by-mode
  (lambda (sc str)
    (let ((kana (skk-context-kana-mode sc)))
      (skk-get-string sc str kana))))

(define skk-get-nth-candidate
  (lambda (sc n)
    (let ((head (skk-context-head sc)))
      (if skk-use-numeric-conversion?
	  ;; store and restore numeric strings
	  (let ((numlst (skk-lib-store-replaced-numstr
			 (skk-make-string head skk-type-hiragana))))
	    (skk-lib-merge-replaced-numstr
	     (skk-lib-get-nth-candidate
	      n
	      (skk-lib-replace-numeric (skk-make-string head skk-type-hiragana))
	      (skk-context-okuri-head sc)
	      (skk-make-string (skk-context-okuri sc) skk-type-hiragana)
	      numlst)
	     numlst))
	  (skk-lib-get-nth-candidate
	   n
	   (skk-make-string head skk-type-hiragana)
	   (skk-context-okuri-head sc)
	   (skk-make-string (skk-context-okuri sc) skk-type-hiragana)
	   '())))))

(define skk-get-current-candidate
  (lambda (sc)
    (skk-get-nth-candidate
     sc
     (skk-context-nth sc))))

(define skk-get-nth-completion
  (lambda (sc n)
    (skk-lib-get-nth-completion
     n
     (skk-make-string (skk-context-head sc) skk-type-hiragana))))

(define skk-get-current-completion
  (lambda (sc)
    (skk-get-nth-completion
     sc
     (skk-context-completion-nth sc))))

(define skk-commit-raw
  (lambda (sc key key-state)
    (let ((psc (skk-context-parent-context sc)))
      (if (not (null? psc))
	  (skk-editor-commit-raw
	   (skk-context-editor psc)
	   key key-state)
	  (begin
	    (skk-context-set-commit-raw! sc #t)
	    (im-commit-raw sc))))))

(define skk-commit-raw-with-preedit-update
  (lambda (sc key key-state)
    (let ((psc (skk-context-parent-context sc)))
      (if (not (null? psc))
	  (skk-editor-commit-raw
	   (skk-context-editor psc)
	   key key-state)
	  (begin
	    (skk-context-set-commit-raw! sc #f)
	    (im-commit-raw sc))))))

;; commit string
(define skk-commit
  (lambda (sc str)
    (let ((psc (skk-context-parent-context sc)))
      (if (not (null? psc))
	  (skk-editor-commit (skk-context-editor psc) str)
	  (im-commit sc str)))))

(define skk-prepare-commit-string
  (lambda (sc)
    (let* ((cand (skk-lib-remove-annotation (skk-get-current-candidate sc)))
	   (okuri (skk-make-string (skk-context-okuri sc)
				   (skk-context-kana-mode sc)))
	   (res (string-append cand okuri))
	   (head (skk-context-head sc)))
      (if skk-use-numeric-conversion?
	  ;; store original number for numeric conversion #4
	  (let ((numlst (skk-lib-store-replaced-numstr
			 (skk-make-string head skk-type-hiragana))))
	    (skk-lib-commit-candidate
	     (skk-lib-replace-numeric (skk-make-string head skk-type-hiragana))
	     (skk-context-okuri-head sc)
	     (skk-make-string (skk-context-okuri sc) skk-type-hiragana)
	     (skk-context-nth sc)
	     numlst))
	  (begin
	    (skk-lib-commit-candidate
	     (skk-make-string head skk-type-hiragana)
	     (skk-context-okuri-head sc)
	     (skk-make-string (skk-context-okuri sc) skk-type-hiragana)
	     (skk-context-nth sc)
	     '())))
      (if (> (skk-context-nth sc) 0)
	  (skk-save-personal-dictionary))
      (skk-reset-candidate-window sc)
      (skk-flush sc)
      res)))


(define skk-append-string
  (lambda (sc str)
    (and
     str
     (if (not (string? (car str)))
	 (begin
	   (skk-append-string sc (car str))
	   (skk-append-string sc (cdr str))
	   )
	 #t)
     (skk-context-set-head!
      sc
      (cons str (skk-context-head sc))))))

(define skk-append-okuri-string
  (lambda (sc str)
    (and
     str
     (if (not (string? (car str)))
	 (begin
	   (skk-append-okuri-string sc (car str))
	   (skk-append-okuri-string sc (cdr str))
	   )
	 #t)
     (skk-context-set-okuri!
      sc
      (cons str (skk-context-okuri sc))))))

(define skk-append-residual-kana
  (lambda (sc)
    (let* ((rkc (skk-context-rk-context sc))
	   (residual-kana (rk-push-key-last! rkc)))
      (if residual-kana
	  (skk-append-string sc residual-kana)))))

(define skk-begin-conversion
  (lambda (sc)
    (let ((res #f)
	  (head (skk-context-head sc)))
      (if skk-use-numeric-conversion?
	  ;; no need to store original number for numeric conversion
	  (set! res (skk-lib-get-entry
	    	     (skk-lib-replace-numeric
		      (skk-make-string head skk-type-hiragana))
		     (skk-context-okuri-head sc)
		     (skk-make-string (skk-context-okuri sc)
				      skk-type-hiragana)))
	  (set! res (skk-lib-get-entry
		     (skk-make-string head skk-type-hiragana)
		     (skk-context-okuri-head sc)
		     (skk-make-string (skk-context-okuri sc)
				      skk-type-hiragana))))
      (if res
	  (begin
	    (skk-context-set-nth! sc 0)
	    (skk-context-set-nr-candidates! sc 0)
	    (skk-check-candidate-window-begin sc)
	    (if (skk-context-candidate-window sc)
		(im-select-candidate sc 0))
	    (skk-context-set-state!
	     sc 'skk-state-converting))
	  (if skk-use-recursive-learning?
	      (skk-setup-child-context sc)
	      (skk-flush sc))))))

(define skk-begin-completion
  (lambda (sc)
    (let ((res))
      ;; get residual 'n'
      (if (= (skk-context-state sc) 'skk-state-kanji)
	  (skk-append-residual-kana sc))
      ;;
      (set! res
	    (skk-lib-get-completion
	     (skk-make-string (skk-context-head sc) (skk-context-kana-mode sc))))
      (if res
	  (begin
	    (skk-context-set-completion-nth! sc 0)
	    (skk-context-set-state! sc 'skk-state-completion)))
      )))

(define skk-do-update-preedit
  (lambda (sc)
    (let ((rkc (skk-context-rk-context sc))
	  (stat (skk-context-state sc))
	  (csc (skk-context-child-context sc)))
      (if (and
	   (null? csc)
	   (or
	    (= stat 'skk-state-kanji)
	    (= stat 'skk-state-completion)
	    (= stat 'skk-state-okuri)))
	  (im-pushback-preedit sc skk-preedit-attr-mode-mark "▽"))
      (if (or
	   (not (null? csc))
	   (= stat 'skk-state-converting))
	  (im-pushback-preedit sc skk-preedit-attr-mode-mark "▼"))
      (if (and
	   (null? csc)
	   (or
	    (= stat 'skk-state-kanji)
	    (= stat 'skk-state-okuri)))
	  (let ((h (skk-make-string 
		    (skk-context-head sc)
		    (skk-context-kana-mode sc))))
	    (if (string? h)
		(im-pushback-preedit
		 sc skk-preedit-attr-head
		 h))))
      (if (and
	   (= stat 'skk-state-converting)
	   (null? csc))
	  (begin
	    (im-pushback-preedit
	     sc
	     (bit-or skk-preedit-attr-conv-body
		     preedit-cursor)
	     (skk-get-current-candidate sc))
	    (im-pushback-preedit
	     sc skk-preedit-attr-conv-okuri
	     (skk-make-string (skk-context-okuri sc)
			      (skk-context-kana-mode sc)))))
      (if (and
	   (not (null? csc))
	    (or
	     (= stat 'skk-state-kanji)
	     (= stat 'skk-state-okuri)
	     (= stat 'skk-state-converting)))
	  (let ((h '()))
	    (if skk-use-numeric-conversion?
	      ;; replace numeric string with #
	      (set! h (skk-lib-replace-numeric
			(skk-make-string 
			 (skk-context-head sc)
			 (skk-context-kana-mode sc))))
	      (set! h (skk-make-string 
			(skk-context-head sc)
			(skk-context-kana-mode sc))))
	    (if (string? h)
		(im-pushback-preedit
		 sc skk-preedit-attr-head
		 h))))
      (if (and
	   (= stat 'skk-state-completion)
	   (null? csc))
	  (begin
	    (im-pushback-preedit
	     sc skk-preedit-attr-head
	     (skk-get-current-completion sc))))

      (if (or
	   (= stat 'skk-state-okuri)
	   (and
	    (not (null? csc))
	    (= stat 'skk-state-converting)
	    (skk-context-okuri sc)))
	  (begin
	    (im-pushback-preedit 
	     sc skk-preedit-attr-okuri
	     (string-append
	      "*" (skk-make-string (skk-context-okuri sc)
				   (skk-context-kana-mode sc))))))

      (if (or
	   (= stat 'skk-state-direct)
	   (= stat 'skk-state-latin)
	   (= stat 'skk-state-wide-latin))
	  (begin
	    (im-pushback-preedit sc skk-preedit-attr-direct-pending-rk
				 (rk-pending rkc))
	    (im-pushback-preedit sc preedit-cursor ""))
	  (begin
	    (im-pushback-preedit sc skk-preedit-attr-pending-rk
				 (rk-pending rkc))
	    (if (and
		 (or
		  (= stat 'skk-state-kanji)
		  (= stat 'skk-state-completion)
		  (= stat 'skk-state-okuri))
		 skk-show-cursor-on-preedit?)
		(im-pushback-preedit sc preedit-cursor ""))))

      ;; child context's preedit
      (if (not (null? csc))
	  (let ((editor (skk-context-editor sc)))
	    (im-pushback-preedit sc skk-preedit-attr-child-beginning-mark
				 skk-child-context-beginning-mark)
	    (im-pushback-preedit sc skk-preedit-attr-child-committed
				 (skk-editor-get-left-string editor))
	    (skk-do-update-preedit csc)
	    (im-pushback-preedit sc skk-preedit-attr-child-committed
				 (skk-editor-get-right-string editor))
	    (im-pushback-preedit sc skk-preedit-attr-child-end-mark
				 skk-child-context-end-mark)
	    )))))

(define skk-update-preedit
  (lambda (sc)
    (if (not (skk-context-commit-raw sc))
	(begin
	  (im-clear-preedit sc)
	  (skk-do-update-preedit (skk-find-root-context sc))
	  (im-update-preedit sc))
	(skk-context-set-commit-raw! sc #f))))


;; called from skk-editor
(define skk-commit-editor-context
  (lambda (sc str)
    (let* ((psc (skk-context-parent-context sc))
	   (okuri (skk-make-string (skk-context-okuri sc)
				   (skk-context-kana-mode sc)))
	   (str (if (not (null? psc))
		    str
		    (string-append str okuri))))
      (skk-flush sc)
      (skk-context-set-child-context! sc #f)
      (skk-commit sc str))))

;; experimental coding style. discussions are welcome -- YamaKen
(define skk-proc-state-direct-no-preedit
  (lambda (key key-state sc rkc)
    (if skk-use-with-vi?
	(if (skk-vi-escape-key? key key-state)
	    (begin
	      (skk-context-set-state! sc 'skk-state-latin)
	      (rk-flush rkc))))
    (cond
     ((or (skk-cancel-key? key key-state)
	  (skk-backspace-key? key key-state)
	  (skk-return-key? key key-state))
      (skk-commit-raw sc key key-state)
      #f)
     ((skk-wide-latin-key? key key-state)
      (skk-context-set-state! sc 'skk-state-wide-latin)
      (rk-flush rkc)
      #f)
     ((skk-latin-key? key key-state)
      (skk-context-set-state! sc 'skk-state-latin)
      (rk-flush rkc)
      #f)
     ((skk-latin-conv-key? key key-state)
      (skk-context-set-state! sc 'skk-state-kanji)
      (skk-context-set-latin-conv! sc #t)
      #f)
     ((skk-kanji-mode-key? key key-state)
      (skk-context-set-state! sc 'skk-state-kanji)
      (skk-context-set-latin-conv! sc #f)
      #f)
     ((skk-hankaku-kana-key? key key-state)
      (let* ((kana (skk-context-kana-mode sc))
	     (new-kana (if (= kana skk-type-hankana)
			   skk-type-hiragana
			   skk-type-hankana)))
	(skk-context-set-kana-mode! sc new-kana))
      #f)
     ((skk-kana-toggle-key? key key-state)
      (skk-context-kana-toggle sc)
      #f)
     ;; bad strategy. see bug #528
     ((symbol? key)
      (skk-commit-raw sc key key-state)
      #f)
     ;; bad strategy. see bug #528
     ((or
       (control-key-mask key-state)
       (alt-key-mask key-state)
       (meta-key-mask key-state)
       (super-key-mask key-state)
       (hyper-key-mask key-state))
      (if (not (skk-state-direct-no-preedit-nop-key? key key-state))
	  (skk-commit-raw sc key key-state))
      #f)
     (else
      #t))))

(define skk-proc-state-direct
  (lambda (c key key-state)
    (let* ((sc (skk-find-descendant-context c))
	   (key-str (charcode->string (to-lower-char key)))
	   (rkc (skk-context-rk-context sc))
	   (res #f)
	   (kana (skk-context-kana-mode sc)))
      (and
       ;; at first, no preedit mode
       (if (string=? (rk-pending rkc) "")
	   (skk-proc-state-direct-no-preedit key key-state sc rkc)
	   #t)
       (if (skk-cancel-key? key key-state)
	   (begin
	     (skk-flush sc)
	     #f)
	   #t)
       (if (skk-backspace-key? key key-state)
	   (begin
	     (rk-backspace rkc)
	     #f)
	   #t)
       ;; commits "n" as kana according to kana-mode. This is
       ;; ddskk-compatible behavior.
       (if (skk-commit-key? key key-state)
	   (begin
	     (set! res (rk-push-key-last! rkc))
	     #f)
	   #t)
       ;; commits "n" as kana according to kana-mode, and send
       ;; native return
       (if (skk-return-key? key key-state)
	   (begin
	     (set! res (rk-push-key-last! rkc))
	     (skk-commit-raw-with-preedit-update sc key key-state)
	     #f)
	   #t)
       ;; Handles "n{L,l,/,Q,C-q,C-Q,q}" key sequence as below. This is
       ;; ddskk-compatible behavior.
       ;; 1. commits "n" as kana according to kana-mode
       ;; 2. switch mode by "{L,l,/,Q,C-q,C-Q,q}"
       (if (and (skk-wide-latin-key? key key-state)
		(not (string-find (rk-expect rkc) key-str)))
	   (begin
	     (set! res (rk-push-key-last! rkc))
	     (skk-context-set-state! sc 'skk-state-wide-latin)
	     #f)
	   #t)
       (if (and (skk-latin-key? key key-state)
		(not (string-find (rk-expect rkc) key-str)))
	   (begin
	     (set! res (rk-push-key-last! rkc))
	     (skk-context-set-state! sc 'skk-state-latin)
	     #f)
	   #t)
       (if (and (skk-latin-conv-key? key key-state)
		(not (string-find (rk-expect rkc) key-str)))
	   (let* ((residual-kana (rk-push-key-last! rkc)))
	     (if residual-kana
		 (skk-commit sc (skk-get-string sc residual-kana kana)))
	     (skk-context-set-state! sc 'skk-state-kanji)
	     (skk-context-set-latin-conv! sc #t)
	     #f)
	   #t)
       (if (and (skk-kanji-mode-key? key key-state)
		(not (string-find (rk-expect rkc) key-str)))
	   (let* ((residual-kana (rk-push-key-last! rkc)))
	     (if residual-kana
		 (skk-commit sc (skk-get-string sc residual-kana kana)))
	     (skk-context-set-state! sc 'skk-state-kanji)
	     (skk-context-set-latin-conv! sc #f)
	     #f)
	   #t)
       (if (and (skk-hankaku-kana-key? key key-state)
		(not (string-find (rk-expect rkc) key-str)))
	   (let* ((kana (skk-context-kana-mode sc))
		  (new-kana (if (= kana skk-type-hankana)
		    		  skk-type-hiragana
				  skk-type-hankana)))
	     (set! res (rk-push-key-last! rkc))
	     (skk-context-set-kana-mode! sc new-kana)
	     #f)
	   #t)
       (if (and (skk-kana-toggle-key? key key-state)
		(not (string-find (rk-expect rkc) key-str)))
	   (begin
	     (set! res (rk-push-key-last! rkc))
	     (skk-context-kana-toggle sc)
	     #f)
	   #t)
       ;; Handles "n " key sequence as below. This is ddskk-compatible
       ;; behavior.
       ;; 1. commits "n" as kana according to kana-mode
       ;; 2. commits " " as native space (such as Qt::Key_Space)
       ;;    unless expected rkc list includes " "
       (if (and (skk-plain-space-key? key key-state)
		(not (string-find (rk-expect rkc) key-str)))
	   (begin
	     (set! res (rk-push-key-last! rkc))
	     (skk-commit-raw-with-preedit-update sc key key-state)
	     #f)
	   #t)
       ;; bad strategy. see bug #528
       ;; "<Control>a", "<Alt> ", "<Meta>b" and so on
       (if (or
	    (control-key-mask key-state)
	    (alt-key-mask key-state)
	    (meta-key-mask key-state)
	    (super-key-mask key-state)
	    (hyper-key-mask key-state))
	   (begin
	     (skk-flush sc)
	     (skk-commit-raw-with-preedit-update sc key key-state)
	     #f)
	   #t)
       (if (skk-upper-char? key)
	   (let* ((residual-kana (rk-push-key-last! rkc)))
	     ;; handle preceding "n"
	     (if residual-kana
		 (skk-commit sc (skk-get-string sc residual-kana kana)))
	     (skk-context-set-state! sc 'skk-state-kanji)
	     (set! key (to-lower-char key))
	     (set! key-str (charcode->string key))
	     #t)
	   #t)
       ;; Hack to handle "n1" sequence as "ん1".
       ;; This should be handled in rk.scm. -- ekato
       (if (and (not (alphabet-char? key))
		(not (string-find (rk-expect rkc) key-str)))
	   (let* ((residual-kana (rk-push-key-last! rkc)))
	     (if residual-kana
		 (skk-commit sc (skk-get-string sc residual-kana kana)))
	     #t)
	   #t)
       ;; bad strategy. see bug #528
       (if (symbol? key)
	   (begin
	     (skk-flush sc)
	     (skk-commit-raw-with-preedit-update sc key key-state)
	     #f)
	   #t)
       (begin
	 (set! res
	       (rk-push-key!
		rkc
		key-str))
	 #t));;and
      ;; update state
      (if (= (skk-context-state sc) 'skk-state-kanji)
	  (if res
	      (skk-append-string sc res)))
      (if (or
	   (= (skk-context-state sc) 'skk-state-direct)
	   (= (skk-context-state sc) 'skk-state-latin)
	   (= (skk-context-state sc) 'skk-state-wide-latin))
	  (if (and res
		   (or
		    (list? (car res))
		    (not (string=? (car res) ""))))
	      (skk-get-string sc res kana))
	  #f))))

(define skk-upper-char?
  (lambda (c)
    (and (integer? c)
	 (or
	  (and (>= c 65) (<= c 90))))))

(define skk-sokuon-shiin-char?
  (lambda (c)
    (and (alphabet-char? c)
	 (and
	  (not (= c 97))	;; a
	  (not (= c 105))	;; i
	  (not (= c 117))	;; u
	  (not (= c 101))	;; e
	  (not (= c 111))	;; o
	  (not (= c 110))))))	;; n

(define skk-proc-state-kanji
  (lambda (c key key-state)
    (let* ((sc (skk-find-descendant-context c))
	   (rkc (skk-context-rk-context sc))
	   (stat (skk-context-state sc))
	   (res #f))
      (and
       ;; First, check begin-conv, completion, cancel, backspace,
       ;; commit, and return keys
       (if (skk-begin-conv-key? key key-state)
	   (begin
	     (skk-append-residual-kana sc)
	     (if (not (null? (skk-context-head sc)))
		 (skk-begin-conversion sc)
		 (skk-flush sc))
	     #f)
	   #t)
       (if (skk-begin-completion-key? key key-state)
	   (begin
	     (skk-begin-completion sc)
	     #f)
	   #t)
       (if (skk-cancel-key? key key-state)
	   (begin
	     (skk-flush sc)
	     #f)
	   #t)
       (if (skk-backspace-key? key key-state)
	   (begin
	     (if (not (rk-backspace rkc))
		 (if (> (length (skk-context-head sc)) 0)
		     (skk-context-set-head!
		      sc (cdr (skk-context-head sc)))
		     (skk-flush sc)))
	     #f)
	   #t)
       (if (or
	    (skk-commit-key? key key-state)
	    (skk-return-key? key key-state))
	   (begin
	     (skk-append-residual-kana sc)
	     (skk-commit sc (skk-make-string
			     (skk-context-head sc)
			     (skk-context-kana-mode sc)))
	     (skk-flush sc)
	     (if (not skk-egg-like-newline?)
		 (if (skk-return-key? key key-state)
		     (if skk-commit-newline-explicitly?
			 (skk-commit sc "\n")
			 (begin
			   (skk-update-preedit sc)
			   (skk-proc-state-direct c key key-state)))))
 	     #f)
	   #t)
       ;; Then check latin-conv status before key handling of hiragana/katakana
       (if (skk-context-latin-conv sc)
	   (begin
	     (if (skk-conv-wide-latin-key? key key-state) 
		 ;; wide latin conversion
		 (begin
		   (if (not (null? (skk-context-head sc)))
		       (begin
			 (skk-commit sc (skk-conv-wide-latin
					 (skk-context-head sc)))
			 (skk-flush sc))))
		 ;; append latin string
		 (begin
		   (if (usual-char? key)
		       (let* ((s (charcode->string key))
			      (p (cons s (cons s (cons s s)))))
			 (skk-append-string sc p)))))
	     #f)
	   #t)
       (if (skk-kanji-mode-key? key key-state)
	   (begin
	     (skk-append-residual-kana sc)
	     (if (not (null? (skk-context-head sc)))
		 (begin
		   (skk-commit sc (skk-make-string
				   (skk-context-head sc)
				   (skk-context-kana-mode sc)))
		   (skk-flush sc)
		   (skk-context-set-state! sc 'skk-state-kanji)
		   (skk-context-set-latin-conv! sc #f)))
	     #f)
	   #t)
       ;; handle Settou-ji
       (if (skk-special-midashi-key? key key-state)
	   (begin
	     (skk-append-residual-kana sc)
	     (skk-append-string sc '(">"))
	     (skk-begin-conversion sc)
	     #f)
	   #t)
       (if (and (skk-upper-char? key)
		(not (null? (skk-context-head sc))))
	   (begin
	     (skk-context-set-state! sc 'skk-state-okuri)
	     (set! key (to-lower-char key))
	     (skk-context-set-okuri-head! sc
					  (charcode->string key))
	     (if (skk-sokuon-shiin-char? key)
		 (begin
		   (set! res
			 (rk-push-key! rkc (charcode->string key)))
		   (if res
		       (skk-context-set-head! sc
					      (cons
					       res
					       (skk-context-head sc))))))
	     (skk-append-residual-kana sc)
	     #t)
	   #t)
       (if (skk-kana-toggle-key? key key-state)
	   (begin
	     (skk-append-residual-kana sc)
	     (if (not (null? (skk-context-head sc)))
		 (begin
		   (skk-commit sc (skk-make-string
				   (skk-context-head sc)
				   (skk-opposite-kana
				    (skk-context-kana-mode sc))))
	     	   (skk-flush sc)))
	     #f)
	   #t)
       (if (skk-hankaku-kana-key? key key-state)
	   (begin
	     (skk-append-residual-kana sc)
	     (if (not (null? (skk-context-head sc)))
		 (begin
		   (skk-commit sc (skk-make-string (skk-context-head sc)
						   skk-type-hankana))
		   (skk-flush sc)))
	     #f)
	   #t)
       ;; Hack to handle "n1" sequence as "ん1".
       ;; This should be handled in rk.scm. -- ekato
       (if (and (not (alphabet-char? key))
		(not (string-find
		      (rk-expect rkc)
		      (charcode->string (to-lower-char key)))))
	   (let* ((residual-kana (rk-push-key-last! rkc)))
	     (if residual-kana
		 (skk-context-set-head! sc
					(cons
					 residual-kana
					 (skk-context-head sc))))
	     #t)
	   #t)
       (begin
	 (set! key (to-lower-char key))  
	 (set! stat (skk-context-state sc))
	 (set! res
	       (rk-push-key!
		rkc
		(charcode->string key)))
	 (and
	  (if (and
	       skk-auto-start-henkan?
	       (string-find skk-auto-start-henkan-keyword-list (car res)))
	      (begin
		(skk-context-set-okuri! sc (list res))
		(skk-begin-conversion sc)
		#f)
	      #t)
	  (if (and res
		   (= stat 'skk-state-kanji)
		   (or
		    (list? (car res))
		    (not (string=? (car res) ""))))
	      (begin
		(skk-append-string sc res)
		#t)
	      #t)
	   (if (and res
	 	    (= stat 'skk-state-okuri)
		    (or
		     (list? (car res))
		     (not (string=? (car res) ""))))
	       (begin
		 (skk-append-okuri-string sc res)
		 (skk-begin-conversion sc))))))
      #f)))

(define skk-setup-child-context
  (lambda (sc)
    (let ((csc (skk-context-new (skk-context-id sc)
				(skk-context-im sc))))
      (skk-context-set-child-context! sc csc)
      (skk-context-set-parent-context! csc sc)
      (skk-context-set-state! csc 'skk-state-direct))))

(define skk-check-candidate-window-begin
  (lambda (sc)
    (let ((head (skk-context-head sc)))
      (if
       (and
	(not
	 (skk-context-candidate-window sc))
	skk-use-candidate-window?
	;; XXX skk-context-candidate-op-count start from 0 with
	;; the first entry of the candidates
	(> (skk-context-candidate-op-count sc)
	   (- skk-candidate-op-count 2)))
	(begin
	 (skk-context-set-candidate-window! sc #t)
	 (if skk-use-numeric-conversion?
	   ;; store numeric strings to check #4
	   (let ((numlst (skk-lib-store-replaced-numstr
			  (skk-make-string head skk-type-hiragana))))
	     (skk-context-set-nr-candidates!
	      sc
	      (skk-lib-get-nr-candidates
		(skk-lib-replace-numeric
		 (skk-make-string head skk-type-hiragana))
		(skk-context-okuri-head sc)
		(skk-make-string (skk-context-okuri sc) skk-type-hiragana)
		numlst))
	     (im-activate-candidate-selector
	      sc
	      (skk-context-nr-candidates sc)
	      skk-nr-candidate-max))
	   (begin
	     (skk-context-set-nr-candidates!
	      sc
	      (skk-lib-get-nr-candidates
	       (skk-make-string head skk-type-hiragana)
	       (skk-context-okuri-head sc)
	       (skk-make-string (skk-context-okuri sc) skk-type-hiragana)
	       '()))
	     (im-activate-candidate-selector
	      sc
	      (skk-context-nr-candidates sc)
	      skk-nr-candidate-max))))))))

(define skk-commit-by-label-key
  (lambda (sc key)
    (let ((nr (skk-context-nr-candidates sc))
	  (cur-page (if (= skk-nr-candidate-max 0)
			0
			(quotient (skk-context-nth sc) skk-nr-candidate-max)))
	  (idx -1)
	  (res #f))
      (if (numeral-char? key)
	  (let ((num (numeral-char->number key)))
	    (if (= num 0)
		(set! num 9) ; pressing key_0
		(set! num (- num 1)))
	    (if (or (< num skk-nr-candidate-max)
		    (= skk-nr-candidate-max 0))
		(set! idx (+ (* cur-page skk-nr-candidate-max) num))))
	  ;; FIXME: add code to handle labels other than number here
	  )
      (if (and (>= idx 0)
	       (< idx nr))
	  (begin
	    (skk-context-set-nth! sc idx)
	    (set! res (skk-prepare-commit-string sc))))
      res)))

(define skk-change-candidate-index
  (lambda (sc incr)
    (let ((head (skk-context-head sc)))
      (if incr
	  (begin
	    (skk-context-set-nth! sc
				  (+ 1 (skk-context-nth sc)))
	    (skk-context-set-candidate-op-count!
	     sc
	     (+ 1 (skk-context-candidate-op-count sc))))
	  (begin
	    (if (> (skk-context-nth sc) 0)
		(skk-context-set-nth! sc (- (skk-context-nth sc) 1))
		(skk-context-set-nth!
		 sc
		 (- (skk-context-nr-candidates sc) 1)))))
      (if (null? (skk-get-current-candidate sc))
	  (begin
	    (skk-context-set-nth! sc 0)
	    (if skk-use-recursive-learning?
		(begin
		  (skk-reset-candidate-window sc)
		  (skk-setup-child-context sc)))))
      (if (null? (skk-context-child-context sc))
	  (begin
	    ;; 候補Windowの表示を開始するか
	    (skk-check-candidate-window-begin sc)
	    ;;
	    (if (skk-context-candidate-window sc)
		(im-select-candidate sc (skk-context-nth sc)))))
      #f)))

(define skk-reset-candidate-window
  (lambda (sc)
    (if (skk-context-candidate-window sc)
	(begin
	  (im-deactivate-candidate-selector sc)
	  (skk-context-set-candidate-window! sc #f)))
    (skk-context-set-candidate-op-count! sc 0)))

(define skk-back-to-kanji-state
  (lambda (sc)
    (skk-reset-candidate-window sc)
    (skk-context-set-state! sc 'skk-state-kanji)
    (skk-context-set-okuri-head! sc "")
    (if (not (null? (skk-context-okuri sc)))
	(skk-context-set-head! sc
			       (append (skk-context-okuri sc)
				       (skk-context-head sc))))
    (skk-context-set-okuri! sc '())))

(define skk-change-completion-index
  (lambda (sc incr)
    (if incr
	(begin
	  (if (> (- (skk-lib-get-nr-completions
		  (skk-make-string (skk-context-head sc) skk-type-hiragana)) 1)
		 (skk-context-completion-nth sc))
	      (skk-context-set-completion-nth!
	       sc
	       (+ 1 (skk-context-completion-nth sc)))))
	(begin
	  (if (> (skk-context-completion-nth sc) 0)
	      (skk-context-set-completion-nth!
	       sc
	       (- (skk-context-completion-nth sc) 1)))))
    #f))

(define find-kana-list-from-rule
  (lambda (rule str)
    (if (not (null? rule))
	(if (pair? (member str (car (cdr (car rule)))))
	    (car (cdr (car rule)))
	    (find-kana-list-from-rule (cdr rule) str))
	(list str str str))))

(define skk-append-list-to-context-head
  (lambda (sc sl)
     (skk-context-set-head! sc (append (skk-context-head sc) (list sl)))))

(define skk-string-list-to-context-head
  (lambda (sc sl)
    (if (not (null? sl))
	(begin
	  (skk-append-list-to-context-head
	   sc
	   (find-kana-list-from-rule ja-rk-rule-basic (car sl)))
	  (skk-string-list-to-context-head sc (cdr sl)))
	#f)))

(define skk-proc-state-completion
  (lambda (c key key-state)
    (let ((sc (skk-find-descendant-context c)))
      (and
       (if (skk-next-completion-key? key key-state)
	   (skk-change-completion-index sc #t)
	   #t)
       (if (skk-prev-completion-key? key key-state)
	   (skk-change-completion-index sc #f)
	   #t)
       (if (skk-cancel-key? key key-state)
	   (begin
	     (skk-lib-clear-completions
	       (skk-make-string (skk-context-head sc) skk-type-hiragana))
	     (skk-context-set-state! sc 'skk-state-kanji)
	     #f)
	   #t)
       (let ((sl (string-to-list (skk-get-current-completion sc))))
	 (skk-lib-clear-completions
	   (skk-make-string (skk-context-head sc) (skk-context-kana-mode sc)))
	 (skk-context-set-head! sc '())
	 (skk-string-list-to-context-head sc sl)
	 (skk-context-set-state! sc 'skk-state-kanji)
	 (skk-proc-state-kanji c key key-state)))
      #f)))

(define skk-heading-label-char?
  (lambda (key)
    (if (numeral-char? key) ;; FIXME: should handle key other than number
	#t
	#f)))

(define skk-proc-state-converting
  (lambda (c key key-state)
    (let ((sc (skk-find-descendant-context c))
	  (res #f))
      (and
       (if (skk-next-candidate-key? key key-state)
	   (skk-change-candidate-index sc #t)
	   #t)
       (if (skk-prev-candidate-key? key key-state)
	   (skk-change-candidate-index sc #f)
	   #t)
       (if (skk-cancel-key? key key-state)
	   (begin
	     ;; back to kanji state
	     (skk-back-to-kanji-state sc)
	     #f)
	   #t)
       (if (skk-next-page-key? key key-state)
	   (begin
	     (if (skk-context-candidate-window sc)
		 (im-shift-page-candidate sc #t))
	     #f)
	   #t)
       (if (skk-prev-page-key? key key-state)
	   (begin
	     (if (skk-context-candidate-window sc)
		 (im-shift-page-candidate sc #f))
	     #f)
	   #t)
       (if (or
	    (skk-commit-key? key key-state)
	    (skk-return-key? key key-state))
	   (begin
	     (set! res (skk-prepare-commit-string sc))
	     (if (skk-return-key? key key-state)
		 (begin
		   (skk-commit sc res)
		   (set! res #f)
		   (if (not skk-egg-like-newline?)
		       (if skk-commit-newline-explicitly?
			   (skk-commit sc "\n")
			   (begin
			     (skk-update-preedit sc)
			     (skk-proc-state-direct c key key-state))))))
	     #f)
	   #t)
       (if (and skk-commit-candidate-by-label-key?
       		(skk-heading-label-char? key)
		(skk-context-candidate-window sc))
	   (begin
	     (set! res (skk-commit-by-label-key sc key))
	     (if res
		 #f
		 #t))
	   #t)
       (begin
	 (skk-context-set-state! sc 'skk-state-direct)
	 (set! res (skk-prepare-commit-string sc))
	 (skk-commit sc res)
	 (skk-update-preedit sc)
	 ;; handle Setsubi-ji
	 (if (skk-special-midashi-key? key key-state)
	     (begin
	       (skk-context-set-state! sc 'skk-state-kanji)
	       (skk-append-string sc '(">"))
	       (set! res #f))
	     (set! res (skk-proc-state-direct c key key-state)))))
      res)))

(define skk-proc-state-okuri
  (lambda (c key key-state)
    (let* ((sc (skk-find-descendant-context c))
	   (rkc (skk-context-rk-context sc))
	   (res))
      (and
       (if (skk-cancel-key? key key-state)
	   (begin
	     (rk-flush rkc)
	     (skk-context-set-state! sc 'skk-state-kanji)
	     #f)
	   #t)
       (if (skk-backspace-key? key key-state)
	   (begin
	     (rk-backspace rkc)
	     (skk-back-to-kanji-state sc)
	     #f)
	   #t)
       ;; committing incomplete head: conformed the behavior to ddskk
       (if (or
	    (skk-commit-key? key key-state)
	    (skk-return-key? key key-state))
	   (begin
	     (skk-commit sc (skk-make-string
			     (skk-context-head sc)
			     (skk-context-kana-mode sc)))
	     (skk-flush sc)
	     (if (skk-return-key? key key-state)
		 (begin
		   (skk-update-preedit sc)
		   (skk-proc-state-direct c key key-state)))
	     #f)
	   #t)
       (begin
	 (set! res
	       (rk-push-key!
		rkc
		(charcode->string (to-lower-char key))))
	 (if (and res
	 	  (or
		   (list? (car res))
		   (not (string=? (car res) ""))))
	     (begin
	       (skk-append-okuri-string sc res)
	       (if (string=? (rk-pending rkc) "")
		   (skk-begin-conversion sc)))
	     (begin
	       (if (= (length (rk-context-seq rkc)) 1)
		   (skk-context-set-okuri-head! sc (charcode->string key)))))))
      #f)))

(define skk-proc-state-latin
  (lambda (c key key-state)
    (let ((sc (skk-find-descendant-context c)))
      (if
       (skk-on-key? key key-state)
       (begin
	 (skk-context-set-state! sc 'skk-state-direct)
	 (skk-context-set-kana-mode! sc skk-type-hiragana))
       (skk-commit-raw sc key key-state))
      #f)))

(define skk-proc-state-wide-latin
  (lambda (c key key-state)
    (let* ((char (charcode->string key))
	   (w (or (ja-direct char)
		  (ja-wide char)))
	   (sc (skk-find-descendant-context c)))
      (if skk-use-with-vi?
	  (if (skk-vi-escape-key? key key-state)
	      (skk-context-set-state! sc 'skk-state-latin)))
      (cond
       ((skk-on-key? key key-state)
	(skk-flush sc)  ; implicitly reset to 'skk-state-direct
	(skk-context-set-kana-mode! sc skk-type-hiragana))
       ((and (modifier-key-mask key-state)
	     (not (shift-key-mask key-state)))
	(skk-commit-raw sc key key-state))
       (w
	(skk-commit sc w))
       (else
	(skk-commit-raw sc key key-state)))
      #f)))

(define skk-push-key
  (lambda (c key key-state)
    (let* ((sc (skk-find-descendant-context c))
	   (state (skk-context-state sc))
	   (fun (cond
		 ((= state 'skk-state-direct)
		  skk-proc-state-direct)
		 ((= state 'skk-state-kanji)
		  skk-proc-state-kanji)
		 ((= state 'skk-state-completion)
		  skk-proc-state-completion)
		 ((= state 'skk-state-converting)
		  skk-proc-state-converting)
		 ((= state 'skk-state-okuri)
		  skk-proc-state-okuri)
		 ((= state 'skk-state-latin)
		  skk-proc-state-latin)
		 ((= state 'skk-state-wide-latin)
		  skk-proc-state-wide-latin)))
	   (res (fun c key key-state)))
      (if res
	  (skk-commit sc res))
      (skk-update-preedit sc))))

(define skk-init-handler
  (lambda (id im arg)
    (let ((sc (skk-context-new id im)))
      (update-style skk-style-spec (symbol-value skk-style))
      sc)))

(define skk-release-handler
  (lambda (sc)
    (skk-save-personal-dictionary)))

(define skk-press-key-handler
  (lambda (sc key state)
    (if (control-char? key)
	(im-commit-raw sc)
	(skk-push-key sc key state))))

(define skk-release-key-handler
  (lambda (c key state)
    (let* ((sc (skk-find-descendant-context c))
	   (state (skk-context-state sc)))
      (if (= state 'skk-state-latin)
	  ;; don't discard key release event for apps
	  (begin
	    (skk-context-set-commit-raw! sc #f)
	    (im-commit-raw sc))))))

(define skk-reset-handler
  (lambda (sc)
    (let ((st (skk-context-state sc)))
      (if (not (or
		(= st 'skk-state-latin)
		(= st 'skk-state-wide-latin))
	  (skk-flush sc))))))

(define skk-get-candidate-handler
  (lambda (sc idx)
    (let* ((dcsc (skk-find-descendant-context sc))
	   (cand (skk-get-nth-candidate dcsc idx))
	   (okuri (skk-context-okuri dcsc)))
      (list
       (if (and
	    (not (null? okuri))
	    skk-show-candidates-with-okuri?)
	   (string-append cand
			  (skk-make-string okuri skk-type-hiragana))
	   cand)
       ;; FIXME make sure to enable lable other than number
       (if (= skk-nr-candidate-max 0)
	   (digit->string (+ idx 1))
	   (digit->string (+ (remainder idx skk-nr-candidate-max) 1)))
       ""))))

(define skk-set-candidate-index-handler
  (lambda (c idx)
    (let ((sc (skk-find-descendant-context c)))
      (if (skk-context-candidate-window sc)
	  (begin
	    (skk-context-set-nth! sc idx)
	    (skk-update-preedit sc))))))

(skk-configure-widgets)

(register-im
 'skk
 "ja"
 "EUC-JP"
 skk-im-label-name
 skk-im-short-desc
 #f
 skk-init-handler
 skk-release-handler
 context-mode-handler
 skk-press-key-handler
 skk-release-key-handler
 skk-reset-handler
 skk-get-candidate-handler
 skk-set-candidate-index-handler
 context-prop-activate-handler)
