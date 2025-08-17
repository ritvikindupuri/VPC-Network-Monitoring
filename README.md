# Dual-VPC Cloud Architecture with Real-Time Traffic Analysis

## 📌 Overview

This project demonstrates the design, implementation, and validation of a **dual-VPC architecture** with secure **VPC peering** and **real-time network monitoring** using AWS-native tools. The goal was to establish secure connectivity between isolated cloud networks and gain **deep visibility into inter-VPC traffic behavior** using **VPC Flow Logs** and **CloudWatch Logs Insights**.

---

## 🎯 Objectives

- Design and deploy two independent VPCs with secure routing and peering
- Enable and analyze VPC Flow Logs across both VPCs
- Detect rejected connections and traffic anomalies using CloudWatch Logs Insights
- Validate inter-VPC communication with real EC2 traffic (e.g., ICMP ping)
- Strengthen cloud security posture through log-based insights

---

## 🧱 Architecture Summary

- **VPC 1 (10.1.0.0/16)**: Public EC2 instances generating traffic  
- **VPC 2 (10.2.0.0/16)**: Receives and logs traffic  
- **VPC Peering**: Secure routing and interconnectivity  
- **Flow Logs**: Enabled at VPC level and pushed to CloudWatch  
- **CloudWatch Logs Insights**: Used to identify traffic patterns, rejections, and anomalies

---

## 📊 Architecture Diagram

<img width="1204" height="1280" alt="image" src="https://github.com/user-attachments/assets/c5619a87-2afb-41d1-a267-5b40901a1eb8" />

**Figure 1:** Dual VPCs connected via peering with Flow Logs streaming to CloudWatch for real-time analysis

---

## 🧾 Full Technical Documentation

Full implementation steps, log analysis examples, CloudWatch query logic, and screenshots are available in [`Technical_Report.pdf`](link-to-your-uploaded-pdf).

---

## 👨‍💻 Author

**Ritvik Indupuri**  
Cloud Security & Network Visibility Engineer  
_Focused on infrastructure hardening, threat detection, and secure network architecture_
