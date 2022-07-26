# Rebase-Challenge

Este projeto está em desenvolvimento. Trata-se de uma API em Ruby para listagem de exames médicos.

Para fins de teste há um [arquivo](data.csv) csv disponível na aplicação.

- Veja os endpoints [aqui](api_doc.md)

## Dependências do sistema

- docker 20.10.17

## Rodando o projeto

**Clone o repositório:**

```text
git clone git@github.com:JamesToledo/rebase-challenge.git
```

**Rode os comandos:**

```text
bundle install
```

```text
docker network create server
```

```text
docker run --rm -d --name pg-docker --network server \
  -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres
```

```text
docker run --rm --name myredis --network server -dp 6379:6379 redis
```

```text
docker run --rm -d --name sidekiq --network server \
  -v $(pwd):/rebase-challenge -w /rebase-challenge \
  ruby:3.1.0 \
  bash -c 'bundle && sidekiq -r ./config/sidekiq.rb'
```

```text
docker run --rm --name app --network server \
  -v gems:/usr/local/bundle -v $(pwd):/rebase-challenge \
  -w /rebase-challenge -p 3000:3000 \
  ruby:3.1.0 bash -c 'bundle && bundle exec rake db:create \
  db:migrate && bash && ruby ./config/routes.rb'
```

**Para rodar os testes substitua o comando acima pelo seguinte:**

```text
docker run -it --rm --name app --network server \
  -v gems:/usr/local/bundle -v $(pwd):/rebase-challenge \
  -w /rebase-challenge -p 3000:3000 ruby:3.1.0 \
  bash -c 'bundle && bundle exec rake db:create db:migrate && bash'
```

**Em seguida:**

```text
bundle exec rspec
```
