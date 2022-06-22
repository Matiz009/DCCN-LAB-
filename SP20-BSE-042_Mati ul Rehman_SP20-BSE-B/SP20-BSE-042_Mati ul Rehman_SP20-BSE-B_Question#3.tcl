
set ns [new Simulator]
set nf [open o.nam w]
$ns namtrace-all $nf

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
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]

# creating links
$ns duplex-link $n0 $n1 5Mb 10ms RED
$ns duplex-link $n1 $n2 5Mb 10ms RED
$ns duplex-link $n2 $n3 5Mb 10ms RED
$ns duplex-link $n3 $n7 5Mb 10ms RED
$ns duplex-link $n7 $n11 5Mb 10ms RED
$ns duplex-link $n11 $n15 5Mb 10ms RED
$ns duplex-link $n15 $n14 5Mb 10ms RED
$ns duplex-link $n14 $n13 5Mb 10ms RED
$ns duplex-link $n13 $n12 5Mb 10ms RED
$ns duplex-link $n12 $n8 5Mb 10ms RED
$ns duplex-link $n8 $n4 5Mb 10ms RED
$ns duplex-link $n4 $n0 5Mb 10ms RED
$ns duplex-link $n0 $n5 5Mb 10ms RED
$ns duplex-link $n5 $n10 5Mb 10ms RED
$ns duplex-link $n10 $n15 5Mb 10ms RED
$ns duplex-link $n3 $n6 5Mb 10ms RED
$ns duplex-link $n6 $n9 5Mb 10ms RED
$ns duplex-link $n9 $n12 5Mb 10ms RED


set f0 [open out0.tr w]
set f1 [open out1.tr w]


set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
$ns attach-agent $n1 $tcp

set udp [new Agent/UDP]
$ns attach-agent $n2 $udp
$ns attach-agent $n3 $udp

#set ftp [new Application/FTP]
#$ftp attach-agent $tcp

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp
$cbr1 set packet_size_ 1000

set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $tcp
$cbr2 set packet_size_ 1000


set null1 [new Agent/TCPSink]
$ns attach-agent $n12 $null1

set null2 [new Agent/LossMonitor]
$ns attach-agent $n12 $null2

set null3 [new Agent/TCPSink]
$ns attach-agent $n13 $null3

set null4 [new Agent/LossMonitor]
$ns attach-agent $n13 $null4

set null5 [new Agent/TCPSink]
$ns attach-agent $n14 $null5

set null6 [new Agent/LossMonitor]
$ns attach-agent $n14 $null6

set null7 [new Agent/TCPSink]
$ns attach-agent $n15 $null7

set null8 [new Agent/LossMonitor]
$ns attach-agent $n15 $null8

$ns connect $tcp $null1
$ns connect $udp $null4

proc traffic {} {
	global null1 null2 null3 null4 f0 f1
	set ns [Simulator instance]
	set time 0.5
	set bw0 [$null1 set bytes_]
	set bw1 [$null2 set bytes_]
	set now [$ns now]
	puts $f0 "$now [expr $bw0/$time*8/1000000]"
	puts $f1 "$now [expr $bw1/$time*8/1000000]"
	$null1 set bytes_ 0
	$null2 set bytes_ 0
	$ns at [expr $time+$now] "traffic"
}

proc finish {} {
	global ns nf f0 f1 f2 f3
	$ns flush-trace
	close $nf
	close $f0
	close $f1
	exec nam o.nam &
	exec xgraph out0.tr out1.tr &
	exit 0
}

$ns at 0.0 "traffic"
$ns at 0.3 "$cbr1 start"
$ns at 19.0 "$cbr1 stop"
$ns at 0.5 "$cbr2 start"
$ns at 19.5 "$cbr2 stop"
$ns at 20.0 "finish"
$ns run
