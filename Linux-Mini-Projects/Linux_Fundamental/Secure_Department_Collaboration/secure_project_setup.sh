 #!/bin/bash
# Secure Project Setup Script for multi-team collaboration environment

# Ensure the script is run as root (for user/group creation and permission changes)
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# Define team groups
team_groups=("design_team" "dev_team" "marketing_team")

# Create groups for each team if they do not exist
for grp in "${team_groups[@]}"; do
    if ! getent group "$grp" >/dev/null; then
        echo "Creating group: $grp"
        groupadd "$grp"
    else
        echo "Group $grp already exists"
    fi
done

# Define team lead users (username:group)
team_leads=("lead_design:design_team" "lead_dev:dev_team" "lead_marketing:marketing_team")

# Create team lead users with their primary group
for lead in "${team_leads[@]}"; do
    username="${lead%%:*}"
    group="${lead##*:}"
    if ! id "$username" &>/dev/null; then
        echo "Creating user: $username (lead of $group)"
        useradd -m -g "$group" "$username"
    else
        echo "User $username already exists"
    fi
done

# (Optional) Define additional team members for each group (username:group)
team_members=(
    "designer1:design_team"
    "designer2:design_team"
    "dev1:dev_team"
    "dev2:dev_team"
    "marketer1:marketing_team"
    "marketer2:marketing_team"
)
# Create additional team member accounts
for member in "${team_members[@]}"; do
    username="${member%%:*}"
    group="${member##*:}"
    if ! id "$username" &>/dev/null; then
        echo "Creating user: $username (member of $group)"
        useradd -m -g "$group" "$username"
    else
        echo "User $username already exists"
    fi
done

# Create the main projects directory and subdirectories for each team and common area
echo "Setting up directory structure under /company/projects/"
mkdir -p /company/projects/design_team
mkdir -p /company/projects/dev_team
mkdir -p /company/projects/marketing_team
mkdir -p /company/projects/common

# Set ownership and base permissions for each team directory
echo "Configuring team directories permissions and ownership..."
chown lead_design:design_team /company/projects/design_team
chmod 2770 /company/projects/design_team   # rwx for owner & group, no access for others; setgid bit on

chown lead_dev:dev_team /company/projects/dev_team
chmod 2770 /company/projects/dev_team     # rwx for owner & group, no access for others; setgid bit on

chown lead_marketing:marketing_team /company/projects/marketing_team
chmod 2770 /company/projects/marketing_team  # rwx for owner & group, no access for others; setgid bit on

# Set up the common directory ownership and base permissions
echo "Configuring common directory permissions and ownership..."
chown root:root /company/projects/common
chmod 770 /company/projects/common   # rwx for owner & group, no access for others (will refine with ACLs)

# Create auditor user if not exists (for read-only access to common files)
if ! id "auditor" &>/dev/null; then
    echo "Creating auditor user (read-only auditor account)"
    useradd -m auditor
fi

# Apply ACLs to grant team groups full access to common directory, and auditor read-only access
echo "Applying ACLs to common directory..."
setfacl -m g:design_team:rwx /company/projects/common
setfacl -m g:dev_team:rwx /company/projects/common
setfacl -m g:marketing_team:rwx /company/projects/common
setfacl -m u:auditor:r-x /company/projects/common   # auditor can read and traverse (no write)

# Set default ACLs so that new files and subdirectories inherit the same permissions
echo "Setting default ACLs for inheritance on common directory..."
setfacl -d -m g:design_team:rwx /company/projects/common
setfacl -d -m g:dev_team:rwx /company/projects/common
setfacl -d -m g:marketing_team:rwx /company/projects/common
setfacl -d -m u:auditor:r-x /company/projects/common

# Ensure the ACL mask allows rwx for group entries (make sure no permissions are masked out)
setfacl -m mask::rwx /company/projects/common
setfacl -d -m mask::rwx /company/projects/common

# (Optional) Set default ACLs on team directories to ensure group members have full access on new files
echo "Setting default ACLs for team directories (ensure group rw on new files)..."
setfacl -d -m g:design_team:rwX /company/projects/design_team
setfacl -d -m g:dev_team:rwX /company/projects/dev_team
setfacl -d -m g:marketing_team:rwX /company/projects/marketing_team

# All done
echo "Secure collaboration project directories have been set up successfully."
