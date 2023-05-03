if exists('*GolangCILint')
	finish
end

function! GolangCILint()
	cexpr []

	" Run only the typecheck first.
	let l:errors = system("golangci-lint run --no-config --disable-all -E typecheck --out-format line-number --print-issued-lines=false")

	if l:errors == ""
		let l:errors = system("golangci-lint run --out-format line-number --print-issued-lines=false")
	endif

	if l:errors == ""
		echo "GolangCILint: OK!"
	else
		cexpr l:errors
		copen
	endif
endfunction

command! GolangCILint :call GolangCILint()
