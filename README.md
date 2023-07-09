# Data acquisition with DAS240 and EA 9200U

Work presented at ENSEIRB-MATMECA in the Institut National Polytechinique de Bordeaux as a second-year internship, carried out at the Laboratoire de l’Intégration du Matériau au Système (IMS) and Institut de mécanique et d’ingénierie (I2M).

Author: Lucas Furlan
Supervisors: Stéphane Victor, Jean-Luc Battaglia and Andrzej Kusiak.

## Introduction

This is a labVIEW program that was designed to control the input and data acquisition applied to a thermal system. It uses a high efficiency power supply from the EA-PSI 9200-25 series and a Sefram DAS 240 data logger. Communication with the first one is done using the Modbus USB protocol and the second uses the Modbus TCP-IP. As part of the implementation of this interface, it is important to note that a common ethernet cable **cannot be used**: you need a crossover ethernet cable or a switch (which was used).

## Drivers and Packages

The `code` directory contains all the labVIEW files for using the program. It is absolutely necessary to download and install the drivers and packages to communicate with the two machines. For instance, the following procedure must be followed:

1. Run the PSI9000 2U USB driver installer available at the link "https://elektroautomatik.com/shop/en/service/downloads/ps-9000-t1u2u3u/". You have to choose the right version of the power supply.
2. Download the labVIEW package for the source available in the website "https://elektroautomatik.com/shop/en/service/downloads/labVIEW/". Copy and paste the IF-XX folder with all its files into the labVIEW packages folder. Normally, it is located in the same folder that labVIEW was installed, for example: `C:Programs(x86)\NationalInstruments\labview (version)\instr.lib`. Warning, **do not create another folder**.
3. Download the labVIEW package for the DAS240, available at << http://sine.ni.com/apps/utf8/niid_web_display.download_page?p_id_guid=61E0FD2D0F9757F5E05400144FF8B3F6 >>. In the same way as before, copy and paste the folder with the package into `\instr.lib`. Warning, **do not create another folder**.
4. Download and run the NVISA package installer, available at << https://www.ni.com/fr-fr/support/downloads/drivers/download.ni-visa.html#480875 >>. It will allow you to use the TCP/IP connection tools available for labVIEW. It is always possible to do it offline. It is also remarkable that it is necessary to choose a version compatible with the package labVIEW of the preceding item.
5. Download and install the *Sefram Viewer*, available at the link << https://www.sefram.com/en/software-updates.html >>.

Once everything is done and installed, there remains the configuration of the DAS240.

## DAS240 Setup

Open the NI MAX and go to "Create TCP/IP Resource". Choose manual entry of address and gate and enter those of the DAS240.

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/NIMAX.png)

The address can be changed in the device's *setup* menu and the port will always be 23. Normally it will use the *Dynamic Host Configuration Protocol* (DHCP), which is a client/server protocol that automatically provides an Internet Protocol (IP) address. It is therefore recommended to fix the address to avoid future problems with the VISA configuration process.

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/TCPIP.bmp)

Click on << finish >> and verify that the entity has been created. After, go to << open VISA panel >>. The same panel is also accessible in NI-VISA Iteractive control, in the initial menu. In this panel, it will be possible to already order the data acquisition: choose the command << *IDN?\n >> and click on << query >>. If everything has been configured correctly, the DAS240 will send its coordinates which we can see on the screen.

## Using the software

Once the program is going to be executed, the user should see the front face of the VI on the screen. It consists of a data generation part on the left and a data acquisition part on the right. First of all, you have to set up the connection with the power supply: in the field << Desired machine number >> you have to enter the serial number of the connected machine. If you don't know the serial number, you have to run the code once (with other parameters not set) and note the third column that appears in "Machines found".

![Alt text](https://github.com/FurlanLucas/Data-acquisition-with-DAS240-and-EA-9200U/blob/main/fig/mainVIp_markedS.png)

The generation of pseudo random data (PRBS) can be done either with labVIEW itself, by specifying the frequency and amplitude values, or with the reading of a