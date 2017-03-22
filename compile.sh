#!/bin/s
# Um compile top, aqui só para nós

echo "compiling..."
lex jac.l
yacc -d jac.y
cc -o jac lex.yy.c y.tab.c

if [ $? -eq 0 ]; then
  echo "running..."
  ./jac
  echo "zippin..."
  zip -r jac.zip jac.l
else
  echo "error compiling..."
  exit 1
fi
