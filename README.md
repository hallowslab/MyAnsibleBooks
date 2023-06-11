# MyAnsibleBooks

### Configuration

- Copy the contents of `inventory/example.yml` to `inventory/main.yml` and modify the file accordingly
    * If you need to store secrets make sure to encrypt them with `ansible-vault encrypt_string --name 'ansible_become_password' '1234567890' --output inventory/encrypted_vars.yml`
    * And use `ansible-playbook --vault-id @prompt playbooks/test.yml -i inventory/main.yml` to input the credentials to the vault

### Running a playbook

```
ansible-playbook playbooks/test.yml -i inventory/main.yml
```

### Buiding & running the docker images

- Running the images
```
docker-compose up --build -d
```

- Removing the images
```
docker-compose down --remove-orphans
```