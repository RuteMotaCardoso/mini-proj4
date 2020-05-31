# Tópico 5 - Base de Dados 

## Tarefas realizadas
* Instalação do MySql Workbench, que apesar de direcionado para mySql, também funcionou com o DBMS MariaDb instalado por omissão pelo WAMP, pelo que não senti necessidade de instalar o servidor MySql
* Extração do modelo de dados remoto e respetivos dados para um script local (BDWebBook.sql), mantendo os dados existentes no modelo remoto 
* Criar a BD localConference via phpMyAdmin (wampServer)
* Importar o modelo e dados para a BD local (localConference)
* Gerar o modelo a partir da BD (localConferenceBase.mwb) - Reverse Engineering
* Configurar a ligação à BD em config/config.json e config/connectMySQL.js
* No diagrama acrescentar as novas tabelas membroComissao, conf_membroComissao, voluntario, conf_voluntario, tarefa, tipoTarefa e gerar o script de Forward Engineering para aplicar na BD (ajustando quando necessário: substituir GENERATE por AUTOINCREMENT e remover VISIBLE dos index)
* A inicialização das tabelas é realizada por um script por cada tabela contendo os dados iniciais (membrosComissao.sql)
* O modelo final da BD está disponível em localConferenceCompleto.mwb
* Nas queries de ReadID, foi utilizada a sintaxe WHERE ?, sendo o placeholder ? substituído pelo json com os dados da query {idMembro: 1}, que é traduzido para `idMembro` = '1'
* No caso das tarefas, optei por listar os dados das mesmas fazendo join com as tabelas tipoTarefa e Voluntario, e assim apresentar as respetivas designações textuais (tipo e voluntarioNome) em vez dos seus Identificadores
* De forma semelhante, na lista de voluntários é apresentado o nome do tipo de tarefa/área do mesmo em vez do identificador do tipo de tarefa
* Foram implementadas as APIs para ler, associar e remover Membros de Comissão da conferência 1, tal como ler, associar e remover Voluntários da conferência 1 (à semelhança do existente para os Speakers)
* Todos os scripts e modelos estão na pasta config do backend

## Reflexão sobre a implementação do modelo de Tarefas
* Ponderei duas hipóteses para a modelação das tarefas: ou associar a tarefa diretamente ao voluntário, ou associar a tarefa ao voluntário no âmbito de uma conferência. Existindo vantagens em ambas as opções, optei por associar a tarefa ao voluntário, permitindo por exemplo ter voluntários que não estejam associados a conferências, mas tenham tarefas, como por exemplo a gestão do site das conferências.
