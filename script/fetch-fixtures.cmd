@echo off

if not exist tests\fixtures mkdir test\fixtures

call:fetch_grammar javascript master
call:fetch_grammar python     master

@if not exist tests\fixtures\tree-sitter-haskell (
  git clone https://github.com/lunixbochs/tree-sitter-haskell tests\fixtures\tree-sitter-haskell --depth=1
)

exit /B 0

:fetch_grammar
setlocal
set grammar_dir=tests\fixtures\tree-sitter-%~1
set grammar_url=https://github.com/tree-sitter/tree-sitter-%~1
set grammar_branch=%~2
@if not exist %grammar_dir% (
  git clone %grammar_url% %grammar_dir% --depth=1
)
pushd %grammar_dir%
git fetch origin %2 --depth=1
git reset --hard FETCH_HEAD
popd
exit /B 0
