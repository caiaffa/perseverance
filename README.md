<div align="center">
    <h1>Perseverance</h1>
</div>


---

## 🚀 Como executar o projeto

### Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
[Git](https://git-scm.com), [Elixir](https://elixir-lang.org/), [Docker-compose](https://docs.docker.com/compose/install) (Apenas para ambiente de desenvolvimento).

#### 🎲 Rodando

```bash
Ex.:

# Clone este repositório
$ git clone https://github.com/caiaffa/perseverance.git

# Acesse a pasta do projeto no terminal/cmd
$ cd perseverance

# Acesse a pasta do projeto no terminal/cmd
$ cd perseverance

# Instale as dependências
$ make build

# Execute os testes
$ make test

# Execute a aplicação
$ make run

# O servidor inciará na porta:4000 - acesse http://localhost:4000
```

#### 🎲 API

```bash
Ex.:

# Envia a sonda para a posição inicial.
$ curl --location --request GET 'https://perseverance-control-center.herokuapp.com/api/v1/commands/start-position'

# Exibe as coordenadas atuais x e y da sonda.
$ curl --location --request GET 'https://perseverance-control-center.herokuapp.com/api/v1/commands/show-position'

# Movimenta a sonda.
$ curl --location --request POST 'https://perseverance-control-center.herokuapp.com/api/v1/commands/move-position' \
--header 'Content-Type: application/json' \
--data-raw '{
  "movements": ["GE", "M", "M", "M", "GD", "M", "M"]
}'

```

## 🛠 Tecnologias

As seguintes ferramentas foram usadas na construção do projeto:

**Back-End**  ([Elixir](https://elixir-lang.org/)  +  [Phoenix](https://www.phoenixframework.org))

> Veja o arquivo mix.exs

---
