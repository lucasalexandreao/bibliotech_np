# 📚 BIBLIOTECH - Sistema de Gestão para a Biblioteca Municipal Ney Pontes

Este é um sistema completo e moderno de gestão para bibliotecas, desenvolvido com foco em performance, usabilidade (UX) e segurança de dados. A aplicação atende tanto às necessidades administrativas dos bibliotecários (gestão de acervo e usuários) quanto aos leitores, através de um portal público para acompanhamento e renovação de empréstimos.

---

## 🚀 Principais Funcionalidades

### 🛡️ Área Administrativa (Bibliotecário)

* **Gestão de Acervo e Leitores:** CRUD completo de Livros, Categorias e Usuários.

* **Gestão de Empréstimos:** Registro de saídas (com validação de senha do usuário), devoluções e renovações com cálculos automáticos de dias úteis/prazos.
* **Filtros e Buscas Avançadas:** Pesquisa em tempo real por CPF, nome, status do empréstimo e afins, sem perder o estado da página.
* **Integridade de Dados:** Travas de exclusão para registros com histórico financeiro/empréstimos pendentes.

### 📖 Portal do Leitor (Área Pública)

* **Acesso Seguro:** Login exclusivo com CPF e Senha criptografada.
* **Dashboard Pessoal:** Visualização de empréstimos ativos, histórico e datas de devolução.
* **Renovação Online:** Botão interativo para renovação de livros diretamente pelo sistema, desde que o prazo não esteja vencido.

---

## 🛠️ Tecnologias Utilizadas

A aplicação foi construída utilizando o ecossistema moderno do Ruby on Rails, priorizando renderização no servidor (SSR) com atualizações assíncronas ultra-rápidas.

| Tecnologia / Gem | Propósito |
| --- | --- |
| **Ruby on Rails 8** | Framework principal do backend e roteamento. |
| **Hotwire (Turbo Streams/Frames)** | Atualizações dinâmicas de DOM (Modais e Notificações) sem uso pesado de JavaScript. |
| **Tailwind CSS** | Estilização avançada, responsividade e efeitos visuais. |
| **Devise** | Autenticação dos bibliotecários. |
| **Bcrypt** | Criptografia irreversível para as senhas dos leitores. |
| **Ransack** | Filtros de busca complexos e dinâmicos na interface. |
| **Pagy** | Paginação de alta performance para as tabelas de listagem. |
| **CanCanCan** | Autorização e restrição de acesso por perfil de usuário. |

---

## 💻 Instruções de Instalação e Execução

### Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas em sua máquina:

* Ruby (versão recomendada: 3.4+)
* Node.js e Yarn (para compilação do Tailwind CSS)
* PostgreSQL

### Passo a passo para rodar localmente

**1. Clone o repositório**

```bash
git clone https://github.com/lucasalexandreao/bibliotech_np.git
cd bibliotech_np

```

**2. Instale as dependências do Ruby e do Node**

```bash
bundle install
yarn install

```

**3. Configure o Banco de Dados**
Crie o banco de dados, rode as migrations e popule com os dados iniciais:

```bash
rails db:create
rails db:migrate
rails db:seed

```

**4. Inicie o Servidor de Desenvolvimento**
Como o projeto utiliza Tailwind CSS, inicie o servidor usando o processo de build do Node integrado:

```bash
./bin/dev

```

*(Caso não esteja utilizando o `./bin/dev`, você pode rodar `rails s` e `yarn build:css --watch` em terminais separados).*

**5. Acesse a Aplicação**
Abra o seu navegador e acesse: `http://localhost:3000`

---