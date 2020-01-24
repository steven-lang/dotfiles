(defun slang/load-layer (layer-name part)
  "Load a layer."
  (load-file (s-join "/" `(,emacs-dir "layers" ,layer-name ,(concat part ".el")))))

(defun slang/load-layers-part (layers part)
  "Load a particular part of all layers."
  (cl-loop for layer in layers
           do (progn
                (slang/load-layer layer part))))

(defun slang/load-layers (layers)
    " Load a list of layers.
    Each layer has a config-pre.el, config-post.el and keybindings.el file.
    First, all config-pre.el files are loaded which should not have any dependencies.
    Then the config-post.el files and keybindings are loaded.
    "
  ;; Load all initializations
  (slang/load-layers-part layers "config-pre")
  ;; Load all post-configs
  (slang/load-layers-part layers "config-post")
  ;; Load all keybindings
  (slang/load-layers-part layers "keybindings"))


(defun slang/switch-to-scratch ()
  "Switch to scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*"))

(defun slang/edit-config ()
  "Edit config file."
  (interactive)
  (find-file (concat emacs-dir "init.el")))

(defun slang/reload-config ()
  "Reload config file."
  (interactive)
  (load-file (concat emacs-dir "init.el")))


;; Close compilation buffer on succeed
(defun slang/bury-compile-buffer-if-successful (buffer string)
"Bury a compilation buffer if succeeded without warnings
https://stackoverflow.com/questions/11043004/emacs-compile-buffer-auto-close/11059012#11059012"
    (when (and
            (buffer-live-p buffer)
            (string-match "compilation" (buffer-name buffer))
            (string-match "finished" string)
            )
    (run-with-timer 1 nil
                    (lambda (buf)
                        (bury-buffer buf)
                        (delete-windows-on buf))
                    buffer)))
(add-hook 'compilation-finish-functions 'slang/bury-compile-buffer-if-successful)


;; https://gist.github.com/mads-hartmann/3402786
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))
