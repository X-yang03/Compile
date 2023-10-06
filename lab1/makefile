.PHONY:test,clean,work
test:
	arm-linux-gnueabihf-gcc factorical.S -o example.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./example.out
clean:
	rm -fr example.out
work:
	qemu-arm -L /usr/arm-linux-gnueabihf ./example.out
