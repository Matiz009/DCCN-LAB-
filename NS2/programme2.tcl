set ns [new Simulator]

set nf [open o.nam w]

$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 20Mb 10ms DropTail

$ns duplex-link $n1 $n2 20Mb 10ms DropTail

$ns duplex-link $n2 $n3 20Mb 10ms DropTail

proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam o.nam &
    exit 0
}

$ns at 20.0 "finish"
$ns run