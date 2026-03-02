
<img width="1920" height="1080" alt="Architecture" src="https://github.com/user-attachments/assets/f8989bcf-3be3-4a8f-9d56-4f0e061e4683" />



# **Three-Tier Architecture Project Steps**

## **🖼️ Architecture Diagram**

---

## **1. Create a VPC**

---

## **2. Create 6 Subnets**

* 2 Subnets for **Web Server**
* 2 Subnets for **App Server**
* 2 Subnets for **Database**

---

## **3. Create Route Tables**

**Public Route Table**

* Connects with Internet Gateway
* Associate with **2 public subnets**

**Private Route Table**

* Create private route table for each subnet
* Map **NAT Gateway from each Availability Zone** for High Availability

**No NAT for Database**

* Optional: If database patching required
* Map NAT Gateway to Database Route Table

---

## **4. Create Security Groups**

**WebServer-SG**

* Allow SSH (ALL)
* Allow HTTP (ALL)
* Allow HTTPS (ALL)

**AppServer-SG**

* Allow Port 5000 from WebServer-SG
* Allow SSH from WebServer-SG
* Allow 80 from WebServer-SG
* Allow 443 from WebServer-SG

**DB-SG**

* Allow 3306 from AppServer-SG

### **🧪 Task**

➡️ Instead of three Security Groups, **create five Security Groups**

---

## **5. Create Route 53 Hosted Zone**

* Create Hosted Zone for your domain
* Map R53 Name Servers with your Domain Provider

---

## **6. Validate ACM with Route 53**

* Request certificate for domain
* Create **CNAME record** in R53
* Validate domain ownership

---

## **7. Create RDS**

* Create **DB Subnet Group** (minimum 2 subnets)
* Create **MySQL RDS** in private subnet
* Attach **DB-SG**

---

## **8. Create Web Server EC2**

* Launch EC2 in **public subnet**
* Attach **WebServer-SG**

---

## **9. Create App Server EC2**

* Launch EC2 in **private subnet**
* Attach **AppServer-SG**

---

## **10. Command to Login to App Server**

```bash
suriya-key.pem
chmod 400 suriya-key.pem
ssh -i suriya-key.pem ec2-user@10.0.4.162
```

---

## **11. Setup Database**

```bash
sudo yum install mysql -y
mysql -h ytdb.cpk8oagkgyaz.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
```

➡️ Run queries from **commands.sql** to create DB and tables.

---

## **12. Setup App Server**

```bash
sudo yum install python3 python3-pip -y
pip3 install flask flask-mysql-connector flask-cors
vi app.py
```

**Run Application**

```bash
nohup python3 app.py > output.log 2>&1 &
ps -ef | grep app.py
cat output.log
curl http://10.0.3.47:5000/login
```

---

## **13. Setup Web Server**

```bash
sudo yum install httpd -y
sudo service httpd start
cd /var/www/html/
touch index.html script.js styles.css
```

---

## **14. Create Application Load Balancer (ALB)**

### **Backend Target Group (App Server)**

* Port: **5000**
* Health Check Path: **/login**

### **Backend Load Balancer**

* Public subnet
* Listener Port: **80**
* Attach Target Group

---

### **Frontend Target Group (Web Server)**

* Port: **80**
* Health Check Path: **/**

### **Frontend Load Balancer**

* Public subnet
* Listener Port: **80**
* Attach Target Group

---

## **15. Configure Route 53 to Load Balancer**

* Create **A record (Alias)**
* Point to **Frontend Load Balancer**

---

## **16. Attach ACM Certificate to Load Balancer**

---

# **✅ Tasks to be Completed**

* ✔️ Instead of three Security Groups create **five Security Groups**
* ✔️ Create an **Internal Load Balancer for App Server**
* ✔️ Create **Auto Scaling** for Web Server & App Server
* ✔️ Draw Three-Tier Diagram using **Cloudcraft / draw.io**
* ✔️ Read the **4-Part DR Strategies document https://aws.amazon.com/blogs/architecture/

---


