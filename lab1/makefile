.PHONY:test,clean,work,expr,gcc,fibonacci
test:
	arm-linux-gnueabihf-gcc factorial.S -o example.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./example.out
clean:
	rm -fr example.out
work:
	qemu-arm -L /usr/arm-linux-gnueabihf ./example.out

expr:
	yacc expr1.y

gcc:
	gcc y.tab.c -o compute_expr

fibonacci:
	arm-linux-gnueabihf-gcc fibonacci.S -o example.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./example.out
