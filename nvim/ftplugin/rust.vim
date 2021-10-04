set colorcolumn=100

autocmd BufWritePre *.rs execute ':RustFmt'
