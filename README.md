# anozon shell script kit

> Parsonal shell scirpts

### ssh-make-key-github.sh

```sh
$ export NAME=yourkeyname
$ curl -s https://raw.githubusercontent.com/elzup/kit-sh/main/ssh-make-key-github.sh | sh
$ cat ~/.ssh/config
Host github.com
    Hostname github.com
    IdentityFile /home/ec2-user/.ssh/keyname
    User git
```

### github-master-to-main.sh

```
export NAME=yourkeyname
curl -s https://raw.githubusercontent.com/elzup/kit-sh/main/github-master-to-main.sh | bash
```
