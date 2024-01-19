"""cocotb tests"""

from decimal import Decimal
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_uart_loopback(dut):
    """Test that UART TX is following UART RX signal"""

    dut.i_uart_rx.value = 0
    await Timer(Decimal(1), units="ns")
    assert dut.o_uart_tx.value == 0, "o_uart_tx is not 0"
    assert dut.o_led_ready.value == 0, "o_led_ready is not 0"
    assert dut.o_led_done.value == 1, "o_led_done is not 1"

    dut.i_uart_rx.value = 1
    await Timer(Decimal(1), units="ns")
    assert dut.o_uart_tx.value == 1, "o_uart_tx is not 1"
    assert dut.o_led_ready.value == 0, "o_led_ready is not 0"
    assert dut.o_led_done.value == 0, "o_led_done is not 0"
