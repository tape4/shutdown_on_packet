# Shutdown on Packet Setup Script

This project provides a script to set up a C program that listens on UDP port 3333. When the program receives any packet, it shuts down the system. The script compiles the C program, installs it as an executable, and configures it to run automatically at system startup using `systemd`.

---

## Prerequisites

-   Linux-based system (e.g., Ubuntu)
-   `gcc` installed for compiling the C program
-   `systemd` (pre-installed on most Linux distributions)
-   Root privileges to install and configure the service

---

## Files

-   `shutdown_on_packet.c`: The C program file that listens for UDP packets.
-   `setup_shutdown_on_packet.sh`: The script that automates the setup process.

---

## Installation and Usage

1. **Clone or Download the Repository**
   Ensure you have both `shutdown_on_packet.c` and `setup_shutdown_on_packet.sh` in the same directory.

2. **Grant Execute Permission**
   Make the setup script executable:
    ```bash
    chmod +x setup_shutdown_on_packet.sh
    ```
3. **Run the Script**
    ```bash
    sudo ./setup_shutdown_on_packet.sh
    ```
