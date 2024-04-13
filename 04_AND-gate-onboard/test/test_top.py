"""cocotb tests"""

from decimal import Decimal
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_led_state(dut):
    """Test that DONE LED state is AND function of S1 and S2 switches"""

    dut.i_sw_s1.value = 0
    dut.i_sw_s2.value = 0
    await Timer(Decimal(1), units="ns")
    assert dut.o_led_done.value == 0, "o_led_done is not 0 for inputs [0,0]"

    dut.i_sw_s1.value = 1
    dut.i_sw_s2.value = 0
    await Timer(Decimal(1), units="ns")
    assert dut.o_led_done.value == 0, "o_led_done is not 0 for inputs [1,0]"

    dut.i_sw_s1.value = 0
    dut.i_sw_s2.value = 1
    await Timer(Decimal(1), units="ns")
    assert dut.o_led_done.value == 0, "o_led_done is not 0 for inputs [0,1]"

    dut.i_sw_s1.value = 1
    dut.i_sw_s2.value = 1
    await Timer(Decimal(1), units="ns")
    assert dut.o_led_done.value == 1, "o_led_done is not 1 for inputs [1,1]"
