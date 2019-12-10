# Basic-Terraform

Este projeto tem como objetivo demonstrar a utilizacao de um Terraform na nuvem da AWS. Com ele sera provisionado um ALB(Application Load Balancer), duas instancias EC2(Nginx e Apache) e a geracao completa de uma VPC, contendo uma subnet privada e uma subnet publica para ser utilizada de acordo com o necessario pela infraestrutura.

## Terraform

Para que o Terraform execute corretamente e necessario criar um S3, para armazenar os arquivos TF State, e uma tabela no DynamoDB para que sirva como controle de Lock, e dessa forma nao seja possivel dar simultaneamente apply no mesmo arquivo TF evitando assim a duplicacao de infraestrutura e falha na hora da criacao. Abaixo estaremos abordando em como criar essa estrutura inicial.

Os arquivos TF File, foram organizados na seguinte estrutura:
```
    | - Global/ -> Responsavel por criar a infraestrutura inicial do Terraform(S3 e DynamoDB).
    | - Modules/ -> Responsavel por armazenar os modulos criados para o projeto.
    | - main.tf -> Arquivo CORE deste projeto. Consiste em criar todos os recursos necessarios.
    | - outputs.tf -> Arquivo que print a saida desejada.
```

A estrutura inicial, necessaria para que o Terraform funcione corretamente esta feito pelo arquivos TF existente dentro da pasta *Global/*, para que seja feito essa estrutura inicial e necessario executar, dentro da pasta:

```
terraform init
terraform apply
```

Voce pode editar a estrutura inicial criada(S3 e DynamoDB), editando o arquivo *main.tf* existente dentro da pasta *Global/*. As linhas 11 ate 24 fazem referencia ao S3 criado, e possivel modificar o nome do Bucket, caso ja exista outro com o mesmo nome. As linhas 26 ate 34 fazem referencia ao DynamoDB criado, e possivel modificar o nome da tabela criada.

### Modules

Os modulos criados para utilizar neste projeto sao:

1. ALB
2. EC2
3. VPC

Cada modulo tem sua utilizacao de acordo com o necessario pela nossa infraestrutura. Dentro de cada modulo existe sub-modulos que fazem parte do modulo principal, dessa forma o todo fica mais organizado, podendo ser facilmente reaproveitado quando necessario.

#### VPC

Os modulos criados junto com o VPC sao:

1. Elastic IP (EIP)
2. Internet Gateway (IGW)
3. Nat Gateway (NGW)
4. Security Groups
5. Subnets

Estes modulos servem para a criacao completa da Network necessaria para a execucao de nossa aplicacao. Sao criados:

* 1 Elastic IP
* 1 Internet Gateway
* 1 Nat Gateway
* 6 Security Groups
* 6 Subnets (3 Private - 3 Public)

#### EC2

Nao existe sub-modulos do EC2, pois nao foram necessarios para a criacao desta infraestrutura, portanto criamos apenas as instancias EC2.

#### ALB

Os modulos criados juntos com o ALB sao:

1. Listener
2. Target Group

Estes modulos servem para a criacao completa da ALB necessaria para a execucao de nossa aplicacao. Sao criados:

* 2 Target Group (Nginx - Apache)
* 2 Listener (Nginx - Apache)

### Core Projeto