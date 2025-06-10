all: g.g4
	antlr4 -Dlanguage=Python3 -no-listener -visitor g.g4

clean:
	rm -f *.interp *.tokens *Parser.py *Lexer.py *Visitor.py
	rm -rf __pycache__ .antlr
	rm -f ./tests/test_basic.txt ./tests/test_funcions.txt ./tests/test_OperacionsBooleans.txt ./tests/test_operadors.txt ./tests/test_vector.txt

test_basic:
	python3 g.py ./tests/test_basic.j > ./tests/test_basic.txt
	@if diff ./tests/test_basic.txt ./tests/test_basic.out; then \
		echo "test_basic: OK"; \
	else \
		echo "test_basic: FAIL"; \
	fi

test_funcions:
	python3 g.py ./tests/test_funcions.j > ./tests/test_funcions.txt
	@if diff ./tests/test_funcions.txt ./tests/test_funcions.out; then \
		echo "test_funcions: OK"; \
	else \
		echo "test_funcions: FAIL"; \
	fi

test_OperacionsBooleans:
	python3 g.py ./tests/test_OperacionsBooleans.j > ./tests/test_OperacionsBooleans.txt
	@if diff ./tests/test_OperacionsBooleans.txt ./tests/test_OperacionsBooleans.out; then \
		echo "test_OperacionsBooleans: OK"; \
	else \
		echo "test_OperacionsBooleans: FAIL"; \
	fi

test_operadors:
	python3 g.py ./tests/test_operadors.j > ./tests/test_operadors.txt
	@if diff ./tests/test_operadors.txt ./tests/test_operadors.out; then \
		echo "test_operadors: OK"; \
	else \
		echo "test_operadors: FAIL"; \
	fi

test_vector:
	python3 g.py ./tests/test_vector.j > ./tests/test_vector.txt
	@if diff ./tests/test_vector.txt ./tests/test_vector.out; then \
		echo "test_vector: OK"; \
	else \
		echo "test_vector: FAIL"; \
	fi

all_tests: test_basic test_funcions test_OperacionsBooleans test_operadors test_vector

.PHONY: all clean test_basic test_funcions test_OperacionsBooleans test_operadors test_vector all_tests quick_test