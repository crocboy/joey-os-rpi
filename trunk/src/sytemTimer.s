/*
* Get the address of the timer
*/
.globl GetSystemTimerBase
GetSystemTimerBase: 
ldr r0,=0x20003000
mov pc,lr

/*
* Get the current timestamp
*/
.globl GetTimeStamp
GetTimeStamp:
push {lr}
bl GetSystemTimerBase
ldrd r0,r1,[r0,#4]
pop {pc}

/*
* Sleep for x microseconds 
*/
.globl SLEEP
SLEEP:
push {lr}
delay .req r2
mov delay,r0
bl GetTimeStamp
start .req r3
mov start,r0
loop$:
	bl GetTimeStamp
	elapsed .req r1
	sub elapsed,r0,start
	cmp elapsed,delay
	bls loop$
.unreq start
.unreq delay
pop {pc}

	

