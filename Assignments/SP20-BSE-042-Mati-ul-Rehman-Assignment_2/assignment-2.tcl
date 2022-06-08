set ns [new Simulator]

set nf [open output.nam w]

$ns namtrace-all $nf

#Creating nodes

set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]

set n3 [$ns node]

set n4 [$ns node]

set n5 [$ns node]

set n6 [$ns node]

set n7 [$ns node]

set n8 [$ns node]

set n9 [$ns node]

set n10 [$ns node]

set n11 [$ns node]

#Creating Connections

$ns duplex-link $n0 $n4 20Mb 10ms DropTail

$ns duplex-link $n1 $n4 20Mb 10ms DropTail

$ns duplex-link $n4 $n6 20Mb 10ms DropTail

$ns duplex-link $n4 $n5 20Mb 10ms DropTail

$ns duplex-link $n2 $n5 20Mb 10ms DropTail

$ns duplex-link $n3 $n5 20Mb 10ms DropTail

$ns duplex-link $n5 $n7 20Mb 10ms DropTail

$ns duplex-link $n7 $n10 20Mb 10ms DropTail

$ns duplex-link $n7 $n11 20Mb 10ms DropTail

$ns duplex-link $n7 $n6 20Mb 10ms DropTail

$ns duplex-link $n6 $n8 20Mb 10ms DropTail

$ns duplex-link $n6 $n9 20Mb 10ms DropTail

proc finish {} {

global ns nf

$ns flush-trace

close $nf

exec nam output.nam &

exit 0

}

$ns at 20.0 "finish"

$ns run



