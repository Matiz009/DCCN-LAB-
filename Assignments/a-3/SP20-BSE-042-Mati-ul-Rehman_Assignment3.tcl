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

#Creating Connections

$ns duplex-link $n0 $n3 20Mb 10ms DropTail
$ns duplex-link $n1 $n3 20Mb 10ms DropTail
$ns duplex-link $n2 $n3 20Mb 10ms DropTail
$ns duplex-link $n3 $n4 20Mb 10ms DropTail
$ns duplex-link $n4 $n5 20Mb 10ms DropTail
$ns duplex-link $n4 $n6 20Mb 10ms DropTail
$ns duplex-link $n4 $n7 20Mb 10ms DropTail

#Creating protocols

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
$ns attach-agent $n1 $tcp


set udp [new Agent/UDP]
$ns attach-agent $n2 $udp


#creating ftp
set ftp [new Application/FTP]
$ftp attach-agent $udp

#using cbr
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $tcp
$cbr set packet_size_ 1000

#creating null(destination)

set null1 [new Agent/LossMonitor]
$ns attach-agent $n6 $null1


#connecting

$ns connect $tcp $null1
$ns connect $udp $null1






proc finish {} {
   global ns nf
   $ns flush-trace
   close $nf
   exec nam output.nam &
   exit 0

}

$ns at 0.1 "$ftp start"
$ns at 19.0 "$ftp stop"
$ns at 0.3 "$cbr start"
$ns at 19.5 "cbr stop"

$ns at 20.0 "finish"
$ns run


