# TECHDB – Sistema de Gerenciamento de Cartões de Crédito

## 🧩 Cenário Proposto

A empresa de meios de pagamento **Tech** precisa de melhorias em seu sistema de gerenciamento de **cartões de crédito**.  
O objetivo principal é **criar soluções escaláveis e com alta performance**, atendendo a demanda crescente por segurança, agilidade e confiabilidade no processamento de transações financeiras.

Este repositório contém o **versionamento completo do banco de dados Oracle** proposto para a solução, incluindo:
- Scripts de criação de tabelas (DDL)
- Scripts de inserção de dados exemplo (DML)
- Visões, procedures e queries para validação
- Instruções de acesso a ambiente de testes Oracle Cloud

---

## 📁 Estrutura do Repositório

techdb-breno/
│
├── scripts/
│ ├── 01_create_tables.sql
│ ├── 02_insert_sample_data.sql
│ ├── 03_views.sql
│ ├── 04_procedures.sql
│ └── 05_test_queries.sql
│
├── docs/
│ └── instrucoes_de_teste.md

---

## ⚙️ Acesso ao Banco de Dados Oracle Cloud

Um ambiente de testes foi disponibilizado na **Oracle Cloud Free Tier**, contendo a estrutura do banco `TECHDB`.

### 🔐 Informações de Conexão

| Campo             | Valor (exemplo)                       |
|------------------|----------------------------------------|
| **Usuário**       | `admin` ou `avaliador`                |
| **Senha**         | `OracleTeste@12345`                   |
| **Host**          | `adb.sa-saopaulo-1.oraclecloud.com`   |
| **Porta**         | `1522`                                |
| **Service Name**  | `techdb_high`                         |
| **Conexão**       | Oracle Wallet (disponível abaixo)     |

> **Download do Wallet (.zip)**: [Clique aqui para baixar](https://sua-url-do-wallet-oracle.com)

---

### ✅ Como se conectar usando SQL Developer

1. Abra o **Oracle SQL Developer**
2. Vá em **New Connection**
3. Preencha os campos:
   - **Connection Name**: `TECHDB`
   - **Username**: `ADMIN`
   - **Password**: `OracleDB@159753`
   - **Connection Type**: `Cloud Wallet`
   - **Configuration File**: selecione o `.zip` baixado do Wallet
   - **Service**: `techdb_high`
4. Clique em **Test** → depois em **Connect**

---

## 🛠️ Requisitos Técnicos

- Oracle Cloud Free Tier com Autonomous Database
- Oracle SQL Developer ou qualquer cliente compatível (DBeaver, DataGrip)
- SQL padrão Oracle 19c+

---

## 📌 Observações

- Este projeto foi desenvolvido como parte de uma **avaliação técnica**.
- Todos os dados inseridos são fictícios e destinados exclusivamente a testes.
- O banco pode ser acessado por tempo limitado para fins de validação.

---

## ✉️ Contato

**Breno Oliveira**  
📧 brenoreisrv@gmail.com  
📞 (64) 99275-0341  
🔗 [LinkedIn](https://www.linkedin.com/in/breno-oliveira-ti/)

