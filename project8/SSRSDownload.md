How to install 
1. MS SQL SERVER REPORT SERVICE
2. MS SQL SERVER INTEGRATION SERVICE
3. TRANSACT-SQL
   in one time ??

Step    Description
<br>1       Install MS SQL SERVER DEVELOPER EDITION (NEWEST - FREE) (BACK END)
<br>2       Install MS SQL SERVER MANAGEMENT STUDIO (NEWEST - FREE) (FRONT END)

<img width="380" alt="image" src="https://github.com/phdtrong/PortfolioProjects/assets/70780829/f7cea5e1-5cab-4412-9f77-751ebffa189c">

<br>3       From Start button, look for MS SQL SERVER INSTALLATION CENTER
<br>3.1.    Select tab Installation then select New SQL Standalone installation or add features to an existing installation=
<br>3.2.    Select tab Installation then select Install SQL Server Report Services
<br>3.3.    Select tab Installation then select Install SQL Server Management Tools (optional - if you did not do step 2 above)
<br>4.      Open Azure Data Studio and connect with your set sql server instance that is set in 3.1 and 3.2

<img width="853" alt="image" src="https://github.com/phdtrong/PortfolioProjects/assets/70780829/95602e59-ef7e-4282-a82d-d440152d4018">

<br>5.        install SQL Server Reporting Services https://www.microsoft.com/en-us/download/details.aspx?id=100122
<br>5.1.      configure report server in Report Server Configuration Manager
<br>5.2.      Configure Web Service URL. Click on Web Service URL link on the left and then click on Apply
<br>5.3.      Configure the Database: Click on the Database tab on the left, follow instructions to set up Report Server Database
<br>5.4.      Configure Web Portal URL – Click on the Web Portal URL and just click on Apply
<br>5.*.      At this point, the SSRS Configuration is complete and you can exit.
<br>6.        Connect to SSRS and Register a Report Server by
<br>6.1.      Open Management Studio. Goto View menu > select Registered Servers option > Select Reporting Service 

<img width="174" alt="image" src="https://github.com/phdtrong/PortfolioProjects/assets/70780829/cd76b6b4-f659-4062-a07d-c4a053e3583e">

<br>          Then under Local Server Groups, right click and select New Server Registration. Select correct report server that createdc in step 5 above. and then test/ apply that report server.
<br>6.2.      Back to tab Object Explorer, select Connect option, and sepect Server Type field by "Reporting Service"
<br>          Select Server Name as reporting server that register in step 5 above.
          
          <img width="355" alt="image" src="https://github.com/phdtrong/PortfolioProjects/assets/70780829/dce8e505-d4fb-4aff-b370-6f856686db9c">

<br>6.3.      See the report link, click to that to see the dashoard of the report server. its format should be 
            http://username/Reports/browse/
Work Cited:
# (1) install SQL SERVER 2022: SQLSERVER 101 @ https://youtu.be/WdvTb7YKi6Y?si=mhAuZMOQKD1vV5Ap
# (2) install SSRS: KINSON THE TECH PRO @ https://kindsonthegenius.com/mssql/
