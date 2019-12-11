ghdl -a *.vhd && ghdl -e test_bench && ghdl -r test_bench --vcd=test.vcd --stop-time=100ns && gtkwave test.vcd
