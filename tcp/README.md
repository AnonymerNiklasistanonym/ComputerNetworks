**Wireshark filter**: `tcp.port == 5000` (because the interaction happens on PORT 5000 [server])

```sh
python -m server
# ---------------
python -m client
```

In this example the client is on the port: `55106` (as can be seen in the Info column of the first entry `55106 → 5000`)

| Description                    | No.  | Time      | Source    | Destination | Info                                                         |
| ------------------------------ | ---- | --------- | --------- | ----------- | ------------------------------------------------------------ |
| 🔹 Client initiates connection  | 2782 | 11.931374 | 127.0.0.1 | 127.0.0.1   | 55106 → 5000 `[SYN]` Seq=0 Win=65495 Len=0 MSS=65495 SACK_PERM WS=128 |
| 🔹 Server responds with SYN-ACK | 2783 | 11.931383 | 127.0.0.1 | 127.0.0.1   | 5000 → 55106 `[SYN, ACK]` Seq=0 Ack=1 Win=65483 Len=0 MSS=65495 SACK_PERM WS=128 |
| ✅ Client acknowledges          | 2784 | 11.931390 | 127.0.0.1 | 127.0.0.1   | 55106 → 5000 `[ACK]` Seq=1 Ack=1 Win=65536 Len=0             |
| 📤 Client sends data            | 2785 | 11.931411 | 127.0.0.1 | 127.0.0.1   | 55106 → 5000 `[PSH, ACK]` Seq=1 Ack=1 Win=65536 Len=14       |
| ✅ Server acknowledges data     | 2786 | 11.931414 | 127.0.0.1 | 127.0.0.1   | 5000 → 55106 `[ACK]` Seq=1 Ack=15 Win=65536 Len=0            |
| 🛑 Client initiates close       | 2790 | 13.931510 | 127.0.0.1 | 127.0.0.1   | 55106 → 5000 `[FIN, ACK]` Seq=15 Ack=1 Win=65536 Len=0       |
| 🛑 Server replies with FIN, ACK | 2791 | 13.937684 | 127.0.0.1 | 127.0.0.1   | 5000 → 55106 `[FIN, ACK]` Seq=1 Ack=16 Win=65536 Len=0       |
| ✅ Client acknowledges close    | 2792 | 13.937694 | 127.0.0.1 | 127.0.0.1   | 55106 → 5000 `[ACK]` Seq=16 Ack=2 Win=65536 Len=0            |

![](tcp_exchange_localhost.svg)

```sh
ip -4 addr show | grep inet
#    ...
#    inet 192.168.2.184/24 ...
# ------------------------------
python -m server 192.168.2.184
# ------------------------------
python -m client 192.168.2.184
```

When using the private IP Address ( `192.168.2.184`) everything is the same besides the source and destination (and the client port is now `46482`):

| Description                                 | No.  | Time      | Source        | Destination   | Info                                                         |
| ------------------------------------------- | ---- | --------- | ------------- | ------------- | ------------------------------------------------------------ |
| 🔹 Client initiates connection (private IP)  | 3234 | 20.231832 | 192.168.2.184 | 192.168.2.184 | 46482 → 5000 `[SYN]` Seq=0 Win=65495 Len=0 MSS=65495 SACK\_PERM WS=128 |
| 🔹 Server responds with SYN-ACK (private IP) | 3235 | 20.231839 | 5000          | 46482         | 5000 → 46482 `[SYN, ACK]` Seq=0 Ack=1 Win=65483 Len=0 MSS=65495 SACK\_PERM WS=128 |
| ✅ Client acknowledges                       | 3236 | 20.231847 | 192.168.2.184 | 5000          | 46482 → 5000 `[ACK]` Seq=1 Ack=1 Win=65536 Len=0             |
| 📤 Client sends data                         | 3237 | 20.231867 | 192.168.2.184 | 5000          | 46482 → 5000 `[PSH, ACK]` Seq=1 Ack=1 Win=65536 Len=14       |
| ✅ Server acknowledges data                  | 3238 | 20.231871 | 5000          | 46482         | 5000 → 46482 `[ACK]` Seq=1 Ack=15 Win=65536 Len=0            |
| 🛑 Client initiates close                    | 3239 | 20.231880 | 192.168.2.184 | 5000          | 46482 → 5000 `[FIN, ACK]` Seq=15 Ack=1 Win=65536 Len=0       |
| 🛑 Server replies with FIN, ACK              | 3240 | 20.238755 | 5000          | 46482         | 5000 → 46482 `[FIN, ACK]` Seq=1 Ack=16 Win=65536 Len=0       |
| ✅ Client acknowledges close                 | 3241 | 20.238763 | 192.168.2.184 | 5000          | 46482 → 5000 `[ACK]` Seq=16 Ack=2 Win=65536 Len=0            |
