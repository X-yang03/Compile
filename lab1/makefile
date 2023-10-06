.PHONY:test,clean,work,expr,gcc
test:
	arm-linux-gnueabihf-gcc factorical.S -o example.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./example.out
clean:
	rm -fr example.out
work:
	qemu-arm -L /usr/arm-linux-gnueabihf ./example.out

expr:
	yacc expr1.y

gcc:
	gcc y.tab.c -o compute_expr
