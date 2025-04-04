#! /bin/bash

rm -rf ./work
vlib ./work

vcom -reportprogress 300 -work work ALU.vhd
vcom -reportprogress 300 -work work Hex.vhd
vcom -reportprogress 300 -work work InstractionMemory.vhd
vcom -reportprogress 300 -work work Processor.vhd
vcom -reportprogress 300 -work work ProgramCounter.vhd
vcom -reportprogress 300 -work work Reg.vhd
vcom -reportprogress 300 -work work SimProcessor.vhd

vsim -gui -keepstdout work.SimProcessor -t 10ps -do "
add wave -r /*
run -all
quit -f
"
