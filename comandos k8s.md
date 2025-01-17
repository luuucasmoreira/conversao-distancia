# Comandos Docker e Kubernetes

## Subindo uma imagem Docker
```bash
docker build -t luuucasmoreia/conversao-distancia:v2 --push .
```

## Mostrar todos os Nodes
```bash
kubectl get nodes
```

## Mostrar todos os clusters no K3d (aqui já dá para ver se tem loadbalancer)
```bash
k3d cluster list
```

## Deletar Cluster
```bash
k3d cluster delete
```

## Criação de um cluster de alta disponibilidade com 3 nodes e 3 worker nodes
```bash
k3d cluster create meucluster --servers 3 --agents 3
```

## Criação igual, porém expondo a porta para ser usada na nodeport, utilizando a 30000 do container e loadbalancer
```bash
k3d cluster create meucluster --servers 1 --agents 2 -p "8080:30000@loadbalancer"
```

## Aplicar o manifesto do Kubernetes
O comando `create` cria do zero, enquanto `apply` cria ou aplica atualizações caso o recurso já exista. O `create` não atualiza.

```bash
kubectl create -f k8s/deployment.yaml
```
ou
```bash
kubectl apply -f k8s/deployment.yaml
```

## Verificar os ReplicaSets em execução
```bash
kubectl get replicaset
```

## Comando para ficar verificando quantos ReplicaSets estão subindo
```bash
kubectl apply -f k8s/deployment.yaml && watch 'kubectl get pod'
```

## Ver mais detalhes dos Pods
```bash
kubectl get nodes -o wide
```

## Deletar Pod
```bash
kubectl delete pod <nomedopod>
```
> **Observação**: Ao deletar o pod, a réplica será recriada automaticamente, devido ao ReplicaSet.

## Fazer redirecionamento de porta para acessar um pod específico
```bash
kubectl port-forward pod/<nomedopod> 8080:5000
```

## Serviço (Service)
Serve para expor os Pods. Existem vários tipos de service:

### Mostrar tudo de principal do cluster
```bash
kubectl get all
```

### Mostrar as versões do Deployment
```bash
kubectl rollout history deployment conversao-distancia
```

---

## Explicação do Manifesto

- **apiVersion**: A versão do Kubernetes. Para verificar as versões disponíveis, use o comando:
  ```bash
  kubectl api-resources
  ```
  Para criar um **Deployment**, por exemplo, o `apiVersion` e o `kind` devem ser especificados no manifesto.

- **metadata**: O nome do recurso.

- **spec**: A especificação do Deployment. Define o template do pod, tipo de pod que o ReplicaSet gerencia e a quantidade de réplicas.

- **selector**: Dentro do spec, são os objetos para interação. Labels são usadas como tags de chave e valor que o selector utiliza para identificar os Pods.

- **matchLabels**: A label que precisa estar no Pod para que o selector interaja com ele.

- **template**: O que o pod vai gerenciar. Não é necessário colocar `apiVersion` e `kind`, pois o pod será destruído e recriado automaticamente. Não é necessário definir um nome, mas as labels devem ser iguais às do `matchLabels`.

- **ports**:
  - **targetPort**: A porta interna do pod.
  - **ports**: A porta externa do pod.
  - **nodePort**: Especificação da porta `30000` para forçar o NodePort a usar essa porta.

---

## Tipos de Service

- **ClusterIP**: Utilizado apenas internamente, entre Pods.

- **NodePort**: Expondo o Pod para o mundo externo. Criará uma porta no range de `30000-32967` para acessar o serviço a partir de qualquer IP do cluster.

- **LoadBalancer**: Usado principalmente em cenários de cloud, cria um LoadBalancer na frente do serviço, expondo um único IP. Pode ser usado no on-premise com o MetalLB (não abordado aqui). No cloud, funciona como o NodePort, mas com a criação de um LoadBalancer.

No `deployment.yaml`, ao colocar o tipo `NodePort`, ele cria a porta `30000` para o serviço.

---

## Boas Práticas

- Coloque todos os recursos no mesmo arquivo YAML.

- Usando o script:
  ```bash
  k3d cluster create meucluster --servers 1 --agents 2 -p "8080:30000@loadbalancer"
  ```
  O cluster é criado com a **bind** da porta `8080` para a porta `30000`. No deployment, você especifica a porta do NodePort para forçar o uso da porta `30000`.
