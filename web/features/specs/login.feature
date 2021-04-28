#language:pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "papito@yahoo.com" e "pwd123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenario: Tentar logar

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input                | senha_input | mensagem_output                  |
            | raphael.mantilha@gmail.com | abc123      | Usuário e/ou senha inválidos.    |
            | raphael.mantilha@404.com   | pwd123      | Usuário e/ou senha inválidos.    |
            | raphael.mantilha%gmail.com | abc123      | Oops. Informe um email válido!   |
            |                            | abc123      | Oops. Informe um email válido!   |
            | raphael.mantilha@gmail.com |             | Oops. Informe sua senha secreta! |