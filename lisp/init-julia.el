(add-to-list 'load-path "~/Dropbox/.Emacs/julia-emacs")
(add-to-list 'load-path "~/Dropbox/.Emacs/julia-repl")

;; julia-mode
(use-package julia-mode
  :ensure t
  :config
  ;; (add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))
)

(use-package julia-repl
  :ensure t
  :config
  (require 'julia-repl)
  (add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode
  (set-language-environment "UTF-8")
  (julia-repl-set-terminal-backend 'vterm)
  (setq vterm-kill-buffer-on-exit nil)
  )

;; (use-package julia-snail
;;   :ensure t
;;   :requires vterm
;;   :hook (julia-mode . julia-snail-mode)
;;   )

(defun my-julia-hook ()
  (highlight-indentation-mode t)
  ;; (auto-highlight-symbol-mode t)
  (julia-repl-mode t)
  )
(add-hook 'julia-mode-hook 'my-julia-hook)
(setenv "JULIA_NUM_THREADS" "4")


(provide 'init-julia)
;;; init-julia.el ends here

  ;; (defconst julia-keyword-regex
  ;;   (regexp-opt
  ;;    '(
  ;;      "abs"
  ;;      "addprocs"
  ;;      "adjoint"
  ;;      "append!"
  ;;      "apropos"
  ;;      "Base.showerror"
  ;;      "Bernoulli"
  ;;      "Binomial"
  ;;      "BLAS.set_num_threads"
  ;;      "cat"
  ;;      "ccdf"
  ;;      "cd"
  ;;      "cdf"
  ;;      "ceil"
  ;;      "Chisq"
  ;;      "cholesky"
  ;;      "cld"
  ;;      "collect"
  ;;      "convert"
  ;;      "copy"
  ;;      "cor"
  ;;      "corspearman"
  ;;      "countmap"
  ;;      "CSV.read"
  ;;      "CSV.write"
  ;;      "DataFrame"
  ;;      "Date"
  ;;      "DateTime"
  ;;      "deepcopy"
  ;;      "deleteat!"
  ;;      "det"
  ;;      "dot"
  ;;      "eachline"
  ;;      "eachmatch"
  ;;      "ecdf"
  ;;      "eigvals"
  ;;      "eigvecs"
  ;;      "enumerate"
  ;;      "eps"
  ;;      "exit"
  ;;      "exp"
  ;;      "FDist"
  ;;      "fill"
  ;;      "fill!"
  ;;      "filter"
  ;;      "filter!"
  ;;      "find"
  ;;      "findall"
  ;;      "findfirst"
  ;;      "fit"
  ;;      "floor"
  ;;      "gcd"
  ;;      "h5read"
  ;;      "h5write"
  ;;      "haskey"
  ;;      "hcat"
  ;;      "histogram"
  ;;      "homedir"
  ;;      "Hypergeometric"
  ;;      "I"
  ;;      "include"
  ;;      "intersect"
  ;;      "inv"
  ;;      "isa"
  ;;      "isfinite"
  ;;      "ismissing"
  ;;      "isnan"
  ;;      "issubset"
  ;;      "kde"
  ;;      "keys"
  ;;      "lastindex"
  ;;      "layout"
  ;;      "legend"
  ;;      "length"
  ;;      "lm"
  ;;      "log"
  ;;      "map"
  ;;      "mapslices"
  ;;      "match"
  ;;      "max"
  ;;      "maximum"
  ;;      "mean"
  ;;      "median"
  ;;      "methods"
  ;;      "min"
  ;;      "minimum"
  ;;      "mod"
  ;;      "MvNormal"
  ;;      "Normal"
  ;;      "ones"
  ;;      "open"
  ;;      "parse"
  ;;      "params"
  ;;      "pdf"
  ;;      "pinv"
  ;;      "Pkg.add"
  ;;      "Pkg.build"
  ;;      "Pkg.installed"
  ;;      "Pkg.rm"
  ;;      "Pkg.status"
  ;;      "Pkg.update"
  ;;      "plot"
  ;;      "plot!"
  ;;      "pmap"
  ;;      "pop!"
  ;;      "popfirst!"
  ;;      "predict"
  ;;      "print"
  ;;      "println"
  ;;      "prod"
  ;;      "push!"
  ;;      "pushfirst!"
  ;;      "pvalue"
  ;;      "pwd"
  ;;      "quantile"
  ;;      "rand"
  ;;      "randexp"
  ;;      "randn"
  ;;      "Random.seed!"
  ;;      "randsubseq"
  ;;      "range"
  ;;      "rank"
  ;;      "readdlm"
  ;;      "rem"
  ;;      "replace"
  ;;      "reshape"
  ;;      "rethrow"
  ;;      "round"
  ;;      "sample"
  ;;      "save"
  ;;      "savefig"
  ;;      "scatter!"
  ;;      "seed!"
  ;;      "select"
  ;;      "select!"
  ;;      "seriestype"
  ;;      "setdiff"
  ;;      "show"
  ;;      "shuffle"
  ;;      "size"
  ;;      "sizehint!"
  ;;      "skipmissing"
  ;;      "sort"
  ;;      "sort!"
  ;;      "sparse"
  ;;      "SparseMatrixCSC"
  ;;      "SparseVector"
  ;;      "sqrt"
  ;;      "std"
  ;;      "sum"
  ;;      "symdiff"
  ;;      "TDist"
  ;;      "Threads.nthreads"
  ;;      "throw"
  ;;      "tiedrank"
  ;;      "time"
  ;;      "tr"
  ;;      "trace"
  ;;      "transpose"
  ;;      "typemax"
  ;;      "typemin"
  ;;      "typename"
  ;;      "union"
  ;;      "unique"
  ;;      "values"
  ;;      "var"
  ;;      "vcat"
  ;;      "vec"
  ;;      "writedlm"
  ;;      "zeros"
  ;;      )
  ;;    'symbols))

