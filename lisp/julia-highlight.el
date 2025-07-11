;; https://www.emacswiki.org/emacs/AddKeywords

(font-lock-add-keywords
 'julia-mode
 '(("\\_<\\(B\\(?:LAS\\.set_num_threads\\|ase\\.showerror\\|ernoulli\\|inomial\\)\\|C\\(?:SV\\.\\(?:read\\|write\\)\\|hisq\\)\\|Dat\\(?:\\(?:\\(?:aFra\\|eTi\\)m\\)?e\\)\\|FDist\\|Hypergeometric\\|I\\|MvNormal\\|Normal\\|Pkg\\.\\(?:add\\|build\\|installed\\|rm\\|status\\|update\\)\\|Random\\.seed!\\|Sparse\\(?:MatrixCSC\\|Vector\\)\\|T\\(?:Dist\\|hreads\\.nthreads\\)\\|a\\(?:bs\\|d\\(?:dprocs\\|joint\\)\\|p\\(?:pend!\\|ropos\\)\\)\\|c\\(?:at\\|cdf\\|df?\\|eil\\|holesky\\|ld\\|o\\(?:llect\\|nvert\\|py\\|r\\(?:spearman\\)?\\|untmap\\)\\)\\|d\\(?:e\\(?:epcopy\\|leteat!\\|t\\)\\|ot\\)\\|e\\(?:ach\\(?:line\\|match\\)\\|cdf\\|igv\\(?:\\(?:al\\|ec\\)s\\)\\|numerate\\|ps\\|x\\(?:it\\|p\\)\\)\\|f\\(?:i\\(?:l\\(?:l!?\\|ter!?\\)\\|nd\\(?:all\\|first\\)?\\|t\\)\\|loor\\)\\|gcd\\|h\\(?:5\\(?:read\\|write\\)\\|askey\\|cat\\|istogram\\|omedir\\)\\|i\\(?:n\\(?:clude\\|tersect\\|v\\)\\|s\\(?:a\\|finite\\|missing\\|nan\\|subset\\)\\)\\|k\\(?:de\\|eys\\)\\|l\\(?:a\\(?:stindex\\|yout\\)\\|e\\(?:gend\\|ngth\\)\\|m\\|og\\)\\|m\\(?:a\\(?:pslices\\|tch\\|ximum\\|[px]\\)\\|e\\(?:an\\|dian\\|thods\\)\\|in\\(?:imum\\)?\\|od\\)\\|o\\(?:nes\\|pen\\)\\|p\\(?:ar\\(?:ams\\|se\\)\\|df\\|inv\\|lot!?\\|map\\|op\\(?:\\(?:first\\)?!\\)\\|r\\(?:edict\\|int\\(?:ln\\)?\\|od\\)\\|ush\\(?:\\(?:first\\)?!\\)\\|value\\|wd\\)\\|quantile\\|r\\(?:an\\(?:d\\(?:exp\\|n\\|subseq\\)\\|ge\\|[dk]\\)\\|e\\(?:addlm\\|m\\|place\\|shape\\|throw\\)\\|ound\\)\\|s\\(?:a\\(?:mple\\|ve\\(?:fig\\)?\\)\\|catter!\\|e\\(?:ed!\\|lect!?\\|riestype\\|tdiff\\)\\|h\\(?:ow\\|uffle\\)\\|ize\\(?:hint!\\)?\\|kipmissing\\|ort!?\\|parse\\|qrt\\|td\\|um\\|ymdiff\\)\\|t\\(?:hrow\\|i\\(?:edrank\\|me\\)\\|r\\(?:a\\(?:\\(?:c\\|nspos\\)e\\)\\)?\\|ype\\(?:m\\(?:ax\\|in\\)\\|name\\)\\)\\|uni\\(?:on\\|que\\)\\|v\\(?:a\\(?:lues\\|r\\)\\|cat\\|ec\\)\\|writedlm\\|zeros\\)\\_>" . font-lock-function-name-face)
;; font-lock-keyword-face)
   ("\\_<\\(Array\\|Cvoid\\|Float64\\|In\\(?:f\\(?:32\\)?\\|t\\(?:128\\|64\\)\\)\\|Matrix\\|NaN\\(?:32\\)?\\|Vector\\|abstract type\\|b\\(?:aremodule\\|egin\\|reak\\)\\|c\\(?:atch\\|on\\(?:st\\|tinue\\)\\)\\|d\\(?:ims\\|o\\)\\|e\\(?:lse\\(?:if\\)?\\|nd\\|xport\\)\\|f\\(?:alse\\|inally\\|or\\|unction\\)\\|global\\|i\\(?:mport\\|[fn]\\)\\|l\\(?:et\\|ocal\\)\\|m\\(?:acro\\|issing\\|odule\\|utable struct\\)\\|nothing\\|primitive type\\|quote\\|return\\|struct\\|tr\\(?:ue\\|y\\)\\|u\\(?:ndef\\|sing\\)\\|wh\\(?:\\(?:er\\|il\\)e\\)\\)\\_>" . font-lock-constant-face)))

(font-lock-add-keywords
 'julia-mode
 ;; '(("\\<\\(\\sw+\\) ?\\([_!.(]\\)" 1 'font-lock-function-name-face)))
 '(("\\<\\(\\sw+\\) ?\\([!(]\\)" 1 'font-lock-function-name-face)))

(font-lock-add-keywords
 'julia-ts-mode
 '(("\\<\\(\\(?:\\sw\\|\\s_\\)+\\)\\s-*\\(\\.\\)?("1 'font-lock-function-name-face)))

(provide 'julia-highlight)

;; ;; font-lock-keyword-face
;; (setq julia-keyword-regex-tmp
;;       (regexp-opt '("abs" "addprocs" "adjoint" "append!" "apropos" "Base.showerror" "Bernoulli" "Binomial" "BLAS.set_num_threads" "cat" "ccdf" "cd" "cdf" "ceil" "Chisq" "cholesky" "cld" "collect" "convert" "copy" "cor" "corspearman" "countmap" "CSV.read" "CSV.write" "DataFrame" "Date" "DateTime" "deepcopy" "deleteat!" "det" "dot" "eachline" "eachmatch" "ecdf" "eigvals" "eigvecs" "enumerate" "eps" "exit" "exp" "FDist" "fill" "fill!" "filter" "filter!" "find" "findall" "findfirst" "fit" "floor" "gcd" "h5read" "h5write" "haskey" "hcat" "histogram" "homedir" "Hypergeometric" "I" "include" "intersect" "inv" "isa" "isfinite" "ismissing" "isnan" "issubset" "kde" "keys" "lastindex" "layout" "legend" "length" "lm" "log" "map" "mapslices" "match" "max" "maximum" "mean" "median" "methods" "min" "minimum" "mod" "MvNormal" "Normal" "ones" "open" "parse" "params" "pdf" "pinv" "Pkg.add" "Pkg.build" "Pkg.installed" "Pkg.rm" "Pkg.status" "Pkg.update" "plot" "plot!" "pmap" "pop!" "popfirst!" "predict" "print" "println" "prod" "push!" "pushfirst!" "pvalue" "pwd" "quantile" "rand" "randexp" "randn" "Random.seed!" "randsubseq" "range" "rank" "readdlm" "rem" "replace" "reshape" "rethrow" "round" "sample" "save" "savefig" "scatter!" "seed!" "select" "select!" "seriestype" "setdiff" "show" "shuffle" "size" "sizehint!" "skipmissing" "sort" "sort!" "sparse" "SparseMatrixCSC" "SparseVector" "sqrt" "std" "sum" "symdiff" "TDist" "Threads.nthreads" "throw" "tiedrank" "time" "tr" "trace" "transpose" "typemax" "typemin" "typename" "union" "unique" "values" "var" "vcat" "vec" "writedlm" "zeros") 'symbols))

;; ;; font-lock-constant-face
;; (setq julia-constant-regex-tmp
;;       (regexp-opt '("true" "false" "Cvoid" "Inf" "NaN" "Inf32" "NaN32" "nothing" "undef" "missing" "Array" "dims" "Float64" "Int128" "Int64" "Matrix" "Vector" "in" "if" "else" "elseif" "while" "for" "begin" "end" "quote" "try" "catch" "return" "local" "function" "macro" "finally" "break" "continue" "global" "where" "module" "using" "import" "export" "const" "let" "do" "baremodule" "abstract type" "primitive type" "struct" "mutable struct") 'symbols))
