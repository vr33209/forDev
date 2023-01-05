Feature: Login
Como um cliente
Quero poder acessar minha conta e me manter logado
Para que eu possa ver e responder enquetes de forma rapida

Cenario: Credenciais válidas
Dado que o cliente informou credenciais válidas
Quando solicitar para fazer Login
Então o sistema deve enviar o usuario para tela de pesqusias
E manter o usuario conectado

Cenario: Credenciais inválidas
Dado que o cliente informou credenciais inválidas
Quando solicitar para fazer Login
Então o sistema deve retornar uma mensagem de erro