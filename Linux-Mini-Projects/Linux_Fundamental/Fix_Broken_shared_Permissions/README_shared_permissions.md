# 🧪 Linux Mini Challenge: Fix the Broken Shared Folder

This script sets up a shared project directory with correct Linux permissions, ownership, and ACLs.

## 📁 Scenario
You're configuring `/home/shared_project` for collaboration.

### Requirements:
- Owner should be `alice`
- Group should be `devteam`
- Group members: full access (rwx)
- Others: read-only
- User `bob` (not in devteam): read + write via ACL

## 🔧 What the Script Does
- Creates the folder and users
- Assigns ownership using `chown`
- Sets permissions with `chmod`
- Adds ACL for `bob` using `setfacl`
- Verifies results with `ls -ld` and `getfacl`

## ▶️ How to Run
```bash
chmod +x fix_permissions.sh
sudo ./fix_permissions.sh
```

## ✅ Skills Practiced
- File permissions (rwx)
- Ownership (`chown`, `chgrp`)
- ACLs (`setfacl`, `getfacl`)
- Scripting (`bash`, `chmod +x`)
