# -----------------------------------------------------------------
# Query 1: Analyze Network Data Transfer (Top Talkers by Bytes)
# -----------------------------------------------------------------
# This query aggregates the total bytes transferred between source and
# destination IPs to find the most significant data flows.

stats sum(bytes) as bytesTransferred by srcAddr, dstAddr
| sort bytesTransferred desc
| limit 20

# -----------------------------------------------------------------
# Query 2: Proactive Threat Detection (Rejected Connections)
# -----------------------------------------------------------------
# This query filters for all 'REJECT' actions in the flow logs and
# counts how many rejections came from each source IP. It is used
# to identify potential scanners or misconfigured clients.

filter action='REJECT'
| stats count(*) as numRejections by srcAddr
| sort numRejections desc
| limit 20
