#include <stdio.h>
#include <stdlib.h>
#include "Vtop.h"
#include "verilated.h"

int main(int argc, char **argv)
{

	// Prevent unused variable warnings
	if (false && argc && argv)
	{
	}

	// Create logs/ directory in case we have traces to put under it
	Verilated::mkdir("logs");

	const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
	contextp->debug(0);
	contextp->traceEverOn(true);
	contextp->commandArgs(argc, argv);

	const std::unique_ptr<Vtop> top{new Vtop{contextp.get(), "TOP"}};

	top->i_sw_s1 = 0;
	int counter = 0;
	while (!contextp->gotFinish())
	{
		contextp->timeInc(1);
		top->i_sw_s1 = !top->i_sw_s1;
		top->i_sw_s2 = top->i_sw_s1;
		top->eval();

		VL_PRINTF("[%" PRId64 "] sw_s1=%x -> led_ready=%x; sw_s2=%x -> led_done=%x\n",
				  contextp->time(), top->i_sw_s1, top->o_led_ready,
				  top->i_sw_s2, top->o_led_done);
		counter++;
		if (counter > 20)
			break;
	}
	top->final();

	// Coverage analysis (calling write only after the test is known to pass)
#if VM_COVERAGE
	Verilated::mkdir("logs");
	contextp->coveragep()->write("logs/coverage.dat");
#endif

	return 0;
}
