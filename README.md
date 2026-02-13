# 🚀 DevOps Roadmap: 8 Semanas de Prática no Mundo Real

** - Escolhida pela documentação robusta e pelo Free Tier para aprendizado.

## 🗓️ Roteiro de Progresso Semanal

Cada semana tem seu próprio diretório com o código e documentação específica.

---

### [Semana 1: Os Fundamentos - Aplicação Local, Linux & Git](./week01/)
*   **Objetivo:** Configurar ambiente Linux, criar app "Hello World", versionar com Git e script de deploy manual.
*   **Tecnologias:** Linux (VM/WSL), Python Flask ou Nginx, Git, GitHub, Shell Scripting.
*   **Resultado:** Aplicação rodando localmente, repositório Git inicializado com código e script de deploy.

### [Semana 2: Containerização - Dockerizando a Aplicação](./week02/)
*   **Objetivo:** Empacotar a aplicação em um container Docker, rodá-lo e publicá-lo em um registro.
*   **Tecnologias:** Docker, Dockerfile, Docker Hub, Docker Compose (opcional).
*   **Resultado:** Imagem Docker do app no Docker Hub, aplicação rodando via Docker localmente.

### [Semana 3: Integração Contínua (CI) - Automatizando Build e Testes](./week03/)
*   **Objetivo:** Criar um pipeline de CI que construa e teste a imagem Docker automaticamente a cada `git push`.
*   **Tecnologias:** GitHub Actions, Testes automatizados (básicos), Docker Hub (credenciais seguras).
*   **Resultado:** Pipeline de CI funcional no GitHub Actions, construindo e publicando a imagem Docker automaticamente.

### [Semana 4: Infraestrutura como Código (IaC) - Provisionando a Nuvem](./week04/)
*   **Objetivo:** Usar Terraform para provisionar a infraestrutura básica na AWS para hospedar a aplicação.
*   **Tecnologias:** Terraform, AWS (EC2, Security Groups, Chaves SSH).
*   **Resultado:** VM EC2 provisionada na AWS via Terraform, acesso SSH configurado.

### [Semana 5: Entrega Contínua (CD) - Deployando para a Nuvem](./week05/)
*   **Objetivo:** Estender o pipeline de CI para incluir um estágio de CD que deploya a aplicação containerizada para a VM na AWS.
*   **Tecnologias:** GitHub Actions (CD), SSH (acesso remoto), Docker (na VM), Secrets do GitHub.
*   **Resultado:** Pipeline de CI/CD automatizado, deployando o app para a AWS a cada push, aplicação acessível na nuvem.

### [Semana 6: Orquestração (Kubernetes) & Refinamento Docker Compose](./week06/)
*   **Objetivo:** Introduzir conceitos de orquestração com Kubernetes (localmente) e refinar o uso do Docker Compose na nuvem.
*   **Tecnologias:** Docker Compose (na nuvem), Kubernetes (Minikube/Kind), Manifestos YAML.
*   **Resultado:** Deploy do app na nuvem via Docker Compose, app funcionando em cluster Kubernetes local.

### [Semana 7: Monitoramento e Observabilidade Básica](./week07/)
*   **Objetivo:** Adicionar monitoramento básico à aplicação na nuvem e entender como observar o sistema.
*   **Tecnologias:** AWS CloudWatch (métricas, logs, alertas), Prometheus & Grafana (opcional).
*   **Resultado:** Alertas de monitoramento configurados na AWS, capacidade de acessar logs da aplicação.

### [Semana 8: Escalabilidade Básica, Health Checks & IaC Cleanup](./week08/)
*   **Objetivo:** Introduzir conceitos de escalabilidade com Load Balancer, Health Checks e gerenciar recursos com `terraform destroy`.
*   **Tecnologias:** Terraform (Load Balancers na AWS), Health Checks (na aplicação).
*   **Resultado:** Aplicação acessível via Load Balancer com health checks, domínio sobre a criação e destruição de infraestrutura via IaC.

---

## 🛠️ Tecnologias Chave Abordadas

*   **Versionamento:** Git, GitHub
*   **Ambiente:** Linux (VM/WSL)
*   **Linguagem/Framework:** Python Flask, Nginx
*   **Containerização:** Docker, Dockerfile, Docker Compose, Docker Hub
*   **CI/CD:** GitHub Actions
*   **Infraestrutura como Código (IaC):** Terraform
*   **Provedor de Nuvem:** AWS (EC2, SGs, ALB, CloudWatch)
*   **Orquestração:** Kubernetes (Minikube/Kind)
*   **Monitoramento:** AWS CloudWatch, Prometheus, Grafana
*   **Automação:** Shell Scripting
*   **Segurança:** Secrets (GitHub, SSH)
