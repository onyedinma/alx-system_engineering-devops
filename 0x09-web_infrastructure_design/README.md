**0-simple_web_stack**

A server is a computer program or hardware that provides functionality for other programs or devices, called clients. In this case, the server will be hosting a website that is reachable via www.foobar.com. The domain name is a unique identifier for the website and is used to locate the server hosting the website. The domain name is resolved to an IP address using DNS (Domain Name System) records. The www record is a type of DNS record that specifies the hostname of the server that is hosting the website.

The web server is responsible for serving web pages to clients that request them. In this case, we will use Nginx as the web server. The application server is responsible for running the application code that generates the web pages. We will use a Python Flask application running on Gunicorn as the application server. The application files will contain the code for the Flask application. The database will store the data that the application needs to serve the web pages. We will use MySQL as the database.

When a user requests the website, their computer sends a request to the server using HTTP (Hypertext Transfer Protocol). The server responds to the request by sending the appropriate web page back to the user’s computer using HTTP.

There are some issues with this infrastructure. First, it is a single point of failure (SPOF). If the server goes down, the website will be unavailable. Second, there will be downtime when maintenance is needed, such as when deploying new code and the web server needs to be restarted. Finally, this infrastructure cannot scale if there is too much incoming traffic. To address these issues, we could add more servers and use a load balancer to distribute the traffic between them. We could also use a CDN (Content Delivery Network) to cache the web pages and reduce the load on the server.

In bullet Points


- Server: 
  - A server is a computer program or hardware that provides functionality for other programs or devices, called clients. 
  - In this case, the server will be hosting a website reachable via www.foobar.com.

- Domain Name and DNS:
  - The domain name is a unique identifier for the website used to locate the server hosting the website.
  - It's resolved to an IP address using DNS (Domain Name System) records.
  - The "www" record is a specific DNS record specifying the hostname of the server hosting the website.

- Server Components:
  - The web server (Nginx) serves web pages to requesting clients.
  - The application server (Python Flask application running on Gunicorn) executes application code to generate web pages.
  - Application files contain the codebase for the Flask application.
  - MySQL is used as the database to store necessary data for serving web pages.

- User Request and Communication:
  - When a user requests the website, their computer sends a request to the server using HTTP (Hypertext Transfer Protocol).
  - The server responds by sending the appropriate web page back to the user's computer using HTTP.

- Issues with the Infrastructure:
  - It's a single point of failure (SPOF). If the server goes down, the website becomes unavailable.
  - There's downtime during maintenance, such as when deploying new code and restarting the web server.
  - Inability to scale during high traffic periods.

- Improving Infrastructure:
  - Solutions could involve adding more servers and implementing a load balancer to distribute traffic.
  - A CDN (Content Delivery Network) could be used to cache web pages, reducing the load on the server.



---- PlantUML Code to generate Graphics ----

@startuml
actor User
boundary "User's Device" as userDevice

cloud {
    database "Database (MySQL)" as database
    rectangle "Internet" as internet
}

node "Server (8.8.8.8)" {
    rectangle "OS: Linux" as osRect
    rectangle "Web Server: Nginx" as nginxRect
    rectangle "Application Server" as appServerRect
    rectangle "Application Codebase" as codebaseRect
}

User --> userDevice: Access www.foobar.com
userDevice --> internet: Send request
internet --> Server: Receive request

osRect --> nginxRect: HTTP Request
nginxRect --> appServerRect: Forward dynamic content
appServerRect --> database: Retrieve data
appServerRect <-- nginxRect: Return dynamic content
osRect --> internet: Serve www.foobar.com
internet --> userDevice: Return webpage
@enduml


-----------------------------------------------------------------------------------------------------------------------------------------------------------

**1-distributed_web_infrastructure**

Here are some specifics about this infrastructure:

We have added two servers to ensure redundancy and high availability.
Nginx is used as the web server to serve web pages to clients that request them.
MySQL is used as the database to store the data that the application needs to serve the web pages.
Python Flask is used as the application server to run the application code that generates the web pages.
HAproxy is used as the load balancer to distribute incoming network traffic across multiple backend servers in a server pool. It is configured with a round-robin algorithm that distributes client requests or network load efficiently across multiple servers.
The load-balancer is enabling an Active-Passive setup. In this setup, one server is active and serving traffic while the other server is passive and only becomes active when the active server fails.
In a Primary-Replica (Master-Slave) cluster, the primary node receives all write operations while the replica nodes receive the updates from the primary node and replicate them. The primary node is responsible for logging the updates, which then ripple through to the replica nodes. The replica nodes are used to provide redundancy and high availability. The primary node is responsible for executing the application code while the replica nodes are used for read-only operations.
The issues with this infrastructure are:
Single point of failure (SPOF) in case of server failure.
Security issues such as no firewall and no HTTPS.
No monitoring to detect and resolve issues proactively.


---- PlantUML Code to generate Graphics ----

@startuml
title Three Server Web Infrastructure for www.foobar.com

actor User
boundary "User's Device" as userDevice

cloud {
    database "Database (MySQL)" as database
    rectangle "Internet" as internet
}

node "Server 1 (8.8.8.8)" {
    rectangle "OS: Linux" as osRect1
    rectangle "Web Server: Nginx" as nginxRect1
    rectangle "Application Server" as appServerRect1
    rectangle "Application Codebase" as codebaseRect1
}

node "Server 2 (8.8.8.9)" {
    rectangle "OS: Linux" as osRect2
    rectangle "Web Server: Nginx" as nginxRect2
    rectangle "Application Server" as appServerRect2
    rectangle "Application Codebase" as codebaseRect2
}

node "Load Balancer (8.8.8.10)" {
    rectangle "HAproxy" as haproxyRect
}

User --> userDevice: Access www.foobar.com
userDevice --> internet: Send request
internet --> LoadBalancer: Receive request

LoadBalancer --> osRect1: Forward request
LoadBalancer --> osRect2: Forward request

osRect1 --> nginxRect1: HTTP Request
nginxRect1 --> appServerRect1: Forward dynamic content
appServerRect1 --> database: Retrieve data
appServerRect1 <-- nginxRect1: Return dynamic content
osRect1 --> LoadBalancer: Serve www.foobar.com

osRect2 --> nginxRect2: HTTP Request
nginxRect2 --> appServerRect2: Forward dynamic content
appServerRect2 --> database: Retrieve data
appServerRect2 <-- nginxRect2: Return dynamic content
osRect2 --> LoadBalancer: Serve www.foobar.com

LoadBalancer --> internet: Serve www.foobar.com
internet --> userDevice: Return webpage
@enduml



-------------------------------------------------------------------------------------------------------------------------------------------------------------------

**2-secured_and_monitored_web_infrastructure**

Here are some specifics about this infrastructure:

We have added three firewalls to secure the traffic.
An SSL certificate is used to serve www.foobar.com over HTTPS to encrypt the traffic.
Three monitoring clients are used to collect data for Sumologic or other monitoring services.
Firewalls are used to protect the network from unauthorized access and to monitor incoming and outgoing traffic.
HTTPS is used to encrypt the traffic between the user’s device and the web server to ensure that the data is secure.
Monitoring is used to detect and resolve issues proactively and to ensure that the web infrastructure is performing optimally.
The monitoring tool collects data by analyzing logs, metrics, and other data sources to identify issues and trends.
To monitor the web server QPS, you can use a monitoring tool that collects data on the number of queries per second and other metrics. This data can be used to identify performance issues and to optimize the web server for better performance.
The issues with this infrastructure are:

Terminating SSL at the load balancer level is an issue because it leaves the app servers vulnerable to packet sniffing or ARP poisoning.
Having only one MySQL server capable of accepting writes is an issue because it creates a single point of failure.
Having servers with all the same components (database, web server, and application server) might be a problem because it creates a single point of failure and reduces redundancy.


---- PlantUML Code to generate Graphics ----

@startuml
title Three Server Web Infrastructure for www.foobar.com

actor User
boundary "User's Device" as userDevice

cloud {
    database "Database (MySQL)" as database
    rectangle "Internet" as internet
}

node "Server 1 (8.8.8.8)" {
    rectangle "OS: Linux" as osRect1
    rectangle "Web Server: Nginx" as nginxRect1
    rectangle "Application Server" as appServerRect1
    rectangle "Application Codebase" as codebaseRect1
}

node "Server 2 (8.8.8.9)" {
    rectangle "OS: Linux" as osRect2
    rectangle "Web Server: Nginx" as nginxRect2
    rectangle "Application Server" as appServerRect2
    rectangle "Application Codebase" as codebaseRect2
}

node "Load Balancer (8.8.8.10)" {
    rectangle "HAproxy" as haproxyRect
}

node "Firewall 1" as firewall1
node "Firewall 2" as firewall2
node "Firewall 3" as firewall3

User --> userDevice: Access www.foobar.com
userDevice --> internet: Send request
internet --> LoadBalancer: Receive request

LoadBalancer --> osRect1: Forward request
LoadBalancer --> osRect2: Forward request

osRect1 --> nginxRect1: HTTPS Request
nginxRect1 --> appServerRect1: Forward dynamic content
appServerRect1 --> database: Retrieve data
appServerRect1 <-- nginxRect1: Return dynamic content
osRect1 --> LoadBalancer: Serve www.foobar.com

osRect2 --> nginxRect2: HTTPS Request
nginxRect2 --> appServerRect2: Forward dynamic content
appServerRect2 --> database: Retrieve data
appServerRect2 <-- nginxRect2: Return dynamic content
osRect2 --> LoadBalancer: Serve www.foobar.com

LoadBalancer --> internet: Serve www.foobar.com
internet --> userDevice: Return webpage

firewall1 --> osRect1: Secure traffic
firewall2 --> osRect2: Secure traffic
firewall3 --> LoadBalancer: Secure traffic

@enduml



-------------------------------------------------------------------------------------------------------------------------------------------------------------------

**3-scale_up**

Here are some specifics about this infrastructure:

We have added two more servers to ensure redundancy and high availability.
Nginx is used as the web server to serve web pages to clients that request them.
MySQL is used as the database to store the data that the application needs to serve the web pages.
Python Flask is used as the application server to run the application code that generates the web pages.
HAproxy is used as the load balancer to distribute incoming network traffic across multiple backend servers in a server pool. It is configured as a cluster with the other load balancer to ensure high availability.
The web server, application server, and database are split into their own servers to ensure that each component has its own resources and can be scaled independently.

---- PlantUML Code to generate Graphics ----

@startuml
title Web Infrastructure for www.foobar.com

actor User
boundary "User's Device" as userDevice

cloud {
    database "Database (MySQL)" as database
    rectangle "Internet" as internet
}

node "Server 1 (8.8.8.8)" {
    rectangle "OS: Linux" as osRect1
    rectangle "Web Server: Nginx" as nginxRect1
}

node "Server 2 (8.8.8.9)" {
    rectangle "OS: Linux" as osRect2
    rectangle "Application Server" as appServerRect2
}

node "Server 3 (8.8.8.10)" {
    rectangle "OS: Linux" as osRect3
    rectangle "Database Server" as dbServerRect3
    rectangle "Database: MySQL" as dbRect3
}

node "Load Balancer (8.8.8.11)" {
    rectangle "HAproxy" as haproxyRect
}

User --> userDevice: Access www.foobar.com
userDevice --> internet: Send request
internet --> LoadBalancer: Receive request

LoadBalancer --> osRect1: Forward request
LoadBalancer --> osRect2: Forward request

osRect1 --> nginxRect1: HTTP Request
nginxRect1 --> haproxyRect: Forward dynamic content
haproxyRect --> osRect2: Forward dynamic content
osRect2 --> appServerRect2: Generate dynamic content
appServerRect2 --> haproxyRect: Return dynamic content
haproxyRect --> nginxRect1: Return dynamic content
osRect1 --> internet: Serve www.foobar.com
internet --> userDevice: Return webpage

osRect2 --> dbRect3: Retrieve data
dbRect3 --> appServerRect2: Return data

@enduml







