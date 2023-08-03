# MyAnsibleBooks

### Configuration

**For usage of the docker images you must set StrictHostKeyChecking to no for the host 127.0.0.1 in ~/.ssh/config**

- Copy the contents of `inventory/example.yml` to `inventory/main.yml` and modify the file accordingly
    * If you need to store secrets make sure to encrypt them with `ansible-vault encrypt_string --name 'ansible_become_password' '1234567890' --output inventory/encrypted_vars.yml`
    * And use `ansible-playbook --vault-id @prompt playbooks/test.yml -i inventory/main.yml` to input the credentials to the vault

### Running a playbook

- Without encrypted inventory
```
ansible-playbook playbooks/test.yml -i inventory/main.yml
```

- With encrypted inventory
```
ansible-playbook --vault-id @prompt playbooks/test.yml -i inventory/main.yml
```

- Passing variables
```
ansible-playbook -e "remote_user=myuser" playbooks/test.yml -i inventory/main.yml
```

### Buiding & running the docker images

- Running the images in the background
```
docker-compose up --build -d
```

- Removing the images
```
docker-compose down --remove-orphans
```

### Dev notes:

#### VM Management | Restoring snapshots

- Identify the VM names and write them in a text file one per line
- Use the script provided in script/manage_guests.pl
- Parameters are `manage_guests.pl FILENAME ACTION OPTIONAL`
- `FILENAME` is the name of the file with the guests, `ACTION` can be `start` `stop` or `restore`
- `restore` is the only one that supports `OPTIONAL` and it's for the snapshot name

#### Creating new roles

* `ansible-galaxy init playbooks/roles/service-role`

