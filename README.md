# conversao-distancia

Link do DockerHub
[https://hub.docker.com/repository/docker/luuucasmoreia/conversao-distancia/general](https://hub.docker.com/repository/docker/luuucasmoreia/conversao-distancia/general)

Tag
luuucasmoreia/conversao-distancia:v1

Install

kubectl
[https://kubernetes.io/docs/tasks/tools/][https://kubernetes.io/docs/tasks/tools/]

K3d
[https://k3d.io/v5.6.3/](https://k3d.io/v5.6.3/)
https://k3d.io/v5.6.3/

//criação de um cluster de alta disponibilidade com 3 nodes e 3 works-node
k3d cluster create meucluster --servers 3 --agents 3


//CLOUD AWS
Criação de Roule para o EKS

Criate roule - AWS Service - Selecionar EKS - EKS Cluster
Sugere uma role, pode dar next, Coloca um nome e segue

Criação de roule para o workernodes
Criate roule - AWS Service - Selecionar EC2 - EC2 e avança
Deficinir police -
    AmazonEKSWorkerNodePolicy
    AmazonEKS_CNI_Policy
    AmazonEC2ContainerRegistryReadOnly
Colocar o Nome e avançar

- Proximo passo, Criar a rede utilizando CloudFormation
Criar uma stack - Usar template
quero utilizar uma url do S3 que a propria AWS nos fornece

https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml

Avança, da um nome , avança novamente , submit no final que vai criar

- Criar o EKS