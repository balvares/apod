# Astronomy Picture of the Day 🪐

Aplicativo para obter a Astronomy Picture of the Day, da [API oficial](https://api.nasa.gov/) da NASA.

## **Sumário**
 - Instalação
 - Como rodar
 - Arquitetura
 - Linguagem e tecnologias utilizadas
 - Soluções técnicas

## Instalação
Faça o download do repositório, entre na pasta, abra o prompt de comando e digite:

    flutter pub get
Este comando irá buscar as dependências utilizadas no projeto.

## Como rodar
Com um dispositivo conectado à máquina ou um emulador em execução, abra o prompt de comando na pasta do projeto e execute:

    flutter run

## Arquitetura
Este aplicativo foi desenvolvido seguindo os princípios da Clean Architecture, proposta por Robert C. Martin. A Clean Architecture visa criar um código fonte que seja independente de frameworks, UI e databases, facilitando a manutenção e testabilidade do sistema.

**Camadas:**

 - Core: Contém recursos globais e reutilizáveis que podem ser usados em diferentes partes da aplicação.
 - Data: Gerencia a obtenção e armazenamento de dados.
 - Domain: Define a lógica central e regras de negócio da aplicação.
 - Presentation: Contém tudo relacionado à interface de usuário e apresentação de dados.

## Linguagem e Tecnologias utilizadas
- Flutter
- Dart
- Bibliotecas externas: `http` (any), `provider` (any), `intl` (any), `mockito` (any), `build_runner` (any), `get_it` (any) e `sqflite` (any).

Obs.: Optei propositalmente por não definir versões fixas para as bibliotecas, dado que é um projeto com intenção de ser mantido como portfólio.

## Soluções técnicas
Optei em utilizar o Provider por ser uma ferramenta simples de entender e implementar. Não houve necessidade de estruturar de maneira complexa, porém a separação das camadas `Domain` e `Data` mantém viável para escalar futuramente.

**Gerenciamento de estado**
 1. **Providers**: Utilizei providers para gerenciar o estado de diferentes partes da aplicação e separar da view as regras de negócio.
3. **Consumers**: Utilizei Consumers para monitorar mudanças no estado vindas do Provider.
4. **Injeção de dependências**: Optei por injetar as dependências diretamente na classe `main.dart` para que o `MultiProvider` já obtivesse todas as implementações necessárias.

**Navegação**
Para navegar entre telas neste projeto, optei em utilizar o `Navigator` nativo do Flutter.

### Conclusão

A utilização do Provider simplificou significativamente gerenciamento de estado, tornando-o mais limpo, modular e fácil de manter.