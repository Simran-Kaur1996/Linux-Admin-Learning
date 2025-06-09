This project sets up a secure shared directory structure for three teams — Design, Development, and Marketing — on a Linux system.

📂 Structure

/company/projects/
├── design_team/ # Access: lead_design + design_team group
├── dev_team/ # Access: lead_dev + dev_team group
├── marketing_team/ # Access: lead_marketing + marketing_team group
└── common/ # Access: all teams (write), auditor (read-only)

🎯 Key Features

--Team directories:
Owned by team lead
Group access only
No access for others
--Common directory:
Writable by all teams
Files owned by creator
Auditor has read-only access
--ACLs for fine-grained permissions
--Inheritance of permissions on new files

🛠️ Tools Used
Linux commands: useradd, groupadd, chown, chmod, setfacl

Bash scripting

🚀 How to Run

sudo bash secure_project_setup.sh

This will:

Create users/groups

Set directory ownership

Apply correct permissions and ACLs

📘 Learnings
✔️ Linux file permissions
✔️ Access Control Lists (ACL)
✔️ Automating system configuration with Bash
