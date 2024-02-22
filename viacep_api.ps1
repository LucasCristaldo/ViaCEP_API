# 1. Pedir ao user que informe um cep
# 2. Validar esse cep
# 3. Fazer a requisição API com o cep informado
# 4. Mostrar os resultados de:
# - UF, BAIRRO, LOGRADOURO E LOCALIDADE

while ($true)
{

    $cep = Read-Host "Digite seu cep"
    $cep = $cep.Replace("-", "").trim()

    $url = "viacep.com.br/ws/" + $cep + "/json/"

    # Pedindo para entrar nesse site 
    $r = Invoke-WebRequest -Uri $url 
    # Salvando o que retorno na variável $r

    # Posso pegar qualquer "Chave" depois do ".(ponto)", por exemplo:
    echo $r.StatusCode # Retornou '200' corretamente

    echo $r.StatusDescription # Retorno 'Ok' corretamente

    echo "######"
    # Fazendo condições 

    if ($r.StatusCode -eq 200)
    {
        $r_result = $($r.Content | Out-String | ConvertFrom-Json)
        # Peça ajuda ao chatGPT para entender o "Out-String" e "ConvertFrom-Json"

        echo """
            Resultado da Requisição com o CEP: $($r_result.cep)

            UF: $($r_result.uf), LOCALIDADE: $($r_result.localidade)
            BAIRRO: $($r_result.bairro), LOGRADOURO: $($r_result.logradouro)

        """.Replace('"', "") # Apenas para tirar as aspas que estavam aparecendo na hora do 'echo'.

    } 
    else
    {
        echo ""
        echo "API Request Error"
        echo ""
        echo $r.StatusCode
        echo ""
    }

    $sair = Read-Host "Você quer sair"
    $sair = $sair.ToLower().Trim()
    if ($sair -eq "sim")
    {
        echo "Saindo..."
        break;
    }

}