# Basic-Terraform
 
Este projeto tem como objetivo demonstrar a utilização de um Terraform na nuvem da AWS. Com ele será provisionado um ALB(Application Load Balancer), duas instâncias EC2(Nginx e Apache) e a geração completa de uma VPC, contendo uma subnet privada e uma subnet pública para ser utilizada de acordo com o necessário pela infraestrutura.
 
## Terraform
 
Para que o Terraform execute corretamente é necessário criar um S3, para armazenar os arquivos TF State, e uma tabela no DynamoDB para que sirva como controle de Lock, e dessa forma não seja possível dar simultaneamente apply no mesmo arquivo TF evitando assim a duplicação de infraestrutura e falha na hora da criação. Abaixo estaremos abordando em como criar essa estrutura inicial.
 
Os arquivos TF File, foram organizados na seguinte estrutura:
```
    | - Global/ -> Responsável por criar a infraestrutura inicial do Terraform(S3 e DynamoDB).
    | - Modules/ -> Responsável por armazenar os módulos criados para o projeto.
    | - main.tf -> Arquivo CORE deste projeto. Consiste em criar todos os recursos necessários.
    | - outputs.tf -> Arquivo que print a saida desejada.
```
 
Para que o projeto seja executado corretamente é de alta importância a configuração de três variáveis de ambiente, sendo elas:
 
```
export AWS_ACCESS_KEY_ID="" -> Access Key do usuário que tem permissão para a criação dos recursos.
export AWS_SECRET_ACCESS_KEY="" -> Secret Key do access Key acima.
export AWS_DEFAULT_REGION="" -> Region da AWS utilizada.
```
> É de alta importância que seja configurado as variáveis de ambiente acima, sem elas o Terraform não terá permissão de criar a infraestrutura deste projeto.
 
A estrutura inicial, necessária para que o Terraform funcione corretamente esta feito pelo arquivos TF existente dentro da pasta *Global/*, para que seja feito essa estrutura inicial é necessário executar, dentro da pasta:
 
```
terraform init
terraform apply
```
 
Você pode editar a estrutura inicial criada(S3 e DynamoDB), editando o arquivo *main.tf* existente dentro da pasta *Global/*. As linhas 11 até a 24 fazem referência ao S3 criado, é possível modificar o nome do Bucket, caso já exista outro com o mesmo nome. As linhas 26 até a 34 fazem referência ao DynamoDB criado, é possível modificar o nome da tabela criada.
 
### Modules
 
Os módulos criados para utilizar neste projeto são:
 
1. ALB
2. EC2
3. VPC
 
Cada módulo tem sua utilizacao de acordo com o necessário pela nossa infraestrutura. Dentro de cada módulo existe sub-módulos que fazem parte do módulo principal, dessa forma o todo fica mais organizado, podendo ser facilmente reaproveitado quando necessário.
 
#### VPC
 
Os módulos criados junto com o VPC são:
 
1. Elastic IP (EIP)
2. Internet Gateway (IGW)
3. Nat Gateway (NGW)
4. Security Groups
5. Subnets
 
Estes módulos servem para a criação completa da Network necessária para a execução de nossa aplicação. São criados:
 
* 1 Elastic IP
* 1 Internet Gateway
* 1 Nat Gateway
* 6 Security Groups
* 6 Subnets (3 Private - 3 Public)
 
#### EC2
 
Não existe sub-módulos do EC2, pois não foram necessários para a criação desta infraestrutura, portanto criamos apenas as instâncias EC2.
 
#### ALB
 
Os módulos criados juntos com o ALB são:
 
1. Listener
2. Target Group
 
Estes módulos servem para a criação completa da ALB necessária para a execução de nossa aplicação. São criados:
 
* 2 Target Group (Nginx - Apache)
* 2 Listener (Nginx - Apache)
 
### Core Projeto
 
No Core do projeto, se encontra onde são criados todos os recursos necessários para a criação da InfraEstrutura, lá utilizamos todos os módulos criados, para que dessa forma fique tudo organizado e centralizado, ficando fácil a gestão de todo o ambiente.
 
## Iniciando o Projeto
 
Para iniciar o projeto é necessário a execução de dois comandos, no root do projeto, sendo eles:
 
```
terraform init
terraform apply
```
 
> Obs: Para que este projeto execute corretamente, foram criados duas AMI na região *US-EAST-1*. É necessário que esse projeto seja executado nesta região.
 
Após a execução destes dois comandos será criado automaticamente toda a infraestrutura, e no final será printado na tela o DNS Name do Load Balancer criado, para que seja feito o acesso aos sites. Os sites podem ser acessados pelo LoadBalancer utilizando as portas 80 (Nginx) e 8080 (Apache).