describe "POST /sessions" do

    context "login com sucesso" do
    
        before(:all) do 
           payload = { email: "raphael.mantilha_login@gmail.com", password: "pwd123" }
           @result = Sessions.new.login(payload)
        end

        it "login valida status code" do
            expect(@result.code).to eql 200
        end
        
        it "valida id do usuário" do
            #puts @result.parsed_response.class
            #puts @result.parsed_response["_id"]
        
            expect(@result.parsed_response["_id"].length).to eql 24
        end
    end

    # examples = [
    #     {
    #         title: "senha incorreta",
    #         payload: {email: "raphael.mantilha_login@gmail.com", password: "123456"},
    #         code: 401,
    #         error: "Unauthorized"
    #     },
    #     {
    #         title: "usuario nao existe",
    #         payload: {email: "404@gmail.com", password: "123456"},
    #         code: 401,
    #         error: "Unauthorized"
    #     }, 
    #     {
    #         title: "email em branco",
    #         payload: {email: "", password: "123456"},
    #         code: 412,
    #         error: "required email"
    #     },
    #     {
    #         title: "sem o campo email",
    #         payload: {password: "123456"},
    #         code: 412,
    #         error: "required email"
    #     },
    #     {
    #         title: "senha em branco",
    #         payload: {email: "404@gmail.com", password: ""},
    #         code: 412,
    #         error: "required password"
    #     },
    #     {
    #         title: "sem o campo senha",
    #         payload: {email: "404@gmail.com"},
    #         code: 412,
    #         error: "required password"
    #     }
    # ]

    #puts examples.to_json

    examples = Helpers::get_fixture("login")

    examples.each do |e|
        context "#{e[:title]}" do
    
            before(:all) do 
                @result = Sessions.new.login(e[:payload])
            end
    
            it "login valida status code #{e[:code]}" do
                expect(@result.code).to eql e[:code]
            end
            
            it "valida id do usuário" do
                #puts @result.parsed_response.class
                #puts @result.parsed_response["_id"]
            
                expect(@result.parsed_response["error"]).to eql e[:error]
            end
        end
    
    end

    
end
