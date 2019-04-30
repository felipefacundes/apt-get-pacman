apt-get
===

##### Licença GPL3
> Mantenedor: Felipe Facundes
###### Telegram: https://t.me/winehq_linux

Um simples bash wrapper para pacman.

Pros:
* Fácil para usar
* Sem dependências, 100% bash script
* Trabalha com `yay` desde que instalado

Cons:
* Não cobre todos os recursos de `pacman`, é apenas o básico para facilitar a vida dos ex Ubunteiros.

## O que é?

Para aqueles que tem dificuldade de usar o pacman, e já estão acostumados com o apt-get.

## Instalação

### Ínicio Rápido:
Você confia em mim?
```
bash <(curl -s https://raw.githubusercontent.com/felipefacundes/apt-get-pacman/master/iniciorapido.sh)
```

### Manual
Para clonar este repositório `git clone https://github.com/felipefacundes/apt-get-pacman`
e depois colocar o conteúdo (apt-get) do `bin` em seu /usr/bin/.

```
PATH=$PATH:{PATH_TO_APT_GET}/bin
```

## Usage

```
Use: apt-get [options] <command> <args>...
  apt-get install <package>
  apt-get search <package>
  apt-get info <package>
  apt-get remove <package>
  apt-get update [args]...
  apt-get upgrade [args]...

Options:
  -h | --help		Mostra está tela.
  -v | --verbose 	Display the command to be passed through.
  --yay		Use yay no lugar de pacman.
  --pacman    Use pacman no lugar de yay.
```

apt-get irá usar automaticamente `yay` se estiver instalado, e usará automaticamente o `sudo` só digitar a senha e pronto.

### Comandos (sub comandos)

`apt-get install {ARGS}` == `pacman -S {ARGS}`

`apt-get search {ARGS}`  == `pacman -Ss {ARGS}`

`apt-get update {ARGS}`  == `pacman -Syy {ARGS}`

`apt-get upgrade {ARGS}` == `pacman -Syyuu {ARGS}`

`apt-get remove {ARGS}`  == `pacman -Rcs {ARGS}`
