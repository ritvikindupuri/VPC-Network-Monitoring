# AWS VPC Network Monitoring & Security Analytics

This project showcases the design, deployment, and monitoring of a robust multi-VPC cloud network on AWS. It demonstrates how to establish real-time network visibility and enhance security posture by leveraging core AWS services for traffic analysis and secure inter-VPC communication.

---
## Architectural Design & Monitoring Strategy

The foundation of this project is a dual-VPC network, connected via a secure VPC Peering connection. This architecture allows for resource segregation while enabling private communication between instances as if they were on the same network.

To achieve network visibility, **VPC Flow Logs** were enabled on both VPCs. All IP traffic metadata (source/destination IPs, ports, action, bytes transferred) was captured and streamed directly to **Amazon CloudWatch** for real-time analysis and long-term storage.

<img src="./assets/Architecture Diagram.jpg" width="800" alt="Dual VPC Architecture with CloudWatch Monitoring">
*<p align="center">Figure 1: The target architecture, showing two peered VPCs sending Flow Logs to CloudWatch.</p>*

---
## Implementation & Connectivity Validation

The architectural design was implemented in AWS, followed by rigorous testing to ensure the network was functioning correctly.

### VPC Peering & Routing
A VPC Peering connection was established between the two VPCs to link them. The route tables for the relevant subnets were then updated with routes pointing to the peer VPC's CIDR block, enabling traffic flow. The active peering connection below confirms the successful setup.

<img src="./assets/Active VPC peering connection.jpg" width="800" alt="VPC Peering Connection Details">
*<p align="center">Figure 2: The active and stable VPC Peering connection between the two VPCs.</p>*

### Connectivity Validation (Ping)
After configuring the peering and routes, a `ping` test was conducted between EC2 instances in each VPC. The successful ICMP replies confirmed that the network was properly configured and that instance-level security groups were permitting the cross-VPC traffic.

<img src="./assets/VPC Pairing Ping.jpg" width="800" alt="Successful ping between instances in peered VPCs">
*<p align="center">Figure 3: Successful ping validation between instances, confirming a working data plane.</p>*

---
## Security Analytics with CloudWatch Logs Insights

This is the core of the project, where raw network data is turned into actionable intelligence. Using CloudWatch Logs Insights, I queried the VPC Flow Logs to analyze traffic patterns and identify potential security events.

### Analyzing Network Data Transfer
To understand network behavior and identify top talkers, I wrote a query to aggregate the total bytes transferred between source and destination IP addresses. This analysis, which processed **454 records in under a second**, quickly highlighted significant data flows, including one transfer of **25,569 bytes**.

<img src="./assets/Cloudwatchj Log - Top byte trasnfer.jpg" width="800" alt="CloudWatch query for data transfer analysis">
*<p align="center">Figure 4: Identifying top data transfers between network endpoints.</p>*

### Proactive Threat Detection
To enhance the security posture, I developed a query to specifically hunt for rejected traffic, which can indicate misconfigured applications or malicious scanning activity. This query, which scanned **541 records**, instantly identified a single source IP responsible for **17 rejected connections**, flagging it for further investigation.

<img src="./assets/CloudWatch Logs Insights - Rejected Connections.jpg" width="800" alt="CloudWatch query for rejected connections">
*<p align="center">Figure 5: Detecting and counting REJECT events to identify potential threats.</p>*

---
## 🚀 Skills Demonstrated

* **AWS VPC Peering:** Designing and implementing secure, private connectivity between VPCs.
* **VPC Flow Logs:** Enabling and managing real-time network traffic logging for security and operational insights.
* **CloudWatch Logs Insights:** Writing custom queries to perform deep analysis, identify anomalies, and generate security intelligence from raw log data.
* **Network Security Monitoring:** Proactively monitoring network traffic for indicators of compromise or misconfigurations.
* **Data Analysis:** Interpreting network flow data to understand traffic patterns and quantify data transfer.
* **AWS Networking:** Foundational knowledge of VPCs, Subnets, Route Tables, and Security Groups.
