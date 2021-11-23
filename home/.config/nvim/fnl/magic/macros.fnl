;; Trick vim-sleuth into using the right indentation for this file.
(do
  true)

;; These macro functions are executed at compile time to transform our code,
;; add more expressive syntax and create domain specific languages.

;; This file is never compiled to Lua itself, it's only required by the Fennel
;; compiler.

;; Example:
; (module my.fennel.module
;   {require-macros [magic.macros]})
; (some-macro 123)

;; I consider this to be an advanced concept within Lisp languages but one you
;; should try to learn some day. Start small, copy and modify what you find
;; here. You'll get it eventually!

;; Rule of macros: Use a function instead.

;; Macros should be used with care and extremely sparingly. If you can get away
;; with a function, you should! If you're not careful they'll make your code
;; unreadable and far too "clever", use them when plain functions aren't enough
;; or are too awkward to wield for your specific problem.
(fn sym-tostring [x]
  `,(tostring x))

(fn noremap [mode left right ...]
  (let [mode (sym-tostring mode)
        opts {}]
    (var isBuffer false) ; so we don't have to specify not in a buffer
    ; set that noremap is true
    (tset opts :noremap true)
    ; set each option to be true
    (each [key val (ipairs [...])]
      ; buffer isn't an option for nvim_set_keymap
      ; if we see buffer, set flag
      (if (= val :buffer)
        (do (set isBuffer true))
        ; everything else is a valid option
        (do (tset opts val true))))
    ; if buffer is set, use a buffer map
    (if (= isBuffer true)
      (do
        `(vim.api.nvim_buf_set_keymap 0 ,mode ,left ,right ,opts))
      (do
        `(vim.api.nvim_set_keymap ,mode ,left ,right ,opts)))))

{
 ;; Create an augroup for your autocmds.
 ; (augroup my-group
 ;   (nvim.ex.autocmd ...))
 :augroup
 (fn [name ...]
   `(do
      (vim.cmd (.. "augroup " ,(tostring name) "\nautocmd!"))
      ,...
      (vim.cmd "augroup END")
      nil))
 
 :nnoremap
 (fn [left right ...]
   (noremap :n left right ...))
 
 :inoremap
 (fn [left right ...]
   (noremap :i left right ...))
 
 :tnoremap
 (fn [left right ...]
   (noremap :t left right ...))}
