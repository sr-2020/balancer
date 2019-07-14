# Balancer

- [Добавить ключ для расшифровки секретов](#vault)
- [Добавить пользователя на сервер](#user)
- [Добавить домен](#domain)

## <a name="vault"></a> Добавить ключ для расшифровки секретов
Создайте файл `.vault_pass` в корне репозитория:
```
touch .vault_pass
```
Добавьте в него пароль: Password ansible vault (В докумете Evarun Infrastructure)

## <a name="user"></a> Добавить пользователя на сервер
Вы не сможете без sudo доступа добавить своего пользователя на сервер.
Отправьте Гуркалову свой public key.

## <a name="domain"></a> Добавить домен
Для добавления домена для нового сервиса `newservice` нужно написать Гуркалову, чтобы он через панель VScale добавил домен.

Самостоятельно отредактировать файл: `group_vars/server.yml` выбрав на инстансе порт, открытый для вашего сервиса - на него будет проксироваться трафик с балансера.
Диапазон возможных портов: 7000-7100
```
nginx_services:
  - { name: 'gateway', port: '7000'}
  - { name: 'auth', port: '7002'}
  - { name: 'position', port: '7003'}
  - { name: 'billing', port: '7004'}
  - { name: 'push', port: '7005'}
  - { name: 'model-engine', port: '7006'}
  - { name: 'models-manager', port: '7007'}
  - { name: 'newservice', port: '7008'}
  - { name: 'pma', port: '7050'}

```

После нужно выполнить следующую команду, где `username` - имя вашего пользователя:
```
make setup env=production user=username
```
