#!/bin/bash
#
# AUTOR:        Julio C. Pereira
# APLICATIVO:   Realiza testes para determinado ip de destino
#               no sentido de identificar se há conectividade
#               ou/e identificar problemas de qualidade do
#               serviço.
#
# CONTATO:      julliopereira@gmail.com
#
# versão: 0.1 - Inicio do desenvolvimento
#               20220205
#               Julio C. Pereira
# versão: 0.2 - Incluído opção de versionamento
#               20220206
#               Julio C. Pereira
#
#
#
#
##########################################################
# -- MENSAGENS --
msghelp="
Uso: $(basename "$0")-[fmnpthV] <ip_de_destino>

        -f, --file          Redireciona para arquivo
        -m, --mtr           Faz análise com mtr para o destino
        -n, --nmap          Faz uma avaliação com nmap -A para o destino (root)
        -p, --ping          Testa conectividade para o destino
        -q, --qos           Envia pacote marcado com EF para o destino
                            - destino deve availizar se recebe o pacote marcado com EF
        -t, --tracert       Faz um tracert para o destino
        -h, --help          Mostra ajuda do programa
        -V, --version       Mostra a versão do programa

    Exemplos:

    -Mostra cidade e estado de localização do ip de destino e salva em arquivo
        $(basename "$0") -f /tmp/arquivo 192.168.12.10

    -Monitora qualidade do caminho de rede até o ip de destino
        $(basename "$0") -m 192.168.12.10

    -Realiza teste de conectividade e traça rota até o ip de destino
        $(basename "$0") -p -t 192.168.12.10

    -(root)Realiza análise para identificar recursos do dispositivo que contém o ip destino 
        $(basename "$0") -n 192.168.12.10
"
msgopcoes="
    $(basename "$0") : opção $1 incorreta
"
# -- VARIÁVEIS --

icmp="0"    # PINGAR ?
trace="0"   # TRAÇAR ROTA ?
nmap="0"    # ANALISAR DISPOSITIVO ?
mtr="0"     # MONITORAR QUALIDADE DO TRÁFEGO ?
ip="$2"       # IP DE DESTINO

# -- FUNÇÕES --

mtrrun() {
    mtr -t $ip 
}
ajuda() {
    echo -e "$msghelp"
}
erro_opcoes() {
    echo -e "$msgopcoes"
}

# -- CORPO --
case $1 in
    -m|--mtr)
        mtrrun
    ;;
    -h|--help)
        ajuda
    ;;
    -V|--version)
        egrep -A 2 "^# versão" testenet.sh | tail -n 3
    ;;
    *)
        erro_opcoes
    ;;
esac

# -- SAÍDA --
exit 0