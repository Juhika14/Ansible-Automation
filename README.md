 Steps Recap
1. Generate an SSH key pair on Jenkins master
bash
Copy
Edit
ssh-keygen -t ed25519 -f ~/.ssh/ansible_key -C "jenkins-ansible"
Generated the private key (ansible_key) and public key (ansible_key.pub).

2. Distribute the public key to remote hosts
Use ssh-copy-id to allow passwordless SSH access:

bash
Copy
Edit
ssh-copy-id -i ~/.ssh/ansible_key.pub ubuntu@10.0.1.200
ssh-copy-id -i ~/.ssh/ansible_key.pub ubuntu@10.0.1.38
3. Copy the private key to Jenkins agents
On the Jenkins master, securely transferred the private key to each agent:

bash
Copy
Edit
scp ~/.ssh/ansible_key ubuntu@10.0.1.200:/home/ubuntu/.ssh/
scp ~/.ssh/ansible_key ubuntu@10.0.1.38:/home/ubuntu/.ssh/
4. Set correct permissions on each agent
On both remote Jenkins agents, made the key secure:

bash
Copy
Edit
chmod 600 /home/ubuntu/.ssh/ansible_key
5. Verify passwordless SSH login from agents
On each Jenkins agent:

bash
Copy
Edit
ssh -i /home/ubuntu/.ssh/ansible_key ubuntu@10.0.1.200
ssh -i /home/ubuntu/.ssh/ansible_key ubuntu@10.0.1.38
✅ Confirmed no password prompts appeared, meaning SSH keys worked.

