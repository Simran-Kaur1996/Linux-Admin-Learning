#!/bin/bash

# Step 1: Create directory
mkdir -p /home/shared_project

# Step 2: Create demo users and group (optional - skip if they exist)
groupadd devteam 2>/dev/null
useradd alice -G devteam 2>/dev/null
useradd bob 2>/dev/null

# Step 3: Assign ownership
chown alice:devteam /home/shared_project

# Step 4: Set permission for owner, group, and others
chmod 754 /home/shared_project
# → alice = rwx (7), devteam = r-x (5), others = r-- (4)

# Step 5: Give bob extra write permission via ACL
setfacl -m u:bob:rwX /home/shared_project

# Step 6: Verify
echo "Permissions:"
ls -ld /home/shared_project
echo
echo "ACLs:"
getfacl /home/shared_project
