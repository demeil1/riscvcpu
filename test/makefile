test:
	iverilog -g2012 -o test ./*.sv $(shell ls ../src/*.sv | grep -v "top.sv")
clean:
	rm test
